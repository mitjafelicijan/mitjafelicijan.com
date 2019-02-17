//Responsive tables
document.querySelectorAll('table').forEach(function (element) {
  if (!element.classList.contains('rouge-table')) {
    let parent = element.parentNode;
    let wrapper = document.createElement('div');
    wrapper.classList.add('responsive-table');
    parent.replaceChild(wrapper, element);
    wrapper.appendChild(element);
  }
});


// Open external links in new tab
let links = document.links;
for (let i = 0, linksLength = links.length; i < linksLength; i++) {
  if (links[i].hostname != window.location.hostname) {
    links[i].target = '_blank';
    links[i].setAttribute('rel', 'noopener nofollow');
  }
}

