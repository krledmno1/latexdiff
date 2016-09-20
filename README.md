# Latexdiff
Scripts that automatically generate latex diff pdf from tex sources or version control

# Usage

bash diff.sh <old-main-file> <new-main-file> <diff-folder>

ex1.
bash diff.sh latexdoc-v1/main.tex latexdoc-v2/newmain.tex diff/

will generate diff latex sources in folder diff/ for the two latex documents
stored in folders latexdoc-v1 and latexdoc-v2


bash svn-diff.sh <svn-url> <older-revision> <newer-revision> [<name-of-main-file>]

if not specified, name of the main file is assumed to be main.tex

ex2. 
bash svn-diff.sh https://svn.example.com/papers/icse2016/ r12343 r23132 icse2016.tex  

will checkout two versions (r12343 and r23132) of the svn folder and invoke diff.sh 
on them. Then it will compile the souces with pdflatex and bibtex and copy the final 
pdf to the root folder (where the command was invoked). Finally, it will delete all
temporary folders and sources it created. 


