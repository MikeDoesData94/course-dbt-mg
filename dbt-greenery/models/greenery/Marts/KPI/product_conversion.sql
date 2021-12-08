{{
  config(
    materialized='table'
  )
}}

SELECT
    1.0 * COUNT(CASE WHEN checkout_events > 0 THEN 1 END) / COUNT(*) AS conversion_rate
FROM {{ref('fact_sessions')}}

