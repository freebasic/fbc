include ../../version.mk

HHC := hhc
FBDOC := ../fbdoc/fbdoc
MAKEFBHELP := ../makefbhelp/makefbhelp

# Nice names for the resulting .zip's and the important files
TITLE       = FB-manual-$(FBVERSION)
CHM         = $(TITLE).chm
CHMZIP      = $(TITLE)-chm.zip
FBHELP      = fbhelp.daz
FBHELPZIP   = $(TITLE)-fbhelp.zip
HTMLZIP     = $(TITLE)-html.zip
TXT         = $(TITLE).txt
TXTZIP      = $(TITLE)-txt.zip
WAKKAZIP    = $(TITLE)-wakka.zip

ifdef QUIET
  HIDE := > /dev/null
endif

################################################################################

all: $(CHMZIP) $(FBHELPZIP) $(HTMLZIP) $(TXTZIP) $(WAKKAZIP)

################################################################################
# chm

html/fbdoc.hhp:
	$(FBDOC) -chm $(HIDE)

html/fbdoc.chm: html/fbdoc.hhp
	-$(HHC) $< $(HIDE)

$(CHM): html/fbdoc.chm
	cp $< $@

$(CHMZIP): $(CHM)
	zip -q -9 $@ $<

################################################################################
# fbhelp

fbhelp/DocToc.txt:
	$(FBDOC) -fbhelp $(HIDE)

fbhelp/fbhelp.dat: fbhelp/DocToc.txt
	$(MAKEFBHELP)

$(FBHELP): fbhelp/fbhelp.dat
	gzip -c $< > $@

$(FBHELPZIP): $(FBHELP)
	zip -q -9 $@ $<

################################################################################
# html

html/DocToc.html:
	$(FBDOC) -chm $(HIDE)

html/00index.html: html/DocToc.html
	cp $< $@

$(HTMLZIP): html/00index.html
	cd html && zip -q -r -9 ../$@ *.html style.css images

################################################################################
# txt

txt/fbdoc.txt:
	$(FBDOC) -txt $(HIDE)

$(TXT): txt/fbdoc.txt
	cp $< $@

$(TXTZIP): $(TXT)
	zip -q -9 $@ $<

################################################################################
# wakka

$(WAKKAZIP):
	cd cache && zip -q -9 ../$@ *.wakka

################################################################################

refresh:
	rm -rf cache
	mkdir cache
	cd ../fbchkdoc && ./getindex -web && ./getpage -auto -web @PageIndex.txt

clean:
	-rm -f html/*.html
	-rm -f html/fbdoc.hhc html/fbdoc.hhk html/fbdoc.hhp html/fbdoc.chm $(CHM)
	-rm -f fbhelp/*.txt fbhelp/fbhelp.dat $(FBHELP)
	-rm -f txt/*.txt $(TXT)
	-rm -f $(CHMZIP) $(FBHELPZIP) $(HTMLZIP) $(TXTZIP) $(WAKKAZIP)

.PHONY: clean
