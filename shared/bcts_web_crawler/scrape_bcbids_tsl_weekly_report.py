import undetected_chromedriver as uc
import undetected_chromedriver.settings as uc_settings
import tempfile
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pandas as pd
import random
import psycopg
import time
from datetime import datetime
import io
import os
import sys

# In[4]: Retrieve Postgres database configuration
postgres_username = os.environ['ODS_USERNAME']
postgres_password = os.environ['ODS_PASSWORD']
postgres_host = os.environ['ODS_HOST']
postgres_port = os.environ['ODS_PORT']
postgres_database = os.environ['ODS_DATABASE']

URL = 'https://www.bcbid.gov.bc.ca/page.aspx/en/rfp/request_browse_public'

# Use a guaranteed writable temp dir
temp_path = tempfile.mkdtemp()

# Override uc's internal data path BEFORE creating the Chrome driver
uc_settings.data_path = os.path.join(temp_path, "undetected")


options = uc.ChromeOptions()
options.headless = True
options.add_argument("--disable-blink-features=AutomationControlled")
options.add_argument("start-maximized")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

driver = uc.Chrome(options=options, user_data_dir=temp_path)
wait = WebDriverWait(driver, 20)

def load_into_postgres(df, conn_str, target_schema, target_table):
    try:
        with psycopg.connect(conn_str) as conn:
            with conn.cursor() as cur:
                # Write DataFrame to buffer
                buffer = io.StringIO()
                df.to_csv(buffer, index=False, header=False)
                buffer.seek(0)

                # Use copy to load into the table
                cur.copy(f"COPY {target_schema}.{target_table} FROM STDIN WITH (FORMAT CSV)", buffer)
                conn.commit()
    except Exception as e:
        print(f"Error loading data into PostgreSQL: {str(e)}")
        sys.exit(1)

if __name__ == '__main__':
    try:
        driver.get(URL)
        time.sleep(5)

        # === Step 1: Select "Timber Auction" ===
        print("Selecting 'Timber Auction' in Opportunity Type filter...")

        dropdown_button = wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, "div[data-iv-control='body_x_selRtgrouCode'] .ui.dropdown")))
        dropdown_button.click()
        time.sleep(1)

        timber_option = wait.until(EC.element_to_be_clickable((By.ID, "body_x_selRtgrouCode_ta")))
        driver.execute_script("arguments[0].scrollIntoView(true);", timber_option)
        timber_option.click()
        time.sleep(1)

        # === Step 2: Click the Search button ===
        print("Clicking Search to apply filter...")
        search_button = wait.until(EC.element_to_be_clickable((By.ID, "body_x_prxFilterBar_x_cmdSearchBtn")))
        search_button.click()
        time.sleep(3)

        # === Step 3: Wait for filtered table to load ===
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "table.table thead tr")))

        # === Step 4: Get dynamic headers ===
        header_elements = driver.find_elements(By.CSS_SELECTOR, "table.table thead tr th")
        headers = [h.text.strip() for h in header_elements if h.text.strip()]
        print(f"Detected headers: {headers}")

        all_data = []
        page = 1

        # === Step 5: Scrape paginated results ===
        while True:
            print(f"Scraping page {page}")
            rows = driver.find_elements(By.CSS_SELECTOR, "table.table tbody tr")

            for row in rows:
                cols = row.find_elements(By.TAG_NAME, "td")
                if len(cols) == len(headers):
                    row_data = {headers[i]: cols[i].text.strip() for i in range(len(headers))}
                    all_data.append(row_data)
                else:
                    print(f"Skipped row with {len(cols)} columns (expected {len(headers)})")

            # Try next page
            try:
                next_btn = driver.find_element(By.ID, "body_x_grid_gridPagerBtnNextPage")
                if 'disabled' in next_btn.get_attribute('class').lower():
                    break
                next_btn.click()
                time.sleep(random.uniform(3, 5))
                page += 1
            except:
                break

        # === Step 6: Save to ODS ===
        df = pd.DataFrame(all_data)
        df.to_sql("bcbids_tsl_weekly_report",
                  con=PgresPool, if_exists='replace', index=False, schema="bcts_staging")
        print(f"\nDone. Scraped {len(df)} records across {page} pages.")

    finally:
        driver.quit()
