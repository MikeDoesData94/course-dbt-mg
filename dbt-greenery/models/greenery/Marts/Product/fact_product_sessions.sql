{{
  config(
    materialized='table'
  )
}}

SELECT
  ps.session_guid,
  ps.user_guid,
  ps.product_guid,
  p.name AS product_name,
  a.address,
  a.zipcode,
  a.state,
  a.country,
  ps.add_to_cart_events,
  ps.delete_from_cart_events,
  ps.page_view_events,
  ps.session_start,
  ps.session_finish
FROM {{ ref('int_product_sessions') }} ps
LEFT JOIN {{ ref('stg_users') }} u
  ON ps.user_guid = u.user_guid
LEFT JOIN {{ ref('stg_addresses') }} a
  ON u.address_guid = a.address_guid
LEFT JOIN {{ ref('stg_products') }} p
  ON ps.product_guid = p.product_guid