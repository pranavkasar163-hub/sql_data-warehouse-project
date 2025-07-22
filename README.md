# Dara Warehouse and  Analytics Project
Building a modern data warehouse with sql server, including etl process, data modelling and analytics

Welcome to  DataWarehouse and Analytcis project (Data Engineering)


/*
Create data base and schemas

Script Purpose:
This script create a new database name "DataWarehouse"  after checkinh if it already exist. If database exist , it is dropped and recreated.
additionally,script setup 3 scemas within databse": 'bronze''silver','gold'.

Warning:
running this script will drop the entire 'DataWarehouse' databse if exist.
All data in the database will permanently deleted. Proceed with caution and esnure you have backups before running this script

*/

If exist (select 1 from sys.databse where name='DataWarehouse')
Begin 
 Alter databse datawarehouse set single_user with rollback immediate:
 drop database datawarehouse:
 end:

Create database DataWarehouse;

use datawarehouse;


create schema Bronze;
create schema silver;
create schema gold;
