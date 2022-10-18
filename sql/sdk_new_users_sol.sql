WITH solana_wallets AS (
    SELECT
        signers [0] AS address,
        MIN(DATE(block_timestamp)) AS creation_date,
        MAX(DATE(block_timestamp)) AS last_use
    FROM
        solana.core.fact_transactions
    GROUP BY
        address
),
solana_new_wallets AS (
    SELECT
        address,
        creation_date,
        last_use
    FROM
        solana_wallets
    WHERE
        creation_date = {{ date }}
)
SELECT
    *
FROM
    solana_new_wallets