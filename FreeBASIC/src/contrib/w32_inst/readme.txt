Usage:

# builds all *.nsi scripts required to build the installers
make

# builds "normal" installer
make Setup.exe

# builds installer that contains pre-built libraries
make SetupLibs.exe

# builds installer that contains pre-built libraries and the sources
make SetupLibsSources.exe

# builds installer that contains the sources
make SetupSources.exe

On Win32 platforms it should find makensis.exe automatically as soon as
the environemt variable PROGRAMFILES is set correctly and NSIS was
installed to $PROGRAMFILES/NSIS.

2005-10-28, mjs
