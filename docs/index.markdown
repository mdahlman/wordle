---
layout: page
title: Wordle Answers Archive
---

Answers to past Wordle puzzles. No spoilers for today's puzzle or for future puzzles.

<table>
    <thead>
        <tr>
            <th>Date</th>
            <th>Word</th>
            <th>Comments</th>
        </tr>
    </thead>
{% for row in site.data.wordle_answers %}
    <tr>
        <td class="date">{{ row.Date }}</td>
        <td>{{ row.Word }}</td>
        <td>{{ row.Comments }}</td>
    </tr>
{% endfor %}

</table>

The dates for the first 243 words are correct for everyone. 
Starting on 15&nbsp;Feb&nbsp;2022 the dates the diverge from the original public version of the game. 
After that point the dates should be correct for people who played on the New York Times site.
The original words are off by one starting at that point. And at each word removed by the NYT the dates for
the original words are offset by an additional day.

For the first eight removals, the NYT simply removed a word from the original list. So the player
played a word one day sooner than originally planned.

For the ninth and tenth removals (FETUS and BUTCH), the NYT instead selected a word from far in the future and
substituted it in place of the removed word.

We could calculate the actual date that the words would have appeared if you
continued to play a cached version of the original game... but who cares?