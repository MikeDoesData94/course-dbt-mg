{{
  config(
    materialized='table'
  )
}}

SELECT
    product_name
  , 1.0 * COUNT(CASE WHEN add_to_cart_events - delete_from_cart_events > 0 THEN 1 END) / COUNT(*) AS product_conversion_rate
FROM {{ref('fact_product_sessions')}}
GROUP BY 1
ORDER BY 2 DESC