/*	
	Let's see if we don't know the same thing:	
*/
SELECT  CASE WHEN NULL = NULL THEN 'We Know NULLs!'
             WHEN NULL = 'Elephant' THEN 'NULL elephant here.'
             WHEN NULL = 1 THEN '1 NULL to rule them.'
             WHEN NULL = 0.1 THEN 'A FractioNULL.'
             ELSE 'Who NULLs?'
        END AS 'You NULLs?';












/*
	If you don't know: it's OK to say so.
*/
SELECT  CASE WHEN NULL IS NULL THEN 'Yeah, we NULLS!'
             ELSE 'Who Nulls?'
        END AS 'You Nulls?';

SELECT  CASE WHEN 'elephants' IS NOT NULL THEN 'We no NULLs!'
             ELSE 'Who Nulls?'
        END AS 'You Nulls?';













