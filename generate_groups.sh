#!/bin/bash

#removes previous groupings blocks
sed -r 'H;1h;$!d;x; s/@Comment\{jabref-meta: grouping:.*}//g' $1 > temp

#opens new groupings block and adds parent entry
echo -e "@Comment{jabref-meta: grouping:\n0 AllEntriesGroup:;" >> temp

#scans through groups in articles and miscs and creates an entry for every group
grep -E "groups(\s)*=" temp | sed -r 's/(groups(\s)*=\s\{)|(\},)//g; s/(\s)*//g; s/,/\n/g' | sort -u | while read line
do
	echo "1 StaticGroup:$line\;0\;1\;\;\;\;;" >> temp
done

#closes the block
echo "}" >> temp

# renames temp file to file given as argument
mv temp $1
