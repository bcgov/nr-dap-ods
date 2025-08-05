import os
import io
import sys
import time
import random
import tempfile
import pandas as pd
import psycopg2
import undetected_chromedriver as uc

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from sqlalchemy import create_engine
import sys

# In[4]: Retrieve Postgres database configuration
postgres_username = os.environ['ODS_USERNAME']
postgres_password = os.environ['ODS_PASSWORD']
postgres_host = os.environ['ODS_HOST']
postgres_port = os.environ['ODS_PORT']
postgres_database = os.environ['ODS_DATABASE']
postgres_schema = "bcts_staging"
postgres_table = "bcbids_tsl_weekly_report"

URL = 'https://www.bcbid.gov.bc.ca/page.aspx/en/rfp/request_browse_public'

def load_into_postgres(df, schema, table):
    try:
        # Build connection string using SQLAlchemy
        conn_str = (
            f"postgresql+psycopg2://{postgres_username}:{postgres_password}"
            f"@{postgres_host}:{postgres_port}/{postgres_database}"
        )

        engine = create_engine(conn_str)

        # Load the dataframe
        df.to_sql(
            name=table,
            con=engine,
            schema=schema,
            if_exists="replace",  # or "append" if you prefer
            index=False
        )
        print(f"✅ Loaded {len(df)} rows into {schema}.{table}")

    except Exception as e:
        print(f"❌ Error writing to PostgreSQL with to_sql: {e}")
        sys.exit(1)

def run_scraper():
    options = uc.ChromeOptions()
    options.headless = False  # Set True to run headless
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_argument("start-maximized")
    user_data_dir = "/app_chrome/home"
    

    driver = uc.Chrome(options=options, user_data_dir=user_data_dir)
    wait = WebDriverWait(driver, 20)

    try:
        driver.get(URL)
        time.sleep(5)

        # Step 1: Filter to "Timber Auction"
        print("🔘 Selecting 'Timber Auction'...")
        dropdown = wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, "div[data-iv-control='body_x_selRtgrouCode'] .ui.dropdown")))
        dropdown.click()
        time.sleep(1)
        timber_option = wait.until(EC.element_to_be_clickable((By.ID, "body_x_selRtgrouCode_ta")))
        driver.execute_script("arguments[0].scrollIntoView(true);", timber_option)
        timber_option.click()
        time.sleep(1)

        # Step 2: Click Search
        print("🔍 Clicking Search...")
        search_btn = wait.until(EC.element_to_be_clickable((By.ID, "body_x_prxFilterBar_x_cmdSearchBtn")))
        search_btn.click()
        time.sleep(3)

        # Step 3: Wait for results
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "table.table thead tr")))
        headers = [h.text.strip() for h in driver.find_elements(By.CSS_SELECTOR, "table.table thead tr th") if h.text.strip()]
        print(f"📋 Headers: {headers}")

        all_data, page = [], 1
        while True:
            print(f"📄 Scraping page {page}")
            rows = driver.find_elements(By.CSS_SELECTOR, "table.table tbody tr")
            for row in rows:
                cols = row.find_elements(By.TAG_NAME, "td")
                if len(cols) == len(headers):
                    row_data = {headers[i]: cols[i].text.strip() for i in range(len(headers))}
                    all_data.append(row_data)
                else:
                    print(f"⚠️ Skipped row with {len(cols)} cols (expected {len(headers)})")

            try:
                next_btn = driver.find_element(By.ID, "body_x_grid_gridPagerBtnNextPage")
                if "disabled" in next_btn.get_attribute("class").lower():
                    break
                next_btn.click()
                time.sleep(random.uniform(2, 4))
                page += 1
            except:
                break

        df = pd.DataFrame(all_data)
        if df.empty:
            print("⚠️ No data found.")
            return

        load_into_postgres(df, postgres_schema, postgres_table)
        print(f"✅ Done. Scraped {len(df)} rows from {page} pages.")

    finally:
        if driver:
            driver.quit()
            del driver  # ← this prevents __del__ from trying again later


if __name__ == '__main__':
    run_scraper()
    