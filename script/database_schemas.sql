/*

************* CREATE DATABASE AND SCHEMAS ************

This Script Creates a new database called 'DataWareHouse'. Before creating it checks if the same database
exists or not. If yes, then it drops the database and creates a fresh one.

Note :- Running this script will delete any stored data if the database already exists.

*******************************************************

*/


-- Switching to master
USE master;
GO

-- Check if the database exists or not. If yes drop and create new
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Data_Ware_House')
BEGIN
	ALTER DATABASE Data_Ware_House SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Data_Ware_House;
END;
GO


-- Creating DataBase 'DataWareHouse'
CREATE DATABASE Data_Ware_House;
GO

USE Data_Ware_House;
GO

-- Creating Schemas
CREATE SCHEMA bronze_layer;
GO
CREATE SCHEMA silver_layer;
GO
CREATE SCHEMA gold_layer;
GO
