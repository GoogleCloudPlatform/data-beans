# Data Beans

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
