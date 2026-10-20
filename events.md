---
title: Events
permalink: /events/
description: Reading together, thinking together, and opening up the algorithm.
images:
  lightbox2: true
nav: true
nav_order: 3
---

<p class="page-intro">Talks, reading groups, and workshops bring our questions into conversation. Explore posters and fieldwork archives from previous activities and our wider intellectual community.</p>
<nav class="section-nav" aria-label="Event collections"><a href="#campus-thomasson-archive">Campus fieldwork archive</a><a href="#meetup-series">Critical Algorithm Studies Meetups</a><a href="#event-archive">Talks &amp; workshops</a></nav>
<p class="archive-note"></p>

{% for archive in site.data.event_archives %}
<section aria-labelledby="{{ archive.id }}">
  <div class="section-heading"><div><p class="eyebrow">Past activities · {{ archive.period }}</p><h2 id="{{ archive.id }}">{{ archive.title }}</h2></div></div>
  <article class="event-archive-feature">
    <figure>
      <a href="{{ archive.url }}" aria-label="Explore {{ archive.title | escape }}">
        <img src="{{ archive.image | relative_url }}" alt="{{ archive.image_alt | escape }}" width="{{ archive.image_width }}" height="{{ archive.image_height }}" decoding="async">
      </a>
      <figcaption><span lang="zh">{{ archive.image_title }}</span> · {{ archive.image_author }}<br>From the <a href="{{ archive.url }}">{{ archive.title }}</a>.</figcaption>
    </figure>
    <div>
      <p class="archive-title-zh" lang="zh">{{ archive.title_zh }}</p>
      <p>{{ archive.description }}</p>
      <p class="archive-note">{{ archive.context }}</p>
      <a class="cluster-button" href="{{ archive.url }}">Explore the archive <span aria-hidden="true">↗</span></a>
    </div>
  </article>
</section>
{% endfor %}

<section aria-labelledby="meetup-series">
  <div class="section-heading"><div><p class="eyebrow">Our recurring series</p><h2 id="meetup-series">Critical Algorithm Studies Meetup</h2></div></div>
  <p>A shared space for reading, discussion, and practical exploration of algorithms. These sessions are held monthly, and we are organizing a special column to document the discussions.</p>
  <div class="poster-grid meetup-grid">
  {% for event in site.data.events %}{% if event.series == 'meetup' %}{% include poster-card.html event=event %}{% endif %}{% endfor %}
  </div>
</section>

<section aria-labelledby="event-archive">
  <div class="section-heading"><div><p class="eyebrow">The wider conversation</p><h2 id="event-archive">Talks &amp; workshops</h2></div></div>
  <div class="poster-grid">
  {% for event in site.data.events %}{% unless event.series == 'meetup' %}{% include poster-card.html event=event %}{% endunless %}{% endfor %}
  </div>
</section>
