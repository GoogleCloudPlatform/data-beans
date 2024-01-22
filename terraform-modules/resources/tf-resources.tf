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
# Bucket for all data (BigQuery, Spark, etc...)
# This is your "Data Lake" bucket
# If you are using Dataplex you should create a bucket per data lake zone (bronze, silver, gold, etc.)
####################################################################################
resource "google_storage_bucket" "google_storage_bucket_data_beans_curated_bucket" {
  project                     = var.project_id
  name                        = var.data_beans_curated_bucket
  location                    = var.multi_region
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "google_storage_bucket_data_beans_code_bucket" {
  project                     = var.project_id
  name                        = var.data_beans_code_bucket
  location                    = var.multi_region
  force_destroy               = true
  uniform_bucket_level_access = true
}

####################################################################################
# Default Network
# The project was not created with the default network.  
# This creates just the network/subnets we need.
####################################################################################
resource "google_compute_network" "default_network" {
  project                 = var.project_id
  name                    = "vpc-main"
  description             = "Default network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "colab_enterprise_subnet" {
  project                  = var.project_id
  name                     = "colab-enterprise-subnet"
  ip_cidr_range            = "10.1.0.0/16"
  region                   = var.colab_enterprise_region
  network                  = google_compute_network.default_network.id
  private_ip_google_access = true

  depends_on = [
    google_compute_network.default_network
  ]
}

# Firewall for NAT Router
resource "google_compute_firewall" "subnet_firewall_rule" {
  project = var.project_id
  name    = "subnet-nat-firewall"
  network = google_compute_network.default_network.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }
  source_ranges = ["10.1.0.0/16"]

  depends_on = [
    google_compute_subnetwork.colab_enterprise_subnet
  ]
}

# We want a NAT for every region
locals {
  distinctRegions = distinct([var.colab_enterprise_region])
}

resource "google_compute_router" "nat-router-distinct-regions" {
  count   = length(local.distinctRegions)
  name    = "nat-router-${local.distinctRegions[count.index]}"
  region  = local.distinctRegions[count.index]
  network = google_compute_network.default_network.id

  depends_on = [
    google_compute_firewall.subnet_firewall_rule
  ]
}

resource "google_compute_router_nat" "nat-config-distinct-regions" {
  count                              = length(local.distinctRegions)
  name                               = "nat-config-${local.distinctRegions[count.index]}"
  router                             = google_compute_router.nat-router-distinct-regions[count.index].name
  region                             = local.distinctRegions[count.index]
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  depends_on = [
    google_compute_router.nat-router-distinct-regions
  ]
}

####################################################################################
# BigQuery Datasets
####################################################################################
resource "google_bigquery_dataset" "google_bigquery_dataset_data_beans_curated" {
  project       = var.project_id
  dataset_id    = var.bigquery_data_beans_curated_dataset
  friendly_name = var.bigquery_data_beans_curated_dataset
  description   = "This dataset contains the curated data for the data beans demo."
  location      = var.multi_region
}


####################################################################################
# Dataplex / Data Lineage
####################################################################################
resource "google_project_iam_member" "gcp_roles_datalineage_admin" {
  project = var.project_id
  role    = "roles/datalineage.admin"
  member  = "user:${var.gcp_account_name}"
}

####################################################################################
# Bring in Analytics Hub reference
####################################################################################
# To get the URL go to the project hosting the Analtics Hub and view the display listing
# You can copy the URL and get the fields needed (project number, location, exchange name and listing name)
resource "null_resource" "analyticshub_data_beans" {
  provisioner "local-exec" {
    when    = create
    command = <<EOF
  curl --request POST \
    "https://analyticshub.googleapis.com/v1/projects/312090430116/locations/us/dataExchanges/data_analytics_coffee_data_18b8c1d962e/listings/data_beans_18b8c24cd6f:subscribe" \
    --header "Authorization: Bearer $(gcloud auth print-access-token ${var.curl_impersonation})" \
    --header "Accept: application/json" \
    --header "Content-Type: application/json" \
    --data '{"destinationDataset":{"datasetReference":{"datasetId":"${var.data_beans_analytics_hub}","projectId":"${var.project_id}"},"friendlyName":"Data Beans","location":"us","description":"Data Beans demo"}}' \
    --compressed
    EOF
  }
  depends_on = [
  ]
}


####################################################################################
# BigQuery - Connections (BigLake, Functions, etc)
####################################################################################
# Vertex AI connection
resource "google_bigquery_connection" "vertex_ai_connection" {
  connection_id = "vertex-ai"
  location      = var.multi_region
  friendly_name = "vertex-ai"
  description   = "vertex-ai"
  cloud_resource {}
}


# Allow Vertex AI connection to Vertex User
resource "google_project_iam_member" "vertex_ai_connection_vertex_user_role" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_bigquery_connection.vertex_ai_connection.cloud_resource[0].service_account_id}"

  depends_on = [
    google_bigquery_connection.vertex_ai_connection
  ]
}


####################################################################################
# Colab Enterprise
####################################################################################
# Subnet for colab enterprise
resource "google_compute_subnetwork" "colab_subnet" {
  project                  = var.project_id
  name                     = "colab-subnet"
  ip_cidr_range            = "10.8.0.0/16"
  region                   = var.colab_enterprise_region
  network                  = google_compute_network.default_network.id
  private_ip_google_access = true

  depends_on = [
    google_compute_network.default_network,
  ]
}

# https://cloud.google.com/vertex-ai/docs/reference/rest/v1beta1/projects.locations.notebookRuntimeTemplates
# NOTE: If you want a "when = destroy" example TF please see: 
#       https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/cloud-composer/data/terraform/dataplex/terraform.tf#L147
resource "null_resource" "colab_runtime_template" {
  provisioner "local-exec" {
    when    = create
    command = <<EOF
  curl -X POST \
  https://${var.colab_enterprise_region}-aiplatform.googleapis.com/ui/projects/${var.project_id}/locations/${var.colab_enterprise_region}/notebookRuntimeTemplates?notebookRuntimeTemplateId=colab-enterprise-template \
  --header "Authorization: Bearer $(gcloud auth print-access-token ${var.curl_impersonation})" \
  --header "Content-Type: application/json" \
  --data '{
        displayName: "colab-enterprise-template", 
        description: "colab-enterprise-template",
        isDefault: true,
        machineSpec: {
          machineType: "e2-highmem-4"
        },
        dataPersistentDiskSpec: {
          diskType: "pd-standard",
          diskSizeGb: 500,
        },
        networkSpec: {
          enableInternetAccess: false,
          network: "projects/${var.project_id}/global/networks/vpc-main", 
          subnetwork: "projects/${var.project_id}/regions/${var.colab_enterprise_region}/subnetworks/colab-subnet"
        }
  }'
EOF
  }
  depends_on = [
    google_compute_subnetwork.colab_subnet
  ]
}

# https://cloud.google.com/vertex-ai/docs/reference/rest/v1beta1/projects.locations.notebookRuntimes
resource "null_resource" "colab_runtime" {
  provisioner "local-exec" {
    when    = create
    command = <<EOF
  curl -X POST \
  https://${var.colab_enterprise_region}-aiplatform.googleapis.com/ui/projects/${var.project_id}/locations/${var.colab_enterprise_region}/notebookRuntimes:assign \
  --header "Authorization: Bearer $(gcloud auth print-access-token ${var.curl_impersonation})" \
  --header "Content-Type: application/json" \
  --data '{
      notebookRuntimeTemplate: "projects/${var.project_number}/locations/${var.colab_enterprise_region}/notebookRuntimeTemplates/colab-enterprise-template",
      notebookRuntime: {
        displayName: "colab-enterprise-runtime", 
        description: "colab-enterprise-runtime",
        runtimeUser: "${var.gcp_account_name}"
      }
}'  
EOF
  }
  depends_on = [
    google_compute_subnetwork.colab_subnet,
    null_resource.colab_runtime_template
  ]
}



####################################################################################
# Outputs
####################################################################################
