/* 2022-03-24
 * mdahlman
 * Most queries likely to work in many SQL databases.
 * Some queries are Postgres-specific.
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

/* Are wordle words more likely than regular words to begin with a vowel? 
 * Yes.
 * 9% of "popular 5 letter words" start with a vowel.
 * 14% of wordle words as of 14 April 2022 start with a vowel.
 */
select 
	sum(1) as cnt
	, substring(word, 1, 1) in ('a', 'e', 'i', 'o', 'u') as starts_with_vowel
	, to_char( sum(1)::decimal / (select count(*) from v_words_popular_5), '999.000' ) as pct
from v_words_popular_5 
group by ( substring(word, 1, 1) in ('a', 'e', 'i', 'o', 'u') ) 	
;

select 
	sum(1) as cnt
	, substring(word, 1, 1) in ('A', 'E', 'I', 'O', 'U') as starts_with_vowel
	, to_char( sum(1)::decimal / (select count(*) from v_wordle), '999.000' ) as pct
from v_wordle 
group by ( substring(word, 1, 1) in ('A', 'E', 'I', 'O', 'U') )
;


/* Find records with comments */
select w.comments , count(*)
from wordle w 
group by comments
;

select * , the_date from wordle w
where the_date <= '2022-05-09'
order by the_date desc
;

select * from wordle w 
where word = 'SHINE'
;

/*
update wordle 
set the_date = the_date - 1
where day_num >= 319
;
*/


