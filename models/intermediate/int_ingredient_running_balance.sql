/*
  One row per transaction with a cumulative running balance of quantity on hand
  for each ingredient, ordered by date and transaction ID.
*/

with transactions as (
    select * from {{ ref('stg_inventory_transactions') }}
),

ingredients as (
    select * from {{ ref('stg_ingredients') }}
),

running_balance as (
    select
        t.transaction_id,
        t.transaction_date,
        t.ingredient_id,
        i.ingredient_name,
        i.unit_of_measure,
        i.unit_cost,
        t.transaction_type,
        t.quantity_change,
        t.notes,
        sum(t.quantity_change) over (
            partition by t.ingredient_id
            order by t.transaction_date, t.transaction_id
            rows between unbounded preceding and current row
        ) as quantity_on_hand
    from transactions t
    left join ingredients i using (ingredient_id)
)

select * from running_balance
