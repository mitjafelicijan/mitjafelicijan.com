window.addEventListener('load', async () => {
  // dither image on mouse over replace
  // document.querySelectorAll('article img').forEach(img => {
  //   const ditheredImage = img.src;
  //   const originalImage = img.src.replace('.dith.gif', '');

  //   img.addEventListener('mouseover', evt => {
  //     evt.target.src = originalImage;
  //   });

  //   img.addEventListener('mouseout', evt => {
  //     evt.target.src = ditheredImage;
  //   });
  // });

  // flip CV image on mouse over
  const cvImage = document.querySelector('.cv-picture img');
  if (cvImage) {
    cvImage.addEventListener('mouseover', evt => {
      evt.target.style.transform = 'scaleX(-1)';
    });

    cvImage.addEventListener('mouseout', evt => {
      evt.target.style.transform = 'scaleX(1)';
    });
  }

  // Search functionality

  window.index = null;

  const response = await fetch('/feed.json');
  const feed = await response.json();

  window.index = elasticlunr(function () {
    this.addField('title');
    this.addField('body');
    this.setRef('id');
  });

  for (const item of feed.items) {
    item.id = item.url;
    window.index.addDoc({
      id: item.url,
      title: item.title,
      body: item.content_html,
      url: item.url,
    });
  }

  const blur = document.querySelector('.blur');
  const searchForm = document.querySelector('.search-form');
  const searchResultsList = document.querySelector('.search-form ul');

  function showSearchModal() {
    blur.classList.remove('hidden');
    searchForm.classList.remove('hidden');

    // Clear search input.
    searchForm.querySelector('input').value = '';

    // We need to clear the list before opening modal.
    searchResultsList.innerHTML = '';

    // Focus on search input.
    searchForm.querySelector('input').focus();
  }

  document.querySelector('.search-trigger').addEventListener('click', async (evt) => {
    showSearchModal();
  });

  document.onkeydown = function (e) {
    // Show search modal on F key.
    if (blur.classList.contains('hidden')) {
      if (e.key === 'f') {
        setTimeout(() => {
          showSearchModal();
        }, 100);
      }
    }

    // Hide search modal on escape key.
    if (!blur.classList.contains('hidden')) {
      if (e.key === 'Escape') {
        blur.classList.add('hidden');
        searchForm.classList.add('hidden');
      }
    }
  };

  blur.addEventListener('click', async (evt) => {
    evt.target.classList.add('hidden');
    searchForm.classList.add('hidden');
  });

  document.querySelector('.search-form input').addEventListener('keyup', async (evt) => {
    // Perform search.
    const searchResults = window.index.search(evt.target.value);

    // We need to clear the list before adding new results.
    searchResultsList.innerHTML = '';

    // Loop through the results and add them to the list.
    for (const result of searchResults.slice(0, 9)) {
      const listItem = document.createElement('li');
      listItem.innerHTML = `<a href="${result.doc.url}">${result.doc.title}</a>`;
      searchResultsList.appendChild(listItem);
    }
  });

});
