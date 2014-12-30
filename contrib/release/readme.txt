These scripts download & extract DJGPP/MinGW.org/MinGW-w64 toolchains, FB packages
for bootstrapping, fbc sources, etc., then build normal and standalone versions
of fbc, and finally create the complete packages ready to be released.
  - Downloaded archives are cached in the input/ dir
  - Output packages & manifests are put in the output/ dir
  - The scripts also download source packages

What to do here:
  - Run ./dos.sh on Win32 to build FB-dos packages
  - Run ./win32.sh [mingww64|mingworg] on Win32 to build FB-win32 packages (MinGW-w64 or MinGW.org)
  - Adjust download.sh if needed to switch wget/curl etc.
  - Adjust dos.sh/win32.sh to upgrade input packages etc.

Requirements:
  - MSYS environment on Windows with: bash, wget/curl, zip, unzip, patch, make, findutils
    (win32/win64 builds need to be able to run ./configure scripts, to build libffi)
  - 7z (7-zip) in the PATH (win32/win64)
  - makensis (NSIS) in the PATH (FB-win32 installer)

Some of the ideas behind these scripts:
  - Automating the build process for FB releases => less room for mistakes
  - Starting from scratch everytime => clean builds
  - Specifying the exact DJGPP/MinGW packages to use => reproducible builds
  - Only work locally, e.g. don't touch existing DJGPP/MinGW setups on the host

TODO:
  - win32.sh: build NSIS installer + fbdoc CHM
  - win32.sh: package the libffi builds
  - win32.sh: build libcunit too
  - Add win64.sh, or share code with win32.sh?
  - Add linux.sh, but rely on host gcc toolchain
