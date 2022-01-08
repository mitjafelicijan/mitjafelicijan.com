cd ../assets/
find . -type f \( -name "*.png" -o -name "*.jpg" \) | while read fname; do
  echo "$fname"
  convert "$fname" -type Grayscale -ordered-dither 2x2 "$fname.dith.gif"
done

