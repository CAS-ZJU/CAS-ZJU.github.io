(() => {
  const root = document.querySelector('[data-publication-list]');
  const search = document.getElementById('publication-search');
  if (!root || !search) return;

  const publications = Array.from(root.querySelectorAll('[data-publication]'));
  const normalize = text => text.normalize('NFKC').toLocaleLowerCase().replace(/\s+/g, ' ').trim();
  const searchable = publications.map(publication => normalize(publication.dataset.search));
  const update = () => {
    const terms = normalize(search.value).split(' ').filter(Boolean);
    let count = 0;
    publications.forEach((publication, index) => {
      const matches = terms.every(term => searchable[index].includes(term));
      publication.closest('li').hidden = !matches;
      if (matches) count += 1;
    });
    root.querySelectorAll('[data-publication-year]').forEach(group => {
      group.hidden = !Array.from(group.querySelectorAll('li')).some(item => !item.hidden);
    });
    root.querySelectorAll('[data-publication-theme]').forEach(theme => {
      theme.hidden = !Array.from(theme.querySelectorAll('[data-publication-year]')).some(group => !group.hidden);
    });
    document.getElementById('publication-count').textContent = terms.length
      ? `${count} of ${publications.length} publications`
      : `${publications.length} publications`;
    root.querySelector('.publication-empty').hidden = count !== 0;
  };
  search.addEventListener('input', update);
  root.querySelector('[data-clear-publication-search]').addEventListener('click', () => {
    search.value = '';
    update();
    search.focus();
  });

  root.addEventListener('click', event => {
    const toggle = event.target.closest('[data-publication-toggle]');
    if (toggle) {
      const panel = document.getElementById(toggle.getAttribute('aria-controls'));
      panel.hidden = !panel.hidden;
      toggle.setAttribute('aria-expanded', String(!panel.hidden));
    }

  });
})();
