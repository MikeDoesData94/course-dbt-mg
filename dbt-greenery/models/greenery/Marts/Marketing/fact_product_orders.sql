{{
  config(
    materialized='table'
  )
}}

SELECT
    op.product_guid
  , op.product_name
  , op.product_price
  , COUNT(DISTINCT op.order_guid)        AS num_orders
  , COUNT(DISTINCT CASE WHEN op.promo_guid IS NOT NULL
                   THEN op.order_guid
                   END)                  AS num_orders_with_promo
  , COUNT(DISTINCT op.user_guid)         AS num_purchasers
  , AVG(op.product_qty)                  AS avg_items_per_purchase
FROM {{ ref('int_product_orders') }}      AS op
GROUP BY 1, 2, 3