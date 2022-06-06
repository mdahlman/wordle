/* 2022-03-24
 * mdahlman
 * Most queries likely to work in many SQL databases.
 * Some queries are Postgres-specific.
 * Only tested in PostgreSQL 14.
 */

/* All past answers */
select
    the_date,
    day_num,
    word,
    comments
from v_wordle
order by the_date desc, comments desc;

/* Was this word ever the answer? */
select
    the_date,
    day_num,
    word,
    comments
from v_wordle
where word like 'CHOIR';

/* What Wordle answers have had a Q? */
select
    the_date,
    day_num,
    word,
    comments
from v_wordle
where word ~ 'Q';

/* What Wordle answers have had repeated letters? */
select
    the_date,
    day_num,
    word,
    comments
from v_wordle
where
    /* Regexp note:
    *  find 1 character (the parens make it #1),
    *  find zero or more characters,
    *  find the first character again
    */
    word ~ '(.).*\1'
order by the_date desc;

/* What Wordle answers have had triple letters? */
select
    the_date,
    day_num,
    word,
    comments
from v_wordle
where
    /* Regexp note:
    * 	find 1 character (the parens make it #1),
    *  find zero or more characters,
    *  find the first character again,
    *  find zero or more characters,
    *  find the first character again
    */
    word ~ '(.).*\1.*\1'
order by the_date desc;

/* Are wordle words more likely than regular words to begin with a vowel?
* Yes.
* 9% of "popular 5 letter words" start with a vowel.
* 14% of wordle words as of 13 May 2022 start with a vowel.
*/
select
    'regular words' as word_type,
    substring(
        upper(word), 1, 1
    ) in ('A', 'E', 'I', 'O', 'U') as starts_with_vowel,
    sum(1) as cnt,
    to_char(
        sum(1)::decimal / (select count(*) from v_words_popular_5), '999.000'
    ) as pct
from v_words_popular_5
group by ( substring(upper(word), 1, 1) in ('A', 'E', 'I', 'O', 'U') )
union
select
    'wordle words' as word_type,
    substring(
        upper(word), 1, 1
    ) in ('A', 'E', 'I', 'O', 'U') as starts_with_vowel,
    sum(1) as cnt,
    to_char(
        sum(1)::decimal / (select count(*) from v_wordle), '999.000'
    ) as pct
from v_wordle
group by ( substring(upper(word), 1, 1) in ('A', 'E', 'I', 'O', 'U') )
order by word_type, starts_with_vowel;


/* Find records with comments */
select
    wordle.comments,
    count(*) as comment_cnt
from wordle
group by wordle.comments;

/* Query the spoiler-filled complete list */
select
    the_date,
    day_num,
    word,
    comments
from wordle
where the_date <= '2022-05-09'
order by the_date desc;

/* Query one record from the spoiler-filled complete list */
select
    the_date,
    day_num,
    word,
    comments
from wordle
where word = 'SHINE';

/*
update wordle
set the_date = the_date - 1
where day_num >= 319
;
*/
