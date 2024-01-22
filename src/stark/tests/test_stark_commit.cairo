use cairo_verifier::stark::stark_commit::stark_commit;
use cairo_verifier::channel::channel::ChannelTrait;
use cairo_verifier::air::public_input::PublicInput;
use cairo_verifier::air::global_values::InteractionElements;
use cairo_verifier::stark::{StarkUnsentCommitment, StarkConfig, StarkCommitment};
use cairo_verifier::air::traces::{TracesUnsentCommitment, TracesConfig, TracesCommitment};
use cairo_verifier::air::public_input::SegmentInfo;
use cairo_verifier::air::public_memory::AddrValue;
use cairo_verifier::fri::fri::{FriUnsentCommitment, FriConfig, FriCommitment};
use cairo_verifier::proof_of_work::proof_of_work::ProofOfWorkUnsentCommitment;
use cairo_verifier::proof_of_work::config::ProofOfWorkConfig;
use cairo_verifier::table_commitment::table_commitment::{TableCommitmentConfig, TableCommitment};
use cairo_verifier::vector_commitment::vector_commitment::{
    VectorCommitmentConfig, VectorCommitment
};
use cairo_verifier::domains::StarkDomains;

// test generated based on cairo0-verifier run on fib proof from stone-prover
#[test]
#[available_gas(9999999999)]
fn test_stark_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        u256 { low: 0xba9d17a3ebd900899148b125421c118f, high: 0x87433b8dd90acbfe5abea8474d795191 },
        0x0
    );

    let public_input = @PublicInput {
        log_n_steps: 0xe,
        rc_min: 0x7ffa,
        rc_max: 0x8001,
        layout: 0x726563757273697665,
        dynamic_params: array![],
        segments: array![
            SegmentInfo { begin_addr: 0x1, stop_ptr: 0x5 },
            SegmentInfo { begin_addr: 0x25, stop_ptr: 0x68 },
            SegmentInfo { begin_addr: 0x68, stop_ptr: 0x6a },
            SegmentInfo { begin_addr: 0x6a, stop_ptr: 0x6a },
            SegmentInfo { begin_addr: 0x1ea, stop_ptr: 0x1ea },
            SegmentInfo { begin_addr: 0x9ea, stop_ptr: 0x9ea },
        ],
        padding_addr: 0x1,
        padding_value: 0x40780017fff7fff,
        main_page: array![
            AddrValue { address: 0x1, value: 0x40780017fff7fff },
            AddrValue { address: 0x2, value: 0x4 },
            AddrValue { address: 0x3, value: 0x1104800180018000 },
            AddrValue { address: 0x4, value: 0x4 },
            AddrValue { address: 0x5, value: 0x10780017fff7fff },
            AddrValue { address: 0x6, value: 0x0 },
            AddrValue { address: 0x7, value: 0x40780017fff7fff },
            AddrValue { address: 0x8, value: 0x1 },
            AddrValue { address: 0x9, value: 0x400380007ffa8000 },
            AddrValue { address: 0xa, value: 0x480680017fff8000 },
            AddrValue { address: 0xb, value: 0x1 },
            AddrValue { address: 0xc, value: 0x480680017fff8000 },
            AddrValue { address: 0xd, value: 0x1 },
            AddrValue { address: 0xe, value: 0x480a80007fff8000 },
            AddrValue { address: 0xf, value: 0x1104800180018000 },
            AddrValue { address: 0x10, value: 0x9 },
            AddrValue { address: 0x11, value: 0x400280017ffa7fff },
            AddrValue { address: 0x12, value: 0x482680017ffa8000 },
            AddrValue { address: 0x13, value: 0x2 },
            AddrValue { address: 0x14, value: 0x480a7ffb7fff8000 },
            AddrValue { address: 0x15, value: 0x480a7ffc7fff8000 },
            AddrValue { address: 0x16, value: 0x480a7ffd7fff8000 },
            AddrValue { address: 0x17, value: 0x208b7fff7fff7ffe },
            AddrValue { address: 0x18, value: 0x20780017fff7ffd },
            AddrValue { address: 0x19, value: 0x4 },
            AddrValue { address: 0x1a, value: 0x480a7ffc7fff8000 },
            AddrValue { address: 0x1b, value: 0x208b7fff7fff7ffe },
            AddrValue { address: 0x1c, value: 0x480a7ffc7fff8000 },
            AddrValue { address: 0x1d, value: 0x482a7ffc7ffb8000 },
            AddrValue { address: 0x1e, value: 0x482680017ffd8000 },
            AddrValue {
                address: 0x1f,
                value: 0x800000000000011000000000000000000000000000000000000000000000000
            },
            AddrValue { address: 0x20, value: 0x1104800180018000 },
            AddrValue {
                address: 0x21,
                value: 0x800000000000010fffffffffffffffffffffffffffffffffffffffffffffff9
            },
            AddrValue { address: 0x22, value: 0x208b7fff7fff7ffe },
            AddrValue { address: 0x23, value: 0x25 },
            AddrValue { address: 0x24, value: 0x0 },
            AddrValue { address: 0x25, value: 0x68 },
            AddrValue { address: 0x26, value: 0x6a },
            AddrValue { address: 0x27, value: 0x1ea },
            AddrValue { address: 0x28, value: 0x9ea },
            AddrValue { address: 0x64, value: 0x6a },
            AddrValue { address: 0x65, value: 0x6a },
            AddrValue { address: 0x66, value: 0x1ea },
            AddrValue { address: 0x67, value: 0x9ea },
            AddrValue { address: 0x68, value: 0xa },
            AddrValue { address: 0x69, value: 0x90 },
        ],
        continuous_page_headers: array![],
    };

    let unsent_commitment = @StarkUnsentCommitment {
        traces: TracesUnsentCommitment {
            original: 0xa43e1b3b99d987d63116edc58aa49a7d510a667951852446419df5ede6a1cc,
            interaction: 0x32b3d365d461b6c12ab7d3396b5225903bd17bc85216f300472afea65cab39a,
        },
        composition: 0x6e8740c697a0302b55c1b26d955e4befbaedc6bceeeeb54ee6f2dbc9a68bca1,
        oods_values: array![
            0x3a63c21f32409c9ec7614199b40102547e7f698f903bdbbffe56785684b7e04,
            0x5652f216d992bbf255b97dd1b0a4dde72fab97f1bbcc4a4f53fde7fc50293c8,
            0x7c096e451cd06aa80d11322e82a4f4a9eb62413fbc76044867c36090d416dd5,
            0x787521b50c17169b9729a4522e1a0e7bdc028fc8ffdd87c70147bd67c5595d3,
            0x3c329225074106c03d9385a2fbe9aa6a9eecd2b13c6e26884de5acca7251460,
            0x31c7338a8e2a5b04693650792e9cac8f907a3a1c6bec9866889b0dd230b2b2c,
            0x1d8edac47ced1b6fa8a00305efc527d90a5e2b3d31d6a5d3bf33354d0d77c1,
            0x26dd3e59e2541dbe8a3aac06cc0262054f106cd409750e50fc08a32c5ed4947,
            0x3808f487ede4ffb746a97f5621717e8c247e56c71e4b801a89ea134207447ad,
            0x6787bf2159e5fe087900ca33c820ef7bd8ae0ac14fb2daf34c8db53624dbeeb,
            0x649fba72665a03f0d5fe2b61b227501a5b8f7b7acebc4cbaf09380338761ea7,
            0x5cd1c022d91173ff01b59e57f5ac27e0cc8cd06dc695c68fad795acad56331a,
            0x3b17acce9df933e0f951fa2dc5881337d4637f3da2649b32f6d7cbcec76635d,
            0x4ef09f53ec97c0ae427c01aa3138fc0ebb5fa0e0eff8aa88a58e24d0721566b,
            0x66ba8fee46d58ef5821e2f805c760944899d083a5de8b568f7cb28ba5a5bab5,
            0xab844aafcad2b0be5d1372f76be5f8af13117e83efdeba484c82f4b880d945,
            0x7bc4eb9a0b0c62e4e1b025b3186bc4342f4c1a4dd4f8d906fa312bd94df4883,
            0x30697d309839cef6817d37eff90b7e4e222ab8a7db1dd97097793065acf0b85,
            0x2c1f7ce4803cbea74eef0f6302ab3036a399622ec730d5886de2dc2d07852c1,
            0x2ee0fbc2c470ed13fba562a041682eefaeeff60b9ccf343b98a55135e3dc07d,
            0x4ef8992548369e4218881ec2a87ac1f1236fae994793441faa9c1cb07d76a6e,
            0x1bbd239d9bda4fdd8eb564a4b823b3b8a42c7f092910ba595712385f5844363,
            0x7dd197fc9ed8d7ac52643249787eaddb76f8b70a8d9f8ac17cb333067e5405e,
            0x6242725f5db1976d9d4df1c33e2ee59c5ee6d2f04d8a0938a78936f9969b315,
            0x278f1df82d86f636feb36bfa6aaed961f02f83e00a65f036b7293b998da9a9d,
            0x573e839f79edb998361136674befc4f14a438e32b6b058d44e1881db9a3e0ef,
            0xc9e64e4dc62fba091213d48317a642af02cf3cd21bc1fa99cdf2ae390d76a9,
            0x61bcca7e2434fe2845f1407142a4c2183531a741ac808368113af971fb3e3af,
            0x30323fa36bc5c9f0a646e9c83cbeefe8400b769e415495ce785cc4ab1fe2c61,
            0x6bb7fd058f8d69230d9407b2a6e9a319f26de238a612654858ece15d4056398,
            0x2793a5b8852a2101eff784e4549ec9814d22fb5aaa855ed00aacc26cc16e27f,
            0x416d2d8a6515bf82568ea0d3ba067ef2862ca0b60000fad3bbd148a6dc9aac7,
            0x2e9fc14b4c0bd7efc3c8f9575c01b46c5c050d1a13777e027999264fa2703a5,
            0x35222b20560ccdcf2b44cd9071fb1e74b5d8cdfb0bf3f306720a2dbd6a4131b,
            0x4fa5a00c2c14bb62a783d0683dd6464fc8557b0c2727c2473c3dc1e502418ec,
            0x53f6daaa6cfd4b45c3800ce6a533c547e0bd061fa53bff9cc300f296c1ac75,
            0x579a8f58b31caf4bb0c0eb3c3ff3098d7c22dcdc12ed2b79015df21241e695d,
            0x3662f88a8833549ef08ca409b7d03baae580acb5479db93bea215486116fab1,
            0x72d89620b70f59d95533ceddeea9b42ad6e485ce82ae1e8fdbf909c915a21ab,
            0x1a274e2239deacae84f78e0c032191394e53fef8cbd0ee901170aecf8b14bf1,
            0x219c4fe98876996045a2b738a44dac48a0fbcfee5ada3791e91e899e36a48cf,
            0x38337993a5467391468d056c453deb1184115877703f4bba33e326b8a5f777b,
            0x5e903001774644d4d6b2bdef63c8d61496a86fb9c262e6e7b79d87114132166,
            0x614dd4c24b2c903f07c669017861d7ea495463d63033a6d5253491b024e6124,
            0x4a563d8494f0d712455c57b6944c2bdbf0e5a21ed1bca6adcc84dbab9461b05,
            0x4a2aec687b7b78cd517bdd437d4ec61e855438fc9dfb1b37f6a20088f4f47bd,
            0x208f098c8f25947dc9fd5b138a3fd816599f34eed1e2582301af377fbd66a9c,
            0x5b1c2e1450b4e5027e13dad6ad6857e669f923c5c2f8ccea869a6af4d329259,
            0x9a253af187dc262630e1c872b1291f57dc72580d5c95dd7d63d95c4cd04c91,
            0x4641af946768cb50b17b0e13612b522b424226bb58cfa2881a8e1837e3b70ab,
            0x3f644fbd8949c0cb2f9102e63ea60cb23a9183968d02636a59199e0d3684c62,
            0x3cea05e4cfeef52d0a1b1c0e74179cc527f4b0ee46e5372560fe5b926f42b63,
            0x2c9940c95f9a17a8e5fd12b49a8e2c47266b0e9a4cd467ea9d36d826c29ccf5,
            0x432e8b4a079141d4a798ffd785d29ff0bd91deda0babb3f2b081029fcd750c2,
            0x15c6cf8f973411c95c1311efc333322a9887c58d336382be9933e0167316ee3,
            0x3f49f92f7a848997e79ee607088b0d88b72eaec8c0f0c929a7f28decf22e8ad,
            0xec249e3194855eb2cc9d155c8dcd96fac4716adc4c7d0c61bbc441305aa747,
            0xdf003cd1043ff595feddd0828c442a6c1e00a97157cfd328621a8c9d199c3f,
            0x3239d14b92ddec576421cc7efd6d83d33892a7c1a7f6d191e688fc0071852fb,
            0x6488a1054deb3e1a276884f5fac32701cf6c78688d9ccdef7c7e64e0d96676e,
            0x20fa0bb45d2ab48b84945677b6948233bd32ea373354be935f24073cc323157,
            0x5999f45d12cf8e4529e98bd152625421146584d60080d955dd5199da4a9f895,
            0x167e3697aae192fd8936b7abe29976b802eb8cd635f97747751aae5dadbfc71,
            0x14c7ee181752eaa201dfe4ff523bc8b85199148caebe219117b37d70f913fd2,
            0x2103673965b8927c64b311f493514320b04faae92bd1c2e9bc608c2096773c,
            0x4aa6d83f159484ff686fa304a011b5b89fb9916c8cfcf787f029cf82fcff6e1,
            0x4e94bc0d77b9ee122fe9db048f2bcf67658bb34bd9e29d733bcdfd7ab99f289,
            0x3d385bbefadaa470347c6ab25b66578ada66100f36fe96322b885b349a6d4ad,
            0x51f803cd7449b1fe21b93e19eda29940c5053dedef9fe476ef20717192477b5,
            0x6e251054f255ff83c8bde7d7c38c8148fed2797b5f390b8223a61150ce75c3c,
            0x32d2e7c9da1da713eef599074ad5ebf45b69f5c59bd679196410c116a22391a,
            0xc3e8650c42056870374d101b298c08c96c9ee5b0e36a07c7adeaff9726e36f,
            0x219ff5bd061bae60b15652d7e1576db46b3e62e0516c0e1a5dc1c477a7b19b4,
            0x2d35cbade6e664f8555dadc64a1d6a35e67f981f37673ddbbf4018cd6964488,
            0xff4abb08af6a9e2e15c0db372c9f3ab678440f37f585907b92b9641b2c51e9,
            0x1e561e46de019fd4a58e6ed9065d2431c573dcb9fc64fcae5259c7cda2eca9e,
            0x3eba7c7b00ea052bd85d80fd0593114246bb3dfa7132593e8ca7dc5fb0b5443,
            0x7370fb43eb926b47c873b168f95e695f988c0c0ecc360cb30cc4a7c52e3f705,
            0x7eb81bf822ae7298d79a84af3db1d51686b669bc76448928529a90af30d3ef4,
            0x3add254a71be450b03c0adc48aae3f50921a3c9f2c314992dc816c3c7b8a547,
            0x5ed3690969bb9953f7c7e425fd357052398c7454632d7ee3b56a3f952056a50,
            0x5f2da4667133d7a8fd61f0798eda83afbedd8b8091b588b5d671fce06c90f9b,
            0x6ed3b623a6a56f9cd70870b41e14f39ade27b49032a01ce13d1ac1cf612a587,
            0x2c48cd143e27713d6ed8a431f9f77fbc2e02acda139e82ad2e537d49bab51f6,
            0x486933e036c569cef2e2e1e61105f38e68829090e920ca8db475c5b32453ef2,
            0x7b24eaff77ac3967fccfccd3da6cd1cdccf6b226ea6d9614293a944f1dad6f,
            0x754150aec4b9279797c70fbc410ba05a5b2c98e0d9d4621f3b1c98e4ba29b6c,
            0x341ef6cbeae139dd3883a5a7fa64a886d95d99734682e151b542ebc5416cf97,
            0x7cfa6ad883bdc66f63d7471fd6669e7257534d0f96f489d11fafaaf7e6783e0,
            0x71aebca6d6527b6f0177c8a93dc927fbed6e4f95f38ec2ef0212cfe52cf09e3,
            0x521681b827cb7dbc41977031d2240f791f3d6b4c9d3239de290111c840b7d1e,
            0x1dfe4fcee6093e9d90760a96e4732be752a85bc08f37f9dbcddf7bba785441a,
            0x53750e6013edf3eb9f914afd88e90a888a06ed6c26c6ae8bc47e430189ce568,
            0x2237fc57788563e04e734b907860250c493970a176b9909c4bce453ca3645f3,
            0x19b8aecbdf4f3f4bbcdf454aaf26af393e661d62a6761deb8f6479d9ffd19c3,
            0x34219cf157543e6b906b2cfb94cde84adb067335b671fb76bb820cf8f4a2bcc,
            0x104a69651259f8fc85041c46426951254d543203cd88b1c0ada870c351f5a5d,
            0x6bad92813499115dcbc992ee7fc1a75c28927e4cd0e786206e73d5be67947f5,
            0x49a1442ee229a58408244dfa9a57769bbf0fbe94f408d6e1386d80f88852b63,
            0xc192d6e9d0610608b0a89b2a02e8bdccfb076f774e17a091292f8e01de3755,
            0x1dc818657705c5c14194f7f883b8fb089cbe16482dc3d6a09c500a793b4db03,
            0x41ff704a6c5350dceaa7f302a75f646a885cf43cb44bf4cdc32ee1995a51835,
            0x7339ab6a29ec4a422e1a2d0cf60c0143fc2f6b78a790003964d9651a117e14c,
            0x7f0c9b103d9a004aeed6794bdda1823394ea9e6ad3acc3231eab419d2e3d2ad,
            0x3aae3b74214ef0e905c7457f3a3356cac77a6cfe6c013be1049113a1102fbc5,
            0x145c5870e344304ff0ae0456bcad46b727d3b2b589e8c7172025a0a5af13f40,
            0x3ba3deb76229bbfc3430674974249fa1fc416d6d79752201cf0d5cde98f7fc8,
            0x35b6de4051317e1e9f695447296b379b059bf0968143ae6f74c209bcc6c74c5,
            0x5e72ce3b4c78931a7eb01506be85068c4eff95a3e525662d6f2aca1eb0bef64,
            0x56dc47a1d6d3bdaa3ed59c561fbaaffac9576585b50714befe427155c74e7a5,
            0x6319ae5cbe6441bce0e23c8ec453fd5c37841989016b70a4ae96b64cbe6bb30,
            0x4ce80cb618c9d0ab3b58882cbd464954f42009520811b0d13071c5a059b74b3,
            0x5a826d43a69e8dd1f27bfd81b2c582063a69974e3c1de990b750bf7224dc220,
            0xda9651967f8fcaa4c84c821613af32d366aa34792fad690753773b83b201d0,
            0x626dc09f285c1002cc62a885560070ff41c1618c3eee05c45caabc666a9e2bd,
            0x1cd0e87c51f7f03529f3b5ff4470367a610ddc2602383f68275b4e0c4752d27,
            0x1bfb3b574221791a65cbeb296a59bd10a6f7986d99981a0d6fd85b17265775,
            0x1a9ca90e2baadb83d11267f1be82f40b05864338252abfdb886696c670ab313,
            0x54c3d82cde7698537d4042fb17935160b63cb01d2d40e96ffe1f2ab6766f5e5,
            0x27e58a4c01305deff7bd3648ecec5fdec89105e6ca2697bbbde71dd1ade3ebc,
            0x70200f287b5a6e43528bfbd1177841468d3431e63cd673db3532ef92a7b5600,
            0x3a6789597f753b935d80b5d30389e6b7abbcd9427116c9cf0fd5d4cab89e2c,
            0x40d81f401761dca8b8afce8edf235061bcc94f2d5d600b74d8a16e23be94070,
            0x2f60edeb0baa50960230aa0602c52f65849de23553fb2d64db4446ab3fc950b,
            0x3e088f64db59b998acbc4285ac7ffb2e8ebeb86d6bcebe9263045a6c236cd7c,
            0x25e089f9a8de768f39ba2ae6bd6b8d9e675bffcbf1a69a1969cca135886bbb4,
            0x5d316a5168b8c3dd14b117a910a90dd785064e46cba4b80f0b3fa526c310dbb,
            0x2b215161b6ecc86c5a6b6ef93f96173eb7e793b46c69aa62e5d0410c0275f54,
            0x32595065fdbf761693457954ca73a672b0551735de02caddcb8f717d97b4367,
            0x29286b0c18c3efce3834fd4277a69c4f86ca3bc085e451cb72694d5605103a9,
            0x2440310b813129bf1969eee2292d4f95847ec24f637a71a33007ee8c37d113e,
            0x2b6b8ac9a10379acb0143d12a2d82adfa77c3956eff9f6f17c24759d39f9847,
            0x4f24c5ed930d64c09687660ee1952abfc3775e55f74788c1beff41d1d87fb0b,
            0xe880a9838b5fcd4926834b4c8bc563896d1e5d78b9dff2cd2efb2c99281e2e,
            0x5e2c3c832d4007de9af648e708d3ccfd173aa4fed9d1d63986fb0df2d362dc9,
        ]
            .span(),
        fri: FriUnsentCommitment {
            inner_layers: array![
                0x6288a59e1970d629fdfb5bdea93ad3203511b3c27340db1467a39cf7951de3,
                0x821aaa485d3fbdf7b0a06d773e565370f794c06bbcb4e23279a39544782c1e,
                0x7a73129c87d8a60cb07b26775437ac75790bbd415d47912e5eb1f7c7e11d42f,
                0x3ce8c532eab6fcbf597abd8817cc406cc884f6000ab2d79c9a9ea3a12b4c038,
            ]
                .span(),
            last_layer_coefficients: array![
                0x3b844d8df7b26d71ddac95a77283731a044d0817799b93504c961643e7536fa,
                0x6eb1a5ad1749834b2625684ee4f1fe4cdff6a2bef8433e7e4f0796d10c80cbd,
                0x75dc13b4e8e554286a11e29269191a31454de9dd8bd1ff74453d3c8282b9c3e,
                0x5d91e860db3002e93c93ded748b5c69b806914610831b81772a7c3c8582b492,
                0x41e5b0b819808f3ee71e801dddd9332ce4bfe3344e1c4a1f98ef7bcc175a654,
                0x68e0292ec793161aaca50432a7eff9844958933f3d1f0ef42ab4d59602eead2,
                0x12ed5ff38e0af36126ae3dad7f8c9324b6295a4b5575332f1654b0eb5f2ba9f,
                0xe748c2e562defed30bd2a97ddf372f8cdff72050ef2fb6d198ec7e26393030,
                0x7f7703acf716b8a8baeea525fd786e6d758499c15543acc9b8b2543d4e9dc97,
                0x606233fd51fb776eb76395b33de0e5b66363061ea0686173b7f2bd51120ecb9,
                0x5aa88ea353d5bcbdcd25060e4dc1f543b5f517b13ded7be39f86f4588184f95,
                0x696e7876c8317fc8c1b64ecd268bca82152ac03e1d67ecf85c58fdd27472eaa,
                0x229795a82fc1785c5d1bcefc966d2d4327ffcf405a2fadedf006d6efe8f5d28,
                0x5dbc9dfb4b87deeb82f1c989dab28eb8238bba970ac6d790bd2bd747150dded,
                0x7dbf60320086c11016809745ab2aca3e78a857cc77adaa157f39e73cebd40ec,
                0x7683f9ad2d57da120622c1831d2f2bc2a21c6c89db08a8dc99e4e2cb4db0a8a,
                0x240d9b78177254aa4901e4d020c99f3f8c83800c46645c0d98781c89a889d9a,
                0x63d07342b1248a884ed81d8ff276960982f30412232b5eb0e82bd2fee795dba,
                0x138b1c827c50360ee6044e071af128a59244515e6f0d25711520cdcc73137ef,
                0x3ef3ea7d0ed81a0fb837e9d978cafb1d50d9ff20eb0177cf67eefbf5e094c77,
                0x644e69300f7345d84329457a43b888423a3d465b303078ad97694882347a708,
                0xc3ba2e34998f165a1e9b6d39e326b840b9624455617ed6b3ab6797e79e7caf,
                0x7dcff7dd27d1406d84e194d2a4a514375844327f4657f81c57c0a9780bdec7e,
                0x5a7f0e7321ed0fd6002caa89e847e828625862739631c23eeb6b1608a6877e8,
                0x7ec3aa585e55878ec09fc43a4c27fa9c6e1650e3a5f40a3f068a8c1edac55cf,
                0x4485c63701197e83d82abc2005661d9caaaf16d06f79b554e8497343704650f,
                0x7a5547e58a3c521e3f1aa05f9fe92ec5b67acf8160412ea40b124cd6abb409a,
                0x61edcece581dfc7c362d5c68413a318a2a13067056735b6f25efa234a8de781,
                0x52d5c55126361364bc851e93109aa850fa97b3c52ff2037943b286ee6945f24,
                0x1874dc6edd4f2907f6d7853dd484138a1ff5dd970345616637b178180f72016,
                0x5c13969e0080179173365d04a5291827a1867b9bb741bfc79fdeb18bdb127b,
                0xc313755e3efe95b1719e3673079bb9a8e65abc715f4272c0ec82b05576a5d4,
                0x70c40cd969fbb58e0ce8fb8156e75ec643198f1655756dd4345731bdda82457,
                0x1ed92b204747f07d2d7d71b6b0c2c714deffd15630dded2baa4e3cd91d6a6,
                0x207b8a3383d80b4e472b398348aed1c1d5d297a9f65ae3dcae1db0d6759b2c4,
                0x54e9862b9031fc989203051d100afac6f79ca47b45b9a8dc7a489631098bc57,
                0x58bcee8afb1cfa88accd584055bbd789dc3ae2078bc24b707a3cbf3d0b406a,
                0x3db80e4ef29231ced584222388716ae2f1fe22a2ee2b0e78d7eec08a2fcc617,
                0x372efeacd11ce8c0baa8181fac21e3a0b81bdbcbe9804fb049b049b157aab3c,
                0x44cf712a574df01e17dadb8536051e939243d5a09653783fa8df7a2340bb0c7,
                0x572b6bfa27ee798bc99814d57c0e3a6a3c1271ae0a15f21cfc879bbb0e1447c,
                0x659e7542be990fd7964775bbb4ffd6312da031a8a75f58619b9fbcbb45ab862,
                0x307c0e7fb6099f26ab78a02fec97a50ccc5af6f3352b06f95b983bd7d42216f,
                0x4f3181ab68c2bfeed59c6581be75f03ceb1f75643627f31c0fbeedf86f42eb5,
                0x19425c4b4d24775ec1d7af92a56152108b62cbb132dee8d55cf57abbe7fbefa,
                0x4fd54238eb975cbc26dc0df31fbf9578f4343910edaba2763dcc0504ee34ccf,
                0x6d948775eef790de896d9a2398764cce026083b1230727fb9d0ab1ded7f4078,
                0x521fe547fd42527e366950ce2e03049be2af52f8014dda1c8c26726c07da0b6,
                0x79ba9a8b07219cbbdadcc343a88ae06619214a2d889a4288e3803a16d9fa8d0,
                0x4c02186dfe672284ecb4debe18262098a3d4da503fe0a3faba3b6a1b9cb24a0,
                0x169cba5fc545966849d5ca4a04c6543274d8ce2062bac7b031905a236d34947,
                0x5ca15ebaa6a4cabcd2ff1b57104f6016078caa2b7b75359f6dcd6768e20ffed,
                0x6eebdabdc4004547e4d0b3498e482206e0b53aef4173833cdb9604206df874b,
                0x73a44590298020a85aad91f4c24dc904858af2a4cb6db5deb48e08737cb6cd8,
                0x2b730dea711f9e6c71bba2dc6f98a44f8b44ca7ada4def018e19d68523345a4,
                0x60b9f200e5d6716a88a77906875f3e3bf36b72ce5f68d7daf71779e6b605768,
                0x62d04931b023c1589b34cae1fb6deb5cfe9e94e1dc55d37dd75b6a3e7422888,
                0x7cf7edb764e6c56c696a0a309825da406c5544f59a312c5be93b0af3f7b7b92,
                0x1ff628b40a85fec511117f3b16dd2e4d85a736a27d0d7f3c522c0f4d12237eb,
                0x531a594ceb7df07524258e025744818b45172044f4630da3af2dd204e45705f,
                0x6cde7377d376d15ddd1644a4f0a01abd299b014a9d6b371be51bb693e47fba,
                0x27fdaea9d45e8b4736145c45a1e6f28376aad57522e9db7d2c82b437aef410,
                0x511cd012f11b52ff77b3176aa6989c1e3717134dbaf4ba25d1ecfddae6d1dd3,
                0x6f4db519f699a96f0d7c31aed14fa67e5b4cf512b41a188dfd05ef2516d22fb,
                0x383f290213017ea0c013f1f6f017313484607d086b1d532cfb01c75fa62bfdb,
                0x63035854e7a9ece60ec27e05ee24b3e8e33fcd66f69f74072029c7cf888a708,
                0x69687f44312ff1c549e15f217d7a05f5d8b730cf6ba2f0b79469ea2aab44fd2,
                0x62d482089605df042e99352b47cb7b0b5745ef70f10ded966e8a2d870af38ca,
                0x6becfa5e1ecf7017ffbc3dd18d59f2c35918bbebb03a8e733bd8e6a8e5a7153,
                0x2dfdf010e2d014f0a2a0ddd980cf270538d4821737c7cffd5ae35879627c035,
                0x93732663ebed60e68ede807f8c0376e38e093cbdce185e0e59470aac5b90ef,
                0x980b7aa5e884a1d9d06c64c3529d7c4f8cd82344f57c58fb8f33e083379005,
                0x7a01e04e34a5e2d6e1b81e433236a3c997933bd4e24329f2632eab796d14993,
                0x407cd2e7882070607f7ac384adb97013b42140e2e86be3851c09e38185911a7,
                0x7c96759b0eefa2ba71c5a83cd18aee4163f1823bfa56703b790c6107dbf8d55,
                0x5f8b457e268f2c4cdd19e4cfee839de5d54263ca574a2a2c1a8a0fde6f680b1,
                0xe45237d0e9527b8349ac30395b8b4edb39e9828b377a69fd1b028d127bc3cf,
                0x4eb254a9333589162bdec968e7342ce56733d0cc3d1119414a38a8ef38f052a,
                0x7c1ebdacaa499725b5b5066ae78dc73a730b6941aa5f89d9f064af4ead97294,
                0x5ecbbeb0fd4df85b7a97cc1192dd59dfc5b483cd0d230274cc04e5ca063ca3a,
                0x6fd5f158bdb22d4ba47967fce9032e20bdafc7f98a58620aa66a69f651be44f,
                0x17a5acc1b4c2f74c9b7b21873837bfe355edc63b70aa7c748eee11d8de9f646,
                0x1c111d2c257fb6a6fb826ead1f994971f528105bb2fd04b339759f5199f96ba,
                0x51aaf4b65bfc8dace07fde3f9ea5966848a1c7ef96ac91dffbe3c6ecf39cec1,
                0x5e33e6e50fa05337c6aaf111d3371a5869d1f3e418e84a8b92f9f6789bd6a98,
                0x49ba34c8cbdc2818f4f09c4ca7484d9a0a2c7f8bce743f08ceac127dd17fbdb,
                0x34b1417dd68894b89cfff52f89642bda9524de53e4fa22103aa3ee7f00366fb,
                0x7664cbf6da8ad539b0b9ed7b9a86b06cc5f80f639e995c0973e285efdb779a8,
                0x3108e8a3aa756c138343ae9a9676ed77f5e3da60cf519fe2863baf9f114c004,
                0x371568ef4831cfff4baeeaa9142f749596b68202c3500fab27993fab77f94bb,
                0x2013ab48977221f9b9861e0d721f563f7853c20222560ead2717f1d668d8e7c,
                0x67b389022e2e540b2cb55ebee82d08b218e186c7169d8a4b99815ef7088738,
                0x275d7eb58495f33c3e03a327146743ffe91eed27b0c7c3501b2c50e0a166ad5,
                0x2cb9eb5d9cbe6495c048aa1eb6faf9f5c0246853832135009cbbec955027bf3,
                0x635663b9e2ef0c57ae830064f0bece8f18d3276f6dd1242a91ed45f067918ce,
                0x73a0767432cddef3e0654942d64bb8b4802334b795250ae4ebbf84200cd226,
                0x65ee582c948b8c4ae64b2eb31affce5771d3fb6437d60e7e5669a0a12f59d21,
                0x1ebb003fedab8cebd11c4e7fedffa3937e5888e1be2bf90b163c5392c6d00b1,
                0x25a290f232a1bafb1c97efbfb4a5a7f6a2c2023b1ab3344b44ccca30f514eb4,
                0x473aaf24106c820bf7a87d8e781626b0a534d674ed814df151ad31c1a7a2c4e,
                0x4fd4711443d02452732fe7304ed5367472b24a37404d4203e552699df38e1e4,
                0x27fca6dd6064dcadf604a7cd878dd6591c2eceacef36ac0f64bcdf8d50bc143,
                0x51186a24a0768ddec0a2ab60164139499df0022ceab15e480fae9e3678f8a68,
                0x7c563abd1420f288bf0b7dfb184af9c8c24017fe652d9e58d8caa3784b445cc,
                0x2a7dff406b5c7b8e910676df491ce42202a037b4b1129b243040fa99a05a81a,
                0x6f8512bf92c7b4a875abb184a245db46fd43cd2908ce912bda10762fd337d50,
                0x51530afb2758fa99dafe378aaa89493d8631de864f53f3d423396ba2fc165c7,
                0x39fe7a0520ea8d4dba51062dee07750a1b77a3e28dc7374f66c6eee8ac846ff,
                0x6e1f1cd0082420e0c59b2d12d972dfe1d943d66670d4abdd355ce036382a691,
                0x11aad3cdaba675421e2b3fba375eb2687306e6742cca1d03fe3371a1df217b5,
                0x7722d41c190586dbc84ec13fdd5ec42d7702f158bc1cc29f08ef3ed19ac862f,
                0x449eca9e55b688a369bf360d6096751456a33168c9ec38e986447c9895ef98,
                0x65339aa37351112d383def9d140b3602cb88bb9decda842fdf1208a6a7f0a4d,
                0x6630d06f5c63e320deafd2c6a4cc5bffbfddb614d347bf1d607d983d404f0b5,
                0x1a4913a89f0fadaf62bd689eec4e9edb14213aaebfc307aa591c916c54b830a,
                0x3a79548f79577c04dd286ad1db64b38dbf32f9b6fa937168c46d2e98dd76d32,
                0x283055e9bf6b05db39cce849f8a6be5419b1ee2106316967b1514f5bea44c45,
                0xf88adab6614d6d445db04fc7cad589cc19a67d6ba3500f64c3effcecfab112,
                0x47c09554878d8fc2afcfa0b136cc3adc102cd6c790b7cfcbd4cc33932a720e,
                0x4c9be49cff06dd947e1f8016f0e65ca839201072bb0ecf54f4e49023d2ca878,
                0x3a57b0961dc7b48db58921d1f6532fc6ac7bd73b0713a80074c6f6b78cc7219,
                0x7d2e0924dacacd0de5d7cd1d74e357fc90e83b28c964800011c2d3bb39f6ec4,
                0x76d089ceb84af74183cf948602f3724a32783a669a61715c12e017ec3eca29,
                0x7fa727777d52242828b4e0ac59ccabec6939789e90a6109882b57903cb1a88e,
                0x58803b504852d9baae0acea9b94893808f8428d3f1b66fdc3e95b35e9231a3f,
                0x32d904eca7ea63e7174ab1f19d0430ca1f8daddf03c7b400cee6380c4f4cd8,
                0x5dfb739807b4cb1fe4387475630c52f0b44a2f92bdc2718e872273c4b4fa013,
                0x733caba128dc8696c58e20e8f451c63dc8711ff6d6e4ec498b5de3b07f0bb47,
            ]
                .span(),
        },
        proof_of_work: ProofOfWorkUnsentCommitment { nonce: 0x40719c5, },
    };

    let config = @StarkConfig {
        traces: TracesConfig {
            original: TableCommitmentConfig {
                n_columns: 0x7,
                vector: VectorCommitmentConfig {
                    height: 0x16, n_verifier_friendly_commitment_layers: 0x16
                },
            },
            interaction: TableCommitmentConfig {
                n_columns: 0x3,
                vector: VectorCommitmentConfig {
                    height: 0x16, n_verifier_friendly_commitment_layers: 0x16
                },
            },
        },
        composition: TableCommitmentConfig {
            n_columns: 0x2,
            vector: VectorCommitmentConfig {
                height: 0x16, n_verifier_friendly_commitment_layers: 0x16,
            },
        },
        fri: FriConfig {
            log_input_size: 0x16,
            n_layers: 0x5,
            inner_layers: array![
                TableCommitmentConfig {
                    n_columns: 0x10,
                    vector: VectorCommitmentConfig {
                        height: 0x12, n_verifier_friendly_commitment_layers: 0x16,
                    },
                },
                TableCommitmentConfig {
                    n_columns: 0x8,
                    vector: VectorCommitmentConfig {
                        height: 0xf, n_verifier_friendly_commitment_layers: 0x16,
                    },
                },
                TableCommitmentConfig {
                    n_columns: 0x4,
                    vector: VectorCommitmentConfig {
                        height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
                    },
                },
                TableCommitmentConfig {
                    n_columns: 0x4,
                    vector: VectorCommitmentConfig {
                        height: 0xb, n_verifier_friendly_commitment_layers: 0x16,
                    },
                }
            ]
                .span(),
            fri_step_sizes: array![0x0, 0x4, 0x3, 0x2, 0x2].span(),
            log_last_layer_degree_bound: 0x7,
        },
        proof_of_work: ProofOfWorkConfig { n_bits: 0x1e },
        log_trace_domain_size: 0x12,
        n_queries: 0x12,
        log_n_cosets: 0x4,
        n_verifier_friendly_commitment_layers: 0x16,
    };

    let stark_domains = @StarkDomains {
        log_eval_domain_size: 0x16,
        eval_domain_size: 0x400000,
        eval_generator: 0x3e4383531eeac7c9822fb108d24a344d841544dd6482f17ead331453e3a2f4b,
        log_trace_domain_size: 0x12,
        trace_domain_size: 0x40000,
        trace_generator: 0x4768803ef85256034f67453635f87997ff61841e411ee63ce7b0a8b9745a046,
    };

    // assert(
    //     stark_commit(
    //         ref channel, public_input, unsent_commitment, config, stark_domains
    //     ) == StarkCommitment {
    //         traces: TracesCommitment {
    //             public_input: public_input,
    //             original: TableCommitment {
    //                 config: TableCommitmentConfig {
    //                     n_columns: 0x0,
    //                     vector: VectorCommitmentConfig {
    //                         height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
    //                     }
    //                 },
    //                 vector_commitment: VectorCommitment {
    //                     config: VectorCommitmentConfig {
    //                         height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
    //                     },
    //                     commitment_hash: 0x0
    //                 },
    //             },
    //             interaction_elements: InteractionElements {
    //                 memory_multi_column_perm_perm_interaction_elm: 0x0,
    //                 memory_multi_column_perm_hash_interaction_elm0: 0x0,
    //                 rc16_perm_interaction_elm: 0x0,
    //                 diluted_check_permutation_interaction_elm: 0x0,
    //                 diluted_check_interaction_z: 0x0,
    //                 diluted_check_interaction_alpha: 0x0,
    //             },
    //             interaction: TableCommitment {
    //                 config: TableCommitmentConfig {
    //                     n_columns: 0x0,
    //                     vector: VectorCommitmentConfig {
    //                         height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
    //                     }
    //                 },
    //                 vector_commitment: VectorCommitment {
    //                     config: VectorCommitmentConfig {
    //                         height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
    //                     },
    //                     commitment_hash: 0x0
    //                 },
    //             },
    //         },
    //         composition: TableCommitment {
    //             config: TableCommitmentConfig {
    //                 n_columns: 0x0,
    //                 vector: VectorCommitmentConfig {
    //                     height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
    //                 }
    //             },
    //             vector_commitment: VectorCommitment {
    //                 config: VectorCommitmentConfig {
    //                     height: 0x0, n_verifier_friendly_commitment_layers: 0x0,
    //                 },
    //                 commitment_hash: 0x0
    //             },
    //         },
    //         interaction_after_composition: 0x0,
    //         oods_values: array![].span(),
    //         interaction_after_oods: array![].span(),
    //         fri: FriCommitment {
    //             config: FriConfig {
    //                 log_input_size: 0x16,
    //                 n_layers: 0x5,
    //                 inner_layers: array![].span(),
    //                 fri_step_sizes: array![0x0, 0x4, 0x3, 0x2, 0x2,].span(),
    //                 log_last_layer_degree_bound: 0x7,
    //             },
    //             inner_layers: array![].span(),
    //             eval_points: array![].span(),
    //             last_layer_coefficients: array![].span(),
    //         },
    //     },
    //     'Invalid value'
    // );

    stark_commit(ref channel, public_input, unsent_commitment, config, stark_domains);

    assert(
        channel
            .digest == u256 {
                low: 0x2c31f04a6b9c83c2464b2f1688fc719e, high: 0xe631d91ef56f7e4cc7fe09cff2cc4e94
            },
        'Invalid value'
    );
    assert(channel.counter == 0, 'Invalid value');
}
