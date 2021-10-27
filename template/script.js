window.addEventListener('load', () => {
  // dither image on mouse over replace
  document.querySelectorAll('article img').forEach(img => {
    const ditheredImage = img.src;
    const originalImage = img.src.replace('.dith.gif', '');

    img.addEventListener('mouseover', evt => {
      evt.target.src = originalImage;
    });

    img.addEventListener('mouseout', evt => {
      evt.target.src = ditheredImage;
    });
  });

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
});
