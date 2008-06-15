##########################

ifeq (,$(findstring $(TARGET),dos linux win32))
$(error need TARGET=dos | linux | win32)
endif

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

ifeq ($(TARGET),win32)
SRCS += fbhelp_screen_win32.bas
else
ifeq ($(TARGET),dos)
SRCS += fbhelp_screen_dos.bas
else
SRCS += fbhelp_screen_linux.bas
endif
endif


HDRS := $(wilcard *.bi)

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

ifeq ($(TARGET),win32)
LIBS += -l fbgfx -l user32 -l gdi32
else
ifeq ($(TARGET),linux)
LIBS += -l fbgfx -p /usr/X11R6/lib -l X11 -l Xpm -l Xext -l Xrandr -l Xrender
else
ifeq ($(TARGET),dos)
LIBS += -l fbgfx -l c
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

ifeq ($(TARGET),dos)
	FBCFLAGS := -arch 386
else
	FBCFLAGS :=
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

$(objpath)/%.o : %.bas  $(HDRS)
	$(FBC) $(FBCFLAGS) -m $(MAIN) -c $< -o $@

##########################

all: $(APP)

$(APP): $(OBJS)
	$(FBC) $(FBCFLAGS) $(OBJS) $(LIBS) $(RCS) -x $(APP)

.PHONY : clean
clean:
	-rm -f $(OBJS) $(APP)
