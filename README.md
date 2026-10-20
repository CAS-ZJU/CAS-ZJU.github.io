# CAS ZJU

Website of the Critical Algorithms Studies Cluster at Zhejiang University, built with Jekyll and [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/).

## Local preview

Use Ruby 3.3 and Bundler (the lockfile records the Bundler version).

```sh
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve
```

Open http://127.0.0.1:4000. On a Mac with Homebrew Ruby 3.3, prepend `/opt/homebrew/opt/ruby@3.3/bin` to `PATH` if the system Ruby is selected.

```sh
bundle exec jekyll build --strict_front_matter
python3 scripts/check_site.py
```

## Editing content

- `_people/*.md`: one member per file, including profile links, research interests, and a short biography. `person_id` connects the profile to works.
- `_data/works.yml`: selected publications, bibliographic details, member IDs, publication type, and a short explanation of relevance. `_data/work_themes.yml` defines the page sections.
- `_data/events.yml`: event titles, dates as printed, original image paths, and thumbnail paths. The five specified meetup posters use `series: meetup`.
- `resources/posters/`: untouched full-resolution originals. `assets/images/posters/` contains resized WebP previews, displayed without cropping.
- `_data/navigation.yml`: header navigation. `assets/css/cluster.css`: local styling layered over Minimal Mistakes.
- `docs/research-notes.md`: research scope, sources, screening decisions, and uncertainties behind the selected works.

The original member resource is retained in `resources/person/persons.md`. Source resources and uncommitted content supplied with this task have been preserved.

## GitHub Pages

`.github/workflows/pages.yml` builds on pull requests and builds/deploys on pushes to `main` or `master`. In the repository's **Settings → Pages**, set the source to **GitHub Actions** before deployment. This uses Jekyll 4 and the theme gem rather than GitHub's older managed Jekyll environment. No repository setting is changed by these files alone.

The site URL is `https://cas-zju.github.io`; update `url` and `baseurl` in `_config.yml` if the hosting destination changes. Internal links use `relative_url`.
