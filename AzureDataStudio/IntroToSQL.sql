SELECT 'Josh Smith' MyName
    , '@sqldeployhelmet' TwitterHandle
    , 'Database Admin' [What I do]
    , 'Intellitect' [Our Sponsor!]
    , 'http://www.sqlsaturday.com/822/Sessions/SessionEvaluation.aspx' [Session Feedback]
    , 'http://www.sqlsaturday.com/822/EventEval.aspx' [SQL Saturday Feedback]


/* Quick Introduction to Azure Data Studio */
/*
    1. Servers/Connections
    2. Folders
    3. Search
    4. git
    5. appstore
    6. Azure Resource
*/

/* Onto the SQL! */
USE Movies

/* 
    Let's SELECT from a table 

*/

SELECT *
FROM Film


/* 
    What about filters? 

    <,>,=, !=/<>

    Also LIKE '%_', IN/NOT IN
*/

SELECT FilmName, FilmReleaseDate, FilmOscarNominations, FilmBoxOfficeDollars
FROM Film

--WHERE FilmBoxOfficeDollars = NULL -- <-- don't do this!
/*
WHERE FilmBoxOfficeDollars IS NOT NULL
ORDER BY FilmReleaseDate */
/*
WHERE (FilmReleaseDate >=  '01/01/2006'
    AND FilmReleaseDate < '2012-01-02')
    OR FilmID = 1 */
ORDER BY FilmReleaseDate DESC;
--WHERE FilmName LIKE 'Ameri_a'
--WHERE FilmName LIKE 'America%'
--WHERE filmName LIKE '%Die Hard%'


/*  
    Filtering one table is fine 
    but what about combining data? 
*/

SELECT f.FilmName AS [Name]
    , f.FilmReleaseDate [Release Date]
    , c.CountryName
 --   , l.LanguageID
 --   , f.FilmLanguageID
--    , l.[Language]
FROM Film f FULL OUTER JOIN Country c ON f.FilmCountryID = c.CountryID
/*FROM Film f JOIN [Language] l ON f.FilmLanguageID = l.LanguageID
WHERE FilmReleaseDate < '1970-01-01'
    OR l.[Language] = 'Japanese'*/
ORDER BY FilmReleaseDate

 /* 
    aggregating data 
    COUNT(*), MAX, MIN, AVG
 */

SELECT YEAR(FilmReleaseDate) FilmYear, COUNT(*) RowNumbers, MAX(FilmOscarNominations) MaxOscar, MIN(FilmOscarNominations) MinOscar, AVG(FilmOscarNominations) AvgOscar
, SUM(FilmOscarNominations) SumOscars
FROM Film
WHERE FilmOscarNominations IS NOT NULL
 AND FilmOscarNominations > 0
GROUP BY YEAR(FilmReleaseDate) WITH ROLLUP
HAVING MIN(FilmOscarNominations) > 2
ORDER BY FilmYear

--WHERE FilmReleaseDate IS NOT NULL


/* 
    rank/row number/ntile 
*/

SELECT FilmName, YEAR(FilmReleaseDate) FilmYear, FilmOscarNominations, FilmOscarWins
    , ROW_NUMBER() OVER (PARTITION BY YEAR(FilmReleaseDate) ORDER BY FilmOscarNominations DESC, FilmOscarWins DESC) OscarWins
    
FROM Film
WHERE FilmReleaseDate IS NOT NULL
    AND FilmReleaseDate > '1976-01-01'
ORDER BY FilmYear

/* 
    ntile 
*/

/* 
    multi table aggregations
*/

