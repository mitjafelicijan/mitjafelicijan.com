window.addEventListener('load', function(evt) {

	let main = document.querySelector('main');
	let nav = document.querySelector('nav');
	let wrapper = document.querySelector('div.wrapper');
	let hash = window.location.hash.slice(1, window.location.hash.length);

	if (hash.length == 0) {
		main.innerHTML = '<h1>No presentation selected!</h1>';
	} else {

		fetch(`presentations/${hash}/default.pug`).then(function(response) {
			response.text().then(function(template) {
				if (response.status == 200) {
					main.innerHTML = jade.render(template, {});
					initSlideshow();
				} else {
					main.innerHTML = '<section><h3>Presentation does not exists!</h3></section>';
				}
			}).catch(function(error) {
				console.log(error);
			});
		});

		fetch(`presentations/${hash}/meta.json`).then(function(response) {
			response.json().then(function(data) {
				document.title = data.title;
			}).catch(function(error) {
				console.log(error);
			});
		});

	}

	function initSlideshow() {

		// mathjax formulas
		MathJax.Hub.Config({
			//displayAlign: 'left',
			extensions: ['tex2jax.js'],
			jax: ['input/TeX', 'output/SVG'],
			tex2jax: {
				skipTags: ['script', 'noscript', 'style', 'textarea', 'code'],
				inlineMath: [
					['$', '$'],
					["\\(", "\\)"]
				],
				displayMath: [
					['$$', '$$'],
					["\\[", "\\]"]
				],
			}
		});
		MathJax.Hub.Configured();

		// syntax highlighting
		Prism.highlightAll();

		// initializes slides
		function showSlide(slides, op) {
			let tmpIdx = currentIdx + op;
			if (tmpIdx >= 0 && tmpIdx < slides.length) {
				slides.forEach(function(slide) {
					slide.classList.add('hide');
				});
				slides[tmpIdx].classList.remove('hide');
				nav.innerHTML = `${tmpIdx+1} / ${slides.length}`;
				currentIdx = tmpIdx;
			}
		}

		// fixes images relative path
		document.querySelectorAll('img').forEach(function(image) {
			image.src = `presentations/${hash}/${image.getAttribute('src')}`;
		});

		let slides = document.querySelectorAll('section');
		let currentIdx = 0;
		showSlide(slides, currentIdx);

		document.addEventListener('keydown', function(evt) {
			switch (evt.code) {
				case 'ArrowRight':
					{
						showSlide(slides, 1);
						break;
					}
				case 'ArrowLeft':
					{
						showSlide(slides, -1);
						break;
					}
				case 'KeyF':
					{
						if (wrapper.requestFullscreen) {
							wrapper.requestFullscreen();
						} else if (wrapper.mozRequestFullScreen) {
							wrapper.mozRequestFullScreen();
						} else if (wrapper.webkitRequestFullscreen) {
							wrapper.webkitRequestFullscreen();
						} else if (wrapper.msRequestFullscreen) {
							wrapper.msRequestFullscreen();
						}
						break;
					}
			}
		}, false);


		//var elem = document.getElementById("myvideo");
		//if (elem.requestFullscreen) {
		//	elem.requestFullscreen();
		//}

	}

}, false);
