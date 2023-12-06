use core::debug::PrintTrait;
use core::array::ArrayTrait;
use common::horner_eval::horner_eval;

#[test]
fn test_horner_eval_0() {
    let mut coefs = ArrayTrait::<felt252>::new();
    let eval = horner_eval(coefs, 1);
    assert(eval == 0, 'invalid evaluation result');
}

#[test]
fn test_horner_eval_1() {
    let mut coefs = ArrayTrait::<felt252>::new();
    coefs.append(1);
    let eval = horner_eval(coefs, 7);
    assert(eval == 1, 'invalid evaluation result');
}

#[test]
fn test_horner_eval_2() {
    let mut coefs = ArrayTrait::<felt252>::new();
    coefs.append(4);
    coefs.append(10);
    coefs.append(19);
    coefs.append(1);
    coefs.append(9);
    let eval = horner_eval(coefs, 13);
    assert(eval == 262591, 'invalid evaluation result');
}

#[test]
fn test_horner_eval_3() {
    let mut coefs = ArrayTrait::<felt252>::new();
    coefs.append(4);
    coefs.append(10);
    coefs.append(19);
    coefs.append(1);
    coefs.append(9);
    coefs.append(99);
    coefs.append(1);
    coefs.append(7);
    coefs.append(13);
    coefs.append(2);
    coefs.append(5);
    coefs.append(7);
    coefs.append(111);
    coefs.append(1);
    let eval = horner_eval(coefs, 19);
    assert(eval == 288577899334361215, 'invalid evaluation result');
}