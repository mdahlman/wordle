#!/bin/bash

# Set some environment info needed by cron
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
ssh-add $HOME/.ssh/id_rsa

# Add some debugging lines
LOG=/Users/mdahlman/temp/cron_tests.log
ECHO "Starting `date`" >> $LOG
ECHO "PATH: $PATH" >> $LOG

cd /Users/mdahlman/github/wordle
git checkout gh-pages

# This command assumes connectivity to the relevant database will be automatic.
FILENAME=/Users/mdahlman/github/wordle/docs/_data/wordle_answers.csv
psql -d postgres --csv -c "select the_date as \"Date\", word as \"Word\", comments as \"Comments\" from v_wordle order by the_date desc, comments desc;" > $FILENAME 2>>$LOG

# These commands assume you have files stored in my file structure
# and you have your git credentials configured somewhere
# and that date formatting might be Mac-only.
# Yikes! Brittle. But good enough for me today.
git add $FILENAME 2>>$LOG
git commit -m "answers through `date -v-1d +%Y-%m-%d`" 2>>$LOG
git remote set-url origin git@github.com:mdahlman/wordle.git 2>>$LOG
git push origin gh-pages 2>>$LOG

ECHO "Finishing `date`" >> $LOG

# Related notes
#
# Remember to launch Jekyll server locally like this:
# cd /Users/mdahlman/github/wordle/docs
# bundle exec jekyll serve --baseurl ''
