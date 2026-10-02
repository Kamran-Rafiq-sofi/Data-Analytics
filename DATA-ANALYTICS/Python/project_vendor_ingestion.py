import pandas as pd
import os
from sqlalchemy import create_engine
import time
import logging
logging.basicConfig(
    filename="logs/ingestion_db.log",
    level=logging.DEBUG,
    format="%(asctime)s - %(levelname)s - %(message)s",
    filemode="a"
)

engine=create_engine('sqlite:///inventory.db')

def ingest_db(df,table_name, engine):
    ''' This performs funstion of ingesting files into database'''
    df.to_sql(table_name, con=engine, if_exists='replace', index=False)

def load_raw_data():
    ''' This loads csv files and ingest into database'''
    start=time.time()
    for file in os.listdir('data'):
        # print(file)
        if '.csv' in file:
            df=pd.read_csv('data/'+file)
            # print(df.shape)
            logging.info(f'Ingesting {file} in db')
            ingest_db(df,file[:-4], engine)
    end=time.time()
    total_time=(end-start)/60
    logging.info('___________Ingestion Complete_______________')        
    logging.info(f'Total Time taken: {total_time} minutes')   

if __name__=="__main__":
    load_raw_data()