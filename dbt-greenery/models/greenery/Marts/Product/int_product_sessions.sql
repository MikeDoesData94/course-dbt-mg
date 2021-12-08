{{
  config(
    materialized='table'
  )
}}

SELECT
    e.session_guid,
    e.user_guid,
    e.product_guid,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' then event_id end) AS add_to_cart_events,
    COUNT(DISTINCT CASE WHEN event_type = 'delete_from_cart' then event_id end) AS delete_from_cart_events,
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' then event_id end) AS page_view_events,
    MIN(created_at) AS session_start,
    MAX(created_at) AS session_finish
FROM {{ ref('stg_events') }} AS e
WHERE event_type IN ('add_to_cart','page_view', 'delete_from_cart')
GROUP BY 1, 2, 3