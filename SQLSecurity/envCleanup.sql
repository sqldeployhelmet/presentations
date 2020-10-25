/* Pre-Demo Cleanup */
IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'Rona')
	DROP LOGIN [Rona]

ALTER ROLE sysAdmin DROP MEMBER Rona
CREATE LOGIN Rona WITH PASSWORD = 'myAwesomePassword'

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'Jaime')
	DROP LOGIN [Jaime]

CREATE LOGIN Jaime WITH PASSWORD = 'yourAwesomePassword'

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'TKtheFish')
	DROP LOGIN [TKtheFish];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'myOtherNewLogin')
	DROP LOGIN [myOtherNewLogin];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'testdbCreator')
	DROP LOGIN [testdbCreator];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'chad')
	DROP LOGIN [chad];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'SusanInHR')
	DROP LOGIN [SusanInHR];

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

EXEC sp_changedbowner 'sa'

IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'Chad')
BEGIN
	REVOKE SHOWPLAN TO Chad;
	DROP USER [Chad];
END
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'Rona')
BEGIN
	ALTER ROLE db_owner DROP MEMBER Rona;
	ALTER ROLE db_reader DROP MEMBER Rona;

	REVOKE SELECT ON Sales.Orders TO Rona;
	DROP USER [Rona];
END


IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'Jaime')
BEGIN
	DROP USER [Jaime];
END

USE AdvWorksDWViews;
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'SusanInHR')
BEGIN
	ALTER ROLE crole_StandardReports DROP MEMBER [SusanInHr]
	ALTER ROLE crole_SensitiveReports DROP MEMBER [SusanInHr]
	DROP USER [SusanInHR];
END
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'Chad')
BEGIN
	ALTER ROLE crole_StandardReports DROP MEMBER [Chad]
	DROP USER [Chad];
END
GO



IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'crole_StandardReports')
	DROP ROLE [crole_StandardReports];
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE [name] = 'crole_SensitiveReports')
	DROP ROLE [crole_SensitiveReports];
GO

EXEC sp_configure 'Show advanced Options', 1;
RECONFIGURE

EXEC sp_configure 'max degree of parallelism', 2;
EXEC sp_configure 'show advanced options', 0;
RECONFIGURE;


