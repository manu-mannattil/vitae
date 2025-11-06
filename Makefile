.PHONY: clean gitinfo

all: gitinfo vitae.pdf

%.pdf: %.tex
	pdflatex -file-line-error -interaction=nonstopmode -shell-escape -synctex=1 $<

gitinfo:
	mkdir -p .git
	git --no-pager log -1 --date="format:%B %d, %Y" --decorate=short --pretty=format:"\
		\def\gitHash{%H}                \
		\def\gitShortHash{%h}           \
		\def\gitRefName{%D}             \
		\def\gitAuthorName{%an}         \
		\def\gitAuthorEmail{%ae}        \
		\def\gitAuthorDate{%ai}         \
		\def\gitAuthorAltDate{%aD}      \
		\def\gitCommitterName{%cn}      \
		\def\gitCommitterEmail{%ce}     \
		\def\gitCommitterDate{%ci}      \
		\def\gitCommitterAltDate{%cD}   \
		\def\gitCommitterDate{%cD}      \
		\def\gitCommitterDateHuman{%cd} \
	" HEAD >.git/gitInfo.in

clean:
	rm -f .git/gitInfo.in
	rm -f *.aux *.log *.out *.fdb_latexmk *.fls *.gz

distclean: clean
	rm -f vitae.pdf
