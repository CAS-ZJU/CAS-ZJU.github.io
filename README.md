# CAS ZJU

Website of the Critical Algorithms Studies Cluster at Zhejiang University, built with Jekyll and [al-folio](https://github.com/alshedivat/al-folio). It uses the released `al_folio_core` 1.0.15 runtime, with al-folio navigation, typography, light/dark mode, and image galleries.

## Local preview

Use Ruby 3.3 and Bundler (the lockfile records the Bundler version).

```sh
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve
```

Open http://127.0.0.1:4000. On a Mac with Homebrew Ruby 3.3, prepend `/opt/homebrew/opt/ruby@3.3/bin` to `PATH` if the system Ruby is selected.

```sh
JEKYLL_ENV=production bundle exec jekyll build --strict_front_matter
python3 scripts/check_site.py
bundle exec al-folio upgrade audit
```

## Editing content

- `_people/*.md`: names, biographies, research interests, external profiles, and portrait paths and source credits. `person_id` connects each researcher to selected works.
- `assets/images/people/`: locally stored researcher portraits. `docs/portrait-sources.md` records the verified profile and original image URLs. Photo credits also appear on each profile page.
- `_data/works.yml`: selected publications, bibliographic details, member IDs, publication type, and relevance to the cluster. `_data/work_themes.yml` defines the page sections. Works use compact al-folio bibliography rows, descending years within each theme, live filtering, expandable selection notes, and BibTeX generated from the recorded metadata.
- `_data/event_archives.yml`: past activities with external digital archives, including a credited local preview image.
- `_data/events.yml`: event titles, dates as printed, original images, and previews. The five requested meetup posters use `series: meetup`.
- `resources/posters/`: untouched full-resolution originals. `assets/images/posters/` contains WebP previews, displayed without cropping. Clicking a preview opens al-folio's gallery; the separate “Open poster” link opens the original file.
- Navigation is controlled by `nav: true` and `nav_order` in the front matter of the five main pages.
- `_sass/_cluster.scss`: site-owned people, works, and event components, using al-folio's color tokens for both themes. `assets/css/main.scss` retains the core imports and adds this partial. `.al-folio-overrides.yml` records that intentional override for future upgrades.
- `docs/research-notes.md`: publication screening scope, sources, and uncertainties. The original member resource remains in `resources/person/persons.md`.

`_plugins/publication_filters.rb` formats publication badges, member profile links, search text, and BibTeX. `_sass/_works.scss` and `assets/js/works.js` control the Works page presentation and interactions.

`_plugins/style_cache.rb` includes local Sass in the stylesheet fingerprint so styling updates refresh browser caches.

Theme layouts, includes, and JavaScript are supplied by the pinned gems rather than copied into this repository. `jekyll-cache-bust` must load before `al_folio_core` in the Gemfile and plugin list so the theme's asset fallback is installed.

## GitHub Pages deployment

**Use GitHub Actions as the Pages source.** al-folio needs gems that the managed `github-pages` builder does not install. This site intentionally uses Jekyll 4.4 and has no `github-pages`, Minimal Mistakes, or remote-theme dependency.

1. In the repository's **Settings → Pages → Build and deployment → Source**, select **GitHub Actions**.
2. Commit and push the migration files together, including `Gemfile`, `Gemfile.lock`, `_config.yml`, layouts, Sass, and portrait assets.
3. `.github/workflows/pages.yml` installs the locked gems, builds the site, checks its internal links and content coverage, then deploys `_site` to Pages. Pull requests build and check without deploying.

Do not select **Deploy from a branch** for this source repository: that invokes the restricted managed builder and can repeat the missing-theme error. The files here cannot change the repository's Pages setting themselves.

The public URL is `https://cas-zju.github.io`. Update `url` and `baseurl` in `_config.yml` if the hosting destination changes. Internal links use `relative_url`.

After changing al-folio versions, run `bundle exec al-folio upgrade overrides audit`, review any reported diff, and acknowledge reconciled overrides with the upgrade CLI.
