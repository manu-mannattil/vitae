.PHONY: clean distclean gitinfo

all: gitinfo vitae.pdf

%.pdf: %.tex
	latexmk -norc -pdf -dvi- -ps- $<
	command -v pdfsizeopt && pdfsizeopt $@ $@; true

gitinfo:
	git --no-pager log -1 --date=short --decorate=short \
		--pretty=format:"\usepackage[shash={%h}, lhash={%H}, authname={%an}, authemail={%ae}, authsdate={%ad}, authidate={%ai}, authudate={%at}, commname={%cn}, commemail={%ce}, commsdate={%cd}, commidate={%ci}, commudate={%ct}, refnames={%d}, firsttagdescribe={$FIRSTTAG}, reltag={$RELTAG} ]{gitexinfo}" HEAD >.git/gitHeadInfo.gin

clean:
	latexmk -c
	rm -f .git/gitHeadInfo.gin
	rm -f tags

distclean: clean
	latexmk -C
