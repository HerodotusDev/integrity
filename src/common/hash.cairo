use hash::HashStateTrait;
use pedersen::PedersenTrait;

fn hash_felts(mut elements: Span<felt252>) -> felt252 {
    let mut hash_state = PedersenTrait::new(0);
    let len = elements.len();

    loop {
        match elements.pop_front() {
            Option::Some(element) => { hash_state = hash_state.update(*element) },
            Option::None => {
                hash_state = hash_state.update(len.into());
                break hash_state.finalize();
            }
        }
    }
}
