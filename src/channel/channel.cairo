use poseidon::{hades_permutation, poseidon_hash_span};

#[derive(Drop)]
struct Channel {
    digest: felt252,
    counter: felt252,
}

#[generate_trait]
impl ChannelImpl of ChannelTrait {
    fn new(digest: felt252) -> Channel {
        Channel { digest: digest, counter: 0 }
    }

    fn new_with_counter(digest: felt252, counter: felt252) -> Channel {
        Channel { digest: digest, counter: counter }
    }

    fn random_felt_to_prover(ref self: Channel) -> felt252 {
        let (hash, _, _) = hades_permutation(self.digest, self.counter, 2);
        self.counter += 1;
        hash
    }

    fn random_felts_to_prover(ref self: Channel, mut n: felt252) -> Array<felt252> {
        let mut res = ArrayTrait::<felt252>::new();
        loop {
            if n != 0 {
                res.append(self.random_felt_to_prover());
                n -= 1;
            } else {
                break;
            }
        };
        res
    }

    fn read_felt_from_prover(ref self: Channel, value: felt252) {
        let mut hash_data = ArrayTrait::new();
        hash_data.append(self.digest + 1);
        hash_data.append(value);

        self.digest = poseidon_hash_span(hash_data.span());
        self.counter = 0;
    }

    fn read_felt_vector_from_prover(ref self: Channel, mut values: Span<felt252>) {
        let mut hash_data = ArrayTrait::new();

        hash_data.append(self.digest + 1);

        loop {
            match values.pop_front() {
                Option::Some(value) => { hash_data.append(*value); },
                Option::None => { break; }
            }
        };

        self.digest = poseidon_hash_span(hash_data.span());
        self.counter = 0;
    }

    fn read_uint64_from_prover(ref self: Channel, value: u64) {
        self.read_felt_from_prover(value.into())
    }
}
