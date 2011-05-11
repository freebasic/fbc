
    FreeBASIC - A multi-platform BASIC Compiler
    Copyright (C) 2004-2011 The FreeBASIC development team.

    Official site:      http://www.freebasic.net/
    Forum:              http://www.freebasic.net/forum/
    Wiki:               http://www.freebasic.net/wiki/
    fbc project page:   http://www.sourceforge.net/projects/fbc/
    IRC channel:        ##freebasic at freenode.net

  o License

    The FreeBASIC compiler (fbc) is licensed under the GPLv2, see
    fbc/license.txt for details.

    The FreeBASIC runtime (libfb) is licensed under the LGPLv2 with an
    exception, see libfb/license.txt for details.

  o Installing

    The fbc project provides a .zip package and an installer for Windows,
    a .tar.gz package for Linux, and a .zip package for DOS. 

    The packages can be unpacked anywhere, and fbc can be used from there.

    On Windows and DOS, it can be very useful to add the FreeBASIC\bin\
    directory to the PATH environment variable, so it's enough to simply type
    "fbc" in a console and fbc.exe will be found.

    On Linux, programs are typically installed into /usr or /usr/local. The
    Linux fbc package comes with an install.sh script that will copy fbc into
    /usr/local. It can be used like this (you may need root/superuser rights
    for this):
        For installing:
            $ ./install.sh -i
        For uninstalling:
            $ ./install.sh -u
    Note: FreeBASIC may be included in the official package repositories of
    some distributions, in which cases it is enough to install it via the
    corresponding package manager. Then there is no need for an install.sh
    script.

  o Running

    fbc is a command-line compiler; it does not have a graphical editor.

    Open a console and enter "fbc" to see a list of options. If "fbc" cannot
    be found, you may need to specify the full path to fbc.exe instead, or
    make sure that the directory containing fbc.exe is listed in the PATH
    environment variable.

    To compile a "Hello, world!" program, create a text file called "hello.bas"
    with this content:
            print "Hello, world!"
            sleep
    Then open a console and go to the directory where you created the hello.bas
    file:
            cd path/to/hello.bas/file
    Now compile the hello.bas file into a program executable by entering:
            fbc hello.bas
    This will create the "hello" executable file (named "hello.exe" on Windows
    and DOS).

  o Credits

    Project members:
    - Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
    - Angelo Mottola (a.mottola[at]libero.it)
    - Bryan Stoeberl (b_stoeberl[at]yahoo.com)
    - Daniel R. Verkamp (i_am_drv[at]yahoo.com)
    - Jeff Marshall (coder[at]execulink.com)
    - Mark Junker (mjscod[at]gmx.de)
    - Matthew Fearnley (counting.pine[at]virgin.net)
    - Ruben Rodriguez (rubentbstk[at]gmail.com)
    - Simon Nash

    Contributors:
    - Abdullah Ali (voodooattack[at]hotmail.com)
    - Claudio Tinivella (tinycla[at]yahoo.it)
    - Chris Davies (c.g.davies[at]gmail.com)
    - Dumbledore
    - dr0p (dr0p[at]perfectbg.com)
    - Edmond Leung (leung.edmond[at]gmail.com)
    - Eric Lope (vic_viperph[at]yahoo.com)
    - Florent Heyworth (florent.heyworth[at]swissonline.ch)
    - fsw (fsw.fb[at]comcast.net)
    - Garvan O'Keeffe (sisophon2001[at]yahoo.com)
    - Hans L. Nemeschkal (Hans.Leo.Nemeschkal[at]univie.ac.at)
    - Jofers (spam[at]betterwebber.com)
    - Jose Manuel Postigo (postigo[at]uma.es)
    - Laanan Fisher (laananfisher[at]gmail.com)
    - Matthias Faust (matthias_faust[at]web.de)
    - Marzec
    - Nek (dave[at]nodtveidt.net)
    - plasma
    - Randy Keeling (randy[at]keeling.com)
    - Sterling Christensen (sterling[at]engineer.com)
    - Steven Hidy (subxero[at]phatcode.net)
    - zydon
    and many others.

    Included/used third-party tools:
    - GNU binutils (http://www.gnu.org/software/binutils/)
    - DJGPP (http://www.delorie.com/)
    - MinGW (http://www.mingw.org/)
    - GoRC (http://www.godevtool.com/)
    - OpenXDK (http://www.openxdk.org/)

  o Greetings
    - Plasma: Owner of the freebasic.net domain and main site hoster,
      many thanks to him.
    - VonGodric: Author of the first FreeBASIC IDE: FBIDE.
    - Everybody that helped writing the documentation (and in special Nexinarus 
      who started it), more details at:
        http://www.freebasic.net/wiki/wikka.php?wakka=ContributorList
    - All users that reported bugs, requested features and as such helped 
      improving the compiler, language and run-time library somehow.

--------------------------------------------------------------------------------

Compiling FreeBASIC and installing the result:

    Generally, this should work:
        $ ./configure
        $ make
        $ make install

    It can be useful to build outside the source directory. Assuming the FB
    sources are in a directory called "freebasic", this can be done like this:
        $ ls freebasic
        $ mkdir freebasic-build
        $ cd freebasic-build
        $ ../freebasic/configure
        $ make
        $ make install

  o Requirements
    - A working fbc
    - A working gcc
    - libbfd (from binutils)

    When targetting Windows:
        - A MinGW toolchain
        - DirectX headers (only for libfb graphics, see --disable-gfx)

    When targetting DOS:
        - A DJGPP toolchain

    When targetting Linux:
        - X11 headers (only for libfb graphics, see --disable-gfx)
        - ncurses headers
        - gpm (general purpose mouse) headers
        - GL headers (typically from freeglut)


  o libbfd related tips
    fbc uses libbfd to add and read out extra information from object files.
    It's an optional but convenient feature. (see --disable-objinfo)
    Read more here:
        http://www.freebasic.net/wiki/wikka.php?wakka=DevObjinfo

    For the releases made by the fbc project, fbc is linked against a static
    libbfd 2.17,
        a) to avoid dependencies on a shared libbfd, because many Linux
           distributions have different versions of it, and
        b) to avoid licensing conflicts between fbc (GPLv2) and libbfd > 2.17
           (GPLv3).

  o XBox/OpenXDK-related tips
    Note: this hasn't been tested in a long time, please provide feedback!

    - Install OpenXDK as usual (preferably from SVN if there are no recent
      releases). Apply openxdk/configure.in-mingw.patch if necessary.

    - Replace $OPENXDK/bin/i386-pc-xbox-gcc with the one from
      openxdk/i386-pc-xbox-gcc - this avoids having to rebuild gcc while still
      getting the OpenXDK include and lib directories instead of the MinGW ones
      so that configure will work correctly. Modify this script if needed to
      run MinGW gcc (the current one should work in MSYS) or if OpenXDK is
      installed somewhere else.

    - !!!WRITEME!!! cp $MINGW/include/{x,y,z}.h $OPENXDK/i386-pc-xbox/include/

    - Make sure $OPENXDK/bin is in $PATH
        export PATH=$PATH:/usr/local/openxdk/bin

    - Build for or enable the "i386-pc-xbox" target.
      (FB's config/config.guess and config/config.sub are modified to recognize
      and return xbox as OS, so that the fbc/libfb builds know what to do.)
