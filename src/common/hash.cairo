use core::array::SpanTrait;
use pedersen::PedersenTrait;
use hash::HashStateTrait;

fn hash_felts(mut elements: Span<felt252>) -> felt252 {
    let mut hash_state = PedersenTrait::new(0);

    loop {
        match elements.pop_front() {
            Option::Some(element) => { hash_state = hash_state.update(*element) },
            Option::None => { break hash_state.finalize(); }
        }
    }
}
