USE PHXCORE;

/* time to build index: 14 mins  */
CREATE INDEX pk_SQLdemo1 
ON dbo.dp_history (create_dt ASC) 
INCLUDE ([acct_type],[amt]);

CREATE TABLE demo_employee
    (
      empID INT IDENTITY
    , empName VARCHAR(100)
    , managerID INT
    );

INSERT  INTO dbo.demo_employee
        ( empName, managerID )
VALUES  ( 'Rebecca Sugar'  -- empName - varchar(100)
          , 0  -- managerID - int
          ),
        ( 'Amethyst Gem', 1 ),
        ( 'Craig McCrakken', 1 ),
        ( 'Dee Licous', 2 ),
        ( 'Steven Crabcakes', 3 ),
        ( 'Joffrey Gonnadie', 4 ),
        ( 'Darth Yerdad', 4 ),
        ( 'Aaron Diaz', 3 ),
        ( 'Scott McCloud', 5 ),
        ( 'Obvious Alias', 5 ),
        ( 'Scrooge McDuck', 8 ),
        ( 'Heuy Lewis', 9 ),
        ( 'Gordon Sumner', 9 ),
        ( 'Billy Idol', 10 ),
        ( 'Julie Newmar', 10 );


IF 1 = 2
    BEGIN

        DROP TABLE dbo.demo_employee;

        DROP INDEX pk_SQLdemo1 ON dbo.dp_history;

    END;