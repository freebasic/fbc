#!/bin/sh
_defpath_=lib/win32/def

#
# create the import-libraries
#

if [ ! -f $_defpath_/genimplibs.exe ]; then
	echo "ERROR: $_defpath_/genimplibs.exe not found."
        exit 1
fi 

if ! $_defpath_/genimplibs.exe -p cygwin ; then
	echo "ERROR: Execution of $_defpath_/genimplibs.exe failed."
        exit 1
fi

echo "Installation completed."
exit 0
