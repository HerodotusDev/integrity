use cairo_verifier::table_commitment::table_commitment::{
    table_decommit, TableCommitment, TableCommitmentConfig, TableDecommitment,
    TableCommitmentWitness
};
use cairo_verifier::vector_commitment::vector_commitment::{
    VectorCommitment, VectorCommitmentConfig, VectorCommitmentWitness
};

#[test]
#[available_gas(9999999999)]
fn test_table_commitment_decommit() {
    let commitment = TableCommitment {
        vector_commitment: VectorCommitment {
            config: VectorCommitmentConfig { height: 5, n_verifier_friendly_commitment_layers: 2, },
            commitment_hash: 0x65AB11B61229977B507F7B37C4E95769A0F9F8939042B2029D92CFF0D96FD07,
        },
        config: TableCommitmentConfig {
            n_columns: 4,
            vector: VectorCommitmentConfig { height: 5, n_verifier_friendly_commitment_layers: 2, },
        }
    };

    let queries = array![1, 4];
    let values = array![10, 10, 10, 10, 20, 20, 20, 20];

    let decommitment = TableDecommitment { values: values.span() };

    let witness = TableCommitmentWitness {
        vector: VectorCommitmentWitness {
            authentications: array![
                2722258935367507707706996859454145691656,
                2722258935367507707706996859454145691656,
                2722258935367507707706996859454145691656,
                2722258935367507707706996859454145691656,
                2722258935367507707706996859454145691656,
                2722258935367507707706996859454145691656
            ]
                .span()
        }
    };

    table_decommit(commitment, queries.span(), decommitment, witness);
}
