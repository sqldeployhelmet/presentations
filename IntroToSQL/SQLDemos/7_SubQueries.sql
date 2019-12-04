USE PHXCORE;

/* Sub-query: the inner query acts as a dynamic set for the IN clause */
SELECT  acct_no
      , COUNT(*) AS 'NumberTrans'
FROM    dbo.dp_history
WHERE   acct_no IN ( SELECT acct_no
                     FROM   dbo.dp_acct
                     WHERE  create_dt > '2017-01-01' )
GROUP BY acct_no;




/* Self join: the employee table will join to itself
   Note: this table does not exist outside of the demo so this query will not work */
SELECT  e.empID
      , e.empName
      , e.managerID
      , mgr.empName
FROM    demo_employee e
        LEFT JOIN dbo.demo_employee mgr ON e.managerID = mgr.empID;




/*	Recursive CTE: a temp table started from the employee table that self joins to 
	itself to create all the rows in itself) 
	
	Note: the base table does not exist outside of the demo so this query will not work */
WITH    directReports
          AS ( SELECT   empID
                      , empName
                      , managerID
                      , 0 AS 'OrgLevel'
               FROM     dbo.demo_employee
               WHERE    managerID = 0
               UNION ALL
               SELECT   e.empID
                      , e.empName
                      , e.managerID
                      , OrgLevel + 1
               FROM     dbo.demo_employee e
                        JOIN directReports d ON e.managerID = d.empID
             )
    SELECT  *
    FROM    directReports
    ORDER BY directReports.OrgLevel
          , directReports.empID;