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
    - Initializes the system

Description: 
    - Copies all tables (from analytics hub) and intializes the system with local data

References:
    - 

Clean up / Reset script:

*/


CREATE OR REPLACE MODEL `${project_id}.${bigquery_data_beans_curated_dataset}.llm_model`
  REMOTE WITH CONNECTION `${project_id}.us.vertex-ai`
  OPTIONS (endpoint = 'text-bison@002');

CREATE OR REPLACE MODEL `${project_id}.${bigquery_data_beans_curated_dataset}.llm_model_32k`
  REMOTE WITH CONNECTION `${project_id}.us.vertex-ai`
  OPTIONS (endpoint = 'text-bison-32k@002');


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
