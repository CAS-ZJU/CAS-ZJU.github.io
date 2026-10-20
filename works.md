---
title: Selected works
permalink: /works/
description: Research on algorithms, labor, knowledge, and the methods through which we study them.
nav: true
nav_order: 2
---

<p class="page-intro">How are algorithms made, whose labor sustains them, and what kinds of knowledge do they enable? These selected works by cluster members connect critical inquiry with the practice of computational social science.</p>

<p class="archive-note">Selection updated October 20, 2026.</p>

<nav class="section-nav" aria-label="Research themes">
{% for theme in site.data.work_themes %}<a href="#{{ theme.id }}">{{ theme.label }}</a>{% endfor %}
</nav>

{% for theme in site.data.work_themes %}
<section aria-labelledby="{{ theme.id }}">
  <div class="section-heading"><div><p class="eyebrow">{{ theme.kicker }}</p><h2 id="{{ theme.id }}">{{ theme.label }}</h2></div></div>
  <p>{{ theme.description }}</p>
  <div class="works-list">
  {% for work in site.data.works %}{% if work.theme == theme.id %}{% include work-card.html work=work %}{% endif %}{% endfor %}
  </div>
</section>
{% endfor %}
