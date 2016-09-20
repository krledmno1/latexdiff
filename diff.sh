#!/bin/bash
# Assumtion: you have two folders (e.g., doc-v1/ and doc-v2/) with 
# two different versions of latex sources. The second folder is assumed to
# have the newer version.
# The script will latex-diff the .tex files with corresponding filenames and put 
# them in the diff dir. All .tex that exist in the newer version, but not in
# the older version will be added to the diff folder.
# Finally, the content of the latex-diff of the two main files is written and named
# as the newer latex main.

# $1 path to the old main file
# $2 path to the new main file
# #3 path to diff folder; end it with /

old=$1
new=$2
diff=$3

oldmainFile=${old##*/}
newmainFile=${new##*/}

oldmainPath=${old%$oldmainFile}
newmainPath=${new%$newmainFile}


cp -r $newmainPath/* $diff


#for i in `find $oldmainPath -type f | grep -E "*.tex$"`; 
for i in `ls $oldmainPath | egrep ".tex$"`; 
do 

#file=${i##*$oldmainPath}

echo $i

if [ ! -f $newmainPath$i ];		
then

echo "File not found: $newmainPath$i"


else

#newfile=$diff$file
#mkdir -p "${newfile%/*}"


latexdiff $oldmainPath$i $newmainPath$i > $diff$i
#dos2unix $diff$i

#echo $old$file
#echo $new$file
#echo $diff$file


fi

done

latexdiff $old $new > "$diff""newmainFile.tex"
#dos2unix $diff"diff.tex"





