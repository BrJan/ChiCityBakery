/*
  End-of-day inventory balance per ingredient.
  One row per ingredient per day where a transaction occurred.
  Useful for trending inventory levels over time.
*/

with running_balance as (
    select * from {{ ref('int_ingredient_running_balance') }}
),

-- For each ingredient + date, grab the quantity after the last transaction of that day
end_of_day as (
    select
        ingredient_id,
        ingredient_name,
        unit_of_measure,
        unit_cost,
        transaction_date,
        quantity_on_hand,
        row_number() over (
            partition by ingredient_id, transaction_date
            order by transaction_id desc
        ) as rn
    from running_balance
)

select
    {{ dbt_utils.generate_surrogate_key(['transaction_date', 'ingredient_id']) }} as snapshot_id,
    transaction_date                                                               as snapshot_date,
    ingredient_id,
    ingredient_name,
    unit_of_measure,
    quantity_on_hand,
    unit_cost,
    round(quantity_on_hand * unit_cost, 2)                                         as inventory_value
from end_of_day
where rn = 1
order by snapshot_date, ingredient_name
