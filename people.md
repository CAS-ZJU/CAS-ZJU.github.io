---
title: People
permalink: /people/
description: Critical inquiry, computational methods, and shared questions.
nav: true
nav_order: 1
---

<p class="page-intro">We work across sociology, anthropology, and computational social science. The cluster is based in the Department of Sociology at Zhejiang University and connects researchers across disciplines and institutions.</p>

<div class="people-grid">
{% assign people = site.people | sort: 'order' %}
{% for person in people %}
  <article class="person-card">
    <a class="portrait-link" href="{{ person.url | relative_url }}" tabindex="-1" aria-hidden="true">
      <img class="person-portrait" src="{{ person.portrait | relative_url }}" alt="{{ person.title | escape }}" width="{{ person.portrait_width }}" height="{{ person.portrait_height }}" loading="lazy" decoding="async" style="object-position: {{ person.portrait_position | default: 'center 30%' }}">
    </a>
    <p class="eyebrow">{{ person.chinese_name }}</p>
    <h2><a href="{{ person.url | relative_url }}">{{ person.title }}</a></h2>
    <p>{{ person.summary }}</p>
    <ul class="topic-list" aria-label="Research interests">{% for topic in person.topics %}<li>{{ topic }}</li>{% endfor %}</ul>
    <a class="text-link" href="{{ person.url | relative_url }}">Profile &amp; selected work →</a>
  </article>
{% endfor %}
</div>
