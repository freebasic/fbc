!!!WRITEME!!! this document is not complete

Building rtlib/gfxlib2 for xbox:

- Install OpenXDK as usual (preferably from SVN if there are no recent releases).
  Apply FreeBASIC/src/contrib/openxdk/configure.in-mingw.patch if necessary.

- Replace $OPENXDK/bin/i386-pc-xbox-gcc with the one from
  FreeBASIC/src/contrib/openxdk/i386-pc-xbox-gcc - this avoids
  having to rebuild gcc while still getting the OpenXDK include and lib
  directories instead of the MinGW ones so that configure will work correctly.
  Modify this script if needed to run MinGW gcc (the current one should work in 
  MSYS) or if OpenXDK is installed somewhere else.

- !!!WRITEME!!! cp $MINGW/include/{x,y,z}.h $OPENXDK/i386-pc-xbox/include/

- Make sure $OPENXDK/bin is in $PATH
    export PATH=$PATH:/usr/local/openxdk/bin

- cd rtlib/obj/xbox && ../../configure --host=i386-pc-xbox
