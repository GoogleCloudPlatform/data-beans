####################################################################################
# Copyright 2025 Google LLC
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

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google-beta"
      version = "7.3.0"
    }
  }
}


####################################################################################
# Variables
####################################################################################
variable "project_id" {}
variable "vertex_ai_region" {}
variable "bigquery_data_beans_curated_dataset" {}
variable "data_beans_curated_bucket" {}
variable "data_beans_code_bucket" {}
variable "dataform_region" {}
variable "cloud_function_region" {}
variable "workflow_region" {}
variable "random_extension" {}
variable "gcp_account_name" {}

data "google_client_config" "current" {
}


# Define the list of notebook files to be created
locals {
  colab_enterprise_notebooks = [ 
    for s in fileset("../colab-enterprise/gen-ai-demo/", "*.ipynb") : trimsuffix(s, ".ipynb")
  ]  

  notebook_names = local.colab_enterprise_notebooks # concat(local.TTTT, local.colab_enterprise_notebooks)
}


# Setup Dataform repositories to host notebooks
# Create the Dataform repos.  This will create all the repos across all directories
resource "google_dataform_repository" "notebook_repo" {
  count        = length(local.notebook_names)
  provider     = google-beta
  project      = var.project_id
  region       = var.dataform_region
  name         = local.notebook_names[count.index]
  display_name = local.notebook_names[count.index]
  labels = {
    "single-file-asset-type" = "notebook"
  }
}


# Template Substitution - You need one of these blocks per Notebook Directory
resource "local_file" "local_file_colab_enterprise_notebooks" {
  count    = length(local.colab_enterprise_notebooks)
  filename = "../terraform-modules/colab-deployment-create-files/notebooks/${local.colab_enterprise_notebooks[count.index]}.ipynb" 
  content = templatefile("../colab-enterprise/gen-ai-demo/${local.colab_enterprise_notebooks[count.index]}.ipynb",
   {
    project_id = var.project_id
    vertex_ai_region = var.vertex_ai_region
    bigquery_data_beans_curated_dataset = var.bigquery_data_beans_curated_dataset
    data_beans_curated_bucket = var.data_beans_curated_bucket
    data_beans_code_bucket = var.data_beans_code_bucket
    dataform_region = var.dataform_region
    cloud_function_region = var.cloud_function_region
    workflow_region = var.workflow_region
    random_extension = var.random_extension
    gcp_account_name = var.gcp_account_name
    }
  )
}



# Deploy notebooks -  You need one of these blocks per Notebook Directory
# https://cloud.google.com/dataform/reference/rest/v1beta1/projects.locations.repositories/commit#WriteFile
#json='{
#  "commitMetadata": {
#    "author": {
#      "name": "Google Data Bean",
#      "emailAddress": "no-reply@google.com"
#    },
#    "commitMessage": "Committing Colab notebook"
#  },
#  "fileOperations": {
#      "content.ipynb": {
#         "writeFile": {
#           "contents" : "..."
#       }
#    }
#  }
#}'

# Write out the curl command content 
# If you do this within a docker/cloud build you can run into issues with the command output display being too long
resource "local_file" "local_file_colab_enterprise_notebooks_base64" {
  count    = length(local.colab_enterprise_notebooks)
  filename = "../terraform-modules/colab-deployment-create-files/notebooks_base64/${local.colab_enterprise_notebooks[count.index]}.base64" 
  content = "{\"commitMetadata\": {\"author\": {\"name\": \"Google Data Bean\",\"emailAddress\": \"no-reply@google.com\"},\"commitMessage\": \"Committing Colab notebook\"},\"fileOperations\": {\"content.ipynb\": {\"writeFile\": {\"contents\" : \"${base64encode(local_file.local_file_colab_enterprise_notebooks[count.index].content)}\"}}}}"
}
