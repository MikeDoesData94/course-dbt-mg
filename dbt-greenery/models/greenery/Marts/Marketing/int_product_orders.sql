{{
    config(
        materialized='table'
    )
}}

SELECT
    o.user_guid
  , o.order_guid
  , oi.product_guid
  , o.promo_guid
  , o.order_cost
  , o.shipping_cost
  , promo.discount
  , o.order_total
  , o.shipping_service
  , o.estimated_delivery_at
  , o.delivered_at
  , o.status AS order_status
  , p.name   AS product_name
  , p.price  AS product_price
  , oi.quantity AS product_qty
  , o.created_at
FROM {{ref('stg_orders')}}          AS o
LEFT JOIN {{ref('stg_order_items')}}     AS oi
    ON o.order_guid = oi.order_guid
LEFT JOIN {{ref('stg_products')}}   AS p
    ON oi.product_guid = p.product_guid
LEFT JOIN {{ref('stg_promos')}}     AS promo
    ON o.promo_guid = promo.promo_guid
