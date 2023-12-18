struct PublicInput {
}

#[generate_trait]
impl PublicInputImpl of PublicInputTrait {
    // Returns the ratio between the product of all public memory cells and z^|public_memory|.
    // This is the value that needs to be at the memory__multi_column_perm__perm__public_memory_prod
    // member expression.
    fn get_public_memory_product_ratio(
        self: @PublicInput,
        z: felt252,
        alpha: felt252,
        public_memory_column_size: felt252
    ) -> felt252 {
        0
    }
}
