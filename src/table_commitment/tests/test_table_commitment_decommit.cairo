use cairo_verifier::{
    vector_commitment::vector_commitment::{
        VectorCommitment, VectorCommitmentConfig, VectorCommitmentWitness
    },
    table_commitment::table_commitment::{
        table_decommit, TableCommitment, TableCommitmentConfig, TableDecommitment,
        TableCommitmentWitness
    },
    tests::stone_proof_fibonacci_keccak
};

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_table_commitment_decommit_0() {
//     let commitment = TableCommitment {
//         config: TableCommitmentConfig {
//             n_columns: 0x4,
//             vector: VectorCommitmentConfig {
//                 height: 0xb, n_verifier_friendly_commitment_layers: 0x16,
//             },
//         },
//         vector_commitment: VectorCommitment {
//             config: VectorCommitmentConfig {
//                 height: 0xb, n_verifier_friendly_commitment_layers: 0x16,
//             },
//             commitment_hash: 0x3ce8c532eab6fcbf597abd8817cc406cc884f6000ab2d79c9a9ea3a12b4c038,
//         },
//     };
// 
//     let queries = array![
//         0x98,
//         0xa7,
//         0xbc,
//         0xde,
//         0x1bc,
//         0x1c1,
//         0x1eb,
//         0x27a,
//         0x300,
//         0x3dd,
//         0x41a,
//         0x43f,
//         0x48a,
//         0x710,
//         0x72e,
//         0x751,
//         0x772,
//         0x78e,
//     ]
//         .span();
// 
//     let decommitment = TableDecommitment {
//         values: array![
//             0x4bc68e79a50789ef5cff3fbe013b8f846b9a17931fc9cd0416a1ae2c003bfab,
//             0x450cde24550a8bdb560a32385cdb4d15e0c04308af61671ae9f9ffb49f9cf6c,
//             0xa5d29975f58add08f21910f1837b842e16f5c4a24e0e38521917526e122026,
//             0x68d1b5a8dd162c1588d13da8cac43834adc3a7cbb2ba85c063ec7ca6d085739,
//             0x73981cf399de77f720ed93da03f00117303dffa602fc5a1ec0b40a4beaf81fa,
//             0x58d3ed66e1bca22f44a78ea0a387782978b53ac33b9cac2fd1ab651eaddab05,
//             0xe269fc02d3092c00408b983db7c4170139e73ee8b9f70c59883fd3a31679cf,
//             0x5aba6aa232184def63e78898bc9c568b4352514d1a3d0c167e12d76560338b2,
//             0x57917b6f3dd67adf3ca87e7605c804055e4a43b42f222fbfd87264db1eb90f9,
//             0x4f7dec59ddfe644593adbc54f550c74b02b90fd868ffe81ec1fb40e4208df1d,
//             0x58ad0173322c2aabfe3a87ff64473d62a1b26c673dda98664a8ee3de5f1dc60,
//             0x524824165fd387659eecadca7645e217035024f6b69b8c5bde2c0a1a8d833a2,
//             0x12487a39709e55523af865bbaf31dd07985fa5a7cdb59fd057f34c66f5ede18,
//             0x195b9725da75a62535df7359c730f5f268b1d3289f370ac199ad9cfca1d1794,
//             0x535760dcc435d8cc05244bfb8724067dccc9dfee4604e9e315533614340583e,
//             0x146488eb64016f52df23142b2e92981e2bae08500c58eacec0f6f670ff8fb1f,
//             0x772a1fd2a94a411eadc7ac4303ffebb89882436e550238018a3f0d3729246a2,
//             0x75d6268844734a7d5d6323699a8a5afffbe8eb9aca91403812515a66004edf,
//             0x3cb4eb0e093ebdd38920b3498885bd4c5cade2380a32fd9d7fdfc9751dcc1a4,
//             0x6544997d4deb00fa05aa5cd23b1eac5d5783bf6852fe015fddded822b52e33f,
//             0x7f2b853a7e5b26b7797546c73cacecdc2729b0cb9b81560d30c99506678e1ae,
//             0x756ea2513511aef820935f5e1363aa798411005ad9b10504fb73587ee891e2a,
//             0x5dfb1b29b312070b272063aaa74432f1000fcf777982d3e87fcb1b67b38045,
//             0x31b56134a59335316679b8c23b183798778b988e01645f0e448424cf543ce34,
//             0x13c054c54a1705c315726bdfea4fd4ff95bced254b38d3e8e12e0c9bc1ba69c,
//             0x2f9b267bf41ef8ab116658ef856e1e5d5fde3c2b02404caf8be51416698b91a,
//             0x3e9797ef176cd1e9cc862a6fc82053240b9432834f4706742bea42bb5a3d966,
//             0x47ccb02fcecb0162a8d8d4f7242fcca8c255f286f9a16a8ae946929d417f628,
//             0x7628a3b43ad2afd9a4e211fe43b7d3efe8558792a5b74e78f443b04ffe0e2da,
//             0xff6e6efb30a87b56677a97735f4ed808ce91e7d5855eaf51d93164e2a86abd,
//             0x707a09276d158e5adf05a6d5c57573913b8a09cda115e02ca499d5865fac676,
//             0x69bf0505447b50e490b8b1563111e202f25a3d466df3173fc56d294373d62d8,
//             0x784de1124b793881b02fbb6c1f64be6cd8dcdc2a745aebc9e78e6679222b0ed,
//             0x2141097901c7185fa626b6fa727aead038f0da4d68b104f53a657d9a6f74f9d,
//             0x474696bd63eeb50d411ccc39b90731e4a1ba26043d454239f786fafef3eb7bc,
//             0x393fbc114d15a2e38e8ffb4bb01402316756bef921bd3ee5392e180fc502375,
//             0x333f34bd7238f4a346d29268a8a44ffaef53e316a1282fdfec45ffd0d74afaa,
//             0x69d956fa0e35e04e95fff3b13bec67e2bab3aeb3f6beb62e261b85c6a9ea545,
//             0x476f80806354c5e9c90c80ef4137a88adc7c292cedccfb0843c4e8597f6765c,
//             0x23cb9245337fb84308e376de93e2bac3ef3c249954b9531eb27ccb5f9e9d0fc,
//             0x560c384b3c0e3552edf1f4eb51836e38cacc48cf32cb320a23ce4ce672d5c7e,
//             0x4fbe6faeb2c86847fc269c14c049369e8e075185bb35c79e12cd33f1bb1ba04,
//             0x53f4a910cedab8ac2845e2430e3b3030b416c8612e502647dcf74a4665acdac,
//             0x341951cd1f5d5771f7478613da9e0138a6a3fdc310c2fcde7c807d2229122a2,
//             0x7f5f1d8b4a1a3b49d3dd5fa1022f0ee0dba02f3c62bcf3d003b4774742638c7,
//             0x5b254c8375bd9bd31342ea52df78c601bbca0bbf0c3b9633896e66f8c11e173,
//             0x31ef7251ab71ed2f05be9c996bdbb43055f5ac6980b9a5823ead21cae03be9b,
//             0xaaadcd6dc206ebcbb25f111ec55653780ee2c6559b39bb8ebc3d81239bfc4d,
//             0x7e1a932dbac7bd3dbbf070dc6a8284d2479b443d3d9cd7a99eccb8c9b91d880,
//             0x6964b40d6bb01a8d67499f0ef466025648d535fde82e503ba46d67d1f5fdda0,
//             0x4def7517ca02a51bf6e88449d8655773aa48e39a354fcfc3a6d278108eb5023,
//             0x3fafb22fe3b569888829b1386d5973a584d9fa08da5bb478156c632fa4e12c9,
//             0x54fcdc680af70a22f8c2c9c6fab7e40c382568cfcae0cfae07d3a5820660f34,
//             0x4757557fbdecf4b667b00fa12a504a3bb9a722801aa7665966b3691cb7a913a,
//             0x48ac756c294a4ab16a3f09c31635494cf043a962f315b47da0b008f3c7976df,
//             0x5b2dffaf9f85a020ffc0869e656c0bae0728db8e2d4de14a25427a6d6acbb50,
//             0x9afce9532769b3c6d42c9584724003ce7206da153de31c23778975874fb911,
//             0xaebdb79608843c51dfa0e52ff7117ea4d5456dd1f770e88e8d7f7767699799,
//             0x612c01079a956c0d27ef0ff4701ee4fc2d180f6ec89990cd93f3e814d7a1050,
//             0x3720631de9a89485c3be95b62e1de5f9d93ace72c160d4a256a85457e1529f1,
//             0x56c56966b40b924fc5e0e40926f5369572289d059a139ccd64a1c0ad4c9b86e,
//             0x25f72339d0738419af25639246499cf66baa7ebc24affa5412bdeef682dcdee,
//             0x6eb0c92debb4ca1773cc75137fd809c0edc1f88159a743485d50779a1c5a847,
//             0x245d34f7913f0364ecab73cafb920cf0b5d5b2954871ad66246feb02fa55bf2,
//             0x517dc4dd8db7cbd0a5ad53f3c8502e51701d1c27cdc862c4a6064cd145a5015,
//             0x13c6dd843f06cb3475279b00a5ec2f54585a956eb1ce72ffe546c1f97e86123,
//             0x5e96cd5e056477b4fc59ece13935d090e49b55c9e122afedea6352505bdfa28,
//             0x1b3787dc2be8ace44cdcb514f2ef7331cbad5dcd2c68ec392ad7af8e980cc77,
//             0x1309b7870e1783a7cbff4f1d4f8eef4e716d6b9f7f83ea7586859012056b432,
//             0x5707f93582d24ab010eef9f45e609034a0a735f7340503e21509acb0608effb,
//             0xcfe64e222d0239809dd5bf0f6c02c5a8ae9b6dd358a35abd1ce3c62dc98d8f,
//             0x697c74527ed597f12f5a3759100556ea28010f19a67426b16aed384c7c7eebd,
//         ]
//             .span()
//     };
// 
//     let witness = TableCommitmentWitness {
//         vector: VectorCommitmentWitness {
//             authentications: array![
//                 0xe676ff357a733da543bb3d81e3aa60ca9f1063e1,
//                 0xffc663afe730d87e8c5b65ff1c4e02bebfb45c5,
//                 0x9ee28fd2b364c452dfc86e0fb15db982895abb18,
//                 0x4b2aea8358aa2562fc75d90ff221cf7643da2d30,
//                 0xe6ca528ff25b6a8027f6f186a6823b22e407d0f4,
//                 0x2ffc0ca2d4c2a613decdcee120d7ce8bd31270b3,
//                 0x87525e0ba3a6d4f8ddf4a7cc48deb7546f12bd80,
//                 0x26d3a33a07adc85a684d7aa9fdf8b6f582b9acfa,
//                 0xc65fbd68d029050bd45eb8e111a6f31f87c0b451,
//                 0xb43296f2dc5b4c4d908b80789b193962be8db556,
//                 0x9465cacc05be1a69f3eb38424e448a73199774d6,
//                 0xb48f007b7760a3cc2056e5db6f3eca5c4aaa7c8e,
//                 0x54f3688454cf9b399bca2139a865ab970b02e0e,
//                 0xadcfc979b6dd3e142d5c1a6dd2f51d1f65651de1,
//                 0xaaebcd47fccc02841f65830056d1f2d0075a6d25,
//                 0xe45f1dd9110a7a0b3a6c157b841fd9aff4e66874,
//                 0xa3b8e22670e0876ec1f042c974359444c595f1a2,
//                 0x92693ffbfd0ad1f60d4f8843658f20c54fd11a5a,
//                 0x7281b36fcfc367c94e83bdb8ea3e08d0142cd0d2fe627b80c73acef7e6a49b9,
//                 0x3b5e95b9b0fadaf1031300d7c0d9f043706f4dc7f8baff7e2dd55a1a6c65b84,
//                 0x2cc6a33256646a68bed5dd10cb782b229736fc9028ad7addb3ec487c38e937c,
//                 0x296e424b9795e3f4f1e5c00d6285afbb4c797c6dd8624fd735824cb9fa8fb04,
//                 0x36931e8cf7d2e8cae2087d7532f93c12c8ffa20fe5c7a02c9aebd2c0657158,
//                 0x49c91ee3ddec4f62d4c5dd802317cfe81ba9009e7b46f66bb354019e284194a,
//                 0x63ed1d118d536eedd9a286f4fc633b7625f8af0a2bdf6acbeb4e7462dcd734e,
//                 0x4620a4b9fa50fbdd167b899ffa02e8965aa056d35086db2322d6a703c7ad15f,
//                 0x475db860a575eae6424c0bac0039cd8a9450ea558211e42db402a826c14c1dc,
//                 0x4c69f749f7b1a98b707ea255d786c43a944031f3bf9d2fdb4f5b1310c61bfa3,
//                 0x1552bebad7cd328047b44545dfdb3412953d8548b7a65bf15f0f1ccfc98fc0e,
//                 0x44557ef3c00fc68816781800bcf8ef54d988d70c8d22189bbd0415328c8eda0,
//                 0x4ac53f19aa2254dc7ce25d541953e31c2c143069760254162227ce3d975b61d,
//                 0x795b6fcf227eb5d19a4e01c5defc88ba05a65eebf23b9306a7513769d96d040,
//                 0xdbe8fb2afa68997d0ae59711090a255bfbb5f5ed6543a5655ad79577a7aeae,
//                 0x785cde61bda7ca4638d7759a0a742942eaedbf08d1269d36f373c3908964a7e,
//                 0x7f0d790427a3fe91985b625ab9138e5ad2a05af440c26201c516a6ff852f022,
//                 0x5cfc3623a36de637078f8daee039d624bf693db91f8fdb4ed81a41f59e09f3b,
//                 0x453ff600781c3bb90b791d0a7537f31add3a733ba5ea5bc9887d4bab9948a05,
//                 0x26befde2c0f7ad61a726b7138869d76f66ac68e809855fec10bb4e3fc846a0,
//                 0x7ae21aa0e4e1bd6e63527d34e9d493e6b1943d769c3d970e1a6113fb8cdc509,
//                 0x3c4bb6412da8c8cd9155cf27a22934afd270ce654486b15cd77813d1973fe7d,
//                 0x765c40ad58db8cf29235128173ed93490d2fee999353fa4d1401cf734bae9eb,
//                 0x6a8a36b56c2919a2c0f00485d929009d085c52583868aa96a87574e02ac19cb,
//                 0x7c606e8d4c7a82c9b97c733908dce06038ab72ce1d70026f1458b8b0840162b,
//                 0x94922071ef2d6c99fe9da993fa6b494e82a25dc10ab5d6bbbd71b28f58b9c1,
//                 0x53f5dd1bb156b3744de60903a5e1b89fd202dfd0b1c50279c04894f6ab2d13d,
//                 0x6768cb453416dfac3b0eebbb53efb0748e27bca54c0e870c58d9a8f869fa036,
//                 0x16c12fcd3cdafd2f4328fc1a2299de4035baa36fe3bf46701c98558166f9b4d,
//                 0x29cb2a1d86816e6e5ceacbd12c58088385d111cbec53ab677e38b56c3aeb350,
//                 0x8247a109564a0dbcc9f7bad00e0f4131bd1c024e0f3b76ebb6b6c66b317b6b,
//                 0x4751b9f7b400984dbf007960a0522b3696277bea06b4a950ef9b98fe0a8f08e,
//                 0x22907e920eec443995bc55de7ebafec33320ae4ecd0a3dd8635e95ae3ab52bd,
//                 0x7f92acf18e809b3d2a25deef9f176cfbcf1cee6dc48ac1bd1ccfb47f3d01a8b,
//                 0x304fb4d291aa6db2a08cb4fa70e7e3fce26d927048a78a725afcad00eebe671,
//                 0x7748c9d244881a114b8c225d3dc3c212377013fbe9bb4f681024c94c554350c,
//                 0x1e6e1c4a459327339e22e2ce13a7e5e8b55023617731712613898f011237ed1,
//                 0x51344e80e161f57469e4695e624b56c9989ce3fc4081a0a5e2c1e56ff5f4d22,
//                 0x2d8af710272d1e39b101419c80f691346cc93c4cb41d457dbd6697e09490505,
//                 0x69ad0f6fbd109ea3547b6606981197b802a920a319c61fa03ebee73c346e9ad,
//                 0x5c0469ac2a93eb97c7cda4f82253280bd681a611eec612eaff3f91b81844aff,
//                 0x2022f6794db246316b2d2e024e70008bd6ada94a1958b8e5d5cc039202d9400,
//                 0x23c4647f032d7703fda9ffbb4c2c983323c11ce80412b2b5e3b20efa4d3062d,
//                 0x37f277ff3e939433e79e156ce68004fe24741f8c1b9264d346919582117e3d3,
//                 0x4388f543724d6095d53ce54c2b8fec2df52ed0830cff0df933181fb8e377490,
//                 0x1f9646a1c35ccf8656ec727053aa7fc6a571ca0498bc22624f3e0dadc2e1bd,
//                 0xad4cd2d1f4c6da0c831c51b13b8bfe987f61d369f5fa64bfc8827f607c96c6,
//                 0x636027ef64d2f9ba05b3cf507f840c19f12645fb6a0db2a24b8cf1569191bb6,
//                 0x43c8814510c36a011f1b1994275a928b66812d7c3ef14d93c31463339137bbe,
//                 0x300b7133fc0cc085144a2a14e496700dbc4f8b583657ffdde33de02ef78191c,
//                 0x7ba0d828caa7cb414640e08a2fbd789a8d111ec7883ffab5fd538c120c5a5e6,
//                 0x8dde3adeb2e83b034a5ccc12638008362a24d66835262ad33caa211a6c9793,
//                 0x849bf4d63ae4007169c0bd9f5a2b7f572ee2bcd188e868f981b5f4f67bd47d,
//                 0x3ced5193d4bb228dfa19e7f7d46372d80393b242a72d48262e1a8594f623094,
//                 0x325ba92845f1d7350fa4491e3405fde9ebda7c1bbbf7e066a2c8c10a6c680c3,
//                 0x155b15335843b15e4b816ae7e6a340d452d6247552864ac53e39b56910519b4,
//                 0x482777b78954afd4c3ac5ebb92f93a82af11652f50935960d6ac75f75674140,
//                 0x6fe0d0ec0abe430cf7c7c32f15a7ae343796f6175e292fed589aea79b813616,
//                 0x5618be8b708e7ddca48c8b971916c5fd9a1ba6eb4252e614ef88c4f2e41775f,
//                 0x51365af55597548ba0f4543e4fccba8c6e1a7faf6b2e8c48af96dd16b48e8f1,
//                 0xb5cce5205193c3b87dafdf96fd0de0cdac974558aa47e18e515841b2740b1d,
//                 0x51a1cc3992db4da580a2a77277cd81e52376c266b8f8c585b879a2251d7439a,
//                 0x7ca03ac5453cdeff7d3fb2742680345af326e92935686f84462de6f37588dd1,
//                 0x3b26307ed64a35759b0b4792c1f74803627c6b31046ed9c8ff9cc9bfc5b2c0,
//                 0x27a8f5d9f84205f8439338257462f4efaf07924aded94b419ec98c0be0ace0,
//                 0x42223b23fa282ef6a087a92cc400d36ccc6e8d6d953e6d3144bd2f26505a6f,
//                 0x4ef7521d71a61c9fc42725fbf3e36361b53046b68694ce437f576d079ce86f5,
//                 0x35fe0ea431a96210926bbe2002d26c15133a0c2bb1d2c6ee31cec86af66922f,
//                 0x158bfc28d59e25bf7b7a0e9995d1fe201d708db865013aabd6f19fb371a734b,
//                 0x46b9fd1bf3be4660e16c85ae8854e2dd6a8d4203d4b19926e66b3a881553b96,
//                 0x4084cc05bc951721e44cbc69526393ece2f17d2c3ed28675d92bf6e33c1c047,
//                 0x4b8e7e93f3a6888142902582531d0659329a714727f26fa4bc87e4eafa1077,
//                 0x2e9e738a183faa18f7bdce422e9f49318226b3b32d1d8410a48b1cab0875c5,
//                 0x20f4db5c5abe20c948b151cc25bd4c2c001eb8a13711742dc665a21edf137fc,
//                 0x63b799bbf4ec3241fe16b4a154194ccd9e6377a785527ed9365e725521ae17c,
//                 0x365b2a7dcd62b7b0dcb2d10167cdd87c4ad1174dea6fac139d54a3256c0c1d8,
//                 0x3e0bfea95daf7c3a3244e35549f078e029e544b9fe65b4548ec28fe8212b9d,
//                 0x4a899f49847c782e0dbf581f89aa522e4114b42a741d5d78efbe49808ba91f3,
//                 0x593e1c4dc6e2ed44e0953cf736581eda4cc6873859f3e1614c629cc58d86689,
//                 0x12b4960751c2799461bc1fd9e8466c5cc1f2bb4e91aa2be4d7d1c87fb7e3d71,
//                 0x3e3c1fc87c1b07d5f40b728ea660c6320691a1b596edd70d7a2b48bf8e66d47,
//                 0x4a0eb250ff1e14199c95f1a942542e0ddb486317de03d033b6b03cf6a1f66e5,
//                 0x2a768272e178821889693ea00ffca5c5309a7ee33b078a675ff2b4f3dd82325,
//                 0x364195536f59b340f0f315fec7361229e4a61ae63e77d182dac9d54a2170296,
//                 0x204636737aef25c5f4c8aa332e67fc3618e83a896f134f10ed929677bba4f7b,
//                 0x75dfb1d1da06ef149195da6171b78ca57f21946e8920aef4da97c59581fc37b,
//                 0x74f11bef16a2c8923231df2090b074be1c0b017f7f1f12f919f332c9362f82a,
//                 0x109604ebb9ecedc292252882c8eb95d3ca041db27cf1d8a76ba6dfc2355a9c9,
//             ]
//                 .span()
//         }
//     };
// 
//     table_decommit(commitment, queries, decommitment, witness);
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_table_commitment_decommit_1() {
//     let commitment = TableCommitment {
//         config: TableCommitmentConfig {
//             n_columns: 0x4,
//             vector: VectorCommitmentConfig {
//                 height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
//             },
//         },
//         vector_commitment: VectorCommitment {
//             config: VectorCommitmentConfig {
//                 height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
//             },
//             commitment_hash: 0x7a73129c87d8a60cb07b26775437ac75790bbd415d47912e5eb1f7c7e11d42f,
//         },
//     };
// 
//     let queries = array![
//         0x261,
//         0x29f,
//         0x2f3,
//         0x37b,
//         0x6f3,
//         0x707,
//         0x7ad,
//         0x9e8,
//         0xc03,
//         0xf75,
//         0x106b,
//         0x10fc,
//         0x1228,
//         0x1c41,
//         0x1cb8,
//         0x1d47,
//         0x1dc9,
//         0x1e38,
//     ]
//         .span();
// 
//     let decommitment = TableDecommitment {
//         values: array![
//             0x455da27ef48cb1a1b19aae3d09bd3d76dc7b53b9924c04af05dc8e377bc507d,
//             0x4225a8fea03e50594d7122fda111fa9cad465e7f17c417a324517ac51392ca7,
//             0x23e182a77b764524b41a82fe26b9d642874e728aba0aadadf40d9ef9bec22b1,
//             0xc5c2671f750d00e68e44ed7ca895c4b9c37adeda5cde6d13a194d2f7d6c617,
//             0x7358996db3995937f1ee1aec792899282f386448f810884f0311de4f93445e6,
//             0x6ca0b8451824a32a08df73765309b1b1016338a04c9314c73f261ffa5012f40,
//             0x27b1f89be91630fd5f8a58272cd188fd297b069358a596a5c664c90dcdd2e3b,
//             0x433597f60efcb6b38da032d388927d522fd422d7fee7374ae262134eb4fdd7d,
//             0x216476bad4676424a9fcaa31f96ee1051e641a4dcf5859d74e9d57f9d5f7d83,
//             0x5f3fa7c1c3411cbc4efefa238425b246c855f4b8158eb0592509e65e213746e,
//             0x520a6ae91d19de187ed0c64e0d14f1a329427f4ef99bd1c60d50e649a98ce7c,
//             0x66fb585b68ff8127f689e312c0838034f560d8327c6159626903159d4b38c4c,
//             0x65d45617dc29e9938140aa73db916b9915005f15381a27de229a05f5d5dab58,
//             0x353b4f5ae429e111327a5f5b26130af81ef6acc96d1391be1f34d518bd70cbb,
//             0x4e2ac9e115b6bd6defa020381b59a42ece669835c1800f97643043778d79560,
//             0x314174f8bc1fcbf2facdaf281e4ac957ff87679f40639214052f3cab7b7bdcd,
//             0x3d53f739c52ae2c49f5b638cf89f2a2211e99eecae885238d7cf28b981b29f3,
//             0xf88482276eef05a58a771e3897935087eee5750d63cb9c8a6887edce66dde7,
//             0x5779a1b87467e1e78d179c3dd7491e3314a90e8556908b5f3581d386ecf9280,
//             0x19b500c41a88a6b72eb2703bee9cf1d02a45321589f8782bd83cd1b9f27c4a1,
//             0x344b894943ee46743fa685e9702c178049f5d5d3945890506c118a87db8b456,
//             0x5eea3d3d3ab21903e10b6de7aa2da0ff714f2547d86aca91bae5f3a9eb75a39,
//             0x242d5a42fe473331fe5f8838900f76d034f2a3f11ab53d299a118f1fde8ee3e,
//             0x3c6caf3639680de623dc23d709b116ead9289a8f04dbe01d45cf4eda8f1426e,
//             0x29828017e7b3cfd07df9aefcb4bd66e2feb129517ec0adf7fbd6a8a3ee14eea,
//             0x56d2657ef912ef773346977721a11eb88b22a85304e267e300a20e8b5c98db8,
//             0x38094d253b62ff4427ffa7a64e0b86288438eb133b65ff1e0664e0f525531b8,
//             0xeac21cd1c213b70a1f3b66a43c23608ba6fb6e7532848c84c531ea850405a8,
//             0x1df26f7c3f11a0c0ffa1514213ead884f1b4e94a4a3ddbdb3bb690891ed990,
//             0x5956ae95581e75de1ac64dad1d1692e4b57b8765009e9ff151015ff1a08dd76,
//             0x20c97c4b24d57d700f00603372915106fa4373c88f8292bb541dca1c7d5c651,
//             0x55c3d23b21f3de0ad76c8302ef3b5de96db4c59c04bafbd51c7ae383fd5dddf,
//             0x4fc3cc267d49eb511e74f5fddecdaa8321ed90182f55c2182508715ea639e1d,
//             0x3ca6ea010f63dbdd977e7cc2f44f08080e0bffc44b0e6499e5aa5bcdd88c29f,
//             0x44b7680c931f8b684ffea1235db6aae531180b86b967412bbfc4e0c755b8911,
//             0x38e7297fb3d8f378b3e63514edef79b9254051b7d34a32c686a31f9cec6cbc7,
//             0x73e839dbdc72e53afa4e2e1b6210e2032f06386c949ef8b0b0cbee6010a8de5,
//             0x35f8d0822ce62c79725927fc5661f38fbb78a0b64c795fdbbf1223a67b4b6e3,
//             0x6d33354cdd499778acb0c7508d15f4c155d1018a4cc21ddecb174627a2b8d48,
//             0x6440fd8cc3d961a79010675c49edcf094e031bb6178cc300906b1ad387a0261,
//             0x1eb0bc46c6bad956e77aca758851008c4b4d9796d61bd88ea0e346bd3b2b102,
//             0x756e99f445eedb8d8810e67c4a4b07cdd3ef96beaf0db3b043b6b97200ef008,
//             0xac920bb187e5fb8ed74902183d96d24d546494bf70ecef8f760da541050f97,
//             0x86003af472abcc60c260d8495523fd8eb1b10fd6779a775f91a44c7974a517,
//             0x75d726705114e3dca0f3a85c514d4ab6e6ca39a339786d7a4b59da8430f6545,
//             0x6a0459c24cfcf15fd5a7d921a3f1574f914166777c240a371d38b23d14ca79a,
//             0x400a32bff581fa86d9318f18530425051ad4af547d8c867fa20368b55ab9281,
//             0x5882bbdad4dcea0b94b3c437f90ad617d60e84ab611b1987bc26c3a06147126,
//             0x382518d87b522c622b60d6b559ca5d056fab3be96459b45896794b752d4e170,
//             0x748463cbc39d5bac56dafcd48f1c70d9c0a083457b8bf671ff760c60203b85d,
//             0xf7f53934682b09757287f2f4e9518033a1adc73535ea209e72141dbdb9b42d,
//             0x23c8f3711ae8d10621a414a7b637d02ee9aadda3542cd68f39dcadcac2615d4,
//             0x3961c737b79a32b5a0a18fa7e99cbae55d133447ec03e6476b57e9fa3b51763,
//             0x4f47b78d7eb6840ccd3b758c21d74d361aef8f804da05bfe455bddee4623e40,
//             0x5e0241815d7d5046aa8eabcd132b8c0a36f1582c3395612e4cc82083198f888,
//             0x40226ccdc77097a416170a9f6af3b1f24abe74cbd5107df6e4a9257acf23739,
//             0x62c7bbac8a87f06b6d6d676256f33cf3ca479756537c8260e45ea2dae1537a5,
//             0x3e25ed15f8155c4a6843c192049496b98dd469ab9e36e6869cd54a72fb2528c,
//             0xed947a6fab7e6ba1ec9a374c2fbf7bcc7eff8063e81563b09e5b0f26b4e7e8,
//             0x50dcd8819d4b6d302469186cdd04f735f1a111e16e63f2730d5ae6d0be57615,
//             0x446122e5612f05bee84e465b29d88ad4733b0c44bf63890d3d710f0d2baf7d5,
//             0x1bf02e089d74c6d21e7dfc76c60f2edb8c936acde31f87eac5f953bb719e633,
//             0xc2701281878f2688c9518364c8226a8012f2444bca154a0152e49dfab86890,
//             0x2fcce848fb49b7f48ac9a202e3a442994d0c3ff8e479172781751b278652206,
//             0x5d5cf53181e0c80fb3fc4da821cacf29fd0ff92651e1dacfc8c5ede724fa0ce,
//             0x426524642478fb8efdc6be15767371cf2911465e9c780f9ad5dd902086b57e0,
//             0x6e13cfd637f806c50c2bec5fb730bc344b515b61c03667471d5597ae12f4d48,
//             0x6d41a02c9908ab91744bcaf071a00a69fe7b73fc6c86624b91139eb8671d0af,
//             0x2952682038b3b29bd07f5fb21013aba016d5b4cf992b7140ac8c62ad83c9a1b,
//             0x21e7cbf6c7878acd1da671b3ff9c66ff83b3abfa28ccd0fa024d8e998f73567,
//             0x464472b1f155d2a02aebcf25b95c92e37d9214e9985875bdfbccfb368acbf24,
//             0x3d633a646a00da5b1a93df5cb5be1fd0b46359ae57ce412f26e0d492be1defc,
//         ]
//             .span()
//     };
// 
//     let witness = TableCommitmentWitness {
//         vector: VectorCommitmentWitness {
//             authentications: array![
//                 0xc3e94514aa77a36f6a9f41813af8126ac136b4aa,
//                 0x49f8b8b10637afb7a1ab9e16e4947f2ee50925f7,
//                 0x1171c4b3e777a53ce4e578a80785787eedf290e0,
//                 0x6f8906fff796ad3ee92e6a71da6c1d6f90c14eb8,
//                 0x66acec1dd66bcf447ddb79fad03b607f367dcead,
//                 0x83507326c500980ce9f1eedcb9302eb63efd2cd1,
//                 0xcafb75d02d4420b068dbe310c231a364eb6724ca,
//                 0x32a29b217b6cfa8cbd59a54e93cc3be081c7525c,
//                 0x783da7ba22cea0655de35700d61e32f0ca742a3b,
//                 0xf499c047d3b4c2f1fef0871223c1668891e9c1f1,
//                 0xc75f3678e0a6898cad60a298b92c465593cff4b8,
//                 0xe875e4ca7a783c670c8108dcee4a249d0d88e0f4,
//                 0x7361a467d99da0c45dd651f9aa0c672f3c5379e1,
//                 0x3dd8cac24ea1cadcdd4bd2bf96c1d0f45b63be81,
//                 0x61052234c3c7f3aa02e1ceb14e0dadec863a3061,
//                 0x373c3947410249b5f05df425644953c56f05d2fc,
//                 0x7537f9a9eb2e829c6ec0f162ff30b2b2c6f4a1a1,
//                 0xcc91a08de6a21a5c6564b086b538d67efeef0887,
//                 0x798c38c634ea00e22a26f852c9cd26203ea59ea4076fc8c208fc5bab569c83c,
//                 0x20d4266491c107a62c6f4c5564e8da08e7eb38f9ec6e21d03724e6b361586d7,
//                 0x3a684219c93b08205f34f8bd790ba8276003e897ae7d3db112e431c2c9ba162,
//                 0x3589cadac0b45ba4037942965c2e71affe8789814c51dea3b555a88cd88b65b,
//                 0x32ee629c190e29af70c3fa78ae0cdf8c21be20593a82413f29525f7107e05a0,
//                 0x5e9764bff3f67f2662431d01c0039bc4ebf7084693199640cba59d4f1152d94,
//                 0x42cbe9322f4b51ba13c2bb569d0f56e773e8b06999f41e0c96ef803fe0013,
//                 0x23257f3a9a77a193a9d9e666c339f0f2eca418cf6113591f872d77020530f73,
//                 0x60282ff48b747703885a7dc50b9e4effb64d623fd2e55e65b74b3612cb983bb,
//                 0x5ee568d1f5a9e734f7e8d9582b28d65578b0bb6e962c6ffecb8765f53936467,
//                 0x71da72e33a552b0673d947368184e91fbe821c7a778b867d95bb6daabb13045,
//                 0xdddbe37f039b62c7a62fa8a3abd59ff59cbca4619ae75e5225f6c019a65d64,
//                 0x74f724293c954d9be3d868529d0a458fdcf5af70ea47064c14c3021e241077,
//                 0x35d9a1b302ce8e4baede9b87ce4d20594daa6a790bac5401154c0f7d9e0e460,
//                 0x69cf2f38f2f9b6934c0a626d50285b90bdf212e4c88f7cc3d1d14c60896cd10,
//                 0x6e09a5800512369c61bd19179317231dc588124820711a0847611036ed54c37,
//                 0x14bcad13570492e60c955faa00c2b7b64f717c0b98e09bd2405e257660527,
//                 0x14f0bcfa619407fe8eb3701a71519adfb7e47ee08fdd30a0b3fe42adb005e7,
//                 0x6e93b1715abb6c43ad9a53edc93cb82169218bc5eb30a05db26c104553e089f,
//                 0x582f7a4410a3f721f11c7b84ba8eeb0c977cc5b50c9475be1754b6f89c5103f,
//                 0x40690537dde7fc9e4e7cf591ba9c0cf30746039d876c5952e178f54c283d8d2,
//                 0x208266c53b0a7f9a7eef284eefc9defa9928e89cee74fb6e8e1359825904a18,
//                 0x7b6441354a2fe25338ab9b3d276ee1083243e45b4b59c5c9025e6c117205476,
//                 0x2582ecbeb84b9cac9185dcb3ae69b34f7c81d0d41081e6e08ae43bd3a80f575,
//                 0x29831cd49174b200360d531b696c6df6137ca6671296c43d19c3058dfef8b1a,
//                 0x4fdac91a023f1194c9b7656a70e36abb64da59b70a83802df00998ae0d986da,
//                 0x1883f444a2b5d284609d831b99a2fc5f913d934966b6a4d0adf99117f691035,
//                 0x21ad817c22936856a66b316615b7cb143eff322392089fde1034b6caf25555e,
//                 0x3de4488718e2d62b92c7741c20e912927c51cc85c3cc1b567b6d90612324a20,
//                 0x60d7479c2a17294963bcaa345c1c23f5a350dd74621fc1fd464dbea83098f78,
//                 0x3090a72e0ca08f7b020f7c50bf28c03ecda81238e893625728341ba5175d3be,
//                 0x5b4c0d9bbd6fad0cde32faf70c04578842da6f46717ea8c54c6c1ecea393c3c,
//                 0x544c72dc2ed7e8a85d10b12cc560f3841021b4b9d5b220804147dcd81d5ade1,
//                 0x781560f19b30d624eaacd86602ab796b658b87bd16393c1e380316d7c8f0681,
//                 0x1581fe147990ac48ce8201cb5df26898c34f64513990833aab8d195095fb1d3,
//                 0xa3ab77aa3304446fc7906c6804f6e41b7475b44d1d514bea7b053fa0cd99ec,
//                 0x1a4976701e30a8da11e7006d78fd54a57f5c0c0c11ed0e2528eaf2f1e5433d5,
//                 0x70cedd6e0815d52a8eb3bb9b007064c0e01e76a90d49dc8d7085b3237628c2b,
//                 0x2959838bf62c8b6794788a6eb0dcf0f21c9433296d11c6e50db7303b191fb6f,
//                 0x5451cf74e325301151b8619ea36b0f96fb93824890e1bb6beccee389d1751d9,
//                 0x24888459cfd1b337714cbeb948038839b96df854a7c8c184aff2bc2be8b212d,
//                 0x33cf87a63fa8da0def4869348b26037933daa2388bb8aedbaf486b4ddb54061,
//                 0x1288437b5b44db954b1b446742610f60cec1880a02cae7a7fede364e8727965,
//                 0x1699e46fda5aa529f77b5ae3dbc5b169d49c251c79491abd60f255ebfb79ddc,
//                 0x6cb88866e926a9d4d676e54d6b81c8a7269ebb11c711672afc90891bd71c9fc,
//                 0x7ab12f69971869c61201c8b50666a59ea670acb589e62f9dd6edd6613dd2ba6,
//                 0x36d4632bc6ac53824db01ef9b3a0e5468daa5787fd21092653f1728100994eb,
//                 0x5e1647ecf18f144b71cc9e5cf5548ef0baa08f76f9a1f7aa988f85df6f107c5,
//                 0x5be37d7dd734b7bda63d147a63b331bfa5948e2d7a0891538a0104e7538c884,
//                 0x67b464f433636e77d1ce2fc3ea69ae3c72833848d8298e72632719da629ccc,
//                 0x2ad1886cf0d997ed8b818621ddf942b13b1152d66304d9691ce663606cc203c,
//                 0x939a14688e44d65015692d479f1fac3f9a35694e4f84d318cf2e56d56e213f,
//                 0x281884e5207110fe5cea18a0017e539938d875a1d346f68f30045d55fe7d889,
//                 0x5121684e8818763ef1093421bc9a16b2dbc1dcb7085d57b3281576f0e98ba0d,
//                 0x62b861a7625a917d84568ec0fbf2087a09c949de4c7b6ee18f587cfd315bfc1,
//                 0x10a2c664d2c0f4610ca376acfd75f95ce8b7269710f3378836ddf449742054e,
//                 0x6737b42e2c098edb0153f2d41d1e723b1d430f1b1cb71d2ad25e064f362516f,
//                 0x6a42c28e4829e583f57620d8c2ed31fb9ed7e0133e9c0d46f5ad2ccac3b4c59,
//                 0x46041a733c464f3014ac33a41b34a124cad22c3e623bc1d510edff4c963dffa,
//                 0x66d71854e56fba0f236dac60c169f09c61ec073c6a54da87a57a7ddd8656e93,
//                 0x18c4692cd43a7452a3ac525367a5b56979e460f8436a7675c88875053c07161,
//                 0x6ef4ac36f38e6b1ed37a0d723f6108148054201a031e9b72c666bd56cf36644,
//                 0xe9219f736fe58404c500bda77042c76aa4ce9975a40ead8ce0ca250ac48086,
//                 0x67306c39c8833e99d7553bff08c26a1a330c9f2dfa303964bbdf0e7164d3eef,
//                 0x5b4aa324b6141f443655f02c9d0415348b3091452c5f62e66b02ecd6fc59760,
//                 0x1dec1a0ec076a70952066179e0a3823f43268aff6544a7642289ac6edbd5ac4,
//                 0x195433a62989ad8ffd0b190b46843bca2fdcc72a86ac5f519f08eea8bb7b296,
//                 0x3322d792118766ede665fd6cd5802ffc4fb07ff1a7e073e15a71df4b8f1c1df,
//                 0x1f9a1d7c36cf04e63f38c7f3a48233b4f28b12125a9ac92f2eb51728220d3f8,
//                 0x88635e5ce988595ff78d8242c33e5e0c9261ddb5ffb93383d9c7e2de39599c,
//                 0x68a7c0d05a8621d36f01345c034e55da86ba872837b0202f1621bcc523cbc38,
//                 0x27edfdcfa53792dddcbf31ce0ea0b12cb2c1d4f71040796cc460b6b64ab52f4,
//                 0x710694b2b36250ef6314269840db327e418440000c6ac605a1ab43c75b4f837,
//                 0x14857a4abb12a5ec5a6b48e819ea2ecb57a5f3d44d848e60496af7aacaa087a,
//                 0x6c22004eb4259a0ff99f1062395b252c66376a9ab6e56161c89382d98bd48df,
//                 0x7274f06686de6b76cf05e4e5afc663a8718f787690f89f589f34c34a08aeaa0,
//                 0x41ad703fe29d8ec4ff0d6803ceac3492a7aceeec7ada6ef818a0a6fa4b998b7,
//                 0x603daaaa2b6827ca5ff703b2e7652abde0a89c31e2eb3e14dfd04510f4c06b4,
//                 0xacc3de2007fb23f835a1becb7a68fff31080df8d99363b3579bc9b4b52ecf,
//                 0x7b98888e83256b58d84e773b44b5423ea77726046115a0daef8d920f068ce88,
//                 0x52c4a39918e388b73509f5c31260d975a7ac011227976ed4be3fbb7b51be9e2,
//                 0x5d0239ed0ff6d5d3a873d112d217933b6d31f7c48a6695369047df6b21afbf9,
//                 0x308c446d8d5fe7a184f5b5f03cd59d19abfcd1d623771e1bd740690cd378233,
//                 0x154bec31809b0a7329eb1d7a3ffaa6e94fc3208d058735e81f4c4009457aa1c,
//                 0x44711dbf24ed8fe7e5210e8b15ed359e677b591ef5939ef6ca2fa892e2a0fba,
//                 0x450d05c6b5530a5880acf1bb9fbeb3ce2682d222987baf7156aad946b15adc6,
//                 0x46b9ff8424e6beaf8fddafadbe1c472bbb6945a300460cb153228be1c5b82c7,
//                 0x45579b13d87f7f6a335842175f40920952cb470069f805674d26c29dd08d037,
//                 0xc3b6026fa76f77b8490d2dcad25b5ef2b5f49eada4ccc681eec136ff448a83,
//                 0xc8d0f4135ef63a9cd8494ec89eedfeee012d6ec475e0861114417bfc7565da,
//                 0x994418526c89febce55ef91dc4ef8ceb9d5dcdab746eb94aebb13140d0873c,
//                 0x291d8087051983a343d3f6169022163ffa0999165e5cd47cb1b84dd71e33318,
//                 0x530aba858540b6d570bcc45320bd543a452477737e02826f352002cba305a74,
//                 0x4053ea849f58991ab779a131d58bfb77092e87ff2c80b75320e172988824a3e,
//                 0x44c2702486b67360f8ddf016ba850e7a325903d7e3bf5853d5bfdc8505cd3ae,
//                 0x70ed0a6c78eefbd2265dede23f3502abcd782edd2d5ae3580463e4c7076704f,
//                 0x2a50bec0f7110c516368abde0a81206184e2f2fa01538f8cbb06c57536e1b55,
//                 0x461bf8367593fc13e35c41446bda699b79c748f7df41868fc2b21041d45eaeb,
//                 0x28a07d1bcf363266a921055f7381581acee8607ec1f4cf03dfcfffd70d580d8,
//                 0x3549e6689d39d436ef656638e72f2b6ea4c0d352f6ab141926f568d050d1b49,
//                 0x41cdda9f5eb3b7c9523d72155881c0873502118f0799b66ea889c5fbac8bf3f,
//                 0x455fb23ae2b0cb9e089ffe7e951ae0be26aaa277155a1b71d4d4d2c7b46842a,
//                 0x3f370aa73a0d3b32f3819e82f0ed6f12a0bf4e12492befb2034ddc6899408de,
//                 0x4730cf627ae1a0c370faa34d5569d6364617814108a6e1e844e244809f7f191,
//                 0x79bb0cb486dc0a7d7058884e2851c32ff8af081d454f332d7e4eaf1bbbf7b83,
//                 0x5a9bccdbecf1a8beccd2d710957c3fed7581ab869c1ac76486954bccac5b267,
//                 0x11fa619335e1ff082b482cd4e7a6f69cf77f969a298b3efbad6116082812333,
//                 0x5adb7ed8c63c20884bb1c8ac49f8b08b0885ea003172718a0e7c3bea2e83652,
//                 0x415f337c69debd246a942e06a1534d496185c37d3f1f04dbc18f19ff1cc68fb,
//                 0x6e88ec7f3e9de925cdd0099c4a98f8bcf4fdf688d35c591e5b71dcdea08051b,
//                 0x227ab6b7ac10d7cb0e7ca74489eba2ee51e0284ef0889833527a20fcbc85300,
//                 0x71e57ed557bb47f7db9bc61f6458c1bb49559e81aaf4c53b2e8916b0cac29b0,
//                 0x696faff6f3ed31936495d478e3bd6611e6f012803580e6811d028c4db0bf0ed,
//                 0x69c89bf048993da0006008783d6c6efba96ad817b2c40fe194b225204b10637,
//                 0x27a4341d105f47dac23491db73d7b9ddded0481222d3e3182871541562f0d31,
//                 0x21a12954e99788363671fdfa45608f201ad28ff1a78816db6be552fd4d7ab40,
//                 0x5e8f6052137444bc50152f59b4c7e4ee4383de708e202cae758f94c75706e,
//                 0x255b8c17cbb39f1c134b9df3d84387fa4640bdae53d744a69907d260abebd4b,
//                 0xac529438574ab715715be48ada2eda5e0b3cf7a9913b2a6477d7f3f09854f7,
//                 0x5cebb8c8f427c2f740b8cbc725ea7895c878918a6ee672f0028d87be6470b84,
//                 0x27122de701d85da00dd82aba83976259db377a69ddb362a8d45c6b7fd605133,
//                 0x594d17d53ed09c87cbb60d8edbe6b06a0150402adb097b4fab3cc7e6b9bceb1,
//                 0x6bd28199e854d6bc77737e83705f41e5f8e4bcf901b9aae6affb9a911f71fc2,
//                 0x5e33c31d02f312a48584bf8626d8d09c081ee76f707f6f7e25875dc8140bcc1,
//             ]
//                 .span()
//         }
//     };
// 
//     table_decommit(commitment, queries, decommitment, witness);
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_table_commitment_decommit() {
    let commitment = stone_proof_fibonacci_keccak::traces::commitment::get().original;
    let queries = stone_proof_fibonacci_keccak::queries::get().span();
    let decommitment = stone_proof_fibonacci_keccak::traces::decommitment::get().original;
    let witness = stone_proof_fibonacci_keccak::traces::witness::get().original;

    table_decommit(commitment, queries, decommitment, witness);
}
// === KECCAK ONLY END ===


