
[Legal stuff]

    FreeBASIC - a 32-bit QB-compatible Compiler
    Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)

    This program is free software; you can redistribute it and/or modify it under the terms
    of the GNU General Public License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along with this program;
    if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
    MA 02111-1307 USA.



[Most important features]

    * syntax compatible with Microsoft's QBASIC/QuickBASIC/PDS/VBDOS interpreters/compilers:

        - freeBASIC is not a "new" BASIC language, you don't have to learn anything new if
          you already know any MS-BASIC variant

        - case-insensitive, scalar variables don't need to be dimensioned, supports line
          numbers, no MAIN functions and so on..

        - please note that compatibility doesn't mean you can compile a source-code made for
          QuickBASIC and hope it will run fine (it may compile fine!)


    * clean syntax:

        - only a small number of keywords were added, all functions are implemented as
          libraries, there's not a single new intrinsic routine, like MSGBOX of example,
          so there's no variable clashes with old code. if you want to show up a msg box
          in Windows, simply do:

          '$include: 'user32.bi'
          MessageBox NULL, "Title", "Text", MB_ICONASTERISK

          (note, MessageBox is case-insensitive, it can be MESSAGEBOX if you want)


    * great number of variables types, like BYTE/SHORT/INTEGER, SINGLE/DOUBLE and STRING:

      - all integer types have unsigned versions (UBYTE/USHORT/UINTEGER)

      - strings can be fixed or variable-length (up to 2GB long!)


    * user defined types (UDT's):

      - unlimited nesting

      - QB's TYPE and UNION's (including nameless inner-unions):

        type MYTYPE
            a as short
            b as integer
            c as short
            d as OTHERTYPE
            union
                e as double
                f as single
                g as OTHERTYPE
            end union
            h as byte
        end type

        union MYUNION
            a as integer
            b as short
            c as double
        end union

      - array fields, up to 4 dimensions, ex:

        type MYLIST
            mylist(0 to MAXITEMS-1) as MYITEM
        end type

      - function field types:

        type SOMETYPE
            myfunc as function( byval arg1 as integer ) as integer
        end type


    * enum's (Enumerations):

        enum MYENUM
            A
            B = 3
            C
        end enum

        dim e as MYENUM

        e = C (ie, e = 4)


    * arrays:

      - dynamic and static, up to 2GB

      - unlimited number of dimensions

      - any lower and upper bounds

      - redim preserve


    * pointers:

      - pointers to *any* variable listed above, including UDT's and arrays

      - uses the same syntax as in C, ex:
        type node 
          prevNode as node ptr
          nextNode as node ptr
        end type

	dim currNode as node ptr
        currNode->nextNode->prevNode = NULL

        dim a as short ptr, b as short ptr, c as short ptr ptr
        *a = *b \ **c

      - unlimited indirection levels (pointer to pointer to pointer to ...)

      - function pointers:

        dim myptr as sub( byval arg1 as function( byval arg as integer ), byval arg2 as double )
        dim otherptr as as function( byval arg as integer )

        myptr = @realsub
        myptr( otherptr, f )

        sub realsub( byval arg1 as function( byval arg as integer ), byval arg2 as double )

            res = arg1( a+b ) * arg2

        end sub


    * optional function arguments (numeric only):

      declare sub bar( foo1 as double = 12.345, byval foo2 as byte = 255 )

      bar
      bar , 128
      bar ,
      bar 123.4,
      bar 123.4
      etc...


    * inline assembly:

      - intel syntax

      - reference variables by name, no trick code needed


    * pre-processor:

      - same syntax as in C (less for complex #define's, that are not supported)

      #define SOMEDEF  1234
      #define OTHERDEF 5678
      #ifdef SOMEDEF
      # if not defined( OTHERDEF )
      #  define OTHERDEF SOMEDEF
      # else
      #  if OTHERDEF <> SOMEDEF
      #   undef OTHERDEF
      #   define OTHERDEF SOMEDEF
      #  endif
      # endif
      #else
      # define OTHERDEF 5678
      #endif
      #print OTHERDEF


    * escape characters inside literal strings:

      - same as in C (but numbers are interpreted as decimal, not octagonal)

        option escape                           '' needed to enable
        print "\"Hello from FreeBASIC!\""


    * creates OBJ's, LIB's, DLL's, console and GUI EXE's

      - you are in no way locked to an IDE

      - create static libraries as before


    * as a 32-bit application:

      - FB can compile source-code files up to 2GB long

      - the number of symbols (variables, constants, etc) is only limited
        by the memory available (you can include/use for example opengl +
        sdl + bass + win api with your application)


    * optimized code generation:

      - while freeBASIC isn't an optimizing compiler, it does many kinds
        of optimizations to generate the fastest possible code on x86 CPU's,
        not losing to other BASIC alternatives, including the commercial ones


    * completely *FREE*:

      - all 3rd party tools are also free, no piece of abandoned or copyrighted
        software is used. assembler, linker, archiver and other cmd-line tools came
        from the (awesome) Mingw32 project (the GCC Windows port)


    * portability:

      - runtime-lib is being written with portability in mind, OS dependent
        functions are being separated to make porting easy later

      - compiler is written in 100% in FB (that's it, FB is compiles itself),
        and all modules are independent, porting to other OSes on the x86
        platform won't be too difficult

      - as all tools used also exist on other OSes and can even create
        cross-platform executables, that will make the porting easier


[What freeBASIC isn't]

    * it's not a VisualBASIC alternative:

      - there's no events, no frames or any GUI wrapper (you can create them easily
        with the UDT's and function pointers)

    * it's not bug free:

      - as any 5-months old project, FB wasn't tested enough



[Possible additions to next versions]

    * macros


    * typedefs


    * var initializers:

      dim myvar as sometype = { initialvalue }


    * CLASS data structure (OOP anyone?)

      - GUI code would be way easier to write


    * more optimizations: common sub-expression elimination:

      - believe or not, MS-QB 4.5 and above had that kind of optimization 16 years ago,
        and you can't find ANY BASIC compiler these days that can do that, not even
        PowerBASIC, known as the BASIC compiler that gens the fastest code (until now ;)

      - Direct Acyclic Graph module is already coded, just have to get it to work
        with the IR module


[Known bugs]

    * "ON expr GOTO|GOSUB list" will be fixed later, it acts as "IF expr GOTO|GOSUB"
      by now

    * "DIM a as someusertype, a.b as somescalar" is being allowed, the first one will be
      used, take care..


[Credits]

    * Angelo Motolla (a.mottola@libero.it) - project member:
      - ported FreeBASIC to Linux
      - wrote many fixes and additions to the rtlib and compiler (too many to list ;)
    
    * Sterling Christensen (sterling@engineer.com) - project member: 
      - developer of the QB-ish GFX library
    
    * Daniel R. Verkamp (i_am_drv@yahoo.com): 
      - wrote the DLL and static lib automation
      - developed the SETDATE and SETTIME rtlib routines
      - completed the crtdll and ddraw headers

    * Edmond Leung (leung.edmond@gmail.com): 
      - ported the SDL headers, including SDL_mixer and SDL_image
      - wrote/ported many of the examples at the SDL dir

    * fsw (...@...): 
      - ported most of the Windows API headers

    * Nek (dave@nodtveidt.net): 
      - ported the Windows API headers, integrating parts of fsw's work

    * Marzec (...@...): 
      - wrote the sdl_bassgl, sdl_opengl and sdl_key tests at the SDL dir
      - ported the first SDL headers (replaced by new ones since version 0.11b)
      - wrote the first file routines for the rtlib
      - made the preliminary pre-processor, an external tool

    * plasma (...@...): 
      - ported the fmod and BASS headers
      - wrote the fmod.bas test at SOUNDS dir

    * Rel (...@...):
      - ported the OpenGL and GLU headers
      - wrote the rel-* GFX demos at the GFX dir

    * zydon (...@...): 
      - wrote the calendar and toolbar examples at the GUI dir

    * All 3rd-party tools from Mingw32 (http://www.mingw.org/)

    * Many rtlib console routines were based on the conio implementation for Mingw32


[Greetings]

    * Blitz: The first to see the compiler when it was just a toy (delete the sources!).
      Helped pointing me out the right paths to follow in order to generate better code.
      Helped finding tons of bugs and wrote the first real apps.

    * Marzec: Loads of tests, besides giving many ideas.

    * Nexinarus: Organized the documentation (W.I.P.), found bugs and saved a bunch of
      kangaroos in the middle time.

    * VonGodric: author of the first (an unique at the moment) freeBASIC IDE: FBIDE (download 
      it here: http://www.hot.ee/wizgui/setup.exe) and also reported loatsa bugs (i'm getting 
      tired of typing that, arf)

    * Rel: Best beta tester ever, found loads of bugs.

    * Plasma: Wrote the first FB demos for fmod and BASS. Also the register of the freebasic.net 
      domain.

    * DrV: reported some serious bugs - using Sourceforge's bug tracking services, as anyone else 
      should.

    * Jofers: Fitted a horse icon in just 16x16 pixels (awesome work, btw ;), also working on the
      documentation (more info at http://freebasicdoc.sourceforge.net).

    * Wildcard: Created the biggest FB forum and helped making FB known even before it was
      released.

    * Nek, na_th_an, Sj Zero, Z!re: Some serious beta testing - meaning: loads of bugs found.

    * Dav, WD, Alias, Urger: Beta testing.

    * People at Qbasicnews (too many to list, thanks all!) for all the support and feedback.

    * You, for giving it a try - you won't regret.. er.


[Links]

    Site: http://fbc.sourceforge.net/ (or http://www.sourceforge.net/projects/fbc)

    IRC channel: irc://irc.freenode.net/freeBASIC


[Libraries]

    BASS and BASSMod: http://www.un4seen.com/

    fmod: http://www.fmod.org/

    FreeImage: http://freeimage.sourceforge.net/

    GLUT: http://www.xmission.com/~nate/glut.html

    OpenGL: http://www.opengl.org/

    SDL: http://www.libsdl.org/ (look under Projects for SDL_net, SDL_image, etc)

    TinyPTC: http://www.gaffer.org/tinyptc/

    Zlib: http://www.zlib.net/


[EOF]