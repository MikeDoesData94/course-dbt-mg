{{
    config(
      materialized = 'table'
     ,unique_key = 'product_id'
    )
}}  
  
SELECT
      id                           AS product_id
    , product_id                   AS product_guid
    , name
    , price
    , quantity
FROM {{ source('tutorial', 'products') }}