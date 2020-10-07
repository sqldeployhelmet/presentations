/* Pre-Demo Cleanup */
IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'testdbCreator')
	DROP LOGIN [testdbCreator];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'chad')
	DROP LOGIN [chad];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'crole_Troubleshooting')
	DROP SERVER ROLE [crole_Troubleshooting];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'crole_CreateDB')
	DROP SERVER ROLE [crole_CreateDB];

IF NOT EXISTS (SELECT * FROM sys.databases WHERE [name] = 'neverDrop')
	CREATE DATABASE neverDrop;

IF EXISTS (SELECT * FROM sys.databases WHERE [name] = 'safeToDrop')
	DROP DATABASE safeToDrop;

USE WideWorldImporters;
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'Chad')
BEGIN
	REVOKE SHOWPLAN TO Chad;
	DROP USER [Chad];
END
GO

USE AdvWorksDWViews;
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'SusanInHR')
	DROP USER [SusanInHR];
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'Chad')
	DROP USER [Chad];
GO

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'crole_StandardReports')
	DROP ROLE [crole_StandardReports];
GO

EXEC sp_configure 'Show advanced Options', 1;
RECONFIGURE

EXEC sp_configure 'max degree of parallelism', 2;
EXEC sp_configure 'show advanced options', 0;
RECONFIGURE;

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'crole_SensitiveReports')
	DROP ROLE [crole_SensitiveReports];
GO
