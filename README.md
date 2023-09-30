# [SQL] Explore-Adventureworks2019-Dataset
Utilized SQL in Google BigQuery to write and execute queries to find the desired data
## I. Introduction
This project contains an Adventureworks2019 dataset that I will explore using SQL on [Google BigQuery](https://cloud.google.com/bigquery). 
## II. Requirements
* [Google Cloud Platform account](https://cloud.google.com)
* Project on Google Cloud Platform
* [Google BigQuery API](https://cloud.google.com/bigquery/docs/enable-transfer-service#:~:text=Enable%20the%20BigQuery%20Data%20Transfer%20Service,-Before%20you%20can&text=Open%20the%20BigQuery%20Data%20Transfer,Click%20the%20ENABLE%20button.) enabled
* [SQL query editor](https://cloud.google.com/monitoring/mql/query-editor) or IDE
## III. Dataset Access
The eCommerce dataset is stored in a public Google BigQuery dataset. To access the dataset, follow these steps:
* Log in to your Google Cloud Platform account and create a new project.
* Navigate to the BigQuery console and select your newly created project.
* In the navigation panel, select "Add Data" and then "Star a project by name".
* Enter the project name **"adventureworks2019"** and click "Enter".
## IV. Exploring the Dataset
In this project, I will write 08 queries in Bigquery based on some of my project requirements. 
### Query 01: Calc Quantity of items, Sales value & Order quantity by each Subcategory in L12M
* SQL code

<img width="480" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/c1da7d78-d8d6-47ae-9411-c9404e10f8f7">

* Query results

<img width="626" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/22d873ae-0a35-4119-9910-bfa2f7d83ac8">

### Query 02: Calc % YoY growth rate by SubCategory & release top 3 cat with highest grow rate. Can use metric: quantity_item. Round results to 2 decimal
* SQL code

<img width="410" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/f81a32bf-0451-47e9-a86e-2d89a82aed1a">

* Query results

<img width="359" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/72e5b336-fa5e-4d47-bfd4-854fb0f8a2e2">

### Query 03: Ranking Top 3 TeritoryID with biggest Order quantity of every year. If there's TerritoryID with same quantity in a year, do not skip the rank number
* SQL code

<img width="299" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/64013312-7e84-4510-9854-d1fb1a8e2804">

* Query results

<img width="356" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/0c18c763-e126-4096-a3dd-4a2e43adf1f1">

### Query 04: Calc Total Discount Cost belongs to Seasonal Discount for each SubCategory
* SQL code

<img width="281" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/711cd282-3846-4048-92e8-a5119466aa7c">

* Query results

<img width="325" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/8fe3c91f-cf4c-4a52-8d23-325f21564aa9">

### Query 05: Retention rate of Customer in 2014 with status of Successfully Shipped (Cohort Analysis)
* SQL code

<img width="282" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/b7e4e459-b098-4221-941a-b94086074e8c">

* Query results

<img width="251" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/cf772166-0006-47a2-8fa3-112b4db4df5f">

### Query 06: Trend of Stock level & MoM diff % by all product in 2011. If %gr rate is null then 0. Round to 1 decimal
* SQL code

<img width="420" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/a4802a93-3e31-4d53-8138-5320955911b0">

* Query results

<img width="440" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/6e5b310b-3a55-412e-b147-849142f9b168">

### Query 07: Calc MoM Ratio of Stock / Sales in 2011 by product name
* SQL code

<img width="218" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/0d4df0c7-27bd-4ae4-89ec-52dfa5352c1b">

* Query results

<img width="595" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/e4a73c86-2d04-4210-80e8-4d9db3d6629e">

### Query 08: No of order and value at Pending status in 2014
* SQL code

<img width="295" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/ddb80873-f203-42fa-baf7-d2a52ed5af28">

* Query results

<img width="376" alt="image" src="https://github.com/KayzDo/Explore-Adventureworks2019-Dataset/assets/141127437/5391be05-81f4-48be-95ef-c6a01083f957">
