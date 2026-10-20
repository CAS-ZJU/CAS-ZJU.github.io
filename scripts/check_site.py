#!/usr/bin/env python3
"""Check the built site's internal links and completeness of the resource archive."""
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
SITE = ROOT / "_site"


class Page(HTMLParser):
    def __init__(self, path):
        super().__init__()
        self.path, self.links, self.ids, self.classes, self.images = path, [], set(), [], []
        self.duplicate_ids = []
        self.feed(path.read_text())

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if attrs.get("id"):
            if attrs["id"] in self.ids:
                self.duplicate_ids.append(attrs["id"])
            self.ids.add(attrs["id"])
        self.classes.extend(attrs.get("class", "").split())
        for name in ("href", "src"):
            if attrs.get(name):
                self.links.append(attrs[name])
        if tag == "img":
            self.images.append(attrs)


def main():
    assert SITE.is_dir(), "Build the site with bundle exec jekyll build first."
    pages = {p.resolve(): Page(p) for p in SITE.rglob("*.html")}
    errors = []
    for path, page in pages.items():
        rel = path.relative_to(SITE)
        for duplicate in page.duplicate_ids:
            errors.append(f"{rel}: duplicate id {duplicate}")
        for img in page.images:
            if not img.get("alt"):
                errors.append(f"{rel}: image missing descriptive alt text")
        for link in page.links:
            url = urlsplit(link)
            if url.scheme or url.netloc:
                continue
            target = (SITE / unquote(url.path).lstrip("/")) if url.path.startswith("/") else (path.parent / unquote(url.path))
            if not url.path:
                target = path
            if target.is_dir():
                target /= "index.html"
            target = target.resolve()
            if not target.exists():
                errors.append(f"{rel}: missing internal target {link}")
            elif url.fragment and target in pages and unquote(url.fragment) not in pages[target].ids:
                errors.append(f"{rel}: missing anchor {link}")

    events = pages[(SITE / "events/index.html").resolve()]
    expected = {"/" + str(p.relative_to(ROOT)) for p in (ROOT / "resources/posters").iterdir() if p.suffix.lower() in (".png", ".jpg", ".jpeg")}
    linked = {unquote(urlsplit(link).path) for link in events.links if "/resources/posters/" in link}
    assert linked == expected, f"Poster coverage mismatch: missing {expected - linked}, unexpected {linked - expected}"
    assert events.classes.count("poster-card") == len(expected) == 24, "Expected each of the 24 posters exactly once."
    meetup_html = (SITE / "events/index.html").read_text().split('class="poster-grid meetup-grid">', 1)[1].split("</section>", 1)[0]
    assert meetup_html.count('class="poster-card"') == 5, "Expected exactly five meetup posters."
    for name in ("064521_521.jpg", "064315_407.jpg", "063803_231.jpg", "063623_438.jpg", "064050_625.jpg"):
        assert name in meetup_html, f"Missing requested series poster {name}"
    assert pages[(SITE / "people/index.html").resolve()].classes.count("person-card") == 6
    assert len(list((SITE / "people").glob("*/index.html"))) == 6
    expected_works = sum(line.startswith("- id:") for line in (ROOT / "_data/works.yml").read_text().splitlines())
    assert pages[(SITE / "works/index.html").resolve()].classes.count("work-card") == expected_works
    assert not errors, "\n".join(errors)
    print(f"Checked {len(pages)} HTML pages: internal links, fragments, image alternatives, six profiles, {expected_works} works, and all 24 posters (five in the meetup series).")


if __name__ == "__main__":
    main()
