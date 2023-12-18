fn pow(base: felt252, exp: felt252) -> felt252 {
    if exp == 0 {
        1
    } else {
        base * pow(base, exp - 1)
    }
}

impl Felt252Div of Div<felt252> {
    fn div(lhs: felt252, rhs: felt252) -> felt252 {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        (lhs_u256 / rhs_u256).try_into().unwrap()
    }
}

impl Felt252PartialOrd of PartialOrd<felt252> {
    fn le(lhs: felt252, rhs: felt252) -> bool {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        lhs <= rhs
    }

    fn ge(lhs: felt252, rhs: felt252) -> bool {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        lhs >= rhs
    }

    fn lt(lhs: felt252, rhs: felt252) -> bool {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        lhs < rhs
    }

    fn gt(lhs: felt252, rhs: felt252) -> bool {
        let lhs_u256: u256 = lhs.into();
        let rhs_u256: u256 = rhs.into();
        lhs > rhs
    }
}
