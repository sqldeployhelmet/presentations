/*
    A Quick Tour
    -- servers
    -- tasks
    -- search
    -- git
    -- extensions
    -- azure resources (mention)
*/

/*
    Now let's connect to a server, select a database and grab some data about stackoverflow users

    ORDER IS NOT GUARANTEED: ORDER BY
*/

SELECT TOP 10 DisplayName, CreationDate, *
FROM users
ORDER BY CreationDate DESC

/* 
    what if we don't want the whole table? Well we need a filter, otherwise known as a where clause 

        = & LIKE
        != & <>
        > 
        <

        (NOT) EXISTS/(NOT) IN
        AND/OR
        (NOT) NULL

        SELECTIVITY/SARGABILITY
        if where clause is restrictive enough *AND* SQL can find an index that supports it 
        the query engine can do less work that scanning the table and return faster.
        scans/seeks/ logical/physical reads out of scope?

*/

SELECT DisplayName, CreationDate
FROM users
WHERE DisplayName =  'josh'

SELECT TOP 10 DisplayName, WebsiteUrl
FROM Users
WHERE WebsiteUrl LIKE '%youtube%' --NOT NULL

SELECT DisplayName, CreationDate
FROM users
WHERE CreationDate >= '2010-12-1'

    AND CreationDate < '2010-12-2'

SELECT DisplayName, WebsiteUrl, CreationDate
FROM users
WHERE WebsiteUrl Is NULL

SELECT TOP 10 DisplayName, WebsiteUrl
FROM Users
WHERE WebsiteUrl LIKE '%youtube%' --NOT NULL

/* 
    this is somewhat useful but what if I want to know more information about a specific user's contributions?
    Let's talk about joins primarily: 

        INNER
            -- let's alias those tables while were at it too
        OUTER (LEFT & RIGHT)
        FULL

        MULTITABLE: whoa now!

        We can get really wierd with joins: link to Steve Stedman's Join type poster
        http://stevestedman.com/wp-content/uploads/TSqlJoinTypePoster1.pdf 
*/

SELECT u.DisplayName, p.Title, p.CreationDate, p.ViewCount, p.Score
FROM users AS u JOIN Posts AS p /* <-- introduction to table alias' here (initially do without aliases (see order by)) */ /* returns in about 30 sec*/
    ON u.Id = p.OwnerUserId
WHERE p.PostTypeId = 1 /* add filters */
 AND u.DisplayName LIKE 'Egg%'
ORDER BY u.DisplayName, u.CreationDate /* initially leave off alias from creation date: need to reference table to avoid ambiguity */

/* join more than 1 table... */
SELECT TOP 100  p.Title, u.DisplayName /*, CASE WHEN u.DisplayName IS NULL THEN 'Post User: ' + u2.DisplayName ELSE 'Nouser!' END */, c.text, c.CreationDate, p.ViewCount, p.Id
FROM Comments AS c LEFT OUTER JOIN Users AS u ON c.UserID = u.Id /* turn this into a left outer join */
    JOIN Posts AS p ON c.postID = p.Id /* add this after first run */
    JOIN users AS u2 ON p.OwnerUserId = u2.id
WHERE PostTypeId = 1
    --AND c.userID IS NULL
    --AND p.id = 3452868 /* 3452868 :Opacity in IE8...(7)  OR 2551775 :Appending vector to a vector (11) or 3867890 :Count character occurences in a string (8)*/
ORDER BY p.ViewCount DESC, c.PostID, c.CreationDate

/* Let's group & aggregate some data! 
    GROUPING SETS
    
    SUM/AVG/MAX/MIN
        -- aw man these columns need an alias too!
    
    ROW_NUMBER/RANK, DENSE RANK, NTILE, PERCENT_RANK

*/
USE Movies

SELECT COUNT(*), COUNT(FilmCertificateID) /* some nulls */
FROM Film

SELECT MIN(FilmReleaseDate), MAX(FilmReleaseDate)
FROM Film 

SELECT AVG(FilmBudgetDollars), MIN(FilmBudgetDollars), MAX(FilmBudgetDollars)
FROM FILM
WHERE FilmReleaseDate > '2007-01-01'
    AND FilmOscarWins > 0 /* <== otherwise need bigint for $$ */

SELECT YEAR(FilmReleaseDate) AS FilmYear, SUM(CAST(FilmBudgetDollars AS bigint))
FROM Film 
WHERE FilmReleaseDate IS NOT NULL
GROUP BY YEAR(FilmReleaseDate)

SELECT FilmOscarWins
    , ROW_NUMBER() OVER (ORDER BY FilmOscarWins DESC) AS RowNum
    , RANK () OVER (ORDER BY FilmOscarWins DESC) AS Rank_result
    , DENSE_RANK() OVER (ORDER BY FilmOscarWins DESC) AS DenseRank_result
    , ROUND(PERCENT_RANK() OVER (ORDER BY FIlmOscarWins DESC), 2) AS PercentRank
    , NTILE (2) OVER (ORDER BY FilmOScarWins DESC) AS tileResult
    , FilmName, FilmRunTimeMinutes, FilmReleaseDate, FilmBudgetDollars, FilmBoxOfficeDollars 
FROM Film 
--ORDER BY FilmOscarWins DESC

--ORDER BY FilmYear
/*  real quick let's talk about inserts/updates/deletes 
    let's also introduce a transaction? */
