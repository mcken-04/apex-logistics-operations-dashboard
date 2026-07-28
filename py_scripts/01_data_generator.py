#!/usr/bin/env python
# coding: utf-8

# # APEX Logistics Operations
# ### Data Generation

# In[1]:


# Library imports
import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

# Set random seed for repoductability
np.random.seed(42)

# Generate 12000 rows of data
num_records = 12000


# In[2]:


# Helper function to generate dates
def generate_dates(start_date, end_date):
    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    return start_date + timedelta(days=random_number_of_days)

start = datetime(2022, 1, 1)
end = datetime(2023, 12, 31)

data = {
    'OrderID': [f"ORD-{i:05d}" for i in range(1, num_records + 1)],
    'Region': np.random.choice(['North', 'South', 'East', 'West'], num_records),
    'VehicleType': np.random.choice(['Van', 'Box Truck', 'Semi-Trailer'], num_records, p=[0.5, 0.3, 0.2]),
    'WeatherCondition': np.random.choice(['Clear', 'Rain', 'Snow', 'Fog'], num_records, p=[0.6, 0.2, 0.1, 0.1]),
    'Distance_Miles': np.random.randint(10, 1500, num_records),
    'OrderDate': [generate_dates(start, end) for _ in range(num_records)],
    'Damaged_Flag': np.random.choice(['Yes', 'No', None], num_records, p=[0.05, 0.90, 0.05]) # Introducing some Nulls
}

df = pd.DataFrame(data)

# Calculate Expected Delivery (1 day for every 300 miles, plus 1 buffer day)
df['ExpectedDeliveryDate'] = df['OrderDate'] + pd.to_timedelta((df['Distance_Miles'] // 300) + 1, unit='D')

# Calculate Actual Delivery (Injecting delays based on weather and random chance)
delay_days = np.where(df['WeatherCondition'].isin(['Snow', 'Fog']), np.random.randint(1, 5, num_records), 0)
random_delays = np.random.choice([0, 1, 2, 3], num_records, p=[0.8, 0.1, 0.05, 0.05])
total_delay = delay_days + random_delays

df['ActualDeliveryDate'] = df['ExpectedDeliveryDate'] + pd.to_timedelta(total_delay, unit='D')

# Introduce some missing Actual Delivery Dates (representing lost/in-transit packages)
missing_delivery_indices = df.sample(frac=0.02).index
df.loc[missing_delivery_indices, 'ActualDeliveryDate'] = np.nan

# Export to CSV
df.to_csv('apex_logistics_raw.csv', index=False)
print("Dataset 'apex_logistics_raw.csv' created successfully!")


# In[11]:





# In[ ]:




