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
      version = "4.42.0"
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
variable "curl_impersonation" {}
variable "terraform_service_account" {}

variable "bigquery_data_beans_curated_dataset" {}
variable "data_beans_curated_bucket" {}
variable "data_beans_code_bucket" {}
variable "data_beans_analytics_hub" {}


####################################################################################
# UDFs
####################################################################################
resource "google_bigquery_routine" "clean_llm_json" {
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

####################################################################################
# Stored Procedures
####################################################################################
resource "google_bigquery_routine" "initialize" {
  dataset_id      = var.bigquery_data_beans_curated_dataset
  routine_id      = "initialize"
  routine_type    = "PROCEDURE"
  language        = "SQL"
  definition_body = templatefile("../sql-scripts/data_beans_curated/initialize.sql", 
  { 
    project_id = var.project_id
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_analytics_hub = var.data_beans_analytics_hub
  })
}