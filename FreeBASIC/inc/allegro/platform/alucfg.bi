''
''
'' allegro\platform\alucfg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_platform_alucfg_bi__
#define __allegro_platform_alucfg_bi__

#include once "crt/fcntl.bi"
''#include once "crt/unistd.bi"

#define ALLEGRO_PLATFORM_STR "Unix"
#inclib "alleg"
#inclib "X11"
#inclib "Xext"
#inclib "Xpm"

#ifndef __FB_BIGENDIAN__
#define ALLEGRO_I386
#define ALLEGRO_LITTLE_ENDIAN
#else
#define ALLEGRO_BIG_ENDIAN
#endif
#define ALLEGRO_USE_CONSTRUCTOR

#define ALLEGRO_ASM_PREFIX ""
#define ALLEGRO_EXTRA_HEADER "allegro/platform/alunix.bi"
#define ALLEGRO_INTERNAL_HEADER "allegro/platform/aintunix.bi"

#ifndef O_BINARY
#define O_BINARY 0
#define O_TEXT 0
#endif

#endif
