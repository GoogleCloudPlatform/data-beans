CREATE OR REPLACE MATERIALIZED VIEW `${project_id}.coffee_curated.looker_databeans_report`
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
  FROM `${project_id}.coffee_curated.order` AS order_table
       INNER JOIN `${project_id}.coffee_curated.order_item` AS order_item
               ON order_table.order_id = order_item.order_id
       INNER JOIN `${project_id}.coffee_curated.menu` AS menu
               ON order_item.menu_id = menu.menu_id
       INNER join ${project_id}.coffee_curated.location as location
               ON order_table.location_id = location.location_id
       INNER join ${project_id}.coffee_curated.city as city
               ON location.city_id = city.city_id
       INNER join ${project_id}.coffee_curated.customer as customer
               ON customer.customer_id=order_table.customer_id
       INNER join ${project_id}.coffee_curated.company as company
               ON menu.company_id = company.company_id;