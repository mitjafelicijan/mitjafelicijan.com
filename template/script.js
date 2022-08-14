window.addEventListener('load', async () => {

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
