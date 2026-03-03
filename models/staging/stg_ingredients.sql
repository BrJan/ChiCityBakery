with source as (
    select * from {{ source('raw', 'raw_ingredients') }}
),

renamed as (
    select
        ingredient_id,
        ingredient_name,
        category,
        unit_of_measure,
        cast(unit_cost as decimal(10, 4))  as unit_cost,
        supplier_id,
        cast(reorder_point as integer)     as reorder_point,
        cast(reorder_quantity as integer)  as reorder_quantity
    from source
)

select * from renamed
