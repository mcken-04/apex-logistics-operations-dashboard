#!/usr/bin/env python
# coding: utf-8

# # APEX Logistics Operations
# ###  Exploritory Analysis

# In[3]:


import pandas as pd

# Load dataset genrated by 01_data_generator
df = pd.read_csv('apex_logistics_raw.csv')



# In[4]:


# Exploring apex_logistics_raw table
print('Dateframe Info')
print(df.info()) # Data types and total non-null rows
print("\n")

print('First 10 Rows')
print(df.head(10)) # Check first 10 rows to quckly view data
print("\n")

print('Missing Values')
print(df.isnull().sum()) # Number of NULL values within the data
print("\n")

print('Summary Statistics')
print(df.describe()) # min, max, and average distances and delays
print('\n')

print('Damaged Packages Null Counter')
print(df['Damaged_Flag'].value_counts(dropna=False)) # Looking to ensure intentional NULL values were created
print('\n')

print('Weather Conditions')
print(df['WeatherCondition'].value_counts())

