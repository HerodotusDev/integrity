// Writes the following `n` values into array:
// initial, initial * alpha, initial * alpha^2, ..., initial * alpha^(n - 1).
fn powers_array(initial: felt252, alpha: felt252, n: u32) -> Array<felt252> {
    let mut array = ArrayTrait::<felt252>::new();
    let mut value = initial;
    let mut i: u32 = 0;
    loop {
        if i == n {
            break;
        }

        array.append(value);
        value *= alpha;

        i += 1;
    };

    array
}
