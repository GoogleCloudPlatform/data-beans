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

CREATE OR REPLACE TABLE `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(
    artifact_id INTEGER NOT NULL OPTIONS(description="Primary key."),
    artifact_category STRING NOT NULL OPTIONS(description="The category grouping of the artifact."),
    artifact_name STRING NOT NULL OPTIONS(description="The name of the artifact."),
    artifact_short_description STRING NOT NULL OPTIONS(description="The short description of the artifact."),
    artifact_long_description STRING NOT NULL OPTIONS(description="The long ort name of the artifact."),
    artifact_video_thumbnail_url STRING NOT NULL OPTIONS(description="The url for the video thumbnail."),
    artifact_video_url STRING NOT NULL OPTIONS(description="The url for the video (YouTube)."),
    artifact_url STRING NOT NULL OPTIONS(description="The url for the artifact (GitHub).")
)
CLUSTER BY artifact_id;

------------------------------------------------------------------------------------------------------------

INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    1,
    'Customer-Reviews',
    'Customer-Reviews-Detect-Themes-GenAI',
    'Use a LLM to detect the theme of each customer reviews.',
    """We want to determine the theme of each customer review so we can categorize them.
    <ol>
        <li>Loop through each customer review</li>
        <li>For reviews which do not already have a theme populated</li>
        <li>Generate our LLM prompt</li>
        <li>Execute our LLM prompt using BigFrames</li>
        <li>Update the customer review table with the theme the LLM detected in BigQuery</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );

INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    2,
    'Customer-Reviews',
    'Customer-Reviews-Generate-Customer-Response-GenAI',
    'Use a LLM to generate 5 potential automated responses for each customer review',
    """We want our LLM to read each review and generate an appropriate response to the customer.
    <ol>
        <li>Loop through each customer review</li>
        <li>For reviews which do not already have an automated response populated</li>
        <li>Generate our LLM prompt</li>
        <li>Execute our LLM prompt using BigFrames</li>
        <li>Update the customer review table with the AI generated response in BigQuery</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );

INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    3,
    'Customer-Reviews',
    'Customer-Reviews-Generate-Insight-GenAI',
    'Use a LLM to generate AI insights based upon the themes and sentiment detected in each location customer reviews.',
    """We want our LLM to process our summeraized customer review data from BigQuery and generate reccomendations on how to improve our business.
    <ol>
        <li>Loop through each location</li>
        <li>Gather each customer review theme, the count and the sentiment</li>
        <li>Generate our LLM prompt</li>
        <li>Execute our LLM prompt using BigFrames</li>
        <li>Insert records into the customer_review_gen_ai_insight that will contain the reccomendations per city per location (the location will be JSON).</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );    

INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    4,
    'Customer-Reviews',
    'Customer-Reviews-Generate-Recommended-Action-GenAI',
    'Use GenAI to a reccomended action to take for each customer review',
    """We want our LLM to determine the course of action to take for each customer review along with explaining its reasoning:
    <ol>
        <li>Loop through each customer review</li>
        <li>For reviews which do not already have a AI recommended action populated</li>
        <li>Generate our LLM prompt</li>
        <li>Execute our LLM prompt using BigFrames</li>
        <li>Update the customer review table with the AI recommended action in BigQuery</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );    

INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    5,
    'Customer-Reviews',
    'Customer-Reviews-Synthetic-Data-Generation-GenAI',
    'Use GenAI to generate customer reviews.',
    """We want our LLM to create customer reviews that contain different themes, sentiments and text:
    <ol>
        <li>Generate our LLM prompt with either a negative or postive review with a specific theme</li>
        <li>Execute our LLM prompt using BigFrames</li>
        <li>Create a customer review record</li>
        <li>Generate our LLM prompt to determine the sentiment of the review</li>
        <li>Update the customer review record with the determiend sentiment</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );
    


INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    6,
    'Customer-Reviews',
    'Customer-Reviews-Word-Cloud',
    'Create a word cloud based upon the themes detected in the customer reviews.',
    """Create a visualization for our postive and negative reviews:
    <ol>
        <li>Execute a BigQuery SQL to gather our postive review data</li>
        <li>Execute a BigQuery SQL to gather our negative review data</li>
        <li>Create a postive word cloud image</li>
        <li>Create a negative word cloud image</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );      


INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    7,
    'Events',
    'Event-Generate-Insight-GenAI',
    'Use GenAI to create a plan on where to position the coffee trucks based upon the events that are taking place in the city.',
    """We want our create a specific recommendation for each of our cities based upon the current night events.
    <ol>
        <li>For each city: "New York City", "London", "Tokyo", "San Francisco" read the current days events</li>
        <li>Generate our LLM prompt</li>
        <li>Pass in all the events in JSON</li>
        <li>Pass in knowledge about past event types and the effect on profits</li>
        <li>Ask the LLM to compute the latitude and longitude of the event address</li>
        <li>Ask the LLM read a human readable date time to a machine datetime</li>
        <li>Ask the LLM to rank the events from 1 to {x}</li>
        <li>Ask the LLM to explain its reasoning</li>
        <li>Insert the results into the event_gen_ai_insight table</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );      


INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    8,
    'Events',
    'Event-Populate-Table',
    'Download the current events from Google Events.',
    """We want to call a HTTP endpoint and download and parse the Google Events data:
    <ol>
        <li>For each city: "New York City", "London", "Tokyo", "San Francisco" read the current days events</li>
        <li>Call to Google Events</li>
        <li>Place the results is a list</li>
        <li>Bulk insert the data into BigQuery</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );        



INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    9,
    'Marketing',
    'Marketing-Campaign-Generate-Insight-GenAI',
    'Create a marketing campaign using GenAI.',
    """We want to create a fully automated marketing campaign for each of our 4 cities in their native language can be delivered to our customers via email, text or social media.  We will use our LLM to brainstorm with our LLM and create the most inticing image as possible.
    <ol>
        <li>Determine the items we want to sell from our menu table.</li>
        <li>Create a basic LLM prompt for Imagegen 2 to render the image.</li>
        <li>We want a really good image that inspires our customers to purchase our coffee/food so we will brainstorm with the LLM<br/>
        &nbsp;&nbsp;- Ask Gemini Pro to take our original image prompt and create 10 new creative prompts.<br/>
        &nbsp;&nbsp;- We are using the LLM to write our prompt for us.<br/>
        &nbsp;&nbsp;- We will also add in a prompt that has nothing to do with coffee/food</li>
        <li>We want to verify the image contains the original coffee/food items we requested.<br/>
        &nbsp;&nbsp;- The LLM might have been too creative so let's verify each image.<br/>
        &nbsp;&nbsp;- Pass each image to Gemini Pro Vision and ask it to verify the contents of the image and explain its reasoning.</li>
        <li>For each of the verified images, let's do a taste test.<br/>
        &nbsp;&nbsp;- Pass all the images to Gemini Pro Vision and ask it to rate each image from 1 to 100.<br/>
        &nbsp;&nbsp;- Rate the images based upon how realistic they are and creative.<br/>
        &nbsp;&nbsp;- Have the LLM explain its reasoning</li>
        <li>We now have the highest rated image and we can see it compared to the original image.</li>
        <li>Now, we will generate our marketing campaign.<br/>
        &nbsp;&nbsp;- We will pass our prompt and the image to Gemini Pro Vision and ask it generate a marketing campaign.<br/>
        &nbsp;&nbsp;- We will do this for each City<br/>
        &nbsp;&nbsp;- We will ask the LLM to write the campaign in the native language for each city (English, Japanese)</li>
        <li>With the marketing text we will now need it formatted as HTML<br/>
        &nbsp;&nbsp;- Pass the marketing text to ask Gemini to create HTML<br/>
        &nbsp;&nbsp;- Ask Gemini to style the email<br/>
        &nbsp;&nbsp;- Ask Gemini to leave a placeholder for our image</li>
        <li>With the HMTL now replace the placeholder with our image</li> 
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );      

INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    10,
    'Menu',
    'Menu-A-B-Testing-Generate-Insight-GenAI',
    'Create a set of A/B test for our menu items by using data generation and GenAI to create our schema',
    """We want to use Gemini Pro Vision to create a new table for A/B testing based to increase sales of items that recently are under performing.  
    <ol>
        <li>Create a new table that we can use for A/B testing of low menu sales.</li>
        <li>Pass the ERD to Gemini Pro and generate the SQL commands to create our tables (primary and foreign keys).</li>
        <li>Create sample data for each of our tables.</li>
        <li>Generate images for our menu items.</li>  
        <li>Upload the images to storage for use by the system.</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );         

INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    11,
    'Menu',
    'Menu-Synthetic-Data-Generation-GenAI',
    'See end to end synthetic data generation using LLMs',
    """We want to increase the speed of our development.  We will use LLMs to generate our create table command, primary and foreign keys.  We will then populate the table with sample data and even create sample images.  Data Enginnering can take advantage of LLMs for many common and even complex tasks.
    <ol>
        <li>Create an ERD</li>
        <li>Pass the ERD to Gemini Pro and generate the SQL commands to create our tables (primary and foreign keys).</li>
        <li>Create sample data for each of our tables.</li>
        <li>Generate images for our menu items.</li>  
        <li>Upload the images to storage for use by the system.</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );         


INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    12,
    'Menu',
    'Menu-Synthetic-Data-Generation-GenAI',
    'Need to jump start a new system with tables and data?',
    """Use LLMs for code generation.  You can start with a table schema or even a picture of your ERD (see Menu-Synthetic-Data-Generation-GenAI).  This is the original notebook that jumpstarted this demo so we can quickly get started and refine our application.
    <ol>
        <li>Create your table DDLs</li>
        <li>Create LLM prompts for each table and ask it to populate the table with data</li>
        <li>Provide the prompts with starting primary keys</li>
        <li>Provide the prompts with foreign keys</li>  
        <li>The LLM makes can understand that it should generate 3 records for menu items (small, med, large) with pricing set accordingly.</li>  
        <li>The LLM can read the description of each field and use that to generate valid values</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );   



INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    13,
    'Weather',
    'Weather-Generate-Insight-GenAI',
    'Based upon the weather forecast ask our LLM where best to position the trucks in each city.',
    """We can move our trucks in each city based upon the daily (hourly) weather forecast.
    <ol>
        <li>For each city: "New York City", "London", "Tokyo", "San Francisco" read the hourly forecast</li>
        <li>Generate our LLM prompt</li>
        <li>Pass in all the weather in JSON</li>
        <li>Ask the LLM to create 5 waypoints based upon the weather</li>
        <li>Ask the LLM to label each of our trucks with a truck number</li>
        <li>Ask the LLM to tell us the time and address of where move each truck</li>
        <li>Ask the LLM to compute the latitude and longitude of each address</li>
        <li>Ask the LLM to explain its reasoning</li>
        <li>Insert the results into the weather_gen_ai_insight table</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );      



INSERT INTO `data-beans-demo-oy9rk9hxus.data_beans_synthetic_data.artifact`
(artifact_id, artifact_category, artifact_name, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_url)
VALUES (
    14,
    'Weather',
    'Weather-Populate-Table',
    'Download the current weather from a REST API call.',
    """We want to call a HTTP endpoint and download and parse the hourly weather data data:
    <ol>
        <li>For each city: "New York City", "London", "Tokyo", "San Francisco" read the current days events</li>
        <li>Call to Weather service</li>
        <li>Place the results is a list</li>
        <li>Bulk insert the data into BigQuery</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/data-beans-logo.png',
    'https://youtu.be/5ZStKD4joK4',
    'https://github.com/GoogleCloudPlatform/data-analytics-golden-demo/blob/main/colab-enterprise/rideshare-llm/rideshare_llm_ai_lakehouse_demo.ipynb'
    );        

