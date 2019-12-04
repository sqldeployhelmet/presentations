USE PHXCORE;

/*	Oh no I will have to scroll down and retype those dates if I want to 
	re-use this script! */
SELECT  acct_no
      , acct_type
      , effective_dt
      , create_dt
      , posting_dt_tm
      , empl_id
      , tran_code
      , amt
FROM    dbo.dp_history
WHERE   create_dt > '2017-02-01'
        AND create_dt < '2017-03-01'; 






/* Create as many variables as you like! */

DECLARE @empid SMALLINT;
DECLARE @endDate DATETIME2;

SELECT  @empid = 12;
SELECT  @endDate = DATEADD(WEEK, -1, GETDATE());

SELECT  acct_no
      , acct_type
      , effective_dt
      , create_dt
      , posting_dt_tm
      , empl_id
      , tran_code
      , amt
FROM    dbo.dp_history
WHERE   empl_id = @empid
        AND create_dt > @endDate; 