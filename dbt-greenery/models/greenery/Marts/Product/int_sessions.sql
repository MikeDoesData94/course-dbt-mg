{{
  config(
    materialized='table'
  )
}}

SELECT
    e.session_guid
  , e.user_guid
  , COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' then event_guid end) AS add_to_cart_events
  , COUNT(DISTINCT CASE WHEN event_type = 'checkout' then event_guid end) AS checkout_events
  , COUNT(DISTINCT CASE WHEN event_type = 'package_shipped' then event_guid end) AS package_shipped_events
  , COUNT(DISTINCT CASE WHEN event_type = 'account_created' then event_guid end) AS account_created_events
  , COUNT(DISTINCT CASE WHEN event_type = 'delete_from_cart' then event_guid end) AS delete_from_cart_events
  , MIN(created_at) AS session_start
  , MAX(created_at) AS session_finish
FROM {{ ref('stg_events') }} AS e
GROUP BY 1, 2