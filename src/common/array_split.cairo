use integrity::common::array_extend::ArrayExtendTrait;

#[generate_trait]
impl ArraySplit<T, +Copy<T>, +Drop<T>> of ArraySplitTrait<T> {
    fn split(self: Array<T>, index: u32) -> (Array<T>, Array<T>) {
        let mut arr1 = array![];
        let mut arr2 = array![];

        arr1.extend(self.span().slice(0, index));
        arr2.extend(self.span().slice(index, self.len() - index));

        (arr1, arr2)
    }
}
