import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote_plus

# Load the Excel file
excel_path = 'ecommerce_sales_cleaned.xlsx'
df = pd.read_excel(excel_path)

# Encode the password to handle special characters like '@'
password = quote_plus("11Sam@07")
engine = create_engine(f"mysql+pymysql://root:{password}@localhost:3306/ecommerce_sales")

table_name = 'ecommerce_sales'
try:
    df.to_sql(table_name, engine, if_exists='replace', index=False)
    print(f"Imported {len(df)} rows into the '{table_name}' table in ecommerce_sales.")
except Exception as exc:
    print('Failed to import Excel file to database:')
    print(exc)