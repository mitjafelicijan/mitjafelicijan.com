window.addEventListener('load', function(evt) {

	let paintStyle = getComputedStyle(document.querySelector('section'));
	let canvas = document.querySelector('canvas');
	let ctx = canvas.getContext('2d');

	canvas.width = parseInt(paintStyle.getPropertyValue('width'));
	canvas.height = parseInt(paintStyle.getPropertyValue('height'));

	var mouse = {
		x: 0,
		y: 0
	};

	ctx.lineWidth = 3;
	ctx.lineJoin = 'round';
	ctx.lineCap = 'round';
	ctx.strokeStyle = 'limegreen';

	canvas.addEventListener('mousemove', function(e) {
		mouse.x = e.pageX - this.offsetLeft;
		mouse.y = e.pageY - this.offsetTop;
	}, false);

	canvas.addEventListener('mousedown', function(e) {
		ctx.beginPath();
		ctx.moveTo(mouse.x, mouse.y);
		canvas.addEventListener('mousemove', onPaint, false);
	}, false);

	canvas.addEventListener('mouseup', function() {
		canvas.removeEventListener('mousemove', onPaint, false);
	}, false);

	var onPaint = function() {
		ctx.lineCap = 'round';
		ctx.lineTo(mouse.x, mouse.y);
		ctx.stroke();
	};


	document.querySelectorAll('nav button').forEach(function(button, idx) {

		if (button.dataset.method == 'color') {
			button.style.background = button.dataset.value;
		}

		button.addEventListener('click', function(evt) {
			switch (button.dataset.method) {
				case 'color':
					{
						ctx.strokeStyle = button.dataset.value;
						break;
					}
				case 'size':
					{
						ctx.lineWidth = parseInt(button.dataset.value);
						break;
					}
			}
		});

	});

	document.addEventListener('keydown', function(evt) {
		if (evt.keyCode == 8) {
			ctx.clearRect(0, 0, canvas.width, canvas.height);
		}
		console.log(evt.keyCode);
	}, false);

});
