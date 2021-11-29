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
PRINTF := printf

ifndef FBC
FBC := fbc$(EXEEXT)
endif
export FBC

ENABLE_CHECK_BUGS :=
export ENABLE_CHECK_BUGS

ENABLE_CONSOLE_OUTPUT :=
export ENABLE_CONSOLE_OUTPUT

UNITTEST_RUN_ARGS :=
export UNITTEST_RUN_ARGS

# verify the FB_LANG option
#
ifneq ($(FB_LANG),)
ifneq ($(FB_LANG),fb)
ifneq ($(FB_LANG),fblite)
ifneq ($(FB_LANG),qb)
ifneq ($(FB_LANG),deprecated)
$(error Unsupported language option -lang $(FB_LANG))
endif
endif
endif
endif
endif

# build sub-targets based on FB_LANG option
#
ifeq ($(FB_LANG),)
REQ_MOSTLYCLEAN := mostlyclean-unit mostlyclean-fb mostlyclean-fblite mostlyclean-qb mostlyclean-deprecated
REQ_CLEAN := clean-unit clean-fb clean-fblite clean-qb clean-deprecated
REQ_TESTS := log-tests-fb log-tests-fblite log-tests-qb log-tests-deprecated
REQ_FAILED := failed-tests-fb failed-tests-fblite failed-tests-qb failed-tests-deprecated
else
REQ_MOSTLYCLEAN := mostlyclean-unit mostlyclean-$(FB_LANG)
REQ_CLEAN := clean-unit clean-$(FB_LANG)
REQ_TESTS := log-tests-$(FB_LANG)
REQ_FAILED := failed-tests-$(FB_LANG)
endif

# ------------------------------------------------------------------------

UNITTESTS_MAKEFILE := unit-tests.mk
LOGTESTS_MAKEFILE := log-tests.mk


# ------------------------------------------------------------------------
.PHONY all :
all : 

	@$(ECHO) "usage: make target [options]"
	@$(ECHO) ""
	@$(ECHO) "Targets:"
	@$(ECHO) "   unit-tests"
	@$(ECHO) "   log-tests"
	@$(ECHO) "   failed-tests"
	@$(ECHO) "   check"
	@$(ECHO) "   mostlyclean"
	@$(ECHO) "   clean"
	@$(ECHO) ""
	@$(ECHO) "Options:"
	@$(ECHO) "   FBC=/path/fbc"
	@$(ECHO) "   FB_LANG=fb | fblite | qb | deprecated"
	@$(ECHO) "   DEBUG=1"
	@$(ECHO) "   EXTRAERR=1"
	@$(ECHO) "   TARGET=target"
	@$(ECHO) "   ARCH=arch (default is 486)"
	@$(ECHO) "   OS=DOS"
	@$(ECHO) "   FPU=fpu | sse"
	@$(ECHO) "   FPMODE=fast | precise"
	@$(ECHO) "   GEN=gas | gcc"
	@$(ECHO) "   UNITTEST_RUN_ARGS=args"
	@$(ECHO) "   ENABLE_CHECK_BUGS=1"
	@$(ECHO) "   ENABLE_CONSOLE_OUTPUT=1"
	@$(ECHO) ""
	@$(ECHO) "Targets: Configuration and Checks"
	@$(ECHO) "   check"
	@$(ECHO) ""
	@$(ECHO) "Example: make all available tests"
	@$(ECHO) "   make unit-tests"
	@$(ECHO) "   make log-tests"
	@$(ECHO) ""
	@$(ECHO) "Example: make the -lang qb tests"
	@$(ECHO) "   make log-tests FB_LANG=qb"
	@$(ECHO) ""

# ------------------------------------------------------------------------
# Sanity checks
# these tests do not generate any files, only output to the screen
#
.PHONY: check
check :
# ------------------------------------------------------------------------
	@$(PRINTF) "Checking that fb compiler $(FBC) exists: "
	@-if $(FBC) -version > /dev/null 2>&1 \
	; then \
		$(ECHO) "OK" && \
		true \
	; else \
		$(ECHO) "Failed" && \
		false \
	; fi
# ------------------------------------------------------------------------
	@$(PRINTF) "Checking that $(FBC) working: "
	@$(ECHO) "end 0" > fbcworks.bas
	@-if $(FBC) fbcworks.bas > /dev/null 2>&1 \
	; then \
		$(ECHO) "OK" && \
		$(RM) -f fbcworks.bas && \
		true \
	; else \
		$(ECHO) "Failed" && \
		$(RM) -f fbcworks.bas && \
		$(RM) -f fbcworks.exe && \
		false \
	; fi
# ------------------------------------------------------------------------
	@$(PRINTF) "Checking that compiled program executes: "
	@-if ./fbcworks$(EXEEXT) > /dev/null 2>&1 \
	; then \
		$(ECHO) "OK" && \
		$(RM) -f fbcworks$(EXEEXT) && \
		true \
	; else \
		$(ECHO) "Failed" && \
		$(RM) -f fbcworks$(EXEEXT) && \
		false \
	; fi


# ------------------------------------------------------------------------
# make fbcunit compatible tests
#
.PHONY: unit-tests
unit-tests :
	$(MAKE) -f $(UNITTESTS_MAKEFILE)

# !!! DEPRECATED TARGET !!! -- callers should use 'unit-tests'
.PHONY: cunit-tests
cunit-tests : unit-tests


# ------------------------------------------------------------------------
# make log-test compatible tests
#
.PHONY: log-tests
log-tests : $(REQ_TESTS)

.PHONY: log-tests-fb
log-tests-fb :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FB_LANG=fb
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) all FB_LANG=fb
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results FB_LANG=fb

.PHONY: log-tests-fblite
log-tests-fblite :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FB_LANG=fblite
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) all FB_LANG=fblite
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results FB_LANG=fblite

.PHONY: log-tests-qb
log-tests-qb :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FB_LANG=qb
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) all FB_LANG=qb
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results FB_LANG=qb

.PHONY: log-tests-deprecated
log-tests-deprecated :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FB_LANG=deprecated
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) all FB_LANG=deprecated
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results FB_LANG=deprecated

.PHONY: failed-tests
failed-tests : $(REQ_FAILED)

.PHONY: failed-tests-fb
failed-tests-fb :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FAILED_ONLY=1 FB_LANG=fb
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) all FAILED_ONLY=1 FB_LANG=fb
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results FB_LANG=fb

.PHONY: failed-tests-fblite
failed-tests-fblite :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FAILED_ONLY=1 FB_LANG=fblite
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) all FAILED_ONLY=1 FB_LANG=fblite
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results FB_LANG=fblite

.PHONY: failed-tests-qb
failed-tests-qb :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FAILED_ONLY=1 FB_LANG=qb
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) all FAILED_ONLY=1 FB_LANG=qb
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results FB_LANG=qb

.PHONY: failed-tests-deprecated
failed-tests-deprecated :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FAILED_ONLY=1 FB_LANG=deprecated
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) all FAILED_ONLY=1 FB_LANG=deprecated
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) results FB_LANG=deprecated

# ------------------------------------------------------------------------
# clean-up
#
.PHONY: mostlyclean
mostlyclean : $(REQ_MOSTLYCLEAN)

.PHONY: mostlyclean-unit
mostlyclean-unit :
	cd . && $(MAKE) -f $(UNITTESTS_MAKEFILE) mostlyclean

.PHONY: mostlyclean-fb
mostlyclean-fb :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FB_LANG=fb

.PHONY: mostlyclean-fblite
mostlyclean-fblite :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FB_LANG=fblite

.PHONY: mostlyclean-qb
mostlyclean-qb :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FB_LANG=qb

.PHONY: mostlyclean-deprecated
mostlyclean-deprecated :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) mostlyclean FB_LANG=deprecated


.PHONY:  clean
 clean : $(REQ_CLEAN)

.PHONY: clean-unit
clean-unit :
	cd . && $(MAKE) -f $(UNITTESTS_MAKEFILE) clean

.PHONY: clean-fb
clean-fb :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) clean FB_LANG=fb

.PHONY: clean-fblite
clean-fblite :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) clean FB_LANG=fblite

.PHONY: clean-qb
clean-qb :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) clean FB_LANG=qb

.PHONY: clean-deprecated
clean-deprecated :
	cd . && $(MAKE) -f $(LOGTESTS_MAKEFILE) clean FB_LANG=deprecated
