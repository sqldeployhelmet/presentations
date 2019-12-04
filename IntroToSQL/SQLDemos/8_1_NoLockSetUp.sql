/*
	Set up the Points table and 
*/
USE SQLMgmtD;

IF OBJECT_ID('dbo.points') IS NOT NULL
    DROP TABLE dbo.Points;

CREATE TABLE dbo.Points
    (
        id UNIQUEIDENTIFIER PRIMARY KEY
            DEFAULT ( NEWID())
      , personid INT
      , dollars MONEY
      , filler_data CHAR(1000)
            DEFAULT ( 'X' )
    );

/* insert $100 for person_id -1 */
INSERT INTO dbo.Points ( personid
                       , dollars )
VALUES ( -1, 10 )
     , ( -1, 10 )
     , ( -1, 10 )
     , ( -1, 10 )
     , ( -1, 10 )
     , ( -1, 10 )
     , ( -1, 10 )
     , ( -1, 10 )
     , ( -1, 10 )
     , ( -1, 10 );

SELECT SUM(dollars)
FROM   Points
WHERE  personid = -1;

/* start inserting $ for other folks */
WHILE 1 = 1
    BEGIN
        INSERT INTO dbo.Points ( personid
                               , dollars )
        VALUES ( CAST(RAND() * 10000 AS INT), 10 );
    END;

IF 1 = 2
    BEGIN
        DROP TABLE dbo.Points;

        DBCC SHRINKFILE(1, 11);
        DBCC SHRINKFILE(2, 20);
    END;
