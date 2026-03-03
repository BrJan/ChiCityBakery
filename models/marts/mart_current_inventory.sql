/*
  Current inventory snapshot — one row per ingredient showing the
  quantity on hand after the most recent transaction.
*/

with running_balance as (
    select * from {{ ref('int_ingredient_running_balance') }}
),

ingredients as (
    select * from {{ ref('stg_ingredients') }}
),

suppliers as (
    select * from {{ ref('stg_suppliers') }}
),

-- Take only the last transaction row per ingredient (most recent balance)
latest_balance as (
    select
        ingredient_id,
        ingredient_name,
        unit_of_measure,
        unit_cost,
        transaction_date as last_transaction_date,
        transaction_type as last_transaction_type,
        quantity_on_hand,
        row_number() over (
            partition by ingredient_id
            order by transaction_date desc, transaction_id desc
        ) as rn
    from running_balance
),

final as (
    select
        lb.ingredient_id,
        lb.ingredient_name,
        i.category,
        lb.unit_of_measure,
        lb.unit_cost,
        s.supplier_name,
        lb.last_transaction_date,
        lb.last_transaction_type,
        lb.quantity_on_hand,
        round(lb.quantity_on_hand * lb.unit_cost, 2)    as inventory_value,
        i.reorder_point,
        i.reorder_quantity,
        lb.quantity_on_hand <= i.reorder_point           as is_below_reorder_point
    from latest_balance lb
    left join ingredients i using (ingredient_id)
    left join suppliers s on i.supplier_id = s.supplier_id
    where lb.rn = 1
)

select * from final
order by category, ingredient_name
