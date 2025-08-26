fn pow(base: felt252, exp: felt252) -> felt252 {
    if exp == 0 {
        return 1;
    }
    let mut exp: u256 = exp.into();
    let mut res = 1;
    let mut curr_base = base;

    loop {
        if exp == 0 {
            break;
        } else {
            if exp % 2 == 1 {
                res = res * curr_base;
            }
            curr_base = curr_base * curr_base;
            exp = exp / 2;
        }
    }
    res
}

impl Felt252Div of Div<felt252> {
    fn div(lhs: felt252, rhs: felt252) -> felt252 {
        felt252_div(lhs, rhs.try_into().unwrap())
    }
}

impl DivRemFelt252 of DivRem<felt252> {
    fn div_rem(lhs: felt252, rhs: NonZero<felt252>) -> (felt252, felt252) {
        let (q, r) = DivRem::div_rem(
            Into::<felt252, u256>::into(lhs),
            TryInto::<u256, NonZero<u256>>::try_into(Into::<felt252, u256>::into(rhs.into()))
                .unwrap(),
        );
        (q.try_into().unwrap(), r.try_into().unwrap())
    }
}

impl Felt252PartialOrd of PartialOrd<felt252> {
    fn le(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) <= Into::<felt252, u256>::into(rhs)
    }

    fn ge(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) >= Into::<felt252, u256>::into(rhs)
    }

    fn lt(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) < Into::<felt252, u256>::into(rhs)
    }

    fn gt(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) > Into::<felt252, u256>::into(rhs)
    }
}
