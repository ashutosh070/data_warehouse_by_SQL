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

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO

-- Creating DataBase 'DataWareHouse'

CREATE DATABASE DataWareHouse;
GO

USE DataWareHouse;
GO

-- Creating Schemas

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
