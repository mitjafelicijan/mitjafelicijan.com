set -xe

OUT=../content/pages/projects.fossil.md.part

echo -e "## Fossil repositories\n" > $OUT

find ~/Projects/ -type f -name "*.fossil" -not -path "*/website/*" | while read -r file; do
	cp $file ../static/projects/
done

find ../static/projects/ -type f -name "*.fossil" | while read -r file; do
	base=$(basename "$file")
	size=$(stat -c %s "$file" | numfmt --to=iec)
	modified_date=$(stat -c %Y "$file")
	formatted_date=$(date -d @"$modified_date" +"%Y-%m-%d %H:%M:%S")
	echo -e "- [$base](/projects/$base)<br><small>Size: $size, Modified: $formatted_date</small>" >> $OUT
done
