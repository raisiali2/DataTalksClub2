#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[2]:


pd.__version__


# In[3]:


# df = pd.read_csv('2021_Yellow_Taxi_Trip_Data.csv', nrows=100)
df = pd.read_csv('yellow_taxi_trip_data_reduced.csv')


# In[4]:


df


# In[5]:


# df = pd.read_csv('2021_Yellow_Taxi_Trip_Data.csv', nrows=400000)b


# In[6]:


# df.to_csv('yellow_taxi_trip_data_reduced.csv')


# In[7]:


# what we can do next take this dataset and put it to our posgtres database
# for that what we need firs we have to generate schema like create table


# In[8]:


df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)


# In[9]:


print(pd.io.sql.get_schema(df, name='yellow_taxi_data'))


# In[25]:


import sqlalchemy
sqlalchemy.__version__


# In[10]:


from sqlalchemy import create_engine


# In[11]:


engine = create_engine('postgresql://root:root@localhost:5432/ny_taxi')


# In[12]:


engine.connect()


# In[13]:


# print(pd.io.sql.get_schema(df, name='yellow_taxi_data', con=engine))


# In[14]:


df_iter = pd.read_csv('yellow_taxi_trip_data_reduced.csv', iterator=True, chunksize=100000)


# In[15]:


df_iter
# it show this is not a data frame it is an iterator


# In[16]:


df = next(df_iter)


# In[17]:


len(df)


# In[18]:


df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)


# In[19]:


df


# In[20]:


# insert data to the database, first it will create table and then
# insert all the datas


# In[21]:


# class TeradataCompiler:
#     def __init__(self, dialect, statement, **kwargs):
#         super(TeradataCompiler, self).__init__(dialect, statement, **kwargs)



# In[22]:


get_ipython().run_line_magic('time', "df.to_sql(name='yellow_taxi_data', con=engine, if_exists='replace')")
         


# In[27]:


from time import time


# In[28]:


while True:
    
    t_start = time()
    
    df = next(df_iter)
    
    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    
    df.to_sql(name='yellow_taxi_data', con=engine, if_exists='append')
    
    t_end = time()
    print('inserted another chunk...., took %.3f second' %(t_end - t_start))


# In[ ]:




