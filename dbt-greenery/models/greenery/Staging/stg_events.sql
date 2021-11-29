
{{
    config(
      materialized = 'table'
     ,unique_key = 'event_id'
    )
}}  
  
SELECT
      id                           AS event_id
    , event_id                     AS event_guid           
    , session_id                   AS session_guid
    , user_id                      AS user_guid
    , event_type
    , page_url
    , created_at::timestamp        AS created_at
FROM {{ source('tutorial', 'events') }}