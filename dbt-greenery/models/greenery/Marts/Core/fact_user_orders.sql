{{
  config(
    materialized = 'table'
  )
}}

SELECT
    order_guid
  , COUNT(1) AS num_orders
FROM {{ref('dim_users')}}
JOIN {{ref('fact_orders')}}
    USING (user_guid)
GROUP BY 1