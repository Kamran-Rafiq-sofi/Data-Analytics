
import pandas as pd
import os
import time
import logging
from pathlib import Path
from sqlalchemy import create_engine

# ==========================================
# 1. PATHS AND DATABASE CONFIGURATION
# ==========================================

# Compatible with Jupyter Notebook
BASE_DIR = Path.cwd()

DATA_DIR = BASE_DIR / "data"
LOG_DIR = BASE_DIR / "logs"

# Create logs folder if it does not exist
LOG_DIR.mkdir(parents=True, exist_ok=True)

# Check whether data folder exists
if not DATA_DIR.exists():
    raise FileNotFoundError(
        f"Data folder not found: {DATA_DIR}\n"
        "Make sure your notebook is inside JupyterProjects."
    )

# SQLite database
DB_PATH = BASE_DIR / "inventory.db"

engine = create_engine( 
    f"sqlite:///{DB_PATH}",
    connect_args={"timeout": 60}
)

# ==========================================
# 2. LOGGING CONFIGURATION
# ==========================================

logging.basicConfig(
    filename=LOG_DIR / "ingestion_db.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    filemode="a",
    force=True
)

# ==========================================
# 3. DATABASE INGESTION FUNCTION
# ==========================================

def ingest_db(file_path, chunksize=5000):

    table_name = file_path.stem

    logging.info(f"Starting ingestion: {file_path.name}")

    total_rows = 0
    first_chunk = True

    try:

        # Read CSV in smaller chunks
        for chunk in pd.read_csv( file_path, chunksize=chunksize ):

            # First chunk creates/replaces table.
            # Remaining chunks append to the same table.
            chunk.to_sql(
                name=table_name,
                con=engine,
                if_exists="replace" if first_chunk else "append",
                index=False,
                method=None,
                chunksize=1000
            )

            total_rows += len(chunk)
            first_chunk = False

            print(
                f"{file_path.name}: "
                f"{total_rows:,} rows ingested"
            )

            logging.info(
                f"{file_path.name}: "
                f"{total_rows:,} rows ingested"
            )

        if first_chunk:
            logging.warning(
                f"{file_path.name} is empty or has no data rows."
            )

            print(f"WARNING: {file_path.name} is empty.")

        else:
            logging.info(
                f"Completed {file_path.name}. "
                f"Total rows: {total_rows:,}"
            )

            print(
                f"Completed {file_path.name}: "
                f"{total_rows:,} rows"
            )

    except Exception:

        logging.exception(
            f"Error ingesting {file_path.name}"
        )

        raise


# ==========================================
# 4. LOAD ALL CSV FILES
# ==========================================

def load_raw_data():

    start_time = time.time()

    csv_files = sorted(DATA_DIR.glob("*.csv"))

    if not csv_files:
        print("No CSV files found in the data folder.")
        return

    print(f"Found {len(csv_files)} CSV files.")

    for file_path in csv_files:

        print(f"\nStarting: {file_path.name}")

        try:

            ingest_db(
                file_path=file_path,
                chunksize=5000
            )

        except Exception as e:

            print(
                f"FAILED: {file_path.name}\n"
                f"Reason: {e}"
            )

            logging.exception(
                f"Failed to ingest {file_path.name}"
            )

            # Continue with the next CSV
            continue

    total_time = (time.time() - start_time) / 60

    print("\n================================")
    print("INGESTION PROCESS FINISHED")
    print(f"Total time: {total_time:.2f} minutes")
    print("================================")

    logging.info("Ingestion process finished.")
    logging.info(
        f"Total time: {total_time:.2f} minutes"
    )


# ==========================================
# 5. EXECUTE
# ==========================================

load_raw_data()







'''
import time
import logging
from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine

# Paths
BASE_DIR = Path.cwd()
DATA_DIR = BASE_DIR / "data"
LOG_DIR = BASE_DIR / "logs"
LOG_DIR.mkdir(parents=True, exist_ok=True)

if not DATA_DIR.is_dir():
    raise FileNotFoundError(f"Data folder not found: {DATA_DIR}")

# Database
engine = create_engine(
    f"sqlite:///{BASE_DIR / 'inventory.db'}",
    connect_args={"timeout": 60}
)

# Logging
logging.basicConfig(
    filename=LOG_DIR / "ingestion_db.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    force=True
)


def ingest_db(file_path, chunksize=10000):
    table = file_path.stem
    total_rows = 0

    try:
        for chunk in pd.read_csv(file_path, chunksize=chunksize):
            chunk.to_sql(
                table,
                engine,
                if_exists="replace" if total_rows == 0 else "append",
                index=False,
                chunksize=1000
            )

            total_rows += len(chunk)
            print(f"{file_path.name}: {total_rows:,} rows")

        logging.info(f"Completed {file_path.name}: {total_rows:,} rows")
        return total_rows

    except Exception:
        logging.exception(f"Failed: {file_path.name}")
        raise


def load_raw_data():
    start = time.time()
    files = sorted(DATA_DIR.glob("*.csv"))

    if not files:
        print("No CSV files found.")
        return

    success, failed = 0, 0

    for file in files:
        try:
            ingest_db(file)
            success += 1
        except Exception as e:
            failed += 1
            print(f"FAILED: {file.name} - {e}")

    print(
        f"\nFinished | Success: {success} | Failed: {failed}"
        f"\nTime: {(time.time() - start) / 60:.2f} minutes"
    )

    logging.info(
        f"Finished | Success: {success} | Failed: {failed}"
    )


load_raw_data()
'''