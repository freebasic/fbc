# common.mk
# This file is part of the FreeBASIC test suite
#
# Guess HOST and TARGET_OS if not already set
# HOST and TARGET_OS both take possible values dos|unix|win32
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
	ifndef HOST
		CHECKHOST_MSG := $(error error: TARGET_OS not defined and HOST couldn't be guessed)
	else
		CHECKHOST_MSG :=
	endif
	TARGET_OS := $(HOST)
endif

# set default command names
# 

ifeq ($(TARGET_OS),unix)
    EXEEXT :=
else
    EXEEXT := .exe
endif
