  
  FreeBASIC - A 32-bit QuickBASIC-compatible Compiler
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

  o Syntax-compatible with Microsoft's QBASIC/QuickBASIC/PDS/VB-DOS interpreters
    and compilers:

    - FreeBASIC is not a "new" BASIC language. It is not required of you to learn
      anything new if you are familiar with any MS-BASIC variant.

    - FreeBASIC is case-insensitive; scalar variables don't need to be dimensioned;
      line numbers are supported; no required MAIN function; et cetera.

    - Please note that compatibility does not mean that any code written for any
      version of MS-BASIC will run the same with FreeBASIC. It may compile
      fine, but have problems running.

  o Clean Syntax:

    - Only a small number of keywords have been added. All functions are implemented
      as libraries, so for the most part, there are no new intrinsic routines, and
      therefore there is a low chance of having name duplication with old code. If you
      want to show up a message box in Windows, simply do:

      '$include: 'win\user32.bi'
      MessageBox NULL, "Title", "Text", MB_ICONASTERISK

      (note: MessageBox is case-insensitive, it can be MESSAGEBOX if you want)


  o A large number of variable types available, like BYTE/SHORT/INTEGER, SINGLE/DOUBLE and STRING:

    - All integer types have unsigned versions (UBYTE/USHORT/UINTEGER).

    - Strings can be fixed or variable-length (up to 2GB long).


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

  o Optional function arguments (numeric only):

      DECLARE SUB Test(A AS DOUBLE = 12.345, BYVAL B AS BYTE = 255)

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

    - Same syntax as in C (less for complex #DEFINE's, as they are unsupported):

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

  o Escape characters inside literal strings:

    - Same as in C (except numbers are interpreted as decimal numbers).
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
      to other BASIC alternatives, including many commercial ones.

  o Completely free:

    - All third-party tools are also free. No piece of abandoned of copyrighted
      software is used. The assembler, linker, archiver, and other command-line
      tools come from the mingw32 project (the GCC port for Windows).

  o Portability:

    - The run-time library is being written with portability in mind. Operating
      system-dependent functions are being separated to make porting the compiler
      easy.

    - The compiler is written in 100% FreeBASIC code (FreeBASIC compiles itself.)
      As all modules are independent, porting to other operating systems on the
      x86 platform won't be too difficult.

    - All tools used in the creation of FreeBASIC exist on most operating systems
      already as they are from the GNU binutils.

    - FreeBASIC currently runs on 32-bit Windows, Linux, and MS-DOS.


What FreeBASIC Isn't:

  o FreeBASIC is not a Visual Basic alternative.

    - There are no events, or any GUI wrapper of any kind. (You can create them
      easily with UDT's and function pointers.)

  o FreeBASIC is most certainly not bug free, as with any other program.

    - The FreeBASIC project is only five months old, and was not/is not tested
      enough.


Possible Additions to Later Versions:

  o Macros

  o TYPEDEF's

  o Variable initializers:

      DIM MyVariable AS SomeType = { InitialValue, ... }

  o CLASS data structure (for object-oriented programming):

    - GUI code would be much easier to write.

  o More optimizations:

    - Common sub-expression elimination: QB 4.5 and later had this type
      of optimization 16 years ago. Today, you can't find any BASIC compiler that
      utilizes this type of optimization - not even PowerBASIC, known as the BASIC
      compiler that generates the fastest code.

    - Direct Acyclic Graph (DAG) module has already been coded. All that remains is
      getting it to work with the Intermediate Representation (IR) module.


Known Bugs:

  o "ON Expression GOTO | GOSUB List" will be fixed later. It acts like
    "IF Expression GOTO | GOSUB" as of now.


Credits (in alphabetic order):

  o Angelo Mottola (a.mottola@libero.it) - Project Member:
    - Ported FreeBASIC to Linux; port maintainer.
    - Developer of GFXLib2.

  o Daniel R. Verkamp (i_am_drv@yahoo.com) - Project Member:
    - Ported FreeBASIC to DOS; port maintainer.
    - Translated the Allegro headers (W.I.P.)
    - FreeBASIC Documentation project member.
    - Wrote the DLL and static library automation.
    - Completed the CRTDLL and DDRAW headers.

  o Edmond Leung (leung.edmond@gmail.com): 
    - Translated the SDL headers, including SDL_mixer and SDL_image.
    - Wrote/ported many of the examples at the SDL dir.

  o Eric Lope (vic_viperph@yahoo.com):
    - Translated the OpenGL and GLU headers
    - Wrote the rel-* graphics demonstrations in the GFX directory.

  o fsw:
    - Translated most of the Windows API headers.

  o Matthias Faust (matthias_faust@web.de):
    - Translated the SDL_ttf header (also SDL_mixer, that unfortunately was sent by
      Edmond Leung some days before) and wrote the SDL_ttf demonstration program.

  o Marzec:
    - Wrote the SDL_bassgl, SDL_opengl, and SDL_key tests in the SDL directory.
    - Translated the first SDL headers (replaced by new ones since version 0.11b).
    - Wrote the first file routines for the run-time library.
    - Made the preliminary preprocessor, an external tool.

  o Nek (dave@nodtveidt.net):
    - Translated the Windows API headers, integrating parts of fsw's work.

  o plasma:
    - Translated the FMOD and BASS headers.
    - Wrote the fmod.bas test in the SOUND directory.

  o Sterling Christensen (sterling@engineer.com) - Project Member:
    - Developer of the QB-like graphics library (later replaced by GFXLib2 in 0.11b)

  o Steven Hidy (subxero@phatcode.net):
    - Rewrote this readme file, correcting v1ctor's mistakes (too many to list :P).

  o zydon:
    - Wrote the calendar the toolbar examples at the GUI directory.


  o All third-party tools from Mingw32: http://www.mingw.org/

  o Many run-time library console routines were based on the CONIO implementation
    for Mingw32.


Greetings:

  o Blitz: The first to see the compiler when it was just a toy (delete the sources!).
    Helped pointing me out the right paths to follow in order to generate better code.
    Helped finding tons of bugs and wrote the first real apps.

  o Marzec: Loads of tests, besides giving many ideas.

  o Nexinarus: Organized the documentation (W.I.P.), found bugs and saved a bunch of
    kangaroos in the middle time.

  o VonGodric: author of the first (an unique at the moment) freeBASIC IDE: FBIDE (download
    it here: http://www.hot.ee/wizgui/setup.exe) and also reported loatsa bugs (i'm getting
    tired of typing that, arf)

  o Rel: Best beta tester ever, found loads of bugs.

  o Plasma: Wrote the first FB demos for fmod and BASS. Also the register of the freebasic.net
    domain.

  o Jofers: Fitted a horse icon in just 16x16 pixels (awesome work, btw ;), also working on the
    documentation (more info at http://freebasicdoc.sourceforge.net).

  o Wildcard: Created the biggest FB forum and helped making FB known even before it was
    released.

  o Nek, na_th_an, Sj Zero, Z!re: Some serious beta testing - meaning: loads of bugs found.

  o Dav, WD, Alias, Urger: Beta testing.

  o People at Qbasicnews (too many to list, thanks all!) for all the support and feedback.

  o You, for giving it a try - you won't regret.. er.


Links:

  o Official site: http://fbc.sourceforge.net/ (or http://www.sourceforge.net/projects/fbc)

  o IRC channel: irc://irc.freenode.net/freeBASIC

  o External libraries:

    - Allegro: http://www.talula.demon.co.uk/allegro/

    - BASS and BASSMod: http://www.un4seen.com/

    - fmod: http://www.fmod.org/

    - FreeImage: http://freeimage.sourceforge.net/

    - GLUT: http://www.xmission.com/~nate/glut.html

    - Lua: http://www.lua.org/

    - OpenGL: http://www.opengl.org/

    - SDL: http://www.libsdl.org/ (look under Projects for SDL_net, SDL_image, SDL_ttf, etc)

    - SDL_gfx: http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/

    - TinyPTC: http://www.gaffer.org/tinyptc/

    - Zlib: http://www.zlib.net/


EOF
