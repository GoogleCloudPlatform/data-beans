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

# Need this version to implement
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


####################################################################################
# Deploy Colab notebooks
####################################################################################
resource "google_storage_bucket_object" "Customer-Reviews-Detect-Themes-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Customer-Reviews-Detect-Themes-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Customer-Reviews-Detect-Themes-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Customer-Reviews-Generate-Recommended-Action-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Recommended-Action-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Recommended-Action-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Customer-Reviews-Generate-Customer-Response-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Customer-Response-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Customer-Response-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Customer-Reviews-Synthetic-Data-Generation-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Customer-Reviews-Synthetic-Data-Generation-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Customer-Reviews-Synthetic-Data-Generation-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Customer-Reviews-Generate-Insight-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Insight-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Insight-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Customer-Reviews-Word-Cloud" {
  name   = "colab-enterprise/gen-ai-demo/Customer-Reviews-Word-Cloud.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Customer-Reviews-Word-Cloud.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}

resource "google_storage_bucket_object" "Event-Generate-Insight-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Event-Generate-Insight-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Event-Generate-Insight-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}

resource "google_storage_bucket_object" "Event-Populate-Table" {
  name   = "colab-enterprise/gen-ai-demo/Event-Populate-Table.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Event-Populate-Table.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Marketing-Campaign-Generate-Insight-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Marketing-Campaign-Generate-Insight-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Marketing-Campaign-Generate-Insight-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Menu-A-B-Testing-Generate-Campaign-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Menu-A-B-Testing-Generate-Campaign-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Menu-A-B-Testing-Generate-Campaign-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Menu-A-B-Testing-Generate-Insight-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Menu-A-B-Testing-Generate-Insight-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Menu-A-B-Testing-Generate-Insight-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Menu-Synthetic-Data-Generation-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Menu-Synthetic-Data-Generation-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Menu-Synthetic-Data-Generation-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}


resource "google_storage_bucket_object" "Sample-Synthetic-Data-Generation-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Sample-Synthetic-Data-Generation-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Sample-Synthetic-Data-Generation-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}

resource "google_storage_bucket_object" "Weather-Generate-Insight-GenAI" {
  name   = "colab-enterprise/gen-ai-demo/Weather-Generate-Insight-GenAI.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Weather-Generate-Insight-GenAI.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}

resource "google_storage_bucket_object" "Weather-Populate-Table" {
  name   = "colab-enterprise/gen-ai-demo/Weather-Populate-Table.ipynb"
  bucket = var.data_beans_code_bucket
  content = templatefile("../colab-enterprise/gen-ai-demo/Weather-Populate-Table.ipynb", 
  { 
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
  })
  depends_on = []  
}
