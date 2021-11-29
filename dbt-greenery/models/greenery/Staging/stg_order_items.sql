{{
    config(
      materialized = 'table'
     ,unique_key = 'order_id'
    )
}}  
  
SELECT
      id                           AS order_id
    , order_id                     AS order_guid
    , product_id                   AS product_guid
    , quantity
FROM {{ source('tutorial', 'order_items') }}