
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
			HOST := linux
		endif
       		endif
   		endif
	endif
endif

ifndef TARGET
	ifndef HOST
		CHECKHOST_MSG := $(error error: TARGET not defined and HOST couldn't be guessed)
	else
		CHECKHOST_MSG :=
	endif
	TARGET := $(HOST)
endif

ifeq ($(TARGET),linux)
    EXEEXT :=
else
    EXEEXT := .exe
endif
