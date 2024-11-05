use integrity::{
    StarkProof, CairoVersion, StarkProofWithSerde,
    fri::fri::{FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable},
    settings::{VerifierSettings, FactHash, JobId, SecurityBits},
};

#[derive(Drop, Serde)]
struct InitResult {
    program_hash: felt252,
    output_hash: felt252,
    fact: FactHash,
    last_layer_coefficients: Span<felt252>,
    state_constant: FriVerificationStateConstant,
    state_variable: FriVerificationStateVariable,
    layers_left: u32,
}

#[derive(Drop, Copy, Serde, starknet::Event)]
struct ProofVerified {
    #[key]
    job_id: JobId,
    #[key]
    fact: FactHash,
    #[key]
    security_bits: SecurityBits,
    #[key]
    settings: VerifierSettings,
}

#[starknet::interface]
trait ICairoVerifier<TContractState> {
    fn verify_proof_full(
        ref self: TContractState,
        settings: VerifierSettings,
        stark_proof_serde: StarkProofWithSerde,
    ) -> ProofVerified;

    fn verify_proof_initial(
        ref self: TContractState,
        job_id: JobId,
        settings: VerifierSettings,
        stark_proof_serde: StarkProofWithSerde,
    ) -> InitResult;

    fn verify_proof_step(
        ref self: TContractState,
        job_id: JobId,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        witness: FriLayerWitness,
    ) -> (FriVerificationStateVariable, u32);

    fn verify_proof_final(
        ref self: TContractState,
        job_id: JobId,
        state_constant: FriVerificationStateConstant,
        state_variable: FriVerificationStateVariable,
        last_layer_coefficients: Span<felt252>,
    ) -> ProofVerified;
}

#[starknet::contract]
mod CairoVerifier {
    use starknet::{
        ContractAddress,
        storage::{StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map},
    };
    use integrity::{
        CairoVersion, PublicInputImpl, StarkProofWithSerde, stark::{StarkProof, StarkProofImpl},
        fri::fri::{
            FriLayerWitness, FriVerificationStateConstant, FriVerificationStateVariable,
            hash_constant, hash_variable
        },
        settings::{VerifierSettings, JobId, FactHash, SecurityBits},
    };
    use core::poseidon::{Poseidon, PoseidonImpl, HashStateImpl};
    use super::{ProofVerified, InitResult, ICairoVerifier};

    #[storage]
    struct Storage {
        composition_contract_address: ContractAddress,
        oods_contract_address: ContractAddress,
        state_constant: Map<JobId, Option<felt252>>, // job_id => hash(constant state)
        state_variable: Map<JobId, Option<felt252>>, // job_id => hash(variable state)
        state_fact: Map<JobId, Option<FactHash>>, // job_id => fact_hash
        state_security_bits: Map<JobId, Option<SecurityBits>>, // job_id => security_bits
        state_settings: Map<JobId, Option<VerifierSettings>>, // job_id => verifier_settings
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        composition_contract_address: ContractAddress,
        oods_contract_address: ContractAddress
    ) {
        self.composition_contract_address.write(composition_contract_address);
        self.oods_contract_address.write(oods_contract_address);
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        ProofVerified: ProofVerified,
    }

    #[abi(embed_v0)]
    impl CairoVerifier of ICairoVerifier<ContractState> {
        fn verify_proof_full(
            ref self: ContractState,
            settings: VerifierSettings,
            stark_proof_serde: StarkProofWithSerde,
        ) -> ProofVerified {
            let stark_proof: StarkProof = stark_proof_serde.into();
            let (program_hash, output_hash) = match settings.cairo_version {
                CairoVersion::Cairo0 => stark_proof.public_input.verify_cairo0(),
                CairoVersion::Cairo1 => stark_proof.public_input.verify_cairo1(),
            };
            let security_bits = stark_proof
                .verify(
                    self.composition_contract_address.read(),
                    self.oods_contract_address.read(),
                    @settings
                );

            let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();

            let event = ProofVerified { job_id: 0, fact, security_bits, settings };
            self.emit(event);
            event
        }

        fn verify_proof_initial(
            ref self: ContractState,
            job_id: JobId,
            settings: VerifierSettings,
            stark_proof_serde: StarkProofWithSerde,
        ) -> InitResult {
            assert(self.state_constant.entry(job_id).read().is_none(), 'job_id already exists');

            let stark_proof: StarkProof = stark_proof_serde.into();
            let (program_hash, output_hash) = match settings.cairo_version {
                CairoVersion::Cairo0 => stark_proof.public_input.verify_cairo0(),
                CairoVersion::Cairo1 => stark_proof.public_input.verify_cairo1(),
            };

            let fact = PoseidonImpl::new().update(program_hash).update(output_hash).finalize();

            let (con, var, last_layer_coefficients, security_bits) = stark_proof
                .verify_initial(
                    self.composition_contract_address.read(),
                    self.oods_contract_address.read(),
                    @settings
                );
            self.state_constant.entry(job_id).write(Option::Some(hash_constant(@con)));
            self.state_variable.entry(job_id).write(Option::Some(hash_variable(@var)));
            self.state_fact.entry(job_id).write(Option::Some(fact));
            self.state_security_bits.entry(job_id).write(Option::Some(security_bits));
            self.state_settings.write(job_id, Option::Some(settings));

            let layers_left = con.n_layers - var.iter;

            InitResult {
                program_hash,
                output_hash,
                fact,
                last_layer_coefficients,
                state_constant: con,
                state_variable: var,
                layers_left,
            }
        }

        fn verify_proof_step(
            ref self: ContractState,
            job_id: JobId,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            witness: FriLayerWitness,
        ) -> (FriVerificationStateVariable, u32) {
            assert(
                hash_constant(@state_constant) == self
                    .state_constant
                    .entry(job_id)
                    .read()
                    .expect('No state (constant) saved'),
                'Invalid state (constant)'
            );
            assert(
                hash_variable(@state_variable) == self
                    .state_variable
                    .entry(job_id)
                    .read()
                    .expect('No state (variable) saved'),
                'Invalid state (variable)'
            );
            let settings = self.state_settings.entry(job_id).read().expect('No settings saved');

            let (con, var) = StarkProofImpl::verify_step(
                state_constant, state_variable, witness, @settings
            );
            self.state_variable.entry(job_id).write(Option::Some(hash_variable(@var)));

            let layers_left = con.n_layers - var.iter;

            (var, layers_left)
        }

        fn verify_proof_final(
            ref self: ContractState,
            job_id: JobId,
            state_constant: FriVerificationStateConstant,
            state_variable: FriVerificationStateVariable,
            last_layer_coefficients: Span<felt252>,
        ) -> ProofVerified {
            assert(
                hash_constant(@state_constant) == self.state_constant.entry(job_id).read().unwrap(),
                'Invalid state (constant)'
            );
            assert(
                hash_variable(@state_variable) == self.state_variable.entry(job_id).read().unwrap(),
                'Invalid state (variable)'
            );
            let fact = self.state_fact.entry(job_id).read().expect('No fact saved');
            let security_bits = self
                .state_security_bits
                .entry(job_id)
                .read()
                .expect('No security bits saved');

            let (new_con, new_var) = StarkProofImpl::verify_final(
                state_constant, state_variable, last_layer_coefficients
            );
            assert(new_var.iter.into() == new_con.n_layers + 1, 'Verification not finalized');

            let settings = self.state_settings.entry(job_id).read().expect('No settings saved');

            self.state_variable.entry(job_id).write(Option::None);
            self.state_constant.entry(job_id).write(Option::None);
            self.state_fact.entry(job_id).write(Option::None);
            self.state_security_bits.entry(job_id).write(Option::None);
            self.state_settings.entry(job_id).write(Option::None);

            let event = ProofVerified { job_id, fact, security_bits, settings };
            self.emit(event);
            event
        }
    }
}
