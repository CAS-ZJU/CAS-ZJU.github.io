---
layout: about
title: Home
permalink: /
images:
  lightbox2: true
description: A research cluster at Zhejiang University, bringing critical inquiry and computational social science into conversation.
---

{% assign featured_meetup = site.data.events | where: 'id', '063623_438' | first %}
<div class="home-intro">
<div class="cluster-hero">
  <p class="eyebrow">Zhejiang University / Department of Sociology</p>
  <p class="hero-statement">Critical Algorithms Studies Cluster</p>
  <p class="page-intro">We bring critical researchers and computational social scientists together to understand the social implications of algorithms and data science, and to make meaningful interventions.</p>
  <div class="hero-actions">
    <a class="cluster-button" href="{{ '/manifesto/' | relative_url }}">Read our manifesto <span aria-hidden="true">↗</span></a>
    <a class="text-link" href="{{ '/people/' | relative_url }}">Meet the people →</a>
  </div>
</div>

<aside class="home-meetup" aria-labelledby="featured-meetup-title">
  <p class="eyebrow">Featured meetup · {{ featured_meetup.date_label }}</p>
  <h2 id="featured-meetup-title">Critical Algorithm Studies Meetup</h2>
  <a class="poster-link" href="{{ featured_meetup.original | relative_url | uri_escape }}" data-lightbox="featured-meetup" data-title="{{ featured_meetup.title | escape }}" aria-label="Open original poster: {{ featured_meetup.title | escape }}">
    <img src="{{ featured_meetup.thumbnail | relative_url }}" alt="{{ featured_meetup.title | escape }} — {{ featured_meetup.date_label }} poster" width="{{ featured_meetup.width }}" height="{{ featured_meetup.height }}" decoding="async">
  </a>
  <p class="meetup-links"><a class="text-link" href="{{ featured_meetup.original | relative_url | uri_escape }}">Open full poster ↗</a><a class="text-link" href="{{ '/events/#meetup-series' | relative_url }}">Explore the series →</a></p>
</aside>
</div>

<div class="section-heading"><div><p class="eyebrow">Our shared starting point</p><h2>Tinkering Against Scaling</h2></div><span class="section-index" aria-hidden="true"></span></div>
<p>How can we engage with algorithms when the largest models and their infrastructures remain out of reach? Our collective manifesto proposes tinkering as a practice of making, knowing, and caring.</p>
<p><a class="text-link" href="https://arxiv.org/abs/2504.16546">Read the 2025 preprint ↗</a></p>

<div class="home-grid">
  <article><p class="eyebrow">Research</p><h2><a href="{{ '/works/' | relative_url }}">Selected works</a></h2><p>AI labor, algorithmic knowledge, model validation, and the social lives of data.</p><a class="text-link" href="{{ '/works/' | relative_url }}">Explore the research →</a></article>
  <article><p class="eyebrow">Conversations</p><h2><a href="{{ '/events/' | relative_url }}">Events &amp; meetups</a></h2><p>A poster archive of our reading meetups, invited talks, workshops, and wider conversations.</p><a class="text-link" href="{{ '/events/' | relative_url }}">Browse the posters →</a></article>
</div>
