USE SQLMetrics;

/* Inserting Data */
INSERT INTO dbo.AppServer (   Server_Name
                            , OS
                            , IsActive
                            , DMZ
                            , created
                            , destroyed
                            , virtual
                            , prod
                            , warranty_expire
                            , ram
                            , core
                            , notes
                          )
VALUES (   'HANK'                      -- Server_Name - varchar(100)
         , 'WIN2003'                   -- OS - varchar(20)
         , 'Y'                         -- IsActive - varchar(1)
         , 0                           -- DMZ - bit
         , GETDATE()                   -- created - date
         , NULL
         , 1                           -- virtual - bit
         , 1                           -- prod - bit
         , DATEADD(YEAR, 5, GETDATE()) -- warranty_expire - date
         , 32                          -- ram - smallint
         , 4                           -- core - tinyint
         , 'I''m pretend!'             -- notes - varchar(2000)
       );

/* Begin and commit transaction are implied: SQL will just do it */



/*	But what if we aren't sure about the results or we are worried we'll
	break something? (Spoiler alert: we inevitably will)	*/


BEGIN TRANSACTION

UPDATE dbo.AppServer SET Server_Name = 'VERY IMPORTANT SERVER'


/*	If hadn't had a commit we could probably still fix it relatively easily
	but what if we did something worse like this: */


BEGIN TRANSACTION

DELETE FROM dbo.AppServer
WHERE Server_Name = 'HANK'
