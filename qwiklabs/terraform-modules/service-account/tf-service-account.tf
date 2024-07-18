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
# Create the service principal and sets permissions for impersonation
# The service account is currently "not used" since you cannot conditionally set a TF provider with impersonation
# It does work when you run Terraform as as user, but not as a service account (which impersonates another service account)
#
# Author: Adam Paternostro
####################################################################################


terraform {
  required_providers {
    google = {
      source  = "hashicorp/google-beta"
      version = "5.35.0"
    }
  }
}


####################################################################################
# Variables
####################################################################################
variable "project_id" {}
variable "org_id" {}
variable "impersonation_account" {} //  "user:${var.gcp_account_name}" or "serviceAccount:${var.deployment_service_account_name}"
variable "gcp_account_name" {}
variable "environment" {}


# Probably need to change to a sevice account
/*
resource "google_project_iam_member" "service_account_cloud_function_v2" {
  project  = var.project_id
  role     = "roles/cloudfunctions.admin"
  member   = "user:${var.gcp_account_name}"
}
*/