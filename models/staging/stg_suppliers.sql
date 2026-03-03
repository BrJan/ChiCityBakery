with source as (
    select * from {{ source('raw', 'raw_suppliers') }}
),

renamed as (
    select
        supplier_id,
        supplier_name,
        contact_name,
        phone,
        email,
        city,
        state,
        lower(cast(active as varchar)) = 'true' as is_active
    from source
)

select * from renamed
