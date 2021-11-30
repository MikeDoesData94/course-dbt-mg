# Part 1

## Question 1: What is our user repeat rate? (e.g. Customers who have placed 2 or more orders / total customers )

```SQL

-- Counts the number of orders for each consumer
WITH multi_orders AS(
  SELECT 
      user_guid
    , COUNT (DISTINCT order_id) as qty_orders
  FROM dbt_gagliano.stg_orders
  WHERE delivered_at IS NOT NULL
  GROUP BY 1)

SELECT
    1.0 * COUNT(CASE WHEN qty_orders > 1 THEN user_guid END) / COUNT(*) AS repeat_customers
FROM multi_orders;
    
  

```
### Answer: 75% (80% if you remove the conditional WHERE clause so that the result set isn't just completed orders)
```
    repeat_customers    
------------------------
 0.75806451612903225806
(1 row)
```


---
---

## Question 2: What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

```
no code required here
```

### Answer: See below

A good indicator may vary based on how you and/or the stakeholder defines a repeat user. 
  - Are these orders and/or the nature of the items purchased seasonal or cyclical, where trends can be mapped?  

In this scenario we don't have a ton of historical data to look back on, so a **general** good indicator is how frequent they are purchasing relative to an establish baseline purchase frequency

A indicator that represents someone who is not likely to purchase again can be based on those who don't fit the criteria above.

Knowing what kinds of items are being purchased can really help start defining some metrics.
Consider the items if they were something like dog food - you'll probably expect the customer to purchase on a frequent basis.

---
---
## Question 3: More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units: (Core, Marketing, Product)

```
no code required
```
### Answer: See above

---
---
## Question 4: Explain the marts models you added. Why did you organize the models in the way you did?

```
no code required
```

### Answer:  Based on how each group would likely access the data, and the types of analyses they would be doing with them.

Core incudes essentially just your standard "raw" data that the data scientists might prefer
Marketing includes models based around data that would be used for market baset analysis and customer behavior deep dives
Product includes models based around how users interact during each of their sessions

---
---

## Question 5: Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

```
no code required (dbt docs generate)(dbt docs serve)
```
### Answer: see attached image in repository (DAG_week2)

---
---

# Part 2: Tests

## Question 6: What assumptions are you making about each model? (i.e. why are you adding each test?)

### Answer: For simplicities sake, the tests included only are checking for nulls and unique values (where applicable). We don't want to include a test for unique when we expect multiple records with the same field to come back (product_name for example)

---
---

## Question 7: Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

### Answer: Yes! On the fact_product_orders model, the unique and not null tests both failed. However, they passed on the int_product_orders model. This tells me that an aggregate is likeley causing fanout, and we can drop the test for uniqueness. However, more exploration is needed to see why we are getting a null value for the product_guid test.


