
-- ==========================================================
SELECT '==========================================================' AS message;
SELECT '📦 LOADING BRONZE LAYER' AS message;
SELECT '==========================================================' AS message;

-- 🔄 CRM TABLES START
SELECT '--------------------------------------------------------------------------------------------------------' AS message;
SELECT '📥 LOADING CRM TABLES' AS message;
SELECT '--------------------------------------------------------------------------------------------------------' AS message;

-- CRM Customer Info
SELECT '>> Truncating Table: crm_cust_info' AS message;
TRUNCATE TABLE crm_cust_info;

SELECT '--------------------------------------------------------------------------------------------------------' AS message;
SELECT '👤 Loading CRM_CUST_INFO Table...' AS message;
SELECT '--------------------------------------------------------------------------------------------------------' AS message;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_info_cleaned.csv'
INTO TABLE crm_cust_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status, cst_gndr, cst_create_date);

-- CRM Product Info
SELECT '--------------------------------------------------------------------------------------------------------' AS message;
SELECT '📦 Loading CRM_PRD_INFO Table...' AS message;
SELECT '--------------------------------------------------------------------------------------------------------' AS message;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/prd_info.csv'
INTO TABLE bronze.crm_prd_info
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@prd_id, @prd_key, @prd_nm, @prd_cost, @prd_line, @prd_start_dt, @prd_end_dt)
SET
  prd_id = NULLIF(@prd_id, ''),
  prd_key = NULLIF(@prd_key, ''),
  prd_nm = NULLIF(@prd_nm, ''),
  prd_cost = NULLIF(@prd_cost, ''),
  prd_line = NULLIF(@prd_line, ''),
  prd_start_dt = STR_TO_DATE(NULLIF(@prd_start_dt, ''), '%Y-%m-%d'),
  prd_end_dt = STR_TO_DATE(NULLIF(@prd_end_dt, ''), '%Y-%m-%d');

-- CRM Sales Orders
SELECT '--------------------------------------------------------------------------------------------------------' AS message;
SELECT '🧾 Loading CRM_SLS_ORD_NUM Table...' AS message;
SELECT '--------------------------------------------------------------------------------------------------------' AS message;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_details.csv'
INTO TABLE bronze.crm_sls_ord_num
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@sls_ord_num, @sls_prd_key, @sls_cust_id, @sls_order_dt, @sls_ship_dt, @sls_due_dt, @sls_sales, @sls_quantity, @sls_price)
SET
  sls_ord_num  = NULLIF(TRIM(@sls_ord_num), ''),
  sls_prd_key  = NULLIF(TRIM(@sls_prd_key), ''),
  sls_cust_id  = NULLIF(TRIM(@sls_cust_id), ''),
  sls_order_dt = STR_TO_DATE(NULLIF(TRIM(@sls_order_dt), ''), '%Y-%m-%d'),
  sls_ship_dt  = STR_TO_DATE(NULLIF(TRIM(@sls_ship_dt), ''), '%Y-%m-%d'),
  sls_due_dt   = STR_TO_DATE(NULLIF(TRIM(@sls_due_dt), ''), '%Y-%m-%d'),
  sls_sales    = NULLIF(TRIM(@sls_sales), ''),
  sls_quantity = NULLIF(TRIM(@sls_quantity), ''),
  sls_price    = NULLIF(TRIM(@sls_price), '');

-- 🔄 ERP TABLES START
SELECT '--------------------------------------------------------------------------------------------------------' AS message;
SELECT '🏢 LOADING ERP TABLES' AS message;
SELECT '--------------------------------------------------------------------------------------------------------' AS message;

-- ERP Local A101
SELECT '--------------------------------------------------------------------------------------------------------' AS message;
SELECT '🌍 Loading ERP_LOCAL_A101 Table...' AS message;
SELECT '--------------------------------------------------------------------------------------------------------' AS message;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LOC_A101.csv'
INTO TABLE bronze.erp_local_a101
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@cid, @cntry)
SET
  cid = NULLIF(TRIM(@cid), ''),
  cntry = NULLIF(TRIM(@cntry), '');

-- ERP Customer AZ12
SELECT '--------------------------------------------------------------------------------------------------------' AS message;
SELECT '👥 Loading ERP_CUST_AZ12 Table...' AS message;
SELECT '--------------------------------------------------------------------------------------------------------' AS message;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CUST_AZ12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@cid, @bdate, @gen)
SET
  cid = NULLIF(TRIM(@cid), ''),
  bdate = STR_TO_DATE(NULLIF(TRIM(@bdate), ''), '%Y-%m-%d'),
  gen = NULLIF(TRIM(@gen), '');

-- ERP PX Category G1V2
SELECT '--------------------------------------------------------------------------------------------------------' AS message;
SELECT '📁 Loading ERP_PX_CAT_G1V2 Table...' AS message;
SELECT '--------------------------------------------------------------------------------------------------------' AS message;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PX_CAT_G1V2.csv'
INTO TABLE bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@id, @cat, @subcat, @maintainence)
SET
  id = NULLIF(TRIM(@id), ''),
  cat = NULLIF(TRIM(@cat), ''),
  subcat = NULLIF(TRIM(@subcat), ''),
  maintainence = NULLIF(TRIM(@maintainence), '');
