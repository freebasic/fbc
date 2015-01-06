These scripts download & extract DJGPP/MinGW.org/MinGW-w64 toolchains, FB packages
for bootstrapping, fbc sources, etc., then build normal and standalone versions
of fbc, and finally create the complete packages ready to be released.
  - Downloaded archives are cached in the input/ dir
  - Output packages & manifests are put in the output/ dir
  - The scripts also download source packages
  - fbc sources are retrieved from Git; you can specify the exact commit to build,
    the default is "master"
As an exception, linux.sh relies on the host toolchain instead of downloading
any gcc toolchain.

What to do here:
  - Build FB-dos packages on Win32:
        ./dos.sh [<fbc-commit>]
  - Build FB-win32 packages (MinGW-w64 or MinGW.org) on Win32:
        ./windows.sh [win32|win32-mingworg] [<fbc-commit>]
  - Build FB-win64 packages on Win64:
        ./windows.sh [win64] [<fbc-commit>]
  - Build FB-linux-x86[_64] packages on Linux x86[_64] respectively:
        ./linux.sh [linux-x86|linux-x86_64] [<fbc-commit>]
  - Adjust download.sh if needed to switch wget/curl etc.
  - Adjust the scripts to upgrade input packages etc.

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
  - windows.sh: build NSIS installer + fbdoc CHM
  - windows.sh: package the libffi builds
  - windows.sh: build libcunit too
