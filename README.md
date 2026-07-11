# Healthcare Clinic Performance Analysis: Optimizing patient flow, resource utilization and revenue growth.

# Overview 


#Business 


# Dataset
The dataset was obtained from kaggle.It follows a star schema with three fact tables and five dimension tables.
| Tables | Description | Rows |
|--------| ------------| -----|
| fact_appointment | Each patient appointment date and reason        | 100,000|
| fact_payment | Individual payment details | 100,000 |
| fact_treatment| Contains treatment types and cost  | 100,000 |
| Dim_patient | patient personal records | 19861|
| Dim_clinic | Information about various clinics | 50|
| Dim_staff | Contains staff information | 1000|
| Dim_doctors| doctors information | 500|
| Dim_date | Date covering Jan 1st 2025 to Dec 31st 2026 | 729 |


# SQL Analysis
Sql analysis was done on Postgresql
