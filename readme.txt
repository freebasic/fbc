
    FreeBASIC - A multi-platform BASIC Compiler
    Copyright (C) 2004-2023 The FreeBASIC development team.

    Official site:      https://freebasic.net/
    Forum:              https://freebasic.net/forum/
    Online manual:      https://freebasic.net/wiki/DocToc
    fbc project page:   https://sourceforge.net/projects/fbc/
    GitHub mirror:      https://github.com/freebasic/fbc
    Discord:            https://discord.gg/286rSdK
    IRC channel:        ##freebasic at https://webchat.freenode.net
    Features:           https://freebasic.net/wiki/CompilerFeatures
    Requirements:       https://freebasic.net/wiki/CompilerRequirements

    FreeBASIC consists of fbc (the command line compiler), the runtime libraries
    (libfb and libfbgfx), and FreeBASIC header files for third-party libraries.
    In order to produce executables, fbc uses the GNU binutils (assembler,
    linker). When compiling for architectures other than 32bit, fbc depends
    on gcc to generate assembly.

    Documentation of language features, compiler options and many other details
    is available in the FB manual. For help & support, visit the FB forum!

  o Installation & Usage

    FreeBASIC gives you the FreeBASIC compiler program (fbc or fbc.exe),
    plus the tools and libraries used by it. fbc is a command line program
    that takes FreeBASIC source code files (*.bas) and compiles them into
    executables.  In the combined standalone packages for windows, the main
    executable is named fbc32.exe (for 32-bit) and fbc64.exe (for 64-bit)

    fbc is typically invoked by Integrated Development Environments (IDEs) or
    text editors, from a terminal or command prompt, or through build-systems
    such as makefiles. fbc itself is not a graphical code editor or IDE!

    Win32 (similar for Win64):
      Combined 32-bit and 64-bit standalone packages:
        Download and extract latest:
           - FreeBASIC-x.xx.x-winlibs-gcc-9.3.0.7z or
           - FreeBASIC-x.xx.x-gcc-5.2.0.7z
           - fbc32.exe and fbc64.exe are used instead of fbc.exe
      Separate 32-bit and 64-bit standalone packages (based on winlibs-gcc-9.3.0):
        Download and extract latest:
           - FreeBASIC-x.xx.x-win32.zip or FreeBASIC-x.xx.x-win32.7z for 32-bit
           - FreeBASIC-x.xx.x-win64.zip or FreeBASIC-x.xx.x-win64.7z for 64-bit

      Now you can use fbc.exe from the installation directory to compile FB
      programs (*.bas files) into executables (*.exe files). Open a command
      prompt (cmd.exe) and run fbc.exe from there, for example:
        1. In the opened command prompt, type in the following command and
           press ENTER:
             > fbc.exe examples\hello.bas
        2. This should have created examples\hello.exe in the FreeBASIC
           installation directory. You can run it by entering:
             > examples\hello.exe

      A FreeBASIC-x.xx.x-win32.exe installer is also available but should
      only be installed on win32 platforms.
        1. Click Start -> FreeBASIC -> Open console (installer only)
        2. In the opened command prompt, type in the following command and
           press ENTER:
             > fbc.exe examples\hello.bas
        3. This should have created examples\hello.exe in the FreeBASIC
           installation directory. You can run it by entering:
             > examples\hello.exe

      Optionally, you can install a text editor or IDE which will invoke fbc.exe
      for you, for example:
        WinFBE         https://github.com/PaulSquires/WinFBE
        VisualFBEditor https://github.com/XusinboyBekchanov/VisualFBEditor/releases
       Or even though is older and unmaintained will work:
        FBIDE:         https://fbide.freebasic.net/

    Linux (if FreeBASIC is not available through your package manager):
      Download and extract the latest FreeBASIC-x.xx.x-linux.tar.gz. Open a
      terminal and cd into the extracted FreeBASIC-x.xx.x-linux directory, and
      run "sudo ./install.sh -i" to copy the FB setup into /usr/local.
      To compile FB programs, please install the following packages (names may
      vary depending on your Linux distribution):
        Debian/Ubuntu:
          gcc libncurses5-dev libffi-dev libgl1-mesa-dev
          libx11-dev libxext-dev libxrender-dev libxrandr-dev libxpm-dev
          libtinfo5 libgpm-dev
        Fedora:
          gcc ncurses-devel ncurses-compat-libs libffi-devel mesa-libGL-devel
          libX11-devel libXext-devel libXrender-devel libXrandr-devel
          libXpm-devel
      If you want to use the 32bit version of FB on a 64bit system, it is
      necessary to have the gcc 32bit multilib support and 32bit versions
      of the libraries installed.
        Debian/Ubuntu:
          gcc-multilib lib32ncurses5-dev libx11-dev:i386 libxext-dev:i386
          libxrender-dev:i386 libxrandr-dev:i386 libxpm-dev:i386 libtinfo5:i386

      Now you can use fbc to compile FB programs (*.bas files) into executables.
      For example:
        $ cd FreeBASIC-x.xx.x-linux/examples
        $ fbc hello.bas
      This should have created the hello program. You can run it by entering:
        $ ./hello

      Optionally, you can install a text editor or IDE which will invoke fbc for
      your, for example:
        Geany: https://geany.org (sudo apt-get install geany)

    DOS:
      Download and extract the latest FreeBASIC-x.xx.x-dos.zip.

      Now you can use fbc.exe from the installation directory to compile FB
      programs (*.bas files) into executables (*.exe files). For example:
        > fbc.exe examples\hello.bas
      This should have created examples\hello.exe. You can run it by entering:
        > examples\hello.exe

  o Licensing

    The FreeBASIC compiler (fbc) is licensed under the GNU GPLv2 or later.

    The FreeBASIC runtime library (libfb and the thread-safe version, libfbmt)
    and the FreeBASIC graphics library (libfbgfx and the thread-safe version,
    libfbgfxmt) are licensed under the GNU LGPLv2 or later, with this exception
    to allow linking to it statically:
        As a special exception, the copyright holders of this library give
        you permission to link this library with independent modules to
        produce an executable, regardless of the license terms of these
        independent modules, and to copy and distribute the resulting
        executable under terms of your choice, provided that you also meet,
        for each linked independent module, the terms and conditions of the
        license of that module. An independent module is a module which is
        not derived from or based on this library. If you modify this library,
        you may extend this exception to your version of the library, but
        you are not obligated to do so. If you do not wish to do so, delete
        this exception statement from your version.

    The FreeBASIC documentation is licensed under the GNU FDL.

    Dependencies on third-party libraries:

    The FreeBASIC runtime library uses LibFFI to implement the Threadcall
    functionality. This means that, by default, FreeBASIC programs will be
    linked against LibFFI when using Threadcall. LibFFI is released under
    the MIT/Expat license, see doc/libffi-license.txt.

    By default, FreeBASIC programs are linked against various system and/or
    support libraries, depending on the platform. Those include the DJGPP
    libraries used by FreeBASIC for DOS and the MinGW/GCC libraries used by
    FreeBASIC for Windows.

  o Included/used third-party tools and libraries:

    - DJGPP         http://www.delorie.com/
    - GCC           https://gcc.gnu.org/
    - GNU binutils  https://gnu.org/software/binutils/
    - GNU debugger  https://gnu.org/software/gdb/
    - GoRC          http://godevtool.com/
    - LibFFI        https://sourceware.org/libffi/
    - MinGW         https://osdn.net/projects/mingw/
    - MinGW-w64     https://mingw-w64.org/
    - OpenXDK       http://openxdk.sourceforge.net/
    - TDM-GCC       https://jmeubank.github.io/tdm-gcc/
    - WinLibs       https://www.winlibs.com/

  o Credits

    Project members:
    - Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
        Founder, main compiler developer, author of many parts of the runtime,
        lead developer 2004 to 2010
        FB headers (FBSWIG) & emscripten port
        too many additions and improvements to list
    - Angelo Mottola (a.mottola[at]libero.it)
        Author of the FB graphics library, built-in threads, thread-safe
        runtime, ports I/O, dynamic library loading, Linux port.
    - Bryan Stoeberl (b_stoeberl[at]yahoo.com)
        SSE/SSE2 floating point math, AST vectorization.
    - Daniel C. Klauer (daniel.c.klauer[at]web.de)
        lead developer 2010 to 2017
        automatic header / bindings generation (fbfrog)
        FB releases 0.21 to 1.05.0, C & LLVM backends, 64bit port,
        dynamic arrays in UDTs, virtual methods, preprocessor-only mode,
        many fixes and improvements.to compiler, rtlib & gfxlib2
        too many additions and improvements to list
    - Daniel R. Verkamp (i_am_drv[at]yahoo.com)
        DOS, XBox, Darwin, *BSD ports, DLL and static library automation,
        VB-compatible runtime functions, compiler optimizations,
        miscellaneous fixes and improvements.
    - Ebben Feagan (sir_mud[at]users.sourceforge.net)
        FB headers, C emitter
    - Jeff Marshall (coder[at]execulink.com)
        FB releases 0.17 to 0.20, and later 1.06.0 and up
        FB documentation (wiki maintenance, fbdocs offline-docs generator),
        Gosub/Return, profiling support, dialect specifics, DOS serial driver,
        miscellaneous fixes and improvements.to compiler, rtlib & gfxlib2
        lead developer since 2017
    - Mark Junker (mjscod[at]gmx.de)
        Author of huge parts of the runtime (printing support, date/time
        functions, SCR/LPTx/COM/console/keyboard I/O), Cygwin port,
        first FB installer scripts.
    - Matthew Fearnley (matthew.w.fearnley[at]gmail.com)
        Print Using & Co, ImageInfo, and others, dialect specifics,
        optimization improvements in the compiler, many fixes and improvements.
        rtlib & gfxlib2 fixes and improvements
        documentation and examples
        forum administrator and moderator since forever
    - Ruben Rodriguez (fbc[at]cha0s.io)
        Var keyword, const specifier, placement new, operator overloading and
        other OOP-related work, C BFD wrapper, many fixes and improvements.
    - Simon Nash
        AndAlso/OrElse operators, ellipsis for array initializers,
        miscellaneous fixes and improvements.

    Contributors:
    - 1000101
        gfxlib2 patches, e.g. image buffer alignment
    - Abdullah Ali (voodooattack[at]hotmail.com)
        Windows NT DDK headers & examples
    - adeyblue
        Direct2D windows driver
        run time and gfx library improvements and fixes
    - AGS
        gdbm, zlib, Mini-XML, PCRE headers
    - Angelo Rosina (angros47[at]gmail.com)
        gfxlib2 extensions for OpenGL 2D rendering
        integration of threading and dynamic libraries for DOS port (by monochromator)
        integration of emscripten branch and improvements
    - Claudio Tinivella (tinycla[at]yahoo.it)
        Gtk tutorials
    - Chris Davies (c.g.davies[at]gmail.com)
        OpenAL headers & examples
    - Dinosaur
        CGUI headers
    - D.J.Peters
        ARM port, ODE headers & examples, Win32 API header fixes
    - Dumbledore
        wx-c headers & examples
    - dr0p (dr0p[at]perfectbg.com)
        PostgreSQL headers & examples
    - Edmond Leung (leung.edmond[at]gmail.com)
        SDL headers & examples
    - Eric Lope (vic_viperph[at]yahoo.com)
        OpenGL & GLU headers & examples, examples/gfx/rel-*.bas demos
    - Florent Heyworth (florent.heyworth[at]swissonline.ch)
        Win32 API sql/obdc headers
    - fsw (fsw.fb[at]comcast.net)
        Win32 API headers, Gtk/Glade/wx-c examples
    - fxm
        documentation writer and manager for many years
        detailed technical articles, bug tracking and investigations
        documentation forum moderator
    - Garvan O'Keeffe (sisophon2001[at]yahoo.com)
        FB ports of many NeHe OpenGL lessons, PDFlib examples
    - Hans L. Nemeschkal (Hans.Leo.Nemeschkal[at]univie.ac.at)
        DISLIN headers
    - Jofers (spam[at]betterwebber.com)
        ThreadCall keyword, libffi/libjit headers, FreeType examples
    - Jose Manuel Postigo (postigo[at]uma.es)
        Linux serial devices support
    - Laanan Fisher (laananfisher[at]gmail.com)
        FB test suite using CUnit
    - Laurent Gras / SARG (debug[at]aliceadsl.fr)
        gas64 backend emitter
        improvements and fixes for stabs debugging
        fbdebugger project https://users.freebasic-portal.de/sarg
    - Luther Ramsey (luther.ramsey[at]gmail.com)
        freebasic.net forums moderator
    - Matthew Riley (pestery)
        OpenGL, GLFW, glext, FreeGLUT, cryptlib headers
    - Matthias Faust (matthias_faust[at]web.de)
        SDL_ttf headers & examples
    - Marzec
        SDL headers, SDL_bassgl, SDL_opengl and SDL_key examples
        First file routines for FB's rtlib
    - MJK
        big_int header fixes
    - MOD
        wx-c, BASS headers; -lang qb support for built-in macros,
        "real" Rnd() algorithm
    - Nek (dave[at]nodtveidt.net)
        Win32 API headers
    - Hung Nguyen Gia (gh_origin[at]zohomail.com)
        Solaris and DragonFly porting and testing
    - Paul Squires (support[at]planetsquires.com)
        WinFBE IDE project and fbc compiler distribution bundle
    - Plasma
        FMOD and BASS headers & examples
    - Ralph Versteegen
        fixes / improvements to compiler, rtlib, gfxlib2, tests and headers
    - Randy Keeling (randy[at]keeling.com)
        GSL matrix example
    - Saga Musix (Jojo)
        BASS examples with sounds
    - Sisophon2001
        gfxlib2 fixes, Nehe OpenGL lesson ports
    - Stefan Wurzinger (swurzinger[at]gmx.at)
        compiler, runtime library and documentation generator improvements
        daily development builds, documentation builds and testing
        header/bindings updates
    - Sterling Christensen (sterling[at]engineer.com)
        Ex-project-member, author of FB's initial QB-like graphics library
    - TJF (Thomas.Freiherr[at]gmx.net)
        ARM port, GTK+, glib, Cairo, Pango headers & examples,
        SQLiteExtensions headers
    - zydon
        Win32 API examples

    Greetings:
    - Plasma
        Owner of the freebasic.net domain and main site hoster, many thanks to
        him.
    - VonGodric
        Author of the first FreeBASIC IDE: FBIDE.
    - Everybody that helped writing the documentation (and in special Nexinarus 
      who started it)
        https://freebasic.net/wiki/ContributorList
    - All users that reported bugs, requested features and as such helped 
      improving the compiler, language and run-time libraries.
