{{
  config(
    materialized='table'
  )
}}

SELECT
      product_guid
    , name
    , quantity as product_in_stock
FROM {{ref('stg_products')}}