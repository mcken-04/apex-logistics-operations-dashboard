<img src="assets/APEX_logo.png" alt="APEX logo" width="125" height="75">

# Business Requirements Document (BRD)
**Company:** APEX Regional Deliveries

**Project:** End-to-End Data Pipeline & Logistics Analysis

## 1. Executive Summary
APEX Regional Deliveries has experienced a noticeable spike in customer complaints regarding late deliveries and damaged freight over the past two years. Currently the executive team lacks visibility into the root causes of these of these operational bottlenecks. This project aims to design and implement an end-to-end data pipeline and business intelligence dashboard to identify the primary drivers of delayed and damaged shipments, empowering operations managers to monitor and optimize performance.

## 2. Business Objectives
* **Identify Bottlenecks:** Pinpoint where and why shipping delays are occurring across the network.
* **Reducing Package Damage:** Determine if specific vehicle types, routes, or conditions are disproportionately responsible for freight damage.
* **Improving Regional Accountability:** Provide a transparent performance scorecard for regional managers to track key metrics.
* **Enable Data Driven Decisions:** Transition from subjective problem-solving to proactive, data-informed operations management.

## 3. Stakeholder & Requirements
| **Stakeholders** | **Key Metric of Interest** | **Desired Outcome** |
| :--- | :--- | :--- |
| **Operations Manager** | On-Time Delivery Rate (%) | Identify bottlenecks in shipping and improve overall delivery speed. |
| **Fleet Manager** | Package Damage Rate (%) | Determine if specific vehicle types are causing more damage to freight. |
| **Regional Director** | Total Orders & Average Delays | Compare the performance of different distribution regions (e.g., North vs. South ). |

## 4. Scope of Work
**In-Scope:**
  * Ingestion and transformation of 2 years of historical logistics data.
  * Database schema design and deployment using PostgreSQL.
  * Data cleaning and anomaly correction (e.g., handling missing values, standardizing dates) via SQL Views.
  * Development of an interactive Power BI dashboard with KPI scorecards, trend analysis, and categorical breakdown visuals.

**Out-of-Scope:**
  * Real-time data streaming (pipeline is batch-oriented for historical analysis).
  * Direct integration with live IoT sensors or live weather APIs.

## 5. Functional Requirements
### 5.1 Data Engineering & Transformation
* **Data Standardization:** convert raw date strings to native database `DATE`/`TIMESTAMP` formats.
* **Null Handling:** Automatically convert empty strings( '' ) int `Damaged_Flag` column to `NULL`, and subsequently default to `Unknown`.
* **Metric Calculation:** Calculate delivery intervals (`Days_To_Deliver`, `Days_Delayed`) mathematically with SQL. Assign binary flags (`Is_Late`) for on-time vs. late shipments.
* **Data Quality Rules:** Implement business logic to filter out impossible combinations (e.g., reclassify anomalous "Snow" events during Summer months as "Heavy Rain").

### 5.2 Business Intelligence Dashboard
* **Global Filter:** Interactive slicers for `OrderDate` (range slider) and `Region` (dropdown).
* **KPI Ribbon:** Dynamic cards displaying Total Orders, On-Time Delivery Rate (%), Average Delivery Time (Days), and Damage Rate (%).
* **Trend Analysis:** Line Chart showing Late Delivery Rate by Month/Year.
* **Categorical Analysis:** Clustered bar chart showing Delivery Rate by Weather Condition. Donut chart showing Damage Rate by Vehicle Type.
* **Regional Scorecard:** Matrix visual display performance by Region, utilizing conditional formatting( Red/Yellow/Blue gradients) based on defined thresholds )e.g., Target On-Time > 90%, Target Damage < 5%).

## 6. Non-Functional Requirements
* ** Usability & UI/UX:** The dashboard must adhere to APEX Regional Deliveries branding guidelines (Primary Blue #1F449C, Accent Blue: #118DFF, and Accent Orange: #F05C22). Semantic coloring must be striclty enforced (e.g., Crimson #D32F2F exclusively for negative metrics like delays or damages and Yellow #F2A900 to give warning of reaching danger limits.
