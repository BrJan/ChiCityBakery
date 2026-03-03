with source as (
    select * from {{ source('raw', 'raw_inventory_transactions') }}
),

renamed as (
    select
        transaction_id,
        cast(transaction_date as date)         as transaction_date,
        ingredient_id,
        transaction_type,
        cast(quantity_change as decimal(10, 4)) as quantity_change,
        notes
    from source
)

select * from renamed
