/*##################################################################################
# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###################################################################################*/

/*
Author: Adam Paternostro 

Use Cases:
    - Initializes the system (you can re-run this)

Description: 
    - Copies all tables (from analytics hub) and intializes the system with local data

References:
    - 

Clean up / Reset script:

*/


------------------------------------------------------------------------------------------------------------
-- Create GenAI / Vertex AI connections
------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE MODEL `${project_id}.${bigquery_data_beans_curated_dataset}.llm_model`
  REMOTE WITH CONNECTION `${project_id}.us.vertex-ai`
  OPTIONS (endpoint = 'text-bison@002');

CREATE OR REPLACE MODEL `${project_id}.${bigquery_data_beans_curated_dataset}.llm_model_32k`
  REMOTE WITH CONNECTION `${project_id}.us.vertex-ai`
  OPTIONS (endpoint = 'text-bison-32k@002');

CREATE MODEL IF NOT EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.gemini_pro`
  REMOTE WITH CONNECTION `${project_id}.us.vertex-ai`
  OPTIONS (endpoint = 'gemini-pro');


------------------------------------------------------------------------------------------------------------
-- Old code, left for emergencies
------------------------------------------------------------------------------------------------------------
/*
-- From public dataset / analytics hub
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.artifact`                       COPY `${project_id}.${data_beans_analytics_hub}.artifact`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.city`                           COPY `${project_id}.${data_beans_analytics_hub}.city`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_processor`               COPY `${project_id}.${data_beans_analytics_hub}.coffee_processor`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_roaster`                 COPY `${project_id}.${data_beans_analytics_hub}.coffee_roaster`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_farm`                    COPY `${project_id}.${data_beans_analytics_hub}.coffee_farm`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.company`                        COPY `${project_id}.${data_beans_analytics_hub}.company`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer`                       COPY `${project_id}.${data_beans_analytics_hub}.customer`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_profile`               COPY `${project_id}.${data_beans_analytics_hub}.customer_profile`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review`                COPY `${project_id}.${data_beans_analytics_hub}.customer_review`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.location`                       COPY `${project_id}.${data_beans_analytics_hub}.location`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.menu`                           COPY `${project_id}.${data_beans_analytics_hub}.menu`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.menu_a_b_testing`               COPY `${project_id}.${data_beans_analytics_hub}.menu_a_b_testing`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.order`                          COPY `${project_id}.${data_beans_analytics_hub}.order`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.order_item`                     COPY `${project_id}.${data_beans_analytics_hub}.order_item`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.sales_forecast`                 COPY `${project_id}.${data_beans_analytics_hub}.sales_forecast`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.city_location`                  COPY `${project_id}.${data_beans_analytics_hub}.city_location`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.city_location_address`          COPY `${project_id}.${data_beans_analytics_hub}.city_location_address`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.location_history`               COPY `${project_id}.${data_beans_analytics_hub}.location_history`;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.video_processing`               COPY `${project_id}.${data_beans_analytics_hub}.video_processing` ;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.event`                          COPY `${project_id}.${data_beans_analytics_hub}.event` ;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.event_gen_ai_insight`           COPY `${project_id}.${data_beans_analytics_hub}.event_gen_ai_insight` ;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.weather`                        COPY `${project_id}.${data_beans_analytics_hub}.weather` ;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.weather_gen_ai_insight`         COPY `${project_id}.${data_beans_analytics_hub}.weather_gen_ai_insight` ;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review_gen_ai_insight` COPY `${project_id}.${data_beans_analytics_hub}.customer_review_gen_ai_insight` ;
CREATE OR REPLACE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.marketing_gen_ai_insight`       COPY `${project_id}.${data_beans_analytics_hub}.marketing_gen_ai_insight` ;  
*/


/*
-- From storage, copied to local storage account first
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.artifact` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/artifact/artifact_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.city` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/city/city_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.city_location` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/city_location/city_location_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.city_location_address` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/city_location_address/city_location_address_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_farm` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/coffee_farm/coffee_farm_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_processor` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/coffee_processor/coffee_processor_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_roaster` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/coffee_roaster/coffee_roaster_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.company` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/company/company_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.customer` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/customer/customer_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_profile` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/customer_profile/customer_profile_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/customer_review/customer_review_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review_gen_ai_insight` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/customer_review_gen_ai_insight/customer_review_gen_ai_insight_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.event` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/event/event_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.event_gen_ai_insight` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/event_gen_ai_insight/event_gen_ai_insight_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.location` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/location/location_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.location_history` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/location_history/location_history_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.marketing_gen_ai_insight` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/marketing_gen_ai_insight/marketing_gen_ai_insight_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.menu` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/menu/menu_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.menu_a_b_testing` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/menu_a_b_testing/menu_a_b_testing_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.order` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/order/order_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.order_item` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/order_item/order_item_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.sales_forecast` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/sales_forecast/sales_forecast_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.video_processing` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/video_processing/video_processing_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.weather` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/weather/weather_*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.weather_gen_ai_insight` FROM FILES ( format = 'AVRO', uris = ['gs://${data_beans_curated_bucket}/data-beans/v1/export/weather_gen_ai_insight/weather_gen_ai_insight_*.avro']);
*/


------------------------------------------------------------------------------------------------------------
-- Drop everything (removes PKs)
------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.artifact`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.city`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.city_location`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.city_location_address`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_farm`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_processor`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_roaster`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.company`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.customer`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.customer_profile`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review_gen_ai_insight`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.event`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.event_gen_ai_insight`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.location`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.location_history`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.marketing_gen_ai_insight`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.menu`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.menu_a_b_testing`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.order`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.order_item`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.sales_forecast`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.video_processing`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.weather`;
DROP TABLE IF EXISTS `${project_id}.${bigquery_data_beans_curated_dataset}.weather_gen_ai_insight`;


------------------------------------------------------------------------------------------------------------
-- Load tables without any AVRO datatype conversion
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.artifact`                       FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/artifact/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.city_location`                  FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/city_location/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.city_location_address`          FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/city_location_address/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.company`                        FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/company/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_profile`               FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/customer_profile/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.event`                          FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/event/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.location`                       FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/location/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.menu`                           FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/menu/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.order_item`                     FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/order_item/*.avro']);
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.video_processing`               FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/video_processing/*.avro']);


------------------------------------------------------------------------------------------------------------
-- Geography: ST_GEOGPOINT(longitude, latitude) AS lat_long
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_city`                      FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/city/city_*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.city` 
CLUSTER BY (city_id)
AS
SELECT city_id, city_name, country_code, latitude, longitude, ST_GEOGPOINT(longitude, latitude) AS lat_long, popular_locations 
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_city` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_city`;


------------------------------------------------------------------------------------------------------------
-- Geography: ST_GEOGPOINT(longitude, latitude) AS lat_long
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_farm`                    FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/coffee_farm/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_farm` 
CLUSTER BY (coffee_farm_id)
AS
SELECT coffee_farm_id, name, latitude, longitude, ST_GEOGPOINT(longitude, latitude) AS lat_long, contact_name, contact_email, contact_code
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_farm` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_farm`;


------------------------------------------------------------------------------------------------------------
-- Geography: ST_GEOGPOINT(longitude, latitude) AS lat_long
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_processor`                    FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/coffee_processor/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_processor` 
CLUSTER BY (coffee_processor_id)
AS
SELECT coffee_processor_id, name, latitude, longitude, 
      ST_GEOGPOINT(longitude, latitude) AS lat_long, contact_name, contact_email, contact_code
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_processor` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_processor`;


------------------------------------------------------------------------------------------------------------
-- Geography: ST_GEOGPOINT(longitude, latitude) AS lat_long
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_roaster`                 FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/coffee_roaster/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_roaster` 
CLUSTER BY (coffee_roaster_id)
AS
SELECT coffee_roaster_id, name, latitude, longitude, ST_GEOGPOINT(longitude, latitude) AS lat_long, contact_name, contact_email, contact_code
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_roaster` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_coffee_roaster`;


------------------------------------------------------------------------------------------------------------
-- Date: customer_inception_date
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer`                       FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/customer/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer` 
CLUSTER BY (customer_id)
AS
SELECT customer_id, company_id, customer_name, customer_yob, customer_email, 
       DATE_FROM_UNIX_DATE(customer_inception_date) AS customer_inception_date, 
       country_code
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer`;


------------------------------------------------------------------------------------------------------------
-- review_datetime TIMESTAMP
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer_review`                FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/customer_review/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review` 
CLUSTER BY (customer_review_id)
AS
SELECT customer_review_id, customer_id, location_id, TIMESTAMP_MICROS(review_datetime) AS review_datetime, 
       review_text, review_sentiment, social_media_source, 
       social_media_handle, gen_ai_recommended_action, gen_ai_reponse, llm_detected_theme, review_audio_filename, 
       review_audio_gcs, review_audio_http, review_image_filename, review_image_gcs, review_image_http
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer_review` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer_review`;


------------------------------------------------------------------------------------------------------------
-- insight_datetime TIMESTAMP
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer_review_gen_ai_insight` FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/customer_review_gen_ai_insight/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review_gen_ai_insight` 
CLUSTER BY (customer_review_gen_ai_insight_id)
AS
SELECT customer_review_gen_ai_insight_id, customer_review_gen_ai_insight_type, TIMESTAMP_MICROS(insight_datetime) AS insight_datetime, 
       applies_to_entity_type, applies_to_entity_id, applies_to_entity_name, llm_prompt, ml_generate_json_result, generated_insight_text, generated_insight_json 
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer_review_gen_ai_insight` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_customer_review_gen_ai_insight`;


------------------------------------------------------------------------------------------------------------
-- insight_datetime TIMESTAMP
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_event_gen_ai_insight`           FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/event_gen_ai_insight/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.event_gen_ai_insight` 
CLUSTER BY (event_gen_ai_insight_id)
AS
SELECT event_gen_ai_insight_id, event_gen_ai_insight_type, TIMESTAMP_MICROS(insight_datetime) AS insight_datetime, 
       applies_to_entity_type, applies_to_entity_id, applies_to_entity_name, llm_prompt, ml_generate_json_result, generated_insight_text, generated_insight_json
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_event_gen_ai_insight` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_event_gen_ai_insight`;


------------------------------------------------------------------------------------------------------------
-- Has Geo location_history / Datetime
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_location_history`               FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/location_history/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.location_history` 
CLUSTER BY (location_history_id)
AS
SELECT location_history_id, location_id, city_id, 
       DATE_FROM_UNIX_DATE(location_date) AS location_date, 
       TIMESTAMP_MICROS(start_datetime) AS start_datetime, 
       TIMESTAMP_MICROS(stop_datetime) AS stop_datetime,
       address, latitude, longitude, 
       ST_GEOGPOINT(longitude, latitude) AS lat_long
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_location_history` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_location_history`;


------------------------------------------------------------------------------------------------------------
-- insight_datetime TIMESTAMP
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_marketing_gen_ai_insight`       FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/marketing_gen_ai_insight/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.marketing_gen_ai_insight` 
CLUSTER BY (marketing_gen_ai_insight_id)
AS
SELECT marketing_gen_ai_insight_id, marketing_gen_ai_insight_type, TIMESTAMP_MICROS(insight_datetime) AS insight_datetime, applies_to_entity_type, 
       applies_to_entity_id, applies_to_entity_name, picture_description, json_filename, html_filename, subject 
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_marketing_gen_ai_insight` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_marketing_gen_ai_insight`;


------------------------------------------------------------------------------------------------------------
-- create_date TIMESTAMP
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_menu_a_b_testing`               FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/menu_a_b_testing/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.menu_a_b_testing` 
CLUSTER BY (menu_a_b_testing_id)
AS
SELECT menu_a_b_testing_id, menu_id, location_id, item_name, item_description, item_size, 
       llm_item_description_prompt, llm_item_description, llm_item_image_prompt, llm_item_image_url, 
       TIMESTAMP_MICROS(create_date) AS create_date, llm_marketing_prompt, llm_marketing_response, 
       llm_marketing_parsed_response, html_generated, html_filename, html_url 
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_menu_a_b_testing` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_menu_a_b_testing`;


------------------------------------------------------------------------------------------------------------
-- TIMESTAMP
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_order`                          FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/order/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.order` 
CLUSTER BY (order_id)
AS
SELECT order_id, location_id, customer_id, 
       TIMESTAMP_MICROS(order_datetime) AS order_datetime, TIMESTAMP_MICROS(order_completion_datetime) AS order_completion_datetime
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_order` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_order`;

------------------------------------------------------------------------------------------------------------
-- sales_forecast has DATE - might be okay
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_sales_forecast`                 FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/sales_forecast/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.sales_forecast` 
CLUSTER BY (sales_forecast_id)
AS
SELECT sales_forecast_id, DATE_FROM_UNIX_DATE(forecast_date) AS forecast_date, sales_forecast_amount, city_id 
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_sales_forecast` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_sales_forecast`;



------------------------------------------------------------------------------------------------------------
-- weather_date DATE
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_weather`                        FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/weather/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.weather` 
CLUSTER BY (weather_id)
AS
SELECT weather_id, city_id, DATE_FROM_UNIX_DATE(weather_date) AS weather_date, weather_json
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_weather` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_weather`;


------------------------------------------------------------------------------------------------------------
-- insight_datetime TIMESTAMP
------------------------------------------------------------------------------------------------------------
LOAD DATA OVERWRITE `${project_id}.${bigquery_data_beans_curated_dataset}.load_weather_gen_ai_insight`         FROM FILES ( format = 'AVRO', uris = ['gs://data-analytics-golden-demo/data-beans/v1/export/weather_gen_ai_insight/*.avro']);

CREATE TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.weather_gen_ai_insight` 
CLUSTER BY (weather_gen_ai_insight_id)
AS
SELECT weather_gen_ai_insight_id, weather_gen_ai_insight_type, TIMESTAMP_MICROS(insight_datetime) AS insight_datetime, 
       applies_to_entity_type, applies_to_entity_id, applies_to_entity_name, llm_prompt,
       ml_generate_json_result, generated_insight_text, generated_insight_json
  FROM `${project_id}.${bigquery_data_beans_curated_dataset}.load_weather_gen_ai_insight` ;

DROP TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.load_weather_gen_ai_insight`;


------------------------------------------------------------------------------------------------------------
-- Primary Keys
------------------------------------------------------------------------------------------------------------
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.artifact`                       ADD PRIMARY KEY (artifact_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.city`                           ADD PRIMARY KEY (city_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_processor`               ADD PRIMARY KEY (coffee_processor_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_roaster`                 ADD PRIMARY KEY (coffee_roaster_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.coffee_farm`                    ADD PRIMARY KEY (coffee_farm_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.company`                        ADD PRIMARY KEY (company_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer`                       ADD PRIMARY KEY (customer_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_profile`               ADD PRIMARY KEY (customer_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review`                ADD PRIMARY KEY (customer_review_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.location`                       ADD PRIMARY KEY (location_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.menu`                           ADD PRIMARY KEY (menu_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.menu_a_b_testing`               ADD PRIMARY KEY (menu_a_b_testing_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.order`                          ADD PRIMARY KEY (order_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.order_item`                     ADD PRIMARY KEY (order_item_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.sales_forecast`                 ADD PRIMARY KEY (sales_forecast_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.city_location`                  ADD PRIMARY KEY (city_location_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.city_location_address`          ADD PRIMARY KEY (city_location_address_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.location_history`               ADD PRIMARY KEY (location_history_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.event`                          ADD PRIMARY KEY (event_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.event_gen_ai_insight`           ADD PRIMARY KEY (event_gen_ai_insight_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.weather`                        ADD PRIMARY KEY (weather_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.weather_gen_ai_insight`         ADD PRIMARY KEY (weather_gen_ai_insight_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.customer_review_gen_ai_insight` ADD PRIMARY KEY (customer_review_gen_ai_insight_id) NOT ENFORCED; 
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.marketing_gen_ai_insight`       ADD PRIMARY KEY (marketing_gen_ai_insight_id) NOT ENFORCED; 


------------------------------------------------------------------------------------------------------------
-- Add descriptions (to do)
------------------------------------------------------------------------------------------------------------
ALTER TABLE `${project_id}.${bigquery_data_beans_curated_dataset}.artifact`
  ALTER COLUMN artifact_id SET OPTIONS (description='Primary key.'),
  ALTER COLUMN artifact_category SET OPTIONS (description='The category grouping of the artifact.'),
  ALTER COLUMN artifact_name SET OPTIONS (description='The name of the artifact.'),
  ALTER COLUMN artifact_order SET OPTIONS (description='The order in which to display the artifact.'),
  ALTER COLUMN artifact_short_description SET OPTIONS (description='The short description of the artifact.'),
  ALTER COLUMN artifact_long_description SET OPTIONS (description='The long ort name of the artifact.'),
  ALTER COLUMN artifact_video_thumbnail_url SET OPTIONS (description='The url for the video thumbnail.'),
  ALTER COLUMN artifact_video_url SET OPTIONS (description='The url for the video (GCS).'),
  ALTER COLUMN artifact_youtube_url SET OPTIONS (description='The url for the YouTube video.'),
  ALTER COLUMN artifact_url SET OPTIONS (description='The url for the artifact (GitHub).'),
  ALTER COLUMN artifact_gslides_url SET OPTIONS (description='The url for the artifact (Google Slides).');