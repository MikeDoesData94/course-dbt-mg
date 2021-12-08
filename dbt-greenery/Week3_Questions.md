# Part 1

## Question 1: What is our overall conversion rate?

```SQL

-- SELECT * FROM dbt_gagliano.product_conversion;    
SELECT
    1.0 * COUNT(CASE WHEN checkout_events > 0 THEN 1 END) / COUNT(*) AS conversion_rate
FROM {{ref('fact_sessions')}}  

```
### Answer: ~33%
```
    conversion_rate     
------------------------
 0.32976092333058532564
(1 row)
```


---
---

## Question 2: What is our conversion rate *by product* ?

```SQL

-- SELECT * FROM dbt_gagliano.conversion_by_product;  
SELECT
    product_name
  , 1.0 * COUNT(CASE WHEN add_to_cart_events - delete_from_cart_events > 0 THEN 1 END) / COUNT(*) AS product_conversion_rate
FROM {{ref('fact_product_sessions')}}
GROUP BY 1
ORDER BY 2 DESC

```

### Answer: 

```
   product_name     | product_conversion_rate 
---------------------+-------------------------
 Angel Wings Begonia |  0.66666666666666666667
 Pink Anthurium      |  0.62500000000000000000
 Ficus               |  0.61016949152542372881
 Calathea Makoyana   |  0.60784313725490196078
 Majesty Palm        |  0.60655737704918032787
 Aloe Vera           |  0.60000000000000000000
 Fiddle Leaf Fig     |  0.59183673469387755102
 Philodendron        |  0.58620689655172413793
 Pilea Peperomioides |  0.57894736842105263158
 Jade Plant          |  0.57142857142857142857
 ZZ Plant            |  0.56521739130434782609
 Snake Plant         |  0.55932203389830508475
 Bird of Paradise    |  0.55932203389830508475
 Rubber Plant        |  0.55555555555555555556
 Ponytail Palm       |  0.55555555555555555556
 Arrow Head          |  0.54794520547945205479
 Boston Fern         |  0.54716981132075471698
 Orchid              |  0.54545454545454545455
 Birds Nest Fern     |  0.53968253968253968254
 Dragon Tree         |  0.53846153846153846154
 Monstera            |  0.52941176470588235294
 Cactus              |  0.52459016393442622951
 Bamboo              |  0.52112676056338028169
 Alocasia Polly      |  0.52000000000000000000
 String of pearls    |  0.51898734177215189873
 Devil's Ivy         |  0.50000000000000000000
 Money Tree          |  0.50000000000000000000
 Spider Plant        |  0.50000000000000000000
 Pothos              |  0.48000000000000000000
 Peace Lily          |  0.45000000000000000000
                     |  0.00000000000000000000
(31 rows)
```