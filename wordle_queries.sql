/* 2022-03-24
 * mdahlman
 * Most queries likely to work in many SQL databases.
 * Only tested in PostgreSQL 14.
 */

/* All past answers */
select *
from v_wordle vw 
order by the_date desc, comments desc
;

/* Was this word ever the answer? */
select *
from v_wordle vw 
where word like 'CHOIR'
;

/* What Wordle answers have had a Q? */
select *
from v_wordle 
where word ~ 'Q'
;

/* What Wordle answers have had repeated letters? */
select *
from v_wordle 
where word ~ '(.).*\1' /* Regexp note: find 1 character (the parens make it #1), find zero or more characters, find the first character again */
order by the_date desc
;

/* What Wordle answers have had triple letters? */
select *
from v_wordle 
where word ~ '(.).*\1.*\1' /* Regexp note: find 1 character (the parens make it #1), find zero or more characters, find the first character again, find zero or more characters, find the first character again */
order by the_date desc
;


/* Find records with comments */
select w.comments , count(*)
from wordle w 
group by comments
;
