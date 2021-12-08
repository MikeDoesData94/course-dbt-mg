  
​​{% macro extract_product_id(column_name) %}

   CASE WHEN position('https://greenary.com/product/' in {{ column_name }})>0 THEN
      replace({{ column_name }},'https://greenary.com/product/','') END
      
{% endmacro %}