/*
This stored procedure loads Data to bronze schema from the CSV files.
Before inserting it turncates the data and uses BULK INSERT to load DATA.
*/


-- Ingesting Data in bronze_layer
EXEC bronze_layer.load_bronze_layer

CREATE OR ALTER PROCEDURE bronze_layer.load_bronze_layer AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '****************************************';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '****************************************';

        PRINT '########################################';
        PRINT 'LOADING CRM TABLES';
        PRINT '########################################';

        SET @start_time = GETDATE();
        PRINT '-- TRUNCATING TABLE: bronze_layer.crm_cust_info';
        TRUNCATE TABLE bronze_layer.crm_cust_info;
        PRINT '-- INSERTING TABLE: bronze_layer.crm_cust_info';
        BULK INSERT bronze_layer.crm_cust_info
        FROM 'C:\Users\dell\Desktop\SQL\Data Warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
	        FIRSTROW = 2,
	        FIELDTERMINATOR = ',',
	        TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
        PRINT '.......................'


        SET @start_time = GETDATE();
        PRINT '-- TRUNCATING TABLE: bronze_layer.crm_prd_info';
        TRUNCATE TABLE bronze_layer.crm_prd_info;
        PRINT '-- INSERTING TABLE: bronze_layer.crm_prd_info';
        BULK INSERT bronze_layer.crm_prd_info
        FROM 'C:\Users\dell\Desktop\SQL\Data Warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
        PRINT '.......................'


        SET @start_time = GETDATE();
        PRINT '-- TRUNCATING TABLE: bronze_layer.crm_sales_details';
        TRUNCATE TABLE bronze_layer.crm_sales_details;
        PRINT '-- INSERTING TABLE: bronze_layer.crm_sales_details';
        BULK INSERT bronze_layer.crm_sales_details
        FROM 'C:\Users\dell\Desktop\SQL\Data Warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	        WITH (
	        FIRSTROW = 2,
	        FIELDTERMINATOR = ',',
	        TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
        PRINT '.......................'


        PRINT '########################################';
        PRINT 'LOADING ERP TABLES';
        PRINT '########################################';


        SET @start_time = GETDATE();
        PRINT '-- TRUNCATING TABLE: bronze_layer.erp_CUST_AZ12';
        TRUNCATE TABLE bronze_layer.erp_CUST_AZ12;
        PRINT '-- INSERTING TABLE: bronze_layer.erp_CUST_AZ12';
        BULK INSERT bronze_layer.erp_CUST_AZ12
        FROM 'C:\Users\dell\Desktop\SQL\Data Warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
        PRINT '.......................'


        SET @start_time = GETDATE();
        PRINT '-- TRUNCATING TABLE: bronze_layer.erp_LOC_A101';
        TRUNCATE TABLE bronze_layer.erp_LOC_A101;
        PRINT '-- INSERTING TABLE: bronze_layer.erp_LOC_A101';
        BULK INSERT bronze_layer.erp_LOC_A101
        FROM 'C:\Users\dell\Desktop\SQL\Data Warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
        PRINT '.......................'


        SET @start_time = GETDATE();
        PRINT '-- TRUNCATING TABLE: bronze_layer.erp_PX_CAT_G1V2';
        TRUNCATE TABLE bronze_layer.erp_PX_CAT_G1V2;
        PRINT '-- INSERTING TABLE: bronze_layer.erp_PX_CAT_G1V2';
        BULK INSERT bronze_layer.erp_PX_CAT_G1V2
        FROM 'C:\Users\dell\Desktop\SQL\Data Warehouse\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
        PRINT '.......................'
        SET @batch_end_time = GETDATE();
        PRINT '====================='
        PRINT 'BRONZE LAYER SUCCESSFULLY LOADED'
        PRINT '>> BATCH LOAD DURATION :' + CAST (DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds'
        PRINT '====================='



    END TRY
    BEGIN CATCH
        PRINT '------------------------------'
        PRINT 'ERROR OCCURED DURING LOADING'
        PRINT 'Error Message:' + ERROR_MESSAGE();
        PRINT 'Error Message:' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message:' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '------------------------------'
    END CATCH
END

