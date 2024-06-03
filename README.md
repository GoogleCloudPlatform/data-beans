# Data-Beans-Demo

Welcome to Data Beans, a fiticous company that has a fleet of coffee trucks located in cities around the world.  The source code provided here is design to high how you can use GenAI along with BigQuery on Google Cloud.  The code is all working and was used to construct the demo.  The demo consists of a web frontend along with the backend code contained in the project.  To see the frontend, currently is it not deployed as part of the demo, please contact your account team or customer engienner.

This demo is an end to end working demo with all code provided so you can use based upon the contained license agreement.


## Demo Cost
- The demo costs ~ $1 a day to leave idle.
   - You can delete the Colab Runtime if you want to leave idle to mimimize costs.  Just create the runtime when you run the demo.
   - You Colab Enterprise machine storage cost can grow.  If your Colab costs become elevated, delete the Runtime (https://console.cloud.google.com/vertex-ai/colab/runtimes) and re-create it based upon the Runtime Template.
- Running the notebooks that perform the GenAI API calls (or BigQuery) cost ~ $1 or so.  It depends how much you run them.  Running them for a few rows of data is mimimal cost; running for thousands will cost more.
- Running the notebooks that perform the Machine Learning training (where you attach a GPU) cost the machine cost and time run.


## Data Generation
- All data in this demo is synthetically generated by LLMs.  
- All images in this demo are generated by GenAI.


## Usage Notes
- The notebooks use the **Latest** version of the **Gemini** models. This means that some of the generated output might break the notebooks. As the GenAI models are updated (new releases on Google Cloud) you might need to adjust the prompt and/or temperature. For production purposes you would tie your LLM code to a specific version to avoid this issue.
- Make sure you connect to the "colab-enterprise-runtime". Press the down arrow on the connect box:  Connect ▼
- Some SQL statements might fail to generate (contain special characters or other items). This can cause a loop. If this occurs try adjusting the temperature down or filtering out the special characters in the following method:
   ```
   def LLM method:
   E.g. result = result.replace("```sql","")
   ```
- If you get an error message that “query must contain at least one batch” that means you tried to select rows, but nothing was returned. Maybe you ran the notebooks out of order.
- A dataset named “data_beans_synthetic_data” will be created. The purpose of this is to keep the newly generated data away from the data_beans_curated dataset in order not to break certain things. Think of data_beans_synthetic_data as a temporary work area.
- Once the Data Beans deploys, the Colab notebooks will take several more minutes. If you do not see them immediately, press refresh in a minute or two.

## How to Run the Notebooks
Some notebooks require that you run a specific notebook first. These notebooks are grouped together or indicated below.

1. **Marketing-Campaign-Generate-Insight-GenAI** - runs the marketing campaign. 
2. **Weather** 
a. First, run the **Weather-Populate-Table** notebook to download the weather data.
b. Second, run the **Weather-Generate-Insight-GenAI** notebook to generate insights with GenAI.
3. **Events** 
   - First, optionally, run the **Run Event-Populate-Table** to download recent event data.
      - **NOTE:** You need a 3rd party API key from https://serpapi.com/.
   - Second, run **Event-Generate-Insight-GenAI** to generate insights with GenAI. This will use the latest set of events in the table (in case you did not download).
4. **Menu A-B Testing** 
   - First, run the **Menu-A-B-Testing-Generate-Insight-GenAI** notebook to generate the new menu items.
   - Second, run the **Menu-A-B-Testing-Generate-Campaign-GenAI** notebook to generate the marketing campaign.
5. **Menu-Synthetic-Data-Generation-GenAI** - generates some synthetic data for menu items. This shows how we generated the menu items for Data Beans.
6. **Customer Reviews (Generate and Score Reviews)**
   - First, run the **Customer-Reviews-Synthetic-Data-Generation-GenAI** notebook to generate the new customer reviews.
   - Second, run the **Customer-Reviews-Detect-Themes-GenAI** notebook to detect the themes of the newly created customer reviews.
   - Third, run the **Customer-Reviews-Generate-Customer-Response-GenAI** notebook to generate 5 responses for the newly created customer reviews.
   - Fourth, run the **Customer-Reviews-Generate-Recommended-Action-GenAI** notebook to generate the recommended action (e.g. Apologize to the customer) for newly created customer reviews.
   - Fifth, run the **Image-Generation-Pipeline-GenAI** notebook to generate the images associated with the customer reviews.
      - **You will need to comment out these lines after the first run; otherwise, they will keep restarting the notebook. You can also skip running the PIP installs.**
         ```
         # ! pip install google-cloud-vision
         # ! pip3 install --upgrade --user google-cloud-aiplatform
         #app = IPython.Application.instance()
         #app.kernel.do_shutdown(True)
         ```
   - Sixth, run the **Audio-Generation-Pipeline** notebook to generate the audio files associated with the customer reviews.
      - **You will need to comment out these lines after the first run; otherwise, they will keep restarting the notebook. You can also skip running the PIP installs.**
         ```
         # ! pip install google-cloud-texttospeech
         #! pip3 install --upgrade --user google-cloud-aiplatform
         #app = IPython.Application.instance()
         #app.kernel.do_shutdown(True)
         ```
7. **Customer-Reviews-Generate-Insight-GenAI** - generates insights across all customers on ways Data Beans can improve its business.
8. **Customer-Reviews-Word-Cloud** - creates a word cloud, basically a report of the themes detected in the customer reviews.
9. **Common-Themes-RAG** - This will do a RAG pattern using Vector embeddings
10. **Sample-Synthetic-Data-Generation-GenAI** - This is a sample and shows data generation.
11. **Video-Generation-GenAI** - requires GPUs. Need to test with a GPU runtime.

## How to deploy
The are two options to deploy the demo depending on your access privilages to your cloud organization

### Require Permissions to Deploy (2 Options)
1. Elevated Privileges - Org Level
   - **The following IAM roles are required to deploy the solution**
      - Prerequisite:  Billing Account User (to create the project with billing)
   - To deploy the code you will:
      - Run ```source deploy.sh```

2. Owner Project Privileges - Typically Requires Assistance from IT
   - **The following items are required to deploy the solution**
      - Prerequisite: You will need a project created for you (IT can do this for you)
      - Prerequisite: You will need to be an Owner (IAM role) of the project to run the below script
   - To deploy the code you will
      - Update the hard coded values in ```deploy-use-existing-project-non-org-admin.sh```
      - Run ```source deploy-use-existing-project-non-org-admin.sh```



### Using your Local machine (Assuming Linux based)
1. Install Git (might already be installed)
2. Install Curl (might already be installed)
3. Install "jq" (might already be installed) - https://jqlang.github.io/jq/download/
4. Install Google Cloud CLI (gcloud) - https://cloud.google.com/sdk/docs/install
5. Install Terraform - https://developer.hashicorp.com/terraform/install
6. Login:
   ```
   gcloud auth login
   gcloud auth application-default login
   ```
7. Type: ```git clone https://github.com/GoogleCloudPlatform/data-beans```
8. Switch the prompt to the directory: ```cd data-beans```
9. Run the deployment script
   - If using Elevated Privileges
      - Run ```source deploy.sh```
   - If using Owner Project Privileges
      - Update the hard coded values in ```deploy-use-existing-project-non-org-admin.sh```
      - Run ```source deploy-use-existing-project-non-org-admin.sh```
10. Authorize the login (a popup will appear)
11. Follow the prompts: Answer “Yes” for the Terraform approval.


### To deploy through a Google Cloud Compute VM
1. Create a new Compute VM with a Public IP address or Internet access on a Private IP
   - The default VM is fine (e.g.)
      - EC2 machine is fine for size
      - OS: Debian GNU/Linux 12 (bookworm)
2. SSH into the machine.  You might need to create a firewall rule (it will prompt you with the rule if it times out)   
3. Run these commands on the machine one by one:
   ```
   sudo apt update
   sudo apt upgrade -y
   sudo apt install git
   git config --global user.name "FirstName LastName"
   git config --global user.email "your@email-address.com"
   git clone https://github.com/GoogleCloudPlatform/data-beans
   cd data-beans/
   sudo apt-get install apt-transport-https ca-certificates gnupg curl
   sudo apt-get install jq
   gcloud auth login
   gcloud auth application-default login
   sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
   wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
   gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
   https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   sudo apt update
   sudo apt-get install terraform

   source deploy.sh 
   # Or 
   # Update the hard coded values in deploy-use-existing-project-non-org-admin.sh
   # Run source deploy-use-existing-project-non-org-admin.sh
   ```

### Cloud Shell (NOT WORKING) 
1. Open a Google Cloud Shell: http://shell.cloud.google.com/
2. Type: ```git clone https://github.com/GoogleCloudPlatform/data-beans```
3. Switch the prompt to the directory: ```cd data-beans```
4. Run the deployment script
   - If using Elevated Privileges
      - Run ```source deploy.sh```
   - If using Owner Project Privileges
      - Update the hard coded values in ```deploy-use-existing-project-non-org-admin.sh```
      - Run ```source deploy-use-existing-project-non-org-admin.sh```
5. Authorize the login (a popup will appear)
6. Follow the prompts: Answer “Yes” for the Terraform approval