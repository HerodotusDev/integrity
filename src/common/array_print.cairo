use core::debug::PrintTrait;

impl ArrayPrintTrait<T, +PrintTrait<T>, +Drop<T>, +Copy<T>> of PrintTrait<Array<T>> {
    fn print(self: Array<T>) {
        let span = self.span();
        let mut i = 0;
        loop {
            if i == span.len() {
                break;
            };
            (*span[i]).print();
            i += 1;
        };
    }
}

impl SpanPrintTrait<T, +PrintTrait<T>, +Drop<T>, +Copy<T>> of PrintTrait<Span<T>> {
    fn print(self: Span<T>) {
        let mut i = 0;
        loop {
            if i == self.len() {
                break;
            };
            (*self[i]).print();
            i += 1;
        };
    }
}