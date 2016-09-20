#!/bin/bash
# Assumption: you have a folder in svn that contains latex sources and you would like to latex-diff them.
# You need to pass the url and the two revision numbers
# The script will checkout both revisions in folders old/ and new/ and latex-diff them into
# a third folder diff/.
# Finally, it will compile the diff sources with pdflates and bibtex and copy the resulting pdf
# and removes the old/ new/ and diff/ folders. 

if [ "$#" -lt 3 ]; then
    echo "Illegal number of parameters"
    exit
fi


url=$1 # url to the svn repo with the latex source
oldrev=$2 # older version of the svn repo (without @)
newrev=$3 # newer version of the svn repo (without @)

if [ -z "$4" ]; then
    echo "using the default main.tex name"
    main="main"
else
    main=$4
fi


rm -r old
rm -r new

mkdir old
mkdir new
cd old
svn co "$url@$oldrev"
cd ..
cd new 
svn co "$url@$newrev"
cd ..

#root folder (assumed the same)
root=`ls new`

rm -r diff
mkdir diff

bash diff.sh old/$root/$main.tex new/$root/$main.tex diff/

cd diff
pdflatex "$main.tex"
bibtex "$main.aux"
pdflatex "$main.tex"
pdflatex "$main.tex"

cp $main.pdf ../

cd ..

rm -r old
rm -r new
rm -r diff
