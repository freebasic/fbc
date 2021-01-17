#!/usr/bin/make -f
#
# commands:
#    <none>|all TARGET=win32|dos|linux 
#                     build fbhelp application for the TARGET
#
#    srcdist          build source packages .zip & .tar.gz
#    bindist          build binary package for TARGET
#
#    clean            delete built files
#    clean-dist       delete packages
#
# makfile configuration:
#
#    TARGET=win32|dos|linux 
#                     choose target to build for (required)
#    GFX=1            build the fbgfx version instead of the console version
#                       and fbhelp will run in a graphics window
#    FBC              path/name of fbc compiler to use
#    FBCFLAGS         extra options to pass to FBC
#    FBHELPPACKAGE    name of the package to build, not including the suffixes
#    WITHMANUAL=1     include the manual with the binary distribution
#
##########################

ifeq (,$(findstring $(TARGET),dos linux win32))
$(error need TARGET=dos | linux | win32)
endif

# get FBHELPVERSION from the file
include version.mk

MAIN := fbhelp

SRCS := $(MAIN).bas 
SRCS += fbhelp_form_help.bas
SRCS += fbhelp_form_msgbox.bas
SRCS += fbhelp_form_inputbox.bas
SRCS += fbhelp_linebuffer.bas
SRCS += fbhelp_textbuffer.bas
SRCS += fbhelp_screen.bas
SRCS += fbhelp_file.bas
SRCS += fbhelp_controls.bas
SRCS += fbhelp_controls_frame.bas
SRCS += fbhelp_controls_scrollbar.bas
SRCS += fbhelp_controls_helpbox.bas
SRCS += fbhelp_controls_static.bas
SRCS += fbhelp_controls_button.bas
SRCS += fbhelp_controls_editbox.bas
SRCS += common.bas

HDRS := $(wildcard *.bi)

ifeq ($(TARGET),win32)
  ifndef GFX
    SRCS += fbhelp_screen_win32.bas
  else
    SRCS += fbhelp_screen_gfx.bas
  endif
else
  ifeq ($(TARGET),dos)
    ifndef GFX
      SRCS += fbhelp_screen_dos.bas
    else
      SRCS += fbhelp_screen_gfx.bas
    endif
  else
    ifndef GFX
      SRCS += fbhelp_screen_linux.bas
    else
      SRCS += fbhelp_screen_gfx.bas
    endif
  endif
endif

FBHELPPACKAGE := fbhelp-$(FBHELPVERSION)

ifneq ($(WITHMANUAL),1)
  fbhelpmanual := 
else
  fbhelpmanual := fbhelp.daz
endif

packsrc := $(FBHELPPACKAGE)-src
packbin := $(FBHELPPACKAGE)-$(TARGET)

ifndef objpath
objpath=obj/$(TARGET)
endif

OBJS := $(patsubst %.bas,$(objpath)/%.o,$(SRCS))

ifneq ($(LIBDIR),)
LIBS := -p $(LIBDIR)/$(TARGET)
else
LIBS :=
endif

LIBS += -l z

FBCFLAGS :=

ifeq ($(TARGET),win32)
  ifdef GFX
    FBCFLAGS := -s gui
  endif
  #LIBS += -l fbgfx -l user32 -l gdi32
else
  ifeq ($(TARGET),linux)
    #LIBS += -l fbgfx -p /usr/X11R6/lib -l X11 -l Xpm -l Xext -l Xrandr -l Xrender
  else
    ifeq ($(TARGET),dos)
	  FBCFLAGS := -arch 386
      #LIBS += -l fbgfx -l c
    endif
  endif
endif

RCS  := 

##########################

ifndef FBC
	ifeq ($(TARGET),win32)
		FBC = fbc.exe
	else
		ifeq ($(TARGET),dos)
			FBC = fbc_dos.exe
		else
			FBC = fbc
		endif
	endif
endif

FBCFLAGS += -w pedantic

ifdef DEBUG
FBCFLAGS += -g
endif

ifeq ($(TARGET),win32)
APP := $(MAIN)w.exe
else
ifeq ($(TARGET),dos)
APP := $(MAIN).exe
else
APP := $(MAIN)
endif
endif

.SUFFIXES:
.SUFFIXES: .bas

VPATH = .

$(objpath)/%.o : %.bas $(HDRS) | $(objpath)
	$(FBC) $(FBCFLAGS) -m $(MAIN) -c $< -o $@

##########################

all: $(APP)

$(objpath):
	mkdir -p $@

$(APP): $(OBJS) $(HDRS)
	$(FBC) $(FBCFLAGS) $(OBJS) $(LIBS) $(RCS) -x $(APP)

.PHONY : clean
clean:
	-rm -f $(objpath)/*.o $(APP)

.PHONY : srcdist
srcdist:
	mkdir -p $(packsrc)
	cp *.bas *.bi fbhelp.txt changelog.txt gpl.txt makefile version.mk $(packsrc)
	dos2unix $(packsrc)/*
	tar -czf "$(packsrc).tar.gz" "$(packsrc)"
	unix2dos $(packsrc)/*
	zip -q -r "$(packsrc).zip" "$(packsrc)"
	rm -rf "$(packsrc)"

.PHONY : bindist
bindist: all
	mkdir -p $(packbin)
	cp $(APP) fbhelp.txt $(fbhelpmanual) $(packbin)
ifeq ($(TARGET),linux)
	dos2unix $(packbin)/fbhelp.txt
	rm -f "$(packbin).tar.gz"
	tar -czf "$(packbin).tar.gz" "$(packbin)"
else
	unix2dos $(packbin)/fbhelp.txt
	rm -f "$(packbin).zip"
	zip -q -r "$(packbin).zip" "$(packbin)"
endif
	rm -rf "$(packbin)"

.PHONY : dist-clean
dist-clean:
	rm -f "$(packsrc).zip"
	rm -f "$(packsrc).tar.gz"
	rm -f "$(packbin).zip"
	rm -f "$(packbin).tar.gz"
