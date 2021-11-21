
{{
    config(
      materialized = 'table'
     ,unique_key = 'user_id'
    )
}}  

SELECT 
    id                      AS user_id
  , user_id                 AS user_guid 
  , first_name
  , last_name
  , email
  , phone_number
  , created_at::timestamp   AS created_at
  , updated_at::timestamp   AS updated_at
  , address_id              AS address_guid
FROM {{ source('tutorial', 'users') }}