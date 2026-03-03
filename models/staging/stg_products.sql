with source as (
    select * from {{ source('raw', 'raw_products') }}
),

renamed as (
    select
        product_id,
        product_name,
        category,
        cast(unit_price as decimal(10, 2)) as unit_price,
        lower(cast(is_active as varchar)) = 'true' as is_active
    from source
)

select * from renamed
