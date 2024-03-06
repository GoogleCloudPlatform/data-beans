####################################################################################
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
####################################################################################

####################################################################################
# Create the GCP resources
#
# Author: Adam Paternostro
####################################################################################


terraform {
  required_providers {
    google = {
      source  = "hashicorp/google-beta"
      version = ">= 4.52, < 6"
    }
  }
}


####################################################################################
# Variables
####################################################################################
variable "gcp_account_name" {}
variable "project_id" {}

variable "dataplex_region" {}
variable "multi_region" {}
variable "bigquery_non_multi_region" {}
variable "vertex_ai_region" {}
variable "data_catalog_region" {}
variable "appengine_region" {}
variable "colab_enterprise_region" {}

variable "random_extension" {}
variable "project_number" {}
variable "deployment_service_account_name" {}
variable "terraform_service_account" {}

variable "bigquery_data_beans_curated_dataset" {}
variable "data_beans_curated_bucket" {}
variable "data_beans_code_bucket" {}
variable "data_beans_analytics_hub" {}

data "google_client_config" "current" {
}

####################################################################################
# UDFs
####################################################################################
resource "google_bigquery_routine" "clean_llm_json" {
  project         = var.project_id
  dataset_id      = var.bigquery_data_beans_curated_dataset
  routine_id      = "clean_llm_json"
  routine_type    = "SCALAR_FUNCTION"
  language        = "SQL"

  definition_body = templatefile("../sql-scripts/data_beans_curated/clean_llm_json.sql", 
  { 
    project_id = var.project_id
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
  })

  arguments {
    name          = "input"
    argument_kind = "FIXED_TYPE"
    data_type     = jsonencode({ "typeKind" : "JSON" })
  }

  return_type = "{\"typeKind\" :  \"JSON\"}"
}

resource "google_bigquery_routine" "clean_llm_text" {
  project         = var.project_id
  dataset_id      = var.bigquery_data_beans_curated_dataset
  routine_id      = "clean_llm_text"
  routine_type    = "SCALAR_FUNCTION"
  language        = "SQL"

  definition_body = templatefile("../sql-scripts/data_beans_curated/clean_llm_text.sql", 
  { 
    project_id = var.project_id
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
  })

  arguments {
    name          = "input"
    argument_kind = "FIXED_TYPE"
    data_type     = jsonencode({ "typeKind" : "JSON" })
  }
  
  return_type = "{\"typeKind\" :  \"STRING\"}"
}


resource "google_bigquery_routine" "clean_llmgemini_pro_result_as_json_json" {
  project         = var.project_id
  dataset_id      = var.bigquery_data_beans_curated_dataset
  routine_id      = "gemini_pro_result_as_json"
  routine_type    = "SCALAR_FUNCTION"
  language        = "SQL"

  definition_body = templatefile("../sql-scripts/data_beans_curated/gemini_pro_result_as_json.sql", 
  { 
    project_id = var.project_id
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
  })

  arguments {
    name          = "input"
    argument_kind = "FIXED_TYPE"
    data_type     = jsonencode({ "typeKind" : "JSON" })
  }

  return_type = "{\"typeKind\" :  \"JSON\"}"
}


resource "google_bigquery_routine" "gemini_pro_result_as_string" {
  project         = var.project_id
  dataset_id      = var.bigquery_data_beans_curated_dataset
  routine_id      = "gemini_pro_result_as_string"
  routine_type    = "SCALAR_FUNCTION"
  language        = "SQL"

  definition_body = templatefile("../sql-scripts/data_beans_curated/gemini_pro_result_as_string.sql", 
  { 
    project_id = var.project_id
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
  })

  arguments {
    name          = "input"
    argument_kind = "FIXED_TYPE"
    data_type     = jsonencode({ "typeKind" : "JSON" })
  }
  
  return_type = "{\"typeKind\" :  \"STRING\"}"
}


####################################################################################
# Stored Procedures
####################################################################################
resource "google_bigquery_routine" "initialize" {
  project         = var.project_id
  dataset_id      = var.bigquery_data_beans_curated_dataset
  routine_id      = "initialize"
  routine_type    = "PROCEDURE"
  language        = "SQL"
  definition_body = templatefile("../sql-scripts/data_beans_curated/initialize.sql", 
  { 
    project_id = var.project_id
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_analytics_hub = var.data_beans_analytics_hub
    data_beans_curated_bucket = var.data_beans_curated_bucket
  })
}


####################################################################################
# Invoke Initalize SP
####################################################################################
/* THIS RUNS OVER AND OVER AGAIN (for each TF execution) WHICH WILL OVERWRITE THE DATA
data "google_client_config" "current" {
}

# Call the BigQuery initialize stored procedure to initialize the system
data "http" "call_sp_initialize" {
  url    = "https://bigquery.googleapis.com/bigquery/v2/projects/${var.project_id}/jobs"
  method = "POST"
  request_headers = {
    Accept = "application/json"
  Authorization = "Bearer ${data.google_client_config.current.access_token}" }
  request_body = "{\"configuration\":{\"query\":{\"query\":\"CALL `${var.project_id}.${var.bigquery_data_beans_curated_dataset}.initialize`();\",\"useLegacySql\":false}}}"
  depends_on = [
     google_bigquery_routine.initialize
  ]
}
*/


resource "null_resource" "call_sp_initialize" {
  provisioner "local-exec" {
    when    = create
    command = <<EOF
  curl -X POST \
  https://bigquery.googleapis.com/bigquery/v2/projects/${var.project_id}/jobs \
  --header "Authorization: Bearer ${data.google_client_config.current.access_token}" \
  --header "Content-Type: application/json" \
  --data '{ "configuration" : { "query" : { "query" : "CALL `${var.project_id}.${var.bigquery_data_beans_curated_dataset}.initialize`();", "useLegacySql" : false } } }'
EOF
  }
  depends_on = [
    google_bigquery_routine.initialize
  ]
}
