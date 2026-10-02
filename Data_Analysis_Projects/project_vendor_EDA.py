import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as snb
import os
import time
import logging
import zipfile
from sqlalchemy import create_engine
from pathlib import Path
import sqlite3
import mysql.connector
from ingestion_db import ingest_db

logging.basicConfig
(
    filename="logs/vendor_summary.log",
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s',
    filemode="a",
    force=True
)

# #creating database connection
# conn=sqlite3.connect('Inventory.db')
# # dispalying table names
# tables=pd.read_sql_query("select name from sqlite_master where type='table' ",conn)
# tables

# data=pd.read_sql_query("select * from begin_inventory",conn)
# data.head(10)


# # pd.read_sql("select count(*) as count from purchases",conn)
# pd.read_sql_query("select count(*) as count from purchases",conn)

# for table in tables['name']:
#     print('_'*50,f'{table}','_'*50)
#     print("Count of records:", pd.read_sql_query(f"select count(*) as count from {table}",conn)['count'].values[0])


    

# for table in tables['name']:
#     print('_'*50,f'{table}','_'*50)
#     print("Count of records:", pd.read_sql_query(f"select count(*) as count from {table}",conn)['count'].values[0])
#     display(pd.read_sql(f"select * from {table} limit 5", conn))


# # selecting vendor detials


# purchases=pd.read_sql_query("select * from purchases where VendorNumber=4466",conn)
# purchases




# vendor_invoice=pd.read_sql_query("select * from vendor_invoice where VendorNumber=4466",conn) 
# vendor_invoice



# z_sales=pd.read_sql_query("select * from z_sales where VendorNo=4466",conn) 
# z_sales



# purchases.groupby(['Brand','PurchasePrice'])[['Quantity','Dollars']].sum()
# # purchases.groupby('Brand',as_index=False)[['Quantity','Dollars']].sum()
# # purchases.groupby(['Brand','Purchase_Price' ,as_index=False])[['Quantity','Dollars']].sum()

# # no of uniques
# vendor_invoice['PONumber'].nunique()

# z_sales.groupby('Brand', as_index=False)[['SalesQuantity','SalesPrice','SalesDollars']].sum()
# # z_sales.groupby('Brand')[['SalesQuantity','SalesPrice','SalesDollars']].agg(['sum','mean','max'])
# # z_sales.groupby('Brand').agg({
# #     'SalesQuantity':['sum','mean','max'],
# #     'SalesPrice':['sum','mean','max'],
# #     'SalesDollars':['sum','mean','max']
     
# # })
# """
# As the data we need for analysis is in different columns and those columns are distributed in different tables we need to create an aggrgte table to get the data in one table for analysis...

# .purchase transactions made by vendor
# .sales transaction data
# .freight costs for each vendor
# .actual product prices from vendors
# """



# # vendor_invoice.columns
# # vendor_invoice['VendorNumber'].nunique()

# freight_summary=pd.read_sql_query("""select VendorNumber, count(VendorNumber) as count from vendor_invoice  group by 
# VendorNumber having count(Vendornumber)>=0""", conn)
# freight_summary


# freight_summary=pd.read_sql_query("""select VendorNumber, VendorName, sum(Freight) as freight_cost from vendor_invoice group by VendorNumber, VendorName""", conn)
# freight_summary




# pd.read_sql_query("""select 
#                p.VendorNumber,
#                p.vendorName,
#                p.Brand,
#                pp.Volume, 
#                pp.Price as Actual_price,
#                p.PurchasePrice,
#                sum(p.Quantity) as Total_quantity,
#                sum(p.Dollars) as Total_Dollars
#                from 
#                purchases as p 
#                join 
#                purchase_prices as pp 
#                on 
#                p.Brand=pp.Brand 
#                where p.PurchasePrice>0
#                Group by 
#                p.VendorNumber, p.VendorName, p.Brand
#                order by Total_Dollars""", conn)




# pd.read_sql_query("""select VendorNo, Brand, Sum(SalesDollars) as Total_Dollars,Sum(Salesprice) as Total_sales,
#                    Sum(SalesQuantity) as Total_Quantity, Sum(ExciseTax) as Total_Excise from z_sales Group By
#                    VendorNo, Brand order by Total_Sales""",conn)



# # no fo unique
# vendor_invoice['PONumber'].nunique()
# vendor_invoice.shape

# CREATING AGGREGATE TABLE
def create_vendor_summary(conn):
    """This table will merge different tables and will create an aggregate table"""
    
      vendor_sales_summary=pd.read_sql_query("""with Freight_Summary as (
                        select 
                        VendorNumber, 
                        sum(Freight) as freight_cost 
                        from vendor_invoice group by VendorNumber
                        ),
      purchase_summary as (select 
               p.VendorNumber,
               p.vendorName,
               p.Brand,
               p.Description,
               p.PurchasePrice,
               pp.Volume, 
               pp.Price as Actual_price,
               sum(p.Quantity) as Quantity,
               sum(p.Dollars) as Dollars
               from 
               purchases as p 
               join 
               purchase_prices as pp 
               on 
               p.Brand=pp.Brand 
               where p.PurchasePrice>0
               Group by 
               p.VendorNumber, p.VendorName, p.Brand, p.Description, p.PurchasePrice, pp.Volume, pp.Price
             ),
      sales_summary as (select 
      VendorNo,
      Brand, 
      Sum(SalesQuantity) as Total_Sales_Quantity, 
      Sum(SalesDollars) as Total_Sales_Dollars,
      Sum(SalesPrice)as Total_Sales_price,
      Sum(ExciseTax) as Total_Excise_Tax
      from z_sales 
      Group by VendorNo,Brand
      )

      select  
      ps.VendorNumber,
      ps.VendorName,
      ps.Brand,
      ps.Description,
      ps.Actual_Price,
      ps.PurchasePrice,
      ps.volume,
      ps.Quantity, 
      ps.Dollars,
      ss.Total_Sales_Quantity, 
      ss.Total_Sales_Dollars,
      ss.Total_Sales_price,
      ss.Total_Excise_Tax,
      fs.freight_cost
      from purchase_summary as ps
      left join sales_summary as ss 
      on 
      ps.VendorNumber=ss.VendorNo
      and ps.Brand=ss.Brand
      left join 
      freight_summary as fs
      on
      ps.VendorNumber=fs.VendorNumber
      order by ps.Dollars DESC""",conn)
      
      return vendor_sales_summary






# check for discrepencies
def clean_data(df):
    """ This function will clean the data"""

    # checks datatype
    # vendor_sales_summary.dtypes

    # checks if id there any null value
    # vendor_sales_summary.isnull().sum()

    # changes datatye
    vendor_sales_summary['Volume']=vendor_sales_summary['Volume'].astype('float64')
    df['Volume']=df['Volume'].astype('float64')


    # fills fillna
    # vendor_sales_summary.fillna(0,inplace=True)
    df.fillna(0,inplace=True)


    # trims white spaces
    # vendor_sales_summary['vendorName']=vendor_sales_summary['vendorName'].str.strip()
    df['vendorName']=df['vendorName'].str.strip()


    # Renames columns
    # vendor_sales_summary=vendor_sales_summary.rename(columns={'vendorName':'VendorName'})
    # vendor_sales_summary=vendor_sales_summary.rename(columns={'Total_Sales':'Total_Sales_Quantity'})

    # displays columns and table
    # vendor_sales_summary
    # vendor_sales_summary.columns

    # creates columns
    df['Gross_Profit']=df['Total_Sales_Dollars']-df['Dollars']
    df['Stock_Turnover']=df['Total_Sales_Quantity']/df['Quantity']
    df['Profit_Margin']=(df['Gross_Profit']/df['Total_Sales_Dollars'])*100
    df['SalesToPurchaseRatio']=df['Total_Sales_Dollars']/df['Dollars']

    return df

# CREATING TABLE

# curr=conn.cursor()
# query="""create table vendor_sales_summary(
# VendorNumber INT,
# VendorName VARCHAR (100), 
# Brand INT, 
# Description VARCHAR(100), 
# Actual_price DECIMAL(10,2),
# PurchasePrice  DECIMAL(15,2), 
# Volume  DECIMAL(15,2), 
# Quantity INT, 
# Dollars DECIMAL(15,2),
# Total_Sales_Quantity INT, 
# Total_Sales_Dollars DECIMAL(15,2), 
# Total_Sales_price  DECIMAL(15,2),
# Total_Excise_Tax  DECIMAL(15,2), 
# freight_cost  DECIMAL(15,2), 
# Gross_Profit  DECIMAL(15,2), 
# Profit_Margin  DECIMAL(15,2),
# Stock_Turnover  DECIMAL(15,2), 
# SalesToPurchaseRatio  DECIMAL(15,2),
# PRIMARY KEY (VendorNumber, Brand)); """

# curr.execute(query)
# pd.read_sql_query("select * from vendor_sales_summary", conn)
# vendor_sales_summary.to_sql('vendor_sales_summary',conn, if_exists='replace', index=False)
# pd.read_sql_query("select * from vendor_sales_summary", conn)

if __name__ == "__main__":
    conn=sqlite3.connection('Inventory.db')

    logging.info("create Vendor Sales Summary Table.......")
    summary_df=create_vendor_summary(conn)
    logging.info(summary_df.head())

    logging.info("Cleaning Data.......")
    clean_df=clean_data(summary_df)
    logging.info(clean_df.head())

    logging.info("Ingesting data.......")
    ingest_db(clean_df,'vendor_sales_summary',conn)
    logging.info('Completed')
                            
                            
