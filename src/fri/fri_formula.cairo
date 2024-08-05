// Constants representing primitive roots of unity for orders 2, 4, 8, and 16.
// These are calculated based on the formula 1 / 3^((PRIME - 1) / 16) where 3 is a generator.
const OMEGA_16: felt252 = 0x5c3ed0c6f6ac6dd647c9ba3e4721c1eb14011ea3d174c52d7981c5b8145aa75;
const OMEGA_8: felt252 = 0x446ed3ce295dda2b5ea677394813e6eab8bfbc55397aacac8e6df6f4bc9ca34;
const OMEGA_4: felt252 = 0x1dafdc6d65d66b5accedf99bcd607383ad971a9537cdf25d59e99d90becc81e;
const OMEGA_2: felt252 = 0x800000000000011000000000000000000000000000000000000000000000000;

// Function to fold 2 elements into one using one layer of FRI (Fast Reed-Solomon Interactive Oracle
// Proofs).
fn fri_formula2(f_x: felt252, f_minus_x: felt252, eval_point: felt252, x_inv: felt252) -> felt252 {
    f_x + f_minus_x + eval_point * x_inv * (f_x - f_minus_x)
}

// Function to fold 4 elements into one using 2 layers of FRI.
fn fri_formula4(values: Span<felt252>, eval_point: felt252, x_inv: felt252) -> felt252 {
    assert(values.len() == 4, 'Values length invalid');
    // Applying the first layer of folding.
    let g0 = fri_formula2(*values[0], *values[1], eval_point, x_inv);
    let g1 = fri_formula2(*values[2], *values[3], eval_point, x_inv * OMEGA_4);

    // Last layer, combining the results of the first layer.
    fri_formula2(g0, g1, eval_point * eval_point, x_inv * x_inv)
}

// Function to fold 8 elements into one using 3 layers of FRI.
fn fri_formula8(values: Span<felt252>, eval_point: felt252, x_inv: felt252) -> felt252 {
    assert(values.len() == 8, 'Values length invalid');
    // Applying the first two layers of folding.
    let g0 = fri_formula4(values.slice(0, 4), eval_point, x_inv);
    let g1 = fri_formula4(values.slice(4, 4), eval_point, x_inv * OMEGA_8);

    // Preparing variables for the last layer.
    let eval_point2 = eval_point * eval_point;
    let eval_point4 = eval_point2 * eval_point2;
    let x_inv2 = x_inv * x_inv;
    let x_inv4 = x_inv2 * x_inv2;

    // Last layer, combining the results of the previous layers.
    fri_formula2(g0, g1, eval_point4, x_inv4)
}

// Function to fold 16 elements into one using 4 layers of FRI.
fn fri_formula16(values: Span<felt252>, eval_point: felt252, x_inv: felt252) -> felt252 {
    assert(values.len() == 16, 'Values length invalid');
    // Applying the first three layers of folding.
    let g0 = fri_formula8(values.slice(0, 8), eval_point, x_inv);
    let g1 = fri_formula8(values.slice(8, 8), eval_point, x_inv * OMEGA_16);

    // Preparing variables for the last layer.
    let eval_point2 = eval_point * eval_point;
    let eval_point4 = eval_point2 * eval_point2;
    let eval_point8 = eval_point4 * eval_point4;
    let x_inv2 = x_inv * x_inv;
    let x_inv4 = x_inv2 * x_inv2;
    let x_inv8 = x_inv4 * x_inv4;

    // Last layer, combining the results of the previous layers.
    fri_formula2(g0, g1, eval_point8, x_inv8)
}

// Folds 'coset_size' elements into one using log2(coset_size) layers of FRI.
// 'coset_size' can be 2, 4, 8, or 16.
fn fri_formula(
    values: Span<felt252>, eval_point: felt252, x_inv: felt252, coset_size: felt252
) -> felt252 {
    // Sort by usage frequency.
    if (coset_size == 8) {
        return fri_formula8(values, eval_point, x_inv);
    } else if (coset_size == 4) {
        return fri_formula4(values, eval_point, x_inv);
    } else if (coset_size == 16) {
        return fri_formula16(values, eval_point, x_inv);
    } else {
        assert(values.len() == 2, 'Values length invalid');
        return fri_formula2(*values[0], *values[1], eval_point, x_inv);
    }
}
