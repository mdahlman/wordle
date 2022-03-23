# This command assumes connectivity to the relevant database will be automatic.
FILENAME=/Users/mdahlman/github/wordle/docs/_data/wordle_answers.csv
psql -d postgres --csv -c "select the_date as \"Date\", word as \"Word\", comments as \"Comments\" from v_wordle order by the_date desc, comments ;" > $FILENAME

git add $FILENAME
git commit -m "answers through `date -v-1d +%Y-%m-%d`"
git push origin $(current_branch)


# Related notes
#
# Remember to launch Jekyll server locally like this:
# cd /Users/mdahlman/github/wordle/docs
# bundle exec jekyll serve --baseurl ''
