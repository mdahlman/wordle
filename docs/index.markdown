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

The dates for the first 243 words are correct. 
Starting on 15&nbsp;Feb&nbsp;2022 the dates the diverge. 
After that point the New York Times dates should remain correct, but the dates for
the original words are off by one. And at each word removed by the NYT the dates for
the original words are offset by an additional day.

We could calculate the actual date that the words would have appeared if you
continued to play a cached version of the original game... but who cares?