# These files are needed by our configure scripts. You can use this makefile
# to update them.
# TODO: From time to time someone should make sure the URL's are still correct;
# the files should contain them ("Get the latest version from here: ...").

.PHONY: all
all: config.sub config.guess install-sh missing

# Our config.sub and onfig.guess treat xbox specially, so that we can support
# it as a target. The two files need to be patched with our xbox stuff, if the
# xbox detection support at configure time is wanted. There is a good chance
# this will have to be done manually, if the changes to the new config.sub and
# config.guess were extensive. If the patching fails, do it manually, then
# 'make' again. (Due to your edits the timestamps should have been updated and
# make should then ignore these two rules)
config.sub: config.sub.orig
	patch -o $@ < config.sub.patch

config.guess: config.guess.orig
	patch -o $@ < config.guess.patch

config.sub.orig config.guess.orig:
	wget 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=$(patsubst %.orig,%,$@);hb=HEAD' --output-document=$@ --quiet

# Where to get 'install-sh' and 'missing' from? They come with the 'libtool'
# package on Debian/Ubuntu, for example...
#install-sh:
#missing:

.PHONY: clean
clean:
	-rm -f config.sub.orig config.guess.orig

config.sub.patch: config.sub.orig config.sub
	-diff -u $^ > $@
config.guess.patch: config.guess.orig config.guess
	-diff -u $^ > $@
