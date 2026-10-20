---
title: Events
permalink: /events/
description: Reading together, thinking together, and opening up the algorithm.
images:
  lightbox2: true
nav: true
nav_order: 3
---

<p class="page-intro">Talks, reading groups, and workshops bring our questions into conversation. Explore the posters from previous events and our wider intellectual community.</p>
<nav class="section-nav" aria-label="Event collections"><a href="#meetup-series">Critical Algorithm Studies Meetups</a><a href="#event-archive">Talks &amp; workshops</a></nav>
<p class="archive-note"></p>

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
