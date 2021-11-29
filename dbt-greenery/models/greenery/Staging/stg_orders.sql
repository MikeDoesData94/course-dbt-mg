{{
  config(
    materialized = 'table'
   ,unique_key = 'order_id'
  )
}}

SELECT 
    id                                   AS order_id
  , order_id                             AS order_guid
  , user_id                              AS user_guid
  , promo_id
  , address_id                           AS address_guid
  , created_at::timestamp                AS created_at
  , order_cost
  , shipping_cost
  , order_total
  , tracking_id
  , shipping_service
  , estimated_delivery_at::timestamp     AS estimated_delivery_at
  , delivered_at::timestamp              AS delivered_at
  , status
FROM {{ source('tutorial', 'orders') }}