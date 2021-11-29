{{
    config(
      materialized = 'table'
     ,unique_key = 'promo_id'
    )
}}  
  
SELECT
      id                           AS promo_id
    , promo_id                     AS promo_guid
    , discout                      AS discount
    , status
FROM {{ source('tutorial', 'promos') }}