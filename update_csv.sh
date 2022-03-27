#!/bin/bash
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
# This command assumes connectivity to the relevant database will be automatic.

# Add some debugging lines
LOG=/Users/mdahlman/temp/cron_tests.log

ECHO "Starting `date`" >> $LOG
ECHO "PATH: $PATH" >> $LOG

FILENAME=/Users/mdahlman/github/wordle/docs/_data/wordle_answers.csv
psql -d postgres --csv -c "select the_date as \"Date\", word as \"Word\", comments as \"Comments\" from v_wordle order by the_date desc, comments desc;" > $FILENAME 2>>$LOG

# These commands assume you have files stored in my file structure
# and you have your git credentials configured somewhere
# and that date formatting might be Mac-only.
# Yikes! Brittle. But good enough for me today.
cd /Users/mdahlman/github/wordle
git add $FILENAME
git commit -m "answers through `date -v-1d +%Y-%m-%d`"
git push origin gh-pages 2>>$LOG

ECHO "Finishing `date`" >> $LOG

# Related notes
#
# Remember to launch Jekyll server locally like this:
# cd /Users/mdahlman/github/wordle/docs
# bundle exec jekyll serve --baseurl ''
