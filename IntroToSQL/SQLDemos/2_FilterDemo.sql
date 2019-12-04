USE PHXCORE;

SELECT  COUNT(*)
FROM    dbo.dp_history;


/* let's return just the columns we want */
SELECT  acct_no
      , acct_type
      , effective_dt
      , create_dt
      , posting_dt_tm
      , empl_id
      , tran_code
      , amt
FROM    dbo.dp_history
WHERE   create_dt > '2017-03-01';
/* inlclude date! */

/*	= only checking accts or
	it's opposite <> anything but checking accounts */
SELECT  acct_no
      , acct_type
      , effective_dt
      , create_dt
      , posting_dt_tm
      , empl_id
      , tran_code
      , amt
FROM    dbo.dp_history
WHERE   acct_type = 'CKG'
        AND create_dt > '2017-03-01';

/* only checking, savings and IRAs */
SELECT  acct_no
      , acct_type
      , effective_dt
      , create_dt
      , posting_dt_tm
      , empl_id
      , tran_code
      , amt
FROM    dbo.dp_history
WHERE   acct_type IN ( 'CKG', 'SAV', 'IRA' )
        AND create_dt > '2017-03-01';

/*	Do I like like my results?
	% and _ */
SELECT  first_name
      , last_name
      , rim_no
FROM    dbo.rm_acct
WHERE last_name LIKE '';

