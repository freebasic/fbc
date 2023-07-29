# common.mk
# This file is part of the FreeBASIC test suite
#
# Guess HOST and TARGET_OS if not already set;
# it would far cleaner and robust to reuse the detection code in root makefile,
# but we our requirements here are much simpler.
# HOST takes possible values dos|unix|win32, TARGET_OS may be dos|unix|win32|js.
# OS has possible values DOS and Windows_NT.
# 

HOST :=
ifeq ($(OS),DOS)
	HOST := dos
else
	ifeq ($(OS),Windows_NT)
		HOST := win32
	else
		ifdef WINDIR
			HOST := win32
		else
			ifdef windir
				HOST := win32
			else
				ifdef HOME
					HOST := unix
				endif
			endif
		endif
	endif
endif

ifndef TARGET_OS
	triplet := $(subst -, ,$(TARGET))
	ifdef TARGET
		ifneq ($(filter djgpp%,$(triplet)),)
			TARGET_OS := dos
		else ifneq ($(filter msdos%,$(triplet)),)
			TARGET_OS := dos
		else ifneq ($(filter mingw%,$(triplet)),)
			TARGET_OS := win32
		else ifneq ($(filter emscripten%,$(triplet)),)
			TARGET_OS := js
		else ifneq ($(filter js%,$(triplet)),)
			TARGET_OS := js
		else
			TARGET_OS := unix
		endif
	else
		ifndef HOST
			CHECKHOST_MSG := $(error error: TARGET_OS not defined and HOST couldn't be guessed)
		else
			CHECKHOST_MSG :=
		endif
		TARGET_OS := $(HOST)
	endif
endif

# set default command names
# 

ifeq ($(HOST),unix)
    EXEEXT :=
else
    EXEEXT := .exe
endif
ifeq ($(TARGET_OS),unix)
    TARGET_EXEEXT :=
else ifeq ($(TARGET_OS),js)
    ifeq ($(NODEJS),)
       TARGET_EXEEXT := .html
    else
       TARGET_EXEEXT := .js
    endif
else
    TARGET_EXEEXT := .exe
endif
