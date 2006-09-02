# Makefile
# This file is part of the FreeBASIC test suite
#
# main entry point for making the FreeBASIC tests
#

include common.mk

ifeq ($(HOST),dos)
SHELL = /bin/sh
else
SHELL := $(SHELL)
endif

FIND := find
XARGS := xargs
GREP := grep
SED := sed
ECHO := echo

ifndef FBC
FBC := fbc$(EXEEXT)
endif

# ------------------------------------------------------------------------

CUNITTESTS_MAKEFILE := cunit-tests.mk
LOGTESTS_MAKEFILE := log-tests.mk


# ------------------------------------------------------------------------
.PHONY all :
all : 

	@$(ECHO) -e "usage: make target [options]"
	@$(ECHO) -e ""
	@$(ECHO) -e "Targets: (using cunit):"
	@$(ECHO) -e "   cunit-tests"
	@$(ECHO) -e "   log-tests"
	@$(ECHO) -e "   failed-tests"
	@$(ECHO) -e "   check"
	@$(ECHO) -e "   mostlyclean"
	@$(ECHO) -e "   clean"
	@$(ECHO) -e ""
	@$(ECHO) -e "Targets: (bypassing cunit)"
	@$(ECHO) -e "   log-tests ALLOW_CUNIT=1"
	@$(ECHO) -e "   failed-tests ALLOW_CUNIT=1"
	@$(ECHO) -e "   mostlyclean ALLOW_CUNIT=1"
	@$(ECHO) -e "   clean ALLOW_CUNIT=1"
	@$(ECHO) -e ""
	@$(ECHO) -e "Options:"
	@$(ECHO) -e "   FBC=/path/fbc"
	@$(ECHO) -e ""
	@$(ECHO) -e "Targets: Configuration and Checks"
	@$(ECHO) -e "   check"
	@$(ECHO) -e ""

# ------------------------------------------------------------------------
# Sanity checks
# these tests do not generate and files, only output to the screen
#
.PHONY: check
check :
# ------------------------------------------------------------------------
	@$(ECHO) -e "Checking that fb compiler $(FBC) exists: \c"
	@-if $(FBC) -version > /dev/null 2>&1 \
	; then \
		$(ECHO) -e "OK" && \
		true \
	; else \
		$(ECHO) -e "Failed" && \
		false \
	; fi
# ------------------------------------------------------------------------
	@$(ECHO) -e "Checking that $(FBC) working: \c"
	@$(ECHO) -e "end 0" > fbcworks.bas
	@-if $(FBC) fbcworks.bas > /dev/null 2>&1 \
	; then \
		$(ECHO) -e "OK" && \
		$(RM) -f fbcworks.bas && \
		true \
	; else \
		$(ECHO) -e "Failed" && \
		$(RM) -f fbcworks.bas && \
		$(RM) -f fbcworks.exe && \
		false \
	; fi
# ------------------------------------------------------------------------
	@$(ECHO) -e "Checking that compiled program executes: \c"
	@-if ./fbcworks$(EXEEXT) > /dev/null 2>&1 \
	; then \
		$(ECHO) -e "OK" && \
		$(RM) -f fbcworks$(EXEEXT) && \
		true \
	; else \
		$(ECHO) -e "Failed" && \
		$(RM) -f fbcworks$(EXEEXT) && \
		false \
	; fi


# ------------------------------------------------------------------------
# make cunit compatible tests
#
.PHONY: cunit-tests
cunit-tests :
	$(MAKE) -f $(CUNITTESTS_MAKEFILE) fail=1 basic=1

# ------------------------------------------------------------------------
# make log-test compatible tests
#
.PHONY: log-tests
log-tests :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) tests
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results

.PHONY: failed-tests
failed-tests :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FAILED_ONLY=1
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) tests FAILED_ONLY=1
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results

.PHONY: failed-results
failed-results :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results

# ------------------------------------------------------------------------
# clean-up
#
.PHONY: mostlyclean
mostlyclean :
	cd . && $(MAKE) -f $(CUNITTESTS_MAKEFILE) mostlyclean
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean

.PHONY: clean
clean :
	cd . && $(MAKE) -f $(CUNITTESTS_MAKEFILE) clean
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) clean
