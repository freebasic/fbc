#Pull in our generated lists of headers
#so we're not copying files not needed
#on incompatible platforms.

-include includes.cmn

ifeq ($(TARGET_OS),dos)
	-include includes.dos
else
	ifeq ($(TARGET_OS),win32)
		-include includes.win
		-include includes.mod
	else
		ifeq ($(TARGET_OS),cygwin)
			-include includes.win
			-include includes.mod
		else
			ifeq ($(TARGET_OS),xbox)
				-include includes.win
				-include includes.mod
			else
				-include includes.nix
				-include includes.mod
			endif
		endif
	endif
endif
