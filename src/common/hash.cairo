use pedersen::PedersenTrait;
use hash::HashStateTrait;

fn hash_felts(s: Span<felt252>) -> felt252 {
    let mut hash_state = PedersenTrait::new(0);
    let mut i = 0;

    loop {
        if i == s.len() {
            break hash_state.finalize();
        }

        hash_state.update(*s.at(i));
    }
}
