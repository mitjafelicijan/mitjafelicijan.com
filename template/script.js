// dither image on mouse over replace
document.querySelectorAll('article img').forEach(img => {

  const ditheredImage = img.src;
  const originalImage = img.src.replace('.dith.gif', '');

  img.addEventListener('mouseover', evt => {
    evt.target.src = originalImage;
    console.log('mouseover')
  });

  img.addEventListener('mouseout', evt => {
    evt.target.src = ditheredImage;
    console.log('mouseout')
  });

});
