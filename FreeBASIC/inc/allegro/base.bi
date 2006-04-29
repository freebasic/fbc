''
''
'' allegro\base -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_base_bi__
#define __allegro_base_bi__

#include once "crt/errno.bi"
#include once "crt/limits.bi"
#include once "crt/stdarg.bi"
#include once "crt/stddef.bi"
#include once "crt/stdlib.bi"
#include once "crt/time.bi"
#include once "allegro/internal/alconfig.bi"

#define ALLEGRO_VERSION 4
#define ALLEGRO_SUB_VERSION 0
#define ALLEGRO_WIP_VERSION 3
#define ALLEGRO_VERSION_STR "4.0.3"
#define ALLEGRO_DATE_STR "2003"
#define ALLEGRO_DATE 20030419

#ifndef TRUE
#define TRUE -1
#define FALSE 0
#endif

#define AL_MIN(x,y) iif( (x) <= (y), (x), (y) )
#define MIN AL_MIN
#define AL_MAX(x,y) iif( (x) >= (y), (x), (y) )
#define MAX AL_MAX
#define AL_MID(x,y,z) AL_MAX(x, AL_MIN(y, z))
#define AL_PI 3.14159265358979323846
#define AL_ID(a,b,c,d) (((a) shl 24) or ((b) shl 16) or ((c) shl 8) or (d))

extern _AL_DLL allegro_errno alias "allegro_errno" as integer ptr

type _DRIVER_INFO
	id as integer
	driver as any ptr
	autodetect as integer
end type

#endif
