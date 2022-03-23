---
layout: page
title: Wordle Answers Archive
permalink: /wordle-archive/
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
{% for row in site.data.wordle-answers %}
    <tr>
        <td>{{ row.Date }}</td>
        <td>{{ row.Word }}</td>
        <td>{{ row.Comments }}</td>
    </tr>
{% endfor %}
</table>
