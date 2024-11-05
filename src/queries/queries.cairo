use integrity::{
    channel::channel::{Channel, ChannelTrait},
    common::{
        merge_sort::merge_sort, math::pow, consts::FIELD_GENERATOR, bit_reverse::BitReverseTrait
    },
    domains::StarkDomains
};

// 2^64 = 18446744073709551616
const U128maxU64: u128 = 18446744073709551616;

fn generate_queries(
    ref channel: Channel, n_samples: u32, query_upper_bound: u64
) -> Array<felt252> {
    let samples = sample_random_queries(ref channel, n_samples, query_upper_bound);
    usort(samples.span().slice(0, n_samples))
}

fn sample_random_queries(
    ref channel: Channel, mut n_samples: u32, query_upper_bound: u64
) -> Array<u64> {
    let mut result = ArrayTrait::<u64>::new();

    let query_upper_bound_u128: u128 = query_upper_bound.into();
    let query_upper_bound_nonzero: NonZero<u128> = query_upper_bound_u128.try_into().unwrap();

    loop {
        if n_samples == 0 {
            break;
        }

        let res = channel.random_felt_to_prover();
        let low128 = Into::<felt252, u256>::into(res).low;
        let (_, sample) = DivRem::div_rem(low128, query_upper_bound_nonzero);
        result.append(sample.try_into().unwrap());

        n_samples -= 1;
    };

    result
}

// Sorts an array of field elements and removes duplicates.
// Returns the sorted array.
fn usort(input: Span<u64>) -> Array<felt252> {
    let mut result = ArrayTrait::<felt252>::new();

    if input.len() == 0 {
        return result;
    }

    let sorted = merge_sort(input);

    let mut prev = *sorted.at(0);
    result.append(prev.into());

    let mut i: u32 = 1;
    loop {
        if i == sorted.len() {
            break;
        }

        let curr = *sorted.at(i);
        if curr != prev {
            result.append(curr.into());
            prev = curr;
        }

        i += 1;
    };

    result
}

fn queries_to_points(queries: Span<felt252>, stark_domains: @StarkDomains) -> Array<felt252> {
    let mut points = ArrayTrait::<felt252>::new();

    // Evaluation domains of size greater than 2**64 are not supported
    assert((*stark_domains.log_eval_domain_size).into() <= 64_u256, 'Eval domain too big');

    // A 'log_eval_domain_size' bits index can be bit reversed using bit_reverse_u64 if it is
    // multiplied by 2**(64 - log_eval_domain_size) first.
    let shift = pow(2, 64 - (*stark_domains.log_eval_domain_size).into());

    let mut i: u32 = 0;
    loop {
        if i == queries.len() {
            break;
        }

        let index: u64 = (*queries.at(i) * shift).try_into().unwrap();

        // Compute the x value of the query in the evaluation domain coset:
        // FIELD_GENERATOR * eval_generator ^ reversed_index.
        points
            .append(
                FIELD_GENERATOR * pow(*stark_domains.eval_generator, index.bit_reverse().into())
            );

        i += 1;
    };
    points
}
