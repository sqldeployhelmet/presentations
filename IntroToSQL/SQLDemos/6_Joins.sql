USE PHXCORE;

/*	(INNER) JOIN: returns all matches from both tables: */
SELECT  rim.rim_no
      , rim.last_name
      , rim.open_dt
      , acct.acct_type
FROM    dbo.rm_acct rim
        INNER JOIN dbo.dp_acct acct ON rim.rim_no = acct.rim_no;





/*	LEFT/RIGHT/FULL JOIN: returns matches and non-matches from tables
	dependent on the join type */
SELECT  da.rim_no AS 'Deposit_RIM'
      , da.acct_no AS 'Dep_acct'
      , da.acct_type AS 'Dep_acctType'
      , la.rim_no AS 'Loan_RIM'
      , la.acct_no AS 'Ln_acct'
      , la.acct_type AS 'Ln_acctType'
FROM    dbo.dp_acct da
        RIGHT JOIN dbo.ln_acct la ON da.rim_no = la.rim_no;


/*	We can JOIN and still aggregate as well: here is a INNER JOIN with a GROUP BY */
SELECT  dph.acct_type
		/*	we are cheating using a case statment to convert meaningless 0/1's 
			to a more meaningful text string */
      , CASE tc.debit_credit WHEN 0 THEN 'Credit'
             ELSE 'Debit'
        END AS 'TranType'
      , CAST(dph.effective_dt AS DATE) AS 'effective_dt'
      , SUM(dph.amt)
FROM    dbo.dp_history dph
        JOIN dbo.ad_gb_tc tc ON dph.tran_code = tc.tran_code
WHERE   dph.create_dt > '2017-02-27'
GROUP BY dph.acct_type
      , CAST(dph.effective_dt AS DATE)
      , CASE tc.debit_credit WHEN 0 THEN 'Credit'
             ELSE 'Debit'
        END;