## Question 1: How many users do we have?

```SQL
SELECT COUNT(DISTINCT user_id)
FROM dbt_gagliano.stg_users;

```
### Answer: 130 Users
---
---

## Question 2: On average, how many orders do we receive per hour?

```SQL
-- This groups # of orders by hour
WITH hourly_orders AS(
    SELECT 
        date_trunc('hours', created_at) AS order_hour
      , COUNT(DISTINCT order_id) AS quantity_orders
    FROM dbt_gagliano.stg_orders
    GROUP BY 1
)

-- This takes the average of the # of orders per hour from the aggregate above
SELECT
    AVG(quantity_orders)
FROM hourly_orders;
```

### Answer: 8.1 Orders per hour

---
---
## Question 3: On average, how long does an order take from being placed to being delivered?

```SQL
-- We need to include the WHERE clause so that we are only focusing on orders that have been delivered, although technically it will return the same results without it
SELECT
    AVG(delivered_at - created_at)
FROM dbt_gagliano.stg_orders
WHERE status = 'delivered';
```
### Answer: 3 Days, 22 hours, 13 minutes

---
---
## Question 4: How many users many 1 purchase? 2 purchases? 3 or more?

```SQL
WITH purchases_per_user_grouped AS(
    SELECT
        user_guid
      , COUNT(order_id) as user_orders
    FROM dbt_gagliano.stg_orders
    GROUP BY 1
)

SELECT
    SUM( CASE WHEN user_orders = 1 THEN 1 ELSE 0 END) AS "1"
  , SUM( CASE WHEN user_orders = 2 THEN 1 ELSE 0 END) AS "2"
  , SUM( CASE WHEN user_orders >= 3 THEN 1 ELSE 0 END) AS "3+"
FROM purchases_per_user_grouped;
```

### Answer:  
```
 1  | 2  | 3+ 
----+----+----
 25 | 22 | 81
```

---
---

## Question 5: How many unique sessions do we have per hour

```SQL
-- This groups # of sessions by hour
WITH hourly_events AS(
    SELECT 
        date_trunc('hours', created_at) AS event_hour
      , COUNT(DISTINCT session_guid) AS quantity_sessions
    FROM dbt_gagliano.stg_events
    GROUP BY 1
)

-- This takes the average of the # of sessions per hour from the aggregate above
SELECT
    AVG(quantity_sessions)
FROM hourly_events;
```
### Answer: 7.3 (or 8 rounded up)