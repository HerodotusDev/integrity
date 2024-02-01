#[derive(Drop, Copy, Hash, PartialEq)]
struct AddrValue {
    address: felt252,
    value: felt252
}
const AddrValueSize: u32 = 2;

type Page = Array<AddrValue>;

// Information about a continuous page (a consecutive section of the public memory)..
// Each such page must be verified externally to the verifier:
//   hash = Hash(
//     memory[start_address], memory[start_address + 1], ..., memory[start_address + size - 1]).
//   prod = prod_i (z - ((start_address + i) + alpha * (memory[start_address + i])).
// z, alpha are taken from the interaction values, and can be obtained directly from the
// StarkProof object.
//   z     = interaction_elements.memory_multi_column_perm_perm__interaction_elm
//   alpha = interaction_elements.memory_multi_column_perm_hash_interaction_elm0
#[derive(Drop, Copy, PartialEq)]
struct ContinuousPageHeader {
    // Start address.
    start_address: felt252,
    // Size of the page.
    size: felt252,
    // Hash of the page.
    hash: u256,
    // Cumulative product of the page.
    prod: felt252,
}

#[generate_trait]
impl PageImpl of PageTrait {
    // Returns the product of (z - (addr + alpha * val)) over a single page.
    fn get_product(self: @Page, z: felt252, alpha: felt252) -> felt252 {
        let mut res = 1;
        let mut i = 0;
        loop {
            if i == self.len() {
                break res;
            }
            let current = self.at(i);

            res *= z - (*current.address + alpha * *current.value);
            i += 1;
        }
    }

    fn extract_range(self: @Page, addr: u32, len: usize) -> Span<felt252> {
        let mut arr = ArrayTrait::new();
        let mut i = 0;

        loop {
            if i == len {
                break arr.span();
            }

            let current = *self.at(addr + i);

            // TODO is this needed? If not we can just use slice directly 
            assert(current.address == (addr + i).into(), 'Invalid address');
            arr.append(current.value);
            i += 1;
        }
    }

    fn verify_stack(
        self: @Page,
        start_ap: felt252,
        segment_address: felt252,
        builtins: Span<felt252>,
        memory_index: felt252
    ) {
        let mut i = 0;

        // TODO size of SegmentInfo
        let size = 2;
        loop {
            if i == builtins.len() {
                break;
            }

            let current = *self.at(memory_index.try_into().unwrap() + i);

            assert(current.address == start_ap + i.into(), 'Invalid address');
            assert(current.value == segment_address + size * (i.into() + 1), 'Invalid builtin');
            i += 1;
        };
    }
}

fn get_continuous_pages_product(page_headers: Span<ContinuousPageHeader>) -> (felt252, felt252) {
    let mut res = 1;
    let mut total_length = 0;
    let mut i = 0;
    loop {
        if i == page_headers.len() {
            break (res, total_length);
        }
        let current = page_headers.at(i);

        res *= *current.prod;
        total_length += *current.size;

        i += 1;
    }
}

