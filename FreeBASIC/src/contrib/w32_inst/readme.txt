MAKESCRIPT
----------

makescript is a utility for generating an NSIS installer script which can
be used by makensis to create a windows setup.exe for the freebasic compiler

Usage:

    makescript [file.conf] [-manifest ...]


By default if no arguments are given, makescript will process 'replace.conf'
and any "exclude" filters given in the .conf file are respected.

If one or more '-manifest file' options are given, the specified manifest
file will be used as a filter for allowed files in the package.  Also,
specifying '-manifest' also turns on additional checks:

     - files in the manifest are checked that they physically exist
     - files added to the package are checked that they are in the manifest
       (though should never happen, since they should be filtered already)
     - files in the manifest are checked that they exist in the package

If you get a 'missing file' warning, it indicates that there is a file in
the manifest that has not been added to the package.  To solve the problem,
remove it from the manifest if it was added to the manifest in error, or
edit replace.conf or libs_list.conf to correctly select the missing file(s).

How to make
-----------

The make file 'Makefile' can be used to build both makescript and the 
installer packages.

On Win32 platforms it should find makensis.exe automatically as soon as
the environemt variable PROGRAMFILES is set correctly and NSIS was
installed to $PROGRAMFILES/NSIS.

Without modifying the Makefile, makescript.bas, and the .conf files, it's
probably best that this is only every invoked from the 
./src/contrib/w32_inst directory.

By default, ../../../manifest/win32.lst is used as the manifest to
check the installer script's file list.

Usage:

# builds all *.nsi scripts required to build the installers

    make

# builds "normal" installer

    make Setup.exe


Options:

FBC=/path/fbc
   Specify the location of the fbc compiler

MAKENSIS=/path/makensis.exe
   Specify the location of the makensis.exe

MANIFEST=/path/win32.lst
   Specify location of a manifest
