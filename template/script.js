window.addEventListener('load', async () => {

  // flip CV image on mouse over
  const cvImage = document.querySelector('.cv-picture img');
  if (cvImage) {
    setInterval(() => {
      cvImage.style.transform = cvImage.style.transform === 'scaleX(1)' ? 'scaleX(-1)' : 'scaleX(1)';
    }, 1000);
  }

});
