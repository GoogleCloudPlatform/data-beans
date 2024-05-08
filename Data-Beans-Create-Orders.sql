-- location_id 1 to 50
-- customer_id 1 to 10,702
-- 200 usa
-- 200 london GBR
-- 200 japan JPN
-- company_id 1 to 10
-- menu_id 1 to 212
-- customer reviews 1 to 8,027 (missing some rows)
-- CREATE OR REPLACE TABLE `PROJECT-ID.coffee_curated.order_backup` AS SELECT * FROM `PROJECT-ID.coffee_curated.order`

INSERT INTO
  `PROJECT-ID.coffee_curated.order` (
    order_id,
    location_id,
    customer_id,
    order_datetime,
    order_completion_datetime)

WITH
  data_max_id AS (
    -- 2021-11-01 03:59:47.952295 UTC, 2023-12-01 14:35:18.628451 UTC, 10000000, 10000000
    SELECT MIN(order_datetime) AS min_order_datetime, MAX(order_datetime) AS max_order_datetime, MAX(order_id) AS max_id, COUNT(*) AS record_count
      FROM`PROJECT-ID.coffee_curated.order`
  ),

  data_random_data AS (
    SELECT CAST(ROUND(1 + RAND() * (10 - 1)) AS INT64) AS location_id,
           CAST(ROUND(1 + RAND() * (10702 - 1)) AS INT64) AS customer_id,
           TIMESTAMP_ADD(data_max_id.max_order_datetime, INTERVAL CAST(ROUND(1 + RAND() * (30 * 24 * 60 * 2) - 1) AS INT64) MINUTE) AS order_datetime, -- 2 months of minutes
      FROM UNNEST(GENERATE_ARRAY(1, 1000000)) AS element
          CROSS JOIN data_max_id
  ),
  
  data_random_all_data AS (
    SELECT *,
           TIMESTAMP_ADD(order_datetime, INTERVAL CAST(ROUND(60 + RAND() * ((60*15)) - 60) AS INT64) SECOND) AS order_completion_datetime, -- from 60 seconds to 15 minutes
      FROM data_random_data
  ),

  data_ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY order_datetime) AS row_number
     FROM data_random_all_data
  )

-- SELECT extract(YEAR from order_datetime) as year, extract(MONTH from order_datetime) as month, count(*) FROM data_ranked GROUP BY ALL;
-- SELECT min(order_datetime), max(order_datetime) FROM data_ranked

SELECT row_number +  max_id AS  order_id,
    location_id,
    customer_id,
    order_datetime,
    order_completion_datetime 
FROM data_ranked
CROSS JOIN data_max_id;


/*

SELECT extract(YEAR from order_datetime) as year, 
        extract(MONTH from order_datetime) as month,
        count(*)
  FROM`PROJECT-ID.coffee_curated.order`
  group by all
  order by 1 desc, 2 desc

delete 
  from `PROJECT-ID.coffee_curated.order` 
 where extract(YEAR from order_datetime) = 2027
  and extract(MONTH from order_datetime) > 6;
*/


-- location_id 1 to 50
-- customer_id 1 to 10,702
-- 200 usa
-- 200 london GBR
-- 200 japan JPN
-- company_id 1 to 10
-- menu_id 1 to 212
-- customer reviews 1 to 8,027 (missing some rows)
--truncate table `PROJECT-ID.coffee_curated.order_item`;
-- CREATE OR REPLACE TABLE `PROJECT-ID.coffee_curated.order_item_backup` AS SELECT * FROM `PROJECT-ID.coffee_curated.order_item`

INSERT INTO `PROJECT-ID.coffee_curated.order_item` 
   (order_item_id, order_id, menu_id, quantity, item_size, item_price, item_total)
WITH
  data_max_id AS (
    SELECT IFNULL(MAX(order_item_id),0) AS max_id
      FROM `PROJECT-ID.coffee_curated.order_item`
  ),

  -- order's without items
  data_order AS (
    SELECT order_id,
           CASE WHEN RAND() <= .5 THEN 1 -- most order are 1 item
                ELSE CAST(ROUND(2 + RAND() * (5 - 2)) AS INT64) -- up to 5 items per order
            END AS order_item_count
      FROM `PROJECT-ID.coffee_curated.order` AS order_t
    WHERE NOT EXISTS (SELECT * FROM `PROJECT-ID.coffee_curated.order_item` AS order_item WHERE order_t.order_id = order_item.order_id)
  ),

  data_order_with_array AS 
  (
    select order_id,
           order_item_count,
           GENERATE_ARRAY(1, order_item_count) as order_item_array,
           RAND() AS quantity_rand
      from data_order
  ),

  data_random_all_data AS (
    SELECT order_id,
           order_item AS order_item_id,
          CAST(ROUND(1 + RAND() * (212 - 1)) AS INT64) AS menu_id,
          CASE WHEN quantity_rand <= .75 THEN 1 -- most orders are 1 quanity
               WHEN quantity_rand <= .85 THEN 2
               WHEN quantity_rand <= .90 THEN 3
               WHEN quantity_rand <= .95 THEN 4
               ELSE 5
            END AS quantity,           
      from data_order_with_array
           CROSS JOIN UNNEST(order_item_array) AS order_item
  ),

  data_ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY order_id, order_item_id) AS row_number
    FROM data_random_all_data
  )
SELECT row_number +  max_id AS order_item_id,
       data_ranked.order_id,
       data_ranked.menu_id,
       data_ranked.quantity,
       menu.item_size,
       menu.item_price,
       ROUND(CAST(data_ranked.quantity * menu.item_price AS NUMERIC), 2, "ROUND_HALF_EVEN") AS item_total
  FROM data_ranked
       CROSS JOIN data_max_id
       INNER JOIN `PROJECT-ID.data_beans_curated.menu` AS menu
               ON data_ranked.menu_id = menu.menu_id;

SELECT avg(item_total)
  from  `PROJECT-ID.coffee_curated.order` as parent     
      inner join `PROJECT-ID.coffee_curated.order_item` as child on parent.order_id = child.order_id


/*
CREATE OR REPLACE TABLE `data-analytics-golden-v1-share.coffee_curated.order` COPY `PROJECT-ID.coffee_curated.order`;
CREATE OR REPLACE TABLE `data-analytics-golden-v1-share.coffee_curated.order_item` COPY `PROJECT-ID.coffee_curated.order_item`;
*/



CREATE OR REPLACE MATERIALIZED VIEW `PROJECT-ID.coffee_curated.looker_databeans_report`
CLUSTER BY sale_date
OPTIONS (enable_refresh = true, refresh_interval_minutes = 30, description='Used for Looker Studio Pro with Duet AI')
AS
 SELECT
        EXTRACT(DATE FROM TIMESTAMP(order_datetime)) AS sale_date, 
       city.city_name,
       TIMESTAMP_DIFF(order_table.order_completion_datetime,order_table.order_datetime, SECOND) AS seconds_to_make_order,
       customer.customer_name, 
       company.company_name,
       order_item.quantity, 
       menu.item_name,
       menu.item_size, 
       menu.item_price as sale_price
  FROM `PROJECT-ID.coffee_curated.order` AS order_table
       INNER JOIN `PROJECT-ID.coffee_curated.order_item` AS order_item
               ON order_table.order_id = order_item.order_id
       INNER JOIN `PROJECT-ID.coffee_curated.menu` AS menu
               ON order_item.menu_id = menu.menu_id
       INNER join PROJECT-ID.coffee_curated.location as location
               ON order_table.location_id = location.location_id
       INNER join PROJECT-ID.coffee_curated.city as city
               ON location.city_id = city.city_id
       INNER join PROJECT-ID.coffee_curated.customer as customer
               ON customer.customer_id=order_table.customer_id
       INNER join PROJECT-ID.coffee_curated.company as company
               ON menu.company_id = company.company_id;


/*
SELECT """EXPORT DATA OPTIONS ( uri = 'gs://PROJECT-ID/data-beans/v1/export/""" || table_name || """/""" || table_name || """_*.avro', format = 'AVRO', overwrite = true) AS ( SELECT * FROM `PROJECT-ID.coffee_curated.""" || table_name || """`);"""
FROM coffee_curated.INFORMATION_SCHEMA.TABLES 
WHERE table_type = 'BASE TABLE' 
ORDER BY table_name;


EXPORT DATA OPTIONS ( uri = 'gs://PROJECT-ID/data-beans/v1/export/order/order_*.avro', format = 'AVRO', overwrite = true) AS ( SELECT * FROM `PROJECT-ID.coffee_curated.order`);
EXPORT DATA OPTIONS ( uri = 'gs://PROJECT-ID/data-beans/v1/export/order_item/order_item_*.avro', format = 'AVRO', overwrite = true) AS ( SELECT * FROM `PROJECT-ID.coffee_curated.order_item`);


LOAD DATA OVERWRITE `PROJECT-ID.coffee_curated.LOAD_order_item`
FROM FILES ( format = 'AVRO', uris = ['gs://PROJECT-ID/data-beans/v1/export/order_item/order_item_*.avro']);



LOAD DATA OVERWRITE `PROJECT-ID.coffee_curated.load_order` FROM FILES ( format = 'AVRO', uris = ['gs://PROJECT-ID/data-beans/v1/export/order/order_*.avro']);

CREATE TABLE `PROJECT-ID.coffee_curated.LOAD_order` 
CLUSTER BY (order_id)
AS
SELECT order_id, location_id, customer_id, 
       TIMESTAMP_MICROS(order_datetime) AS order_datetime, TIMESTAMP_MICROS(order_completion_datetime) AS order_completion_datetime
  FROM `PROJECT-ID.coffee_curated.load_order` ;

DROP TABLE `PROJECT-ID.coffee_curated.load_order`;


-- DELETE (by hand)

gsutil cp gs://PROJECT-ID/data-beans/v1/export/order/* gs://data-analytics-golden-demo/data-beans/v1/export/order/
gsutil cp gs://PROJECT-ID/data-beans/v1/export/order_item/* gs://data-analytics-golden-demo/data-beans/v1/export/order_item/



*/
