use core::option::OptionTrait;
use core::integer::U128BitAnd;

#[generate_trait]
impl BitReverseU64 of BitReverseTrait {
    fn bit_reverse(self: u64) -> u64 {
        let num: u128 = self.into();
        // Swap 1 bit chunks, and shift left by 1.
        let masked = U128BitAnd::bitand(num, 0x5555555555555555);
        let num = masked * 0x3 + num;
        // Swap 2 bit chunks, and shift left by 2.
        let masked = U128BitAnd::bitand(num, 0x6666666666666666);
        let num = masked * 0xf + num;
        // Swap 4 bit chunks, and shift left by 4.
        let masked = U128BitAnd::bitand(num, 0x7878787878787878);
        let num = masked * 0xff + num;
        // Swap 8 bit chunks, and shift left by 8.
        let masked = U128BitAnd::bitand(num, 0x7f807f807f807f80);
        let num = masked * 0xffff + num;
        // Swap 16 bit chunks, and shift left by 16.
        let masked = U128BitAnd::bitand(num, 0x7fff80007fff8000);
        let num = masked * 0xffffffff + num;
        // Swap 16 bit chunks, and shift left by 32.
        let masked = U128BitAnd::bitand(num, 0x7fffffff80000000);
        let num = masked * 0xffffffffffffffff + num;

        // Combine in reverse.
        (num / 0x8000000000000000).try_into().unwrap()
    }
}
