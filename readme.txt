
    FreeBASIC - A multi-platform BASIC Compiler
    Copyright (C) 2004-2011 The FreeBASIC development team.

    Official site:      http://www.freebasic.net/
    Forum:              http://www.freebasic.net/forum/
    Wiki:               http://www.freebasic.net/wiki/
    fbc project page:   http://www.sourceforge.net/projects/fbc/
    IRC channel:        ##freebasic at irc.freenode.net

  o License

    The FreeBASIC compiler (fbc) is licensed under the GPLv2, see
    compiler/license.txt for details.

    The FreeBASIC runtime (libfb) is licensed under the LGPLv2 with an
    exception, see runtime/license.txt for details.

  o Installing

    FreeBASIC comes as fbc (the command line compiler), the runtime libraries
    (needed to compile FB programs) and compiler tools (assembler, linker).
    In general it just needs to be extracted somewhere, then it can be used
    immediately.

    The fbc project provides full installers for Windows (.exe) and Unix-like
    systems (.run). Simply run them and then follow their instructions.
    These full installers include extra headers and libraries that you can
    choose to install.

    The fbc project also provides smaller .zip (Windows) and .tar.gz archives
    (Unix), and last but not least, the DOS version comes in a .zip only.
    The archives can be extracted anywhere, and the compiler will work.

    Note: FreeBASIC may be included in the official package repositories of
    some Linux distributions, FreeDOS, or other systems, in which cases you
    can install their FreeBASIC package (maybe via a package manager) instead
    of one from the fbc project.

  o Running

    fbc is a command-line compiler; it does not include a text editor.
    Some text editors and development environments can be told to use fbc
    to compile code; please refer to their documentation.

    To see a list of fbc's options, open a console (terminal, command prompt,
    cmd.exe), enter "fbc" and run it by pressing ENTER. If "fbc" cannot be
    found, you may need to specify the full path to the fbc (or fbc.exe)
    executable instead, or make sure that the directory containing fbc is
    listed in the PATH environment variable.

    To compile a "Hello, world!" program, create a text file called "hello.bas"
    with this content:
            print "Hello, world!"
            sleep
    In a console, use fbc to compile the hello.bas into a program executable:
            fbc path/to/hello.bas
    This should create the "hello.exe" (just "hello" on Unix) executable file.

  o Credits

    Project members:
    - Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
          Founder, main compiler developer (sole author of the initial
          versions), author of many parts of the runtime.
    - Angelo Mottola (a.mottola[at]libero.it)
          Author of the FB graphics runtime library, built-in threads,
          thread-safe runtime, ports I/O, dynamic library loading,
          Linux port.
    - Bryan Stoeberl (b_stoeberl[at]yahoo.com)
          SSE/SSE2 floating point math, AST vectorization.
    - Daniel C. Klauer (daniel.c.klauer@web.de)
          FB releases since 0.21, preprocessor-only mode, miscellaneous
          fixes and improvements.
    - Daniel R. Verkamp (i_am_drv[at]yahoo.com)
          DOS, XBox, Darwin, *BSD ports, DLL and static library automation,
          VB-compatible runtime functions, compiler optimizations,
          miscellaneous fixes and improvements.
    - Jeff Marshall (coder[at]execulink.com)
          FB releases since 0.17, FB documentation (wiki maintenance,
          fbdocs offline-docs generator), Gosub/Return, profiling support,
          dialect specifics, DOS serial driver, miscellaneous fixes and
          improvements.
    - Mark Junker (mjscod[at]gmx.de)
          Author of huge parts of the runtime (printing support,
          SCR/LPTx/COM/console/keyboard I/O, date/time functions),
          Cygwin port, first FB installer scripts.
    - Matthew Fearnley (counting.pine[at]virgin.net)
          Print Using & Co, ImageInfo, and also others, dialect specifics,
          optimization improvements in the compiler, many fixes.
    - Ruben Rodriguez (rubentbstk[at]gmail.com)
          Var keyword, const specifier, placement new, operator overloading and
          other OOP-related work, C BFD wrapper, many fixes and improvements.
    - Simon Nash
          AndAlso/OrElse operators, ellipsis for array initializers,
          miscellaneous fixes and improvements.
    - Sterling Christensen (sterling[at]engineer.com)
          Author of the initial QB-like graphics library.

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
    - Steven Hidy (subxero[at]phatcode.net)
    - zydon
    and many others: Thanks for writing FB headers, examples, documentation,
    bug reports and patches.

    Included/used third-party tools:
    - DJGPP (http://www.delorie.com/)
    - GNU binutils (http://www.gnu.org/software/binutils/)
    - GNU debugger (http://www.gnu.org/software/gdb/)
    - GoRC (http://www.godevtool.com/)
    - MinGW (http://www.mingw.org/)
    - OpenXDK (http://www.openxdk.org/)
    - TDM-GCC (http://tdm-gcc.tdragon.net/)

  o Greetings
    - Plasma: Owner of the freebasic.net domain and main site hoster,
      many thanks to him.
    - VonGodric: Author of the first FreeBASIC IDE: FBIDE.
    - Everybody that helped writing the documentation (and in special Nexinarus 
      who started it), more details at:
        http://www.freebasic.net/wiki/wikka.php?wakka=ContributorList
    - All users that reported bugs, requested features and as such helped 
      improving the compiler, language and run-time library somehow.

  o Compiling FreeBASIC (itself)

    The toplevel makefile builds the compiler and the runtime.
    For a simple native build just do a 'make'. For more information on
    configuration possibilities and cross-compiling check the makefile, and
    its 'help' target ('make help').

    Requirements:

    - (GNU?) make
    - fbc
    - binutils' libbfd development files (for the compiler)

    - DOS:
        - DJGPP 2.04

    - Linux (and also *BSD etc.):
        - native gcc/binutils
        - X11 headers (for the graphics runtime)
        - ncurses development files
        - gpm (general purpose mouse) headers
        - GL headers (typically from freeglut)

    - Win32:
        - MinGW
        - DirectX headers (for the graphics runtime)
