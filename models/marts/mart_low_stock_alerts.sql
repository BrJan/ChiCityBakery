/*
  Ingredients that are at or below their reorder point.
  Use this model to drive purchasing decisions.
*/

with current_inventory as (
    select * from {{ ref('mart_current_inventory') }}
)

select
    ingredient_id,
    ingredient_name,
    category,
    unit_of_measure,
    supplier_name,
    quantity_on_hand,
    reorder_point,
    reorder_quantity,
    reorder_point - quantity_on_hand as units_below_reorder_point,
    inventory_value
from current_inventory
where is_below_reorder_point
order by units_below_reorder_point desc
