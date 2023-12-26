trait ArrayExtendTrait<T> {
    fn extend(ref self: Array<T>, span: Span<T>);
}

impl ArrayExtend<T, +Copy<T>, +Drop<T>> of ArrayExtendTrait<T> {
    fn extend(ref self: Array<T>, span: Span<T>) {
        let mut i = 0;
        loop {
            if i == span.len() {
                break;
            };
            self.append(*span.at(i));
            i += 1;
        };
    }
}
