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

CREATE OR REPLACE TABLE `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(
    artifact_id INTEGER NOT NULL OPTIONS(description="Primary key."),
    artifact_category STRING NOT NULL OPTIONS(description="The category grouping of the artifact."),
    artifact_name STRING NOT NULL OPTIONS(description="The name of the artifact."),
    artifact_order INT64 NOT NULL OPTIONS(description="The order in which to display the artifact."),
    artifact_short_description STRING NOT NULL OPTIONS(description="The short description of the artifact."),
    artifact_long_description STRING NOT NULL OPTIONS(description="The long ort name of the artifact."),
    artifact_video_thumbnail_url STRING NOT NULL OPTIONS(description="The url for the video thumbnail."),
    artifact_video_url STRING NOT NULL OPTIONS(description="The url for the video)."),
    artifact_youtube_url STRING NOT NULL OPTIONS(description="The url for the YouTube video."),
    artifact_url STRING NOT NULL OPTIONS(description="The url for the artifact (GitHub)."),
    artifact_gslides_url STRING NOT NULL OPTIONS(description="The url for the artifact (Google Slides).")
)
CLUSTER BY artifact_id;

------------------------------------------------------------------------------------------------------------

INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    1,
    'Customer-Reviews',
    'GenAI Customer Review Theme Detection',
    8,
    'Master Your Customer Experience with AI-Driven Feedback Analysis',
    """This notebook uses GenAI to analyze customer feedback, revealing overarching themes. These insights are summarized by location within the web application, enabling data-driven decision-making.
    <ol>
        <li>AI at Scale: Unleash GenAI on BigQuery Data</li>
        <li>Seamless Data Flow: BigFrames meets Colab Enterprise</li>
        <li>Customer Feedback Whisperer: LLMs Find Hidden Themes</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Customer-Reviews-Detect-Themes-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Customer-Reviews-Detect-Themes-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vQQS7VAZBDXy3_68cf7GbOm8ZjTwlpr7Z65GbRfyxk89g43XL0s3ZBHUbe9ChqaDT_3pVw8qZpH0HkU/embed'
    );

INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    2,
    'Customer-Reviews',
    'GenAI Customer Automated Responses',
    9,
    'Personalize Customer Interactions with GenAI-Crafted Responses',
    """This notebook employs GenAI to generate 5 potential automated responses to customer reviews, facilitating direct replies through the web application. The notebook gathers reviews, crafts LLM prompts with specific instructions, and uses BigFrames to execute the prompts. Finally, it parses the LLM-generated JSON, constructs an SQL statement, and updates the customer review table in BigQuery.
    <ol>
        <li>GenAI + BigQuery: The Data-Driven Decision Making Duo</li>
        <li>Let GenAI Handle the Reviews: Automated Responses with a Personal Touch</li>
        <li>Big Data, Meet Big Brains: GenAI + BigFrames in Action</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Customer-Reviews-Generate-Customer-Response-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Customer-Response-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vQQS7VAZBDXy3_68cf7GbOm8ZjTwlpr7Z65GbRfyxk89g43XL0s3ZBHUbe9ChqaDT_3pVw8qZpH0HkU/embed'
    );

INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    3,
    'Customer-Reviews',
    'GenAI Customer Business Insights',
    10,
    'Unlock Customer Insights for Growth: GenAI Analyzes Reviews',
    """This notebook leverages GenAI to analyze customer reviews, extracting actionable insights and innovative ideas for business improvement. By aggregating sentiment and themes from the past 7 days with BigQuery, the notebook constructs LLM prompts that invite GenAI to act as a consultant, generating insights, unconventional solutions, and explanations of its reasoning. The results are then stored and displayed for analysis.
    <ol>
        <li>LLMs Summarize Customer Feedback</li>
        <li>LLMs Mine Customer Reviews for Ideas</li>
        <li>BigFrames Analyzes Reviews</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Customer-Reviews-Generate-Insight-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Insight-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vQQS7VAZBDXy3_68cf7GbOm8ZjTwlpr7Z65GbRfyxk89g43XL0s3ZBHUbe9ChqaDT_3pVw8qZpH0HkU/embed'
    );    

INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    4,
    'Customer-Reviews',
    'GenAI Customer Recommended Actions',
    11,
    'Let GenAI Guide Your Customer Interactions: Review Action Suggestions',
    """This notebook utilizes GenAI to streamline decision-making for customer reviews, suggesting appropriate actions based on the review content. It gathers reviews, crafts LLM prompts that outline potential actions, and extracts the LLM's recommendation. Finally, the notebook updates the customer review table in BigQuery for efficient tracking.
    <ol>
        <li>GenAI Decides: AI-Powered Action Recommendations</li>
        <li>Multiple Options, Better Outcomes: GenAI's Top 5 Actions</li>
        <li>Gain Confidence with Clarity: GenAI Justifies Its Suggestions</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Customer-Reviews-Generate-Recommended-Action-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Customer-Reviews-Generate-Recommended-Action-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vQQS7VAZBDXy3_68cf7GbOm8ZjTwlpr7Z65GbRfyxk89g43XL0s3ZBHUbe9ChqaDT_3pVw8qZpH0HkU/embed'
    );    

INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    5,
    'Customer-Reviews',
    'GenAI Customer Reviews Synthetic Data',
    12,
    'Synthetic Data Gets Smart: GenAI Creates and Analyzes Reviews',
    """This notebook leverages GenAI to generate realistic customer reviews, demonstrating the value of synthetic data for testing and analysis. GenAI's understanding of data schemas and foreign keys enables the creation of contextually accurate reviews.  The notebook then uses GenAI to determine the sentiment of these generated reviews, highlighting its ability to analyze both real and synthetic feedback.
    <ol>
        <li>Craft the Perfect Fake: Building LLM Prompts for Synthetic Reviews</li>
        <li>Beyond Random Text: LLMs Create Reviews with Purpose</li>
        <li>LLMs as Review Critics: Scoring Sentiment with AI</li>
        <li>Generate our LLM prompt to determine the sentiment of the review</li>
        <li>Update the customer review record with the determiend sentiment</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Customer-Reviews-Synthetic-Data-Generation-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Customer-Reviews-Synthetic-Data-Generation-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vQQS7VAZBDXy3_68cf7GbOm8ZjTwlpr7Z65GbRfyxk89g43XL0s3ZBHUbe9ChqaDT_3pVw8qZpH0HkU/embed'
    );
    


INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    6,
    'Customer-Reviews',
    'Customer Sentiment Word Cloud',
    13,
    'Visualize Customer Sentiment: Word Clouds Reveal Key Themes',
    """This process extracts previously detected themes from customer reviews to generate a visual word cloud. To further analyze sentiment, BigQuery queries gather positive and negative review data, which is then used to create separate word clouds highlighting the most prominent terms in each category.
    <ol>
        <li>Positive Word Cloud Generation</li>
        <li>Generating a Negative Word Cloud</li>
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Customer-Reviews-Word-Cloud.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Customer-Reviews-Word-Cloud.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vS6XfWwpeepjDhF3xSKtI_P3mNd5LE1aDoHxsfsZLs5fuCEfYw6YxrSoqBHESIgqHmQ12nef5fvWHIR/embed'
    );      


INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    7,
    'Events',
    'GenAI Event Planning',
    4,
    'Maximize Coffee Truck Profits with GenAI: Event-Driven Location Planning',
    """This notebook employs GenAI to identify optimal coffee truck locations based on city events. It analyzes event data from BigQuery, instructs GenAI to rank events by potential sales impact, and incorporates location data. The results, along with GenAI's reasoning, are stored for analysis and decision-making.
    <ol>
        <li>Tailored Prompts for Targeted Insights: City-Specific LLM Requests</li>
        <li>Injecting Real-Time Event Data into LLM Prompts</li>
        <li>Event Data Enrichment</li>
        <li>LLMs Process Human-Friendly Dates</li>
        <li>Ranking Events for Maximum Impact</li>
        <li>LLMs Justify Their Choices</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Event-Generate-Insight-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Event-Generate-Insight-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vSWHhR-JCN1R3YyF9MLPCkxCteQ-pwj4l_sXoD03KFk1Cok8vRcVYRHwTsQ1J3nyBQcBl_1wKVYHNSo/embed'
    );      


INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    8,
    'Events',
    'Download Events',
    5,
    'Sync Your Data: Importing Google Event Listings',
    """We want to call a HTTP endpoint and download and parse the Google Events data:
    <ol>
        <li>For each city: "New York City", "London", "Tokyo", "San Francisco" read the current days events</li>
        <li>Call to Google Events</li>
        <li>Place the results is a list</li>
        <li>Bulk insert the data into BigQuery</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Event-Populate-Table.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Event-Populate-Table.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vSWHhR-JCN1R3YyF9MLPCkxCteQ-pwj4l_sXoD03KFk1Cok8vRcVYRHwTsQ1J3nyBQcBl_1wKVYHNSo/embed'
    );        


INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    9,
    'Marketing',
    'GenAI End to End Marketing Campaign',
    1,
    'GenAI: Your Secret Weapon for Winning Marketing Campaigns',
    """This process leverages GenAI to create visually appealing, localized marketing campaigns for selected menu items. First, it uses GenAI to brainstorm and generate high-quality images of the chosen items, ensuring the images accurately reflect the original food. Next, GenAI crafts tailored marketing text for each city in their native language. Finally, the text is integrated into styled HTML email templates, and the entire campaign is stored in BigQuery for analysis and tracking.
    <ol>
        <li>Imagen 2: Picture-Perfect Marketing in a Flash</li>
        <li>Gemini Pro Vision: Your AI Art Director for Maximum Impact</li>
        <li>Break Language Barriers with Gemini Pro's Multilingual Campaigns</li>
        <li>The Secret to LLM Mastery: Let LLMs Write Their Own Prompts</li>
    </ol>
    See the images here: <a href="https://console.cloud.google.com/storage/browser/data-analytics-golden-demo/data-beans/v1/marketing-campaign" target="_blank">Link</a>
    """,
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Marketing-Campaign-Generate-Insight-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Marketing-Campaign-Generate-Insight-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vS7ZGxvsniOZb4NF4fLliF8xB5oYXAmk3vlmb7v5EId6aOw6OgNs23NSdt_68nv9wLzWFo57Xy5lOcz/embed'
    );      


INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    10,
    'Menu',
    'GenAI Menu A-B Testing',
    3,
    'Data-Powered Menu Revamp: A/B Testing with GenAI',
    """This notebook facilitates A/B testing for menu items, improving sales performance. First, it uses GenAI to analyze an ERD (image) and generates a new menu table in BigQuery. Next, it identifies underperforming menu items based on sales data.  GenAI then creates new menu descriptions and uses ImageGen 2 to generate fresh, corresponding images, facilitating testing of different options to potentially boost sales.
    <ol>
        <li>Database Magic: Gemini Pro Visualizes Your Data Structure</li>  
        <li>Data on Demand: Gemini Pro Fills Your Tables with Realistic Data</li>  
        <li>Make Your Menu Crave-Worthy: Imagen 2 Visualizes Deliciousness</li>  
        <li>The Art of the Prompt: Gemini Pro as Your Image Consultant</li>  
    </ol>
    See the images here: <a href="https://console.cloud.google.com/storage/browser/data-analytics-golden-demo/data-beans/v1/menu-images-a-b-testing" target="_blank">Link</a>
    """,
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Menu-A-B-Testing-Generate-Insight-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Menu-Synthetic-Data-Generation-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vRbqlPV3jxPS37-BOFWqz_CG19g6p4_SZMA7xO2SViPN-nNQH5DUiWAc-eE3BbF6RkdZjnGLU6ZjzAb/embed'
    );         

INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    11,
    'Menu',
    'GenAI Menu Synthetic Data',
    2,
    'Build Your Dream Menu with AI: Synthetic Data Generation Made Easy',
    """This notebook showcases how LLMs can streamline a data engineer's workflow.  It demonstrates how LLMs can analyze an ERD (image) to generate table creation code (DDL), create unique product names and descriptions, and even craft prompts for realistic product image generation. This process highlights the potential for LLMs to save time and effort in database development and data generation tasks.
    <ol>
        <li>Database Schema Modeling</li>
        <li>Gemini Pro: From Diagram to Database Structure</li>
        <li>Synthetic Data Population for Testing</li>
        <li>Imagen2 for Visual Menu Creation</li> 
    </ol>
    See the images here: <a href="https://console.cloud.google.com/storage/browser/data-analytics-golden-demo/data-beans/v1/menu-images" target="_blank">Link</a>     
    """,
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Menu-Synthetic-Data-Generation-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Menu-Teaser.mp4',
    'https://youtu.be/YIzhbGZMoLA',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Menu-Synthetic-Data-Generation-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vQjZPqarJhhHnmo4z3sIPyBO0IYwNHR3jN0NrBAGTVvj60E6bHT_1F-0lAdiN0GUJ1YtraNK8hnN6rn/embed'
    );         


INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    12,
    'Weather',
    'GenAI Weather Insights',
    6,
    'Maximize Profits, Rain or Shine: GenAIs Weather-Smart Location Planning',
    """This notebook leverages GenAI to optimize food truck locations based on real-time weather conditions. It gathers hourly weather forecasts from BigQuery and constructs LLM prompts that request strategic waypoints for each truck. GenAI analyzes the weather data, calculates optimal locations with latitude/longitude coordinates, and provides explanations for its decisions. This process helps businesses maximize sales by adapting to changing weather patterns.
    <ol>
        <li>Hourly Weather Data Acquisition: Retrieve hourly forecasts for specified cities.</li>
        <li>LLM Prompt Construction: Generate LLM prompts incorporating weather data.</li>
        <li>Weather Data Injection: Pass JSON-formatted weather data into LLM prompt.</li>
        <li>Waypoint Generation & Planning: Request LLM to create 5 waypoints based on weather patterns.</li>
        <li>Truck Identification: Instruct LLM to assign unique truck numbers for labeling.</li>
        <li>Location and Time Specification: Request LLM to provide address and optimal move time per truck.</li>
        <li>Geocoding: Obtain latitude and longitude coordinates for each generated address.</li>
        <li>Reasoning Capture: Request LLM to provide explanations for its waypoint decisions.</li>
        <li>Data Storage: Insert results and reasoning into the weather_gen_ai_insight table.</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Weather-Generate-Insight-GenAI.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Weather-Generate-Insight-GenAI.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vR5654qtQHaSutKyFb6rfIk4XybZDRXhsZGRIAfl7A0TK17Yrn_ENv_RHb9z0JC69F2PsEY3siEaIJ8/embed'
    );      



INSERT INTO `data-beans-demo-7txet5l0i5.data_beans_curated.artifact`
(artifact_id, artifact_category, artifact_name, artifact_order, artifact_short_description, artifact_long_description, 
artifact_video_thumbnail_url, artifact_video_url, artifact_youtube_url, artifact_url, artifact_gslides_url)
VALUES (
    13,
    'Weather',
    'Download Weather',
    7,
    'Stay Ahead of the Forecast: Live Weather Data with REST APIs',
    """Perform an HTTP call for hourly weather data, then parse the response.
    <ol>
        <li>Iterative City-Based Event Data Retrieval</li>
        <li>External API Invocation for Weather Data</li>
        <li>Weather Response Data Aggregation</li>
        <li>Batch Loading for Optimized Data Storage</li>  
    </ol>""",
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/artifacts/Weather-Populate-Table.png',
    'https://storage.googleapis.com/data-analytics-golden-demo/data-beans/v1/youtube-videos/Data-Beans-Marketing-Teaser.mp4',
    'https://youtu.be/hb-hfK4k204',
    'https://github.com/GoogleCloudPlatform/data-beans/blob/main/colab-enterprise/gen-ai-demo/Weather-Populate-Table.ipynb',
    'https://docs.google.com/presentation/d/e/2PACX-1vR5654qtQHaSutKyFb6rfIk4XybZDRXhsZGRIAfl7A0TK17Yrn_ENv_RHb9z0JC69F2PsEY3siEaIJ8/embed'
    );        

