/* Pre-Demo Cleanup */
IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'testdbCreator')
	DROP LOGIN [testdbCreator];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'Broseph')
	DROP LOGIN [testdbCreator];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'crole_Troubleshooting')
	DROP SERVER ROLE [crole_Troubleshooting];

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'crole_CreateDB')
	DROP SERVER ROLE [crole_CreateDB];

IF EXISTS (SELECT * FROM sys.databases WHERE [name] = 'neverDrop')
	DROP DATABASE neverDrop;

IF EXISTS (SELECT * FROM sys.databases WHERE [name] = 'sqfeToDrop')
	DROP DATABASE safeToDrop;