''
''
'' allegro\platform\almngw32 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_platform_almngw32_bi__
#define __allegro_platform_almngw32_bi__

#include once "crt/io.bi"
#include once "crt/fcntl.bi"
#include once "crt/malloc.bi"

#ifdef ALLEGRO_STATICLINK
 #inclib "alleg_s"
 #define ALLEGRO_PLATFORM_STR "MinGW32.s"
#else
 #inclib "alleg"
 #define ALLEGRO_PLATFORM_STR "MinGW32"
#endif

#define ALLEGRO_WINDOWS
#define ALLEGRO_I386
#define ALLEGRO_LITTLE_ENDIAN
#define ALLEGRO_USE_CONSTRUCTOR

#ifdef USE_CONSOLE
 #define ALLEGRO_CONSOLE_OK
 #define ALLEGRO_NO_MAGIC_MAIN
#endif

#define ALLEGRO_ASM_PREFIX "_"
#define ALLEGRO_EXTRA_HEADER "allegro/platform/alwin.bi"
#define ALLEGRO_INTERNAL_HEADER "allegro/platform/aintwin.bi"
#define ALLEGRO_ASMCAPA_HEADER "obj/mingw32/asmcapa.bi"

#ifdef ALLEGRO_STATICLINK
 #define _AL_DLL
#else
 #define _AL_DLL import
#endif

#endif
