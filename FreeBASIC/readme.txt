  
  FreeBASIC - A 32-bit BASIC Compiler for DOS, Windows and Linux
  Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)


License:

  This program is free software; you can redistribute it and/or modify it under the terms
  of the GNU General Public License as published by the Free Software Foundation; either
  version 2 of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along with this program;
  if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  MA 02111-1307 USA.


Most Important Features:

  o BASIC Compatibility:

    - FreeBASIC is not a "new" BASIC language. It is not required of you to learn
      anything new if you are familiar with any Microsoft-BASIC variant.

    - FreeBASIC is case-insensitive; scalar variables don't need to be dimensioned and
      suffix can be used; line numbers are supported; MAIN function is no required; 
      most of the graphic and console statements and functions found in MS-QuickBASIC were
      implemented, et cetera.

  o Clean Syntax:

    - Only a small number of keywords have been added. All functions are implemented
      as libraries, so for the most part, there are no new intrinsic routines, and
      therefore there is a low chance of having name duplication with old code. If you
      want to show up a message box in Windows, simply do:

      '$include: 'win\user32.bi'
      MessageBox NULL, "Title", "Text", MB_ICONASTERISK

      (note: MessageBox is case-insensitive, it can be MESSAGEBOX if you want)

  o Most of the known C libraries and API's can be used without wrappers or helpers: 

    - GTK+ 2.0: cross-platform GUI Toolkit (over 1MB of headers, including support for 
      Glade, libart and glGtk)

    - libxml and libxslt: defacto standard XML and XSL libraries

    - GSL - GNU Scientific library: complex numbers, vectors and matrices, FFT,
      linear algebra, statistics, sorting, differential equations, and a dozen other 
      sub-libraries with mathematical routines

    - SDL - Simple DirectMedia Layer: multimedia library for audio, user input, 
      3D and 2D gfx (including the sub-libraries such as SDL_Net, SDL_TTF, etc)
    
    - OpenGL: portable library for developing interactive 2D and 3D graphics games and 
      applications (including support for frameworks such as GLUT and GLFW)

    - Allegro: game programming library (graphics, sounds, player input, etc)
    
    - GD, DevIL, FreeImage, GRX and other graphic-related libraries

    - OpenAL, Fmod, BASS: 2D and 3D sound systems, including support for mod, mp3, ogg, etc

    - ODE and Newton - dynamics engines: libraries for simulating rigid body dynamics

    - DirectX and the Windows API (W.I.P.)

    - more to come...

  o A large number of variable types available, like BYTE, SHORT, INTEGER, LONGINT, 
    SINGLE, DOUBLE and STRING:

    - All integer types have unsigned versions (UBYTE, USHORT, UINTEGER, ULONGINT).

    - Strings can be fixed, variable-length or null-terminated (zstring's), up to 2GB long.

    - The LONGINT and ULONGINT data types are 64-bit wide.

  o User-defined Types (UDT's):

    - Unlimited nesting.

    - BASIC's TYPE statement is supported, along with the new UNION statement (including 
      nameless nested UNION's).

      TYPE MyType
         A AS SHORT
         B AS INTEGER
         C AS LONG
         D AS OtherUDT
         UNION
            E AS DOUBLE
            F AS SINGLE
            G AS OtherUDT
         END UNION
         H AS BYTE
      END TYPE

      Or,

      UNION MyUnion
         A AS INTEGER
         B AS INTEGER
         C AS DOUBLE
      END UNION

    - Array fields utilizing up to four dimensions can be used. For example,

      TYPE MyList
         ListData(0 TO MAXITEMS - 1) AS MyItem
      END TYPE

    - Function field types:

      TYPE MyType
         MyFunction AS FUNCTION (BYVAL ArgumentA AS INTEGER) AS INTEGER
      END TYPE

  o Enumerations (ENUM's):

      ENUM MyEnum
         A
         B = 3
         C
      END ENUM

      DIM E AS MyEnum

      E = C

  o Arrays:

    - Dynamic and static arrays are supported, up to 2 GB in size.

    - Unlimited number of array dimensions.

    - Any lower and upper boundaries.

    - REDIM PRESERVE statement is supported to resize any dynamic array and keep its
      contents intact.

  o Pointers:

    - Pointers to any of the data types listed above, including UDT's and arrays.

    - Uses the same syntax as C/C++. For example,

      TYPE Node
         PreviousNode AS Node POINTER
         NextNode     AS Node POINTER
      END TYPE

      DIM CurrentNode AS Node POINTER
      CurrentNode->NextNode->PreviousNode = NULL

      DIM A AS SHORT POINTER, B AS SHORT POINTER, C AS SHORT POINTER POINTER
      *A = *B \ **C

    - Unlimited indirection levels (e.g., pointer to pointer to ...)

    - Function pointers:

      DIM MyPointer AS SUB(BYVAL ArgumentA AS INTEGER, BYVAL ArgumentB AS DOUBLE)
      DIM OtherPointer AS FUNCTION(BYVAL ArgumentA AS INTEGER)

      MyPointer = PROCPTR(RealSub)
      MyPointer (1, 2)

      SUB RealSub(BYVAL ArgumentA AS INTEGER, BYVAL ArgumentB AS DOUBLE)
         Result = ArgumentA * ArgumentB
      END SUB

    - pointer indexing:
    
      DIM foo AS INTEGER PTR
      
      foo = CALLOCATE( 10 * len( integer ) )
      
      FOR i = 0 to 9
      	foo[i] = bar			'' same as *(foo + i) = bar      	
      NEXT
      
    - string indexing:
    
      DIM text AS STRING
      
      text = "BAR"
      print text[0]  			'' output will be 66 = ASC("B")

  o Variable initializers, for static, module-level or local variables, arrays and UDT's:

      DIM foo( 0 to 3 ) AS INTEGER = { 1, 2, 3, 4 }

      STATIC as zstring * 10 bar( 0 to 1, 0 to 1 ) = { { "abc", "def" }, { "ghi", "jkl" } }

      DIM mytype as MYTYPE = ( "a", 1, 2.0 )

      DIM mytypearray(0 to 1) as MYTYPE = { ( "a", 1, 2.0 ), ( "b", 3, 4.0 ) }

      DIM localvar AS INTEGER = a + b * d

  o Bit fields:

      TYPE mytype
          flag_0 : 1 as integer
          flag_1 : 1 as integer
          flag_2 : 1 as integer
      END TYPE

      DIM t AS mytype

      t.flag_0 = 1
      t.flag_1 = 0
      t.flag_2 = 1

      PRINT "All flags ON? ";
      IF ( t.flag_0 AND t.flag_1 AND t.flag_2 ) THEN
	PRINT "TRUE"
      ELSE
        PRINT "FALSE"
      END IF

  o Optional function arguments (numeric and strings):

      DECLARE SUB Test(a AS DOUBLE = 12.345, BYVAL b AS BYTE = 255, BYVAL s AS STRING = "abc")

      Test
      Test , 128
      Test ,
      Test 44,
      Test 44
      Test ( )

      et cetera.

  o Inline Assembly:

    - Intel syntax.

    - Reference variables directly by name; no "trick code" needed.

  o Preprocessor:

    - Same syntax as in C (including #DEFINE's with arguments):

      #DEFINE SOMEDEF 1234
      #DEFINE OTHERDEF 5678
      #IFDEF SOMEDEF
      #   IF NOT DEFINED(OTHERDEF)
      #      DEFINE OTHERDEF SOMEDEF
      #   ELSE
      #      IF OTHERDEF <> SOMEDEF
      #         UNDEF OTHERDEF
      #         DEFINE OTHERDEF SOMEDEF
      #      ENDIF
      #   ENDIF
      #ELSE
      #   DEFINE OTHERDEF 5678
      #ENDIF
      #PRINT OTHERDEF

      #DEFINE bar(x,y) ((x) * (y))
      #DEFINE foo(x,y) bar(x-y,y-x)
      a = foo(b, c)

  o Typedefs:

    - Supporting forward referencing as in C:

      TYPE foo AS bar

      TYPE sometype
           f   AS foo PTR
      END TYPE

      TYPE bar
           st  AS sometype
           a   AS INTEGER
      END TYPE

      DIM s AS SOMETYPE, b AS BAR
      
      b.st.f = @b
      s.f = @b
      
      s.f->st.f->a = 1234

  o Escape characters inside literal strings:

    - Same as in C (except numbers are interpreted as decimal, not octagonal).
      Use the OPTION ESCAPE statement to turn this behavior on or off.

      OPTION ESCPAPE
      PRINT "\"Hello from FreeBASIC!\""

  o Create OBJ's, LIB's, DLL's, and console or GUI EXE's:

    - You are in no way locked to an IDE or editor of any kind.

    - You can create static and dynamic libraries adding just one command-line
      option (-lib or -dll).

  o As a 32-bit application:

    - FreeBASIC can compile source code files up to 2 GB long.

    - The number of symbols (variables, constants, et cetera) is only limited by the
      total memory available during compile time. (You can, for example, include
      OpenGL, SDL, BASS, and Windows 32-bit API simultaneously in your source code.)

  o Optimized code generation:

    - While FreeBASIC is not an optimizing compiler, it does many kinds of general
      optimizations to generate the fastest possible code on x86 CPU's, not losing
      to other BASIC alternatives, including the commercial ones.

  o Completely free:

    - All third-party tools are also free. No piece of abandoned or copyrighted
      software is used (but GoRC on Win32). The assembler, linker, archiver, and 
      other command-line applications come from the GNU binutil programming tools.

  o Portability:

    - The run-time library is being written with portability in mind. Operating
      system-dependent functions are separated to make porting the compiler
      easy.

    - The compiler is written in 100% FreeBASIC code (FreeBASIC compiles itself.)
      As all modules are independent, porting to other operating systems on the
      x86 platform won't be too difficult.

    - All tools used in the creation of FreeBASIC exist on most operating systems
      already as they are from the GNU binutils.

    - FreeBASIC currently runs on 32-bit Windows, Linux, and MS-DOS.


What FreeBASIC Isn't:

  o FreeBASIC is not a QuickBASIC clone, neither an emulator.
  
    - DEF SEG, PEEK and POKE to absolute 16-bit memory locations and many 
      old and deprecated statements, that are seldom used today, were not 
      implemented, read the docs/keywords.txt file for a list of differences. 
      
    - While FB is certainly the BASIC compiler that most reassembles the Microsoft 
      BASIC compilers for DOS, don't expect to compile old source-codes filled with 
      unsupported statements or external libraries, that won't work.

  o FreeBASIC is not a Visual Basic alternative.

    - There are no events, or any GUI wrapper of any kind. (You can create them
      easily with UDT's and function pointers.)

  o FreeBASIC is most certainly not bug free, as with any other program.

    - The FreeBASIC project was started in September 2004, and was not/is not tested
      enough.
      

Possible Additions to Later Versions:

  o Full debug support using GDB/Insight

  o Pointer type casting

  o CLASS data structure (for object-oriented programming):

    - GUI code would be much easier to write.


Credits (in alphabetic order):

  o Angelo Mottola (a.mottola@libero.it) - Project Member:
    - Ported FreeBASIC to Linux; port maintainer.
    - Developer of GFXLib2.
    - Added build-in threads and dynlib support, made the rtlib thread-safe, 
      besides many other runtime lib and compiler improvements.

  o Chris Davies (c.g.davies@gmail.com):
    - Translated the OpenAL headers.
    - Wrote the OpenAL demonstration in the examples/sound directory.

  o Daniel R. Verkamp (i_am_drv@yahoo.com) - Project Member:
    - Ported FreeBASIC to DOS; port maintainer.
    - Translated the Allegro headers (W.I.P.).
    - FreeBASIC Documentation project member.
    - Wrote the DLL and static library automation, plus resource scripts 
      support on Windows.
    - Completed the CRTDLL and DDRAW headers.

  o Edmond Leung (leung.edmond@gmail.com): 
    - Translated the SDL headers, including SDL_mixer and SDL_image.
    - Wrote/ported many of the examples in the examples/SDL dir.

  o Eric Lope (vic_viperph@yahoo.com):
    - Translated the OpenGL and GLU headers
    - Wrote the rel-* graphics demonstrations in the examples/gfx directory.

  o fsw:
    - Translated most of the Windows API headers.
    - Wrote the glade_gui demo at the examples/Gtk directory, besides the 
      wx-c GUI examples (not included).
      
  o Randy Keeling (randy@keeling.com):
    - Wrote the GSL matrix test at the examples/GSL directory.

  o Matthias Faust (matthias_faust@web.de):
    - Translated the SDL_ttf header (also SDL_mixer, that unfortunately was sent by
      Edmond Leung some days before) and wrote the SDL_ttf demonstration program.

  o Marzec:
    - Wrote the SDL_bassgl, SDL_opengl, and SDL_key tests in the SDL directory.
    - Translated the first SDL headers (replaced by new ones since version 0.11b).
    - Wrote the first file routines for the run-time library.

  o Nek (dave@nodtveidt.net):
    - Translated the Windows API headers, integrating parts of fsw's work.

  o plasma:
    - Translated the FMOD and BASS headers.
    - Wrote the fmod.bas test in the examples/sound directory.

  o Sterling Christensen (sterling@engineer.com) - Project Member:
    - Developer of the QB-like graphics library (later replaced by GFXLib2 in 0.11b)

  o Steven Hidy (subxero@phatcode.net):
    - Rewrote this readme file, correcting v1ctor's mistakes (also re-edited by 
      KrisKhaos for version 0.12).

  o zydon:
    - Wrote many of the examples in the examples/Windows/gui directory.


  o Third-party tools:
    - Win32: Mingw (http://www.mingw.org/) and GoRC (http://www.godevtool.com/)
    - DOS32: DJGPP (http://www.delorie.com/)

  o Many console routines used in the Win32 version of the run-time library were 
    based on the CONIO implementation for Mingw32.

  o The long integers (64-bit) division and modulo routines are from the GCC's 
    libgcc2 sources.


Greetings:

  o Plasma: freebasic.net domain register and since mar/2005 hosts the main site too,
    many thanks to him.

  o Nexinarus: Organized the documentation (W.I.P.), found bugs and saved a bunch of
    kangaroos in the middle time.

  o VonGodric: author of the first FreeBASIC IDE: FBIDE (download it here: 
    http://www.hot.ee/fbide/ ).

  o Rel: Best beta tester ever, found loads of bugs.

  o Wildcard: Created the biggest FB forum and helped making FB known even before it was
    released.

  o Blitz: The first to see the compiler when it was just a toy (delete the sources!).
    Helped pointing me out the right paths to follow in order to generate better code.
    Helped finding tons of bugs and wrote the first real apps.

  o Marzec: Loads of tests, besides giving many ideas.

  o Nek, na_th_an, Sj Zero, Z!re: Some serious beta testing - meaning: loads of bugs found.

  o People at Qbasicnews (too many to list, thanks all!) for all the support and feedback.

  o You, for giving it a try - you won't regret.. er.


Links:

  o Official site: http://www.freebasic.net/ or 
                   http://fbc.sourceforge.net/ or 
                   http://www.sourceforge.net/projects/fbc

  o IRC channel: irc://irc.freenode.net/freeBASIC

  o External libraries:

    - Allegro: http://www.talula.demon.co.uk/allegro/

    - BASS and BASSMod: http://www.un4seen.com/

    - BIG_INT: http://chat.finalcombat.com/valyala/big_int/
 
    - cgi-util: http://www.newbreedsoftware.com/cgi-util/

    - cryptlib: http://www.cs.auckland.ac.nz/~pgut001/cryptlib/

    - DevIL: http://openil.sourceforge.net/
    
    - fmod: http://www.fmod.org/

    - FreeImage: http://freeimage.sourceforge.net/

    - GD: http://www.boutell.com/gd/ or http://gnuwin32.sourceforge.net/packages/gd.htm

    - GDSL: http://www.nongnu.org/gdsl/
    
    - GLFW: http://glfw.sourceforge.net/   
 
    - GLUT: http://www.xmission.com/~nate/glut.html

    - GRX: http://grx.gnu.de/

    - GSL: http://www.gnu.org/software/gsl/ or http://gnuwin32.sourceforge.net/packages/gsl.htm

    - GTK+: http://www.gtk.org/ or http://gladewin32.sourceforge.net/modules.php?name=Downloads
    
    - IUP: http://luaforge.net/projects/iup

    - JAPI: http://www.japi.de/

    - LibXML: http://xmlsoft.org/
    
    - Lua: http://www.lua.org/

    - Mini-XML: http://www.easysw.com/~mike/mxml/
    
    - MySQL: http://dev.mysql.com/

    - Newton: http://www.physicsengine.com/

    - ODE: http://ode.org/

    - OpenAL: http://www.openal.org/ or http://developer.creative.com/landing.asp?cat=1&sbcat=31&top=38

    - OpenGL: http://www.opengl.org/

    - PDCurses: http://pdcurses.sourceforge.net/

    - PDFlib: http://www.pdflib.com/ or http://gnuwin32.sourceforge.net/packages/pdflib.htm

    - SDL: http://www.libsdl.org/ (look under Libraries for SDL_net, SDL_image, SDL_ttf, etc)

    - SDL_gfx: http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/
    
    - SQLite: http://www.sqlite.org/

    - TinyPTC: http://www.gaffer.org/tinyptc/
    
    - TRE (Regular Expressions): http://laurikari.net/tre/

    - Zlib: http://www.zlib.net/ or http://gnuwin32.sourceforge.net/packages/zlib.htm


EOF
