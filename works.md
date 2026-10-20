---
title: Selected works
permalink: /works/
description: Research on algorithms, labor, knowledge, and the methods through which we study them.
nav: true
nav_order: 2
---

<p class="page-intro">How are algorithms made, whose labor sustains them, and what kinds of knowledge do they enable? These selected works by cluster members connect critical inquiry with the practice of computational social science.</p>

<p class="archive-note">Selection updated October 20, 2026.</p>

<div class="publication-search">
  <label class="sr-only" for="publication-search">Filter selected works</label>
  <input type="search" id="publication-search" placeholder="Type to filter by title, author, venue, or year" autocomplete="off" spellcheck="false" aria-describedby="publication-count">
  <p id="publication-count" class="archive-note" role="status" aria-live="polite">{{ site.data.works | size }} publications</p>
</div>

<nav class="section-nav" aria-label="Research themes">
{% for theme in site.data.work_themes %}<a href="#{{ theme.id }}">{{ theme.label }}</a>{% endfor %}
</nav>

<div class="publications cluster-publications" data-publication-list>
{% for theme in site.data.work_themes %}
<section class="publication-theme" aria-labelledby="{{ theme.id }}" data-publication-theme>
  <div class="section-heading"><div><p class="eyebrow">{{ theme.kicker }}</p><h2 id="{{ theme.id }}">{{ theme.label }}</h2></div></div>
  <p class="theme-description">{{ theme.description }}</p>
  {% assign theme_works = site.data.works | where: 'theme', theme.id | sort: 'year' | reverse %}
  {% assign years = theme_works | group_by: 'year' %}
  {% for year in years %}
  <div class="publication-year-group" data-publication-year>
    <h3 class="bibliography publication-year">{{ year.name }}</h3>
    <ol class="bibliography">
    {% for work in year.items %}<li>{% include publication-row.html work=work %}</li>{% endfor %}
    </ol>
  </div>
  {% endfor %}
</section>
{% endfor %}
<p class="publication-empty" hidden>No publications match your search. <button type="button" data-clear-publication-search>Clear the filter</button></p>
</div>
<script src="{{ '/assets/js/works.js' | relative_url | bust_file_cache }}" defer></script>
