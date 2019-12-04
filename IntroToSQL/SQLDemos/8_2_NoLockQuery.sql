USE SQLMgmtD

DECLARE @points MONEY;
 
 /* select sum of money that won't change: */
WHILE 1 = 1
    BEGIN
        SET @points = ( SELECT  SUM(dollars)
                        FROM    dbo.Points (NOLOCK)
                        WHERE   personid = -1
                      );
        IF @points <> 100
            BEGIN
                SELECT  @points AS current_total;
                BREAK;
            END;
    END;
/* this could run for minutes and still return incorrect results! */