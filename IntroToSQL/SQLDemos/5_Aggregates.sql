USE PHXCORE;

/*	Most of the aggregations: */
DECLARE @startdate DATETIME2 = CAST(DATEADD(WEEK, -1, GETDATE()) AS DATE);

SELECT  acct_type
      , AVG(amt)
      , MAX(amt)
      , MIN(amt)
      , COUNT(*)
FROM    dp_history
WHERE   create_dt >= @startdate
GROUP BY acct_type;
GO


/*	Aggregation WITH ROLLUP (sub-totals) */
DECLARE @startdate DATETIME2 = CAST(DATEADD(WEEK, -1, GETDATE()) AS DATE);

SELECT  acct_type
      , CAST(create_dt AS DATE) AS create_dt
      , AVG(amt) AS AvgAmt
      , MAX(amt) AS MaxAmt
      , MIN(amt) AS MinAmt
      , COUNT(*) AS TranCount
FROM    dp_history
WHERE   create_dt >= @startdate
GROUP BY acct_type
      , CAST(create_dt AS DATE)
        --WITH ROLLUP
ORDER BY create_dt
      , acct_type;
GO		


/*	Filtering groups via the HAVING clause: */
DECLARE @startdate DATETIME2 = CAST(DATEADD(WEEK, -1, GETDATE()) AS DATE);

SELECT  acct_type
      , CAST(create_dt AS DATE) AS create_dt
      , AVG(amt) AS 'AvgAmt'
      , MAX(amt) AS 'MaxAmt'
      , MIN(amt) AS 'MinAmt'
      , COUNT(*) AS 'TranCount'
FROM    dp_history
WHERE   create_dt >= @startdate
GROUP BY acct_type
      , create_dt
HAVING  AVG(amt) >= 100
ORDER BY create_dt
      , acct_type;
