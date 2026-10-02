import pandas as pd
import os
from sqlalchemy import create_engine

engine=create_engine("mysql+pymysql://root:KamranlovesSameena%40123@127.0.0.1:3306/inventory_db")
conn=engine.connect()

def ingest_db(df,table_name, engine):
    df.to_sql(table_name, engine, if_exists='replace', index=False)
for file in os.listdir('data'):
    # print(file)
    if '.csv' in file:
        df=pd.read_csv('data/'+file)
        print(df.shape)
        ingest_db(df,file[:-4], engine)