use num_bigint::BigUint;
use swiftness_proof_parser::*;

pub trait IntoAst {
    fn into_ast(self) -> Vec<Expr>;
}

impl IntoAst for u32 {
    fn into_ast(self) -> Vec<Expr> {
        vec![Expr::Value(format!("{self}"))]
    }
}

impl IntoAst for usize {
    fn into_ast(self) -> Vec<Expr> {
        vec![Expr::Value(format!("{self}"))]
    }
}

impl IntoAst for BigUint {
    fn into_ast(self) -> Vec<Expr> {
        vec![Expr::Value(format!("{self}"))]
    }
}

impl IntoAst for &BigUint {
    fn into_ast(self) -> Vec<Expr> {
        vec![Expr::Value(format!("{self}"))]
    }
}

impl IntoAst for StarkProof {
    fn into_ast(self) -> Vec<Expr> {
        [
            self.config.into_ast(),
            self.public_input.into_ast(),
            self.unsent_commitment.into_ast(),
            self.witness.into_ast(),
        ]
        .concat()
    }
}

impl IntoAst for StarkConfig {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.traces.into_ast());
        exprs.append(&mut self.composition.into_ast());
        exprs.append(&mut self.fri.into_ast());
        exprs.append(&mut self.proof_of_work.into_ast());
        exprs.append(&mut self.log_trace_domain_size.into_ast());
        exprs.append(&mut self.n_queries.into_ast());
        exprs.append(&mut self.log_n_cosets.into_ast());
        exprs.append(&mut self.n_verifier_friendly_commitment_layers.into_ast());
        exprs
    }
}

impl IntoAst for TracesConfig {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.original.into_ast());
        exprs.append(&mut self.interaction.into_ast());
        exprs
    }
}

impl IntoAst for TableCommitmentConfig {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.n_columns.into_ast());
        exprs.append(&mut self.vector.into_ast());
        exprs
    }
}

impl IntoAst for VectorCommitmentConfig {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.height.into_ast());
        exprs.append(&mut self.n_verifier_friendly_commitment_layers.into_ast());
        exprs
    }
}

impl IntoAst for FriConfig {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.log_input_size.into_ast());
        exprs.append(&mut self.n_layers.into_ast());
        exprs.append(&mut self.inner_layers.into_ast());
        exprs.append(&mut self.fri_step_sizes.into_ast());
        exprs.append(&mut self.log_last_layer_degree_bound.into_ast());
        exprs
    }
}

impl IntoAst for StarkUnsentCommitment {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.traces.into_ast());
        exprs.append(&mut self.composition.into_ast());
        exprs.append(&mut self.oods_values.into_ast());
        exprs.append(&mut self.fri.into_ast());
        exprs.append(&mut self.proof_of_work.into_ast());
        exprs
    }
}

impl IntoAst for TracesUnsentCommitment {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.original.into_ast());
        exprs.append(&mut self.interaction.into_ast());
        exprs
    }
}

impl IntoAst for FriUnsentCommitment {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.inner_layers.into_ast());
        exprs.append(&mut self.last_layer_coefficients.into_ast());
        exprs
    }
}

impl IntoAst for ProofOfWorkUnsentCommitment {
    fn into_ast(self) -> Vec<Expr> {
        vec![Expr::Value(format!("{}", self.nonce))]
    }
}

impl IntoAst for ProofOfWorkConfig {
    fn into_ast(self) -> Vec<Expr> {
        vec![Expr::Value(format!("{}", self.n_bits))]
    }
}

impl IntoAst for StarkWitness {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.traces_decommitment.into_ast());
        exprs.append(&mut self.traces_witness.into_ast());
        exprs.append(&mut self.composition_decommitment.into_ast());
        exprs.append(&mut self.composition_witness.into_ast());
        exprs.append(&mut self.fri_witness.into_ast());
        exprs
    }
}

impl IntoAst for TracesDecommitment {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.original.into_ast());
        exprs.append(&mut self.interaction.into_ast());
        exprs
    }
}

impl IntoAst for TableDecommitment {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![Expr::Value(format!("{}", self.n_values))];
        exprs.append(&mut self.values.into_ast());
        exprs
    }
}

impl IntoAst for TracesWitness {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.original.into_ast());
        exprs.append(&mut self.interaction.into_ast());
        exprs
    }
}

impl IntoAst for TableCommitmentWitness {
    fn into_ast(self) -> Vec<Expr> {
        self.vector.into_ast()
    }
}

impl IntoAst for TableCommitmentWitnessFlat {
    fn into_ast(self) -> Vec<Expr> {
        self.vector.into_ast()
    }
}

impl IntoAst for VectorCommitmentWitness {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![Expr::Value(format!("{}", self.n_authentications))];
        exprs.append(&mut self.authentications.into_ast());
        exprs
    }
}

impl IntoAst for VectorCommitmentWitnessFlat {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![Expr::Value(format!("{}", self.n_authentications))];
        exprs.append(
            &mut self
                .authentications
                .iter()
                .flat_map(|x| x.into_ast())
                .collect::<Vec<_>>(),
        );
        exprs
    }
}

impl IntoAst for FriWitness {
    fn into_ast(self) -> Vec<Expr> {
        self.layers.into_ast()
    }
}

impl IntoAst for FriLayerWitness {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![Expr::Value(format!("{}", self.n_leaves))];
        exprs.append(
            &mut self
                .leaves
                .iter()
                .flat_map(|x| x.into_ast())
                .collect::<Vec<_>>(),
        );
        exprs.append(&mut self.table_witness.into_ast());
        exprs
    }
}

impl IntoAst for PublicInput {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.log_n_steps.into_ast());
        exprs.append(&mut self.range_check_min.into_ast());
        exprs.append(&mut self.range_check_max.into_ast());
        exprs.append(&mut self.layout.into_ast());
        exprs.push(Expr::Array(
            self.dynamic_params
                .values()
                .map(|v| Expr::Value(format!("{v}")))
                .collect(),
        ));
        exprs.append(&mut self.n_segments.into_ast());
        exprs.append(&mut self.segments.into_ast());
        exprs.append(&mut self.padding_addr.into_ast());
        exprs.append(&mut self.padding_value.into_ast());
        exprs.append(&mut self.main_page_len.into_ast());
        exprs.append(&mut self.main_page.into_ast());
        exprs.append(&mut self.n_continuous_pages.into_ast());
        exprs.append(&mut self.continuous_page_headers.into_ast());
        exprs
    }
}

impl IntoAst for SegmentInfo {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.begin_addr.into_ast());
        exprs.append(&mut self.stop_ptr.into_ast());
        exprs
    }
}

impl IntoAst for PubilcMemoryCell {
    fn into_ast(self) -> Vec<Expr> {
        let mut exprs = vec![];
        exprs.append(&mut self.address.into_ast());
        exprs.append(&mut self.value.into_ast());
        exprs
    }
}

impl<T> IntoAst for Vec<T>
where
    T: IntoAst,
{
    fn into_ast(self) -> Vec<Expr> {
        vec![Expr::Array(
            self.into_iter().flat_map(|x| x.into_ast()).collect(),
        )]
    }
}

impl From<StarkConfig> for Exprs {
    fn from(v: StarkConfig) -> Self {
        Exprs(v.into_ast())
    }
}

impl From<PublicInput> for Exprs {
    fn from(v: PublicInput) -> Self {
        Exprs(v.into_ast())
    }
}

impl From<StarkUnsentCommitment> for Exprs {
    fn from(v: StarkUnsentCommitment) -> Self {
        Exprs(v.into_ast())
    }
}

impl From<StarkWitness> for Exprs {
    fn from(v: StarkWitness) -> Self {
        Exprs(v.into_ast())
    }
}

impl From<StarkProof> for Exprs {
    fn from(proof: StarkProof) -> Self {
        Exprs(proof.into_ast())
    }
}

use std::{
    fmt::Display,
    ops::{Deref, DerefMut},
};

#[derive(Debug, Clone)]
pub enum Expr {
    Value(String),
    Array(Vec<Expr>),
}

impl Display for Expr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Expr::Value(v) => write!(f, "\"{v}\""),
            Expr::Array(v) => {
                write!(f, "[")?;

                for (i, expr) in v.iter().enumerate() {
                    if i != 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{expr}")?;
                }

                write!(f, "]")?;

                Ok(())
            }
        }
    }
}

#[derive(Debug, Clone)]
pub struct Exprs(pub Vec<Expr>);

impl Display for Exprs {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "[")?;

        for (i, expr) in self.iter().enumerate() {
            if i != 0 {
                write!(f, ", ")?;
            }
            write!(f, "{expr}")?;
        }

        write!(f, "]")?;

        Ok(())
    }
}

impl Deref for Exprs {
    type Target = Vec<Expr>;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl DerefMut for Exprs {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}

pub struct StarkProofExprs {
    pub config: Exprs,
    pub public_input: Exprs,
    pub unsent_commitment: Exprs,
    pub witness: Exprs,
}

impl From<StarkProof> for StarkProofExprs {
    fn from(value: StarkProof) -> Self {
        Self {
            config: Exprs::from(value.config),
            public_input: Exprs::from(value.public_input),
            unsent_commitment: Exprs::from(value.unsent_commitment),
            witness: Exprs::from(value.witness),
        }
    }
}
