{{
  config(
    materialized='table'
   ,unique_key = 'address_id'
  )
}}

SELECT
      id                AS address_id
    , address_id        AS address_guid           
    , address
    , zipcode
    , state
    , country
FROM {{ source('tutorial', 'addresses') }}