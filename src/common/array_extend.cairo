#[generate_trait]
impl ArrayExtend<T, +Copy<T>, +Drop<T>> of ArrayExtendTrait<T> {
    fn extend(ref self: Array<T>, mut span: Span<T>) {
        loop {
            match span.pop_front() {
                Option::Some(x) => { self.append(*x) },
                Option::None => { break; }
            };
        };
    }
}
