{{
  config(
    materialized = 'table'
  )
}}

SELECT
    order_guid
  , user_guid
  , order_cost
  , shipping_cost
  , order_total
  , status AS order_status
  , created_at
  , COUNT(product_guid)
FROM {{ref('stg_orders')}}
JOIN {{ref('stg_order_items')}}
    USING (order_guid)
GROUP BY 1,2,3,4,5,6,7
