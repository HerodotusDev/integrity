use channel::add;

#[test]
fn test_add() {
    let result = add(42, 11);
    assert(result == 53, 'Invalid value');
}
