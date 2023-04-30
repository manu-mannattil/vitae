.PHONY: clean gitinfo

all: gitinfo vitae.pdf

%.pdf: %.tex
	pdflatex $<

gitinfo:
	git --no-pager log -1 --date=short --decorate=short --pretty=format:"\
		\def\gitHash{%H}              \
		\def\gitShortHash{%h}         \
		\def\gitRefName{%D}           \
		\def\gitAuthorName{%an}       \
		\def\gitAuthorEmail{%ae}      \
		\def\gitAuthorDate{%ai}       \
		\def\gitAuthorAltDate{%aD}    \
		\def\gitCommitterName{%cn}    \
		\def\gitCommitterEmail{%ce}   \
		\def\gitCommitterDate{%ci}    \
		\def\gitCommitterAltDate{%cD} \
	" HEAD >gitInfo.in

clean:
	rm -f .git/gitHeadInfo.gin
	rm -f *.aux *.log *.out *.fdb_latexmk *.fls *.gz

distclean: clean
	rm vitae.pdf

upload: all
	cp vitae.pdf ~/code/assets/vitae
	cd ~/code/assets/vitae; \
	git add --all ; \
	git diff-index --quiet HEAD || git commit --allow-empty-message -m '' ; \
	git push -f
