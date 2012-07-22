''
''
'' allegro\internal\alconfig -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_internal_alconfig_bi__
#define __allegro_internal_alconfig_bi__

#define ALLEGRO_COLOR8
#define ALLEGRO_COLOR16
#define ALLEGRO_COLOR24
#define ALLEGRO_COLOR32

#include once "allegro/platform/alplatf.bi"

#if defined(ALLEGRO_DJGPP)
 #include once "allegro/platform/aldjgpp.bi"
#elseif defined(ALLEGRO_MINGW32)
 #include once "allegro/platform/almngw32.bi"
#elseif defined(ALLEGRO_UNIX)
 #include once "allegro/platform/alucfg.bi"
#else
 #error Unsupported platform
#endif

#ifndef END_OF_FUNCTION
 #define END_OF_FUNCTION(x)
 #define END_OF_STATIC_FUNCTION(x)
 #define LOCK_DATA(d, s)
 #define LOCK_CODE(c, s)
 #define UNLOCK_DATA(d, s)
 #define LOCK_VARIABLE(x)
 #define LOCK_FUNCTION(x)
#endif

#ifndef END_OF_MAIN
 #define END_OF_MAIN()
#endif

#ifndef _AL_DLL
 #define _AL_DLL
#endif

#ifndef ALLEGRO_LFN
 #define ALLEGRO_LFN 1
#endif

#if defined(ALLEGRO_DOS) or defined(ALLEGRO_WINDOWS)
 #define OTHER_PATH_SEPARATOR asc($"\")
 #define DEVICE_SEPARATOR asc(":")
#else
 #define OTHER_PATH_SEPARATOR asc("/")
 #define DEVICE_SEPARATOR 0
#endif

#ifndef FA_RDONLY
 #define FA_RDONLY 1
 #define FA_HIDDEN 2
 #define FA_SYSTEM 4
 #define FA_LABEL 8
 #define FA_DIREC 16
 #define FA_ARCH 32
#endif

#ifndef _video_ds
 #define _video_ds() _default_ds()
#endif

#ifndef ALLEGRO_DJGPP
 #define _farsetsel(seg)
 #define _farnspokeb(addr, val_) *cast(unsigned byte,addr) = (val_)
 #define _farnspokew(addr, val_) *cast(unsigned short,addr) = (val_)
 #define _farnspokel(addr, val_) *cast(unsigned integer,addr) = (val_)
 #define _farnspeekb(addr) (*cast(unsigned byte,addr))
 #define _farnspeekw(addr) (*cast(unsigned short,addr))
 #define _farnspeekl(addr) (*cast(unsigned integer,addr))
#endif

#ifdef ALLEGRO_LITTLE_ENDIAN
 #define READ3BYTES(p) (cint(*(p)) or (cint(*((p) + 1)) shl 8) or (cint(*((p) + 2)) shl 16))
 #define WRITE3BYTES(p,c) *(p) = (c): *((p) + 1) = (c) shr 8: *((p) + 2) = (c) shr 16
#elseif defined(ALLEGRO_BIG_ENDIAN)
 #define READ3BYTES(p) ((cint(*(p)) shl 16) or (cint(*((p) + 1)) shl 8) or cint(*((p) + 2)))
 #define WRITE3BYTES(p,c) *(p) = (c) shr 16: *((p) + 1) = (c) shr 8: *((p) + 2) = (c)
#else
 #error endianess not defined
#endif

#ifndef bmp_select
 #define bmp_select(bmp)
#endif

#ifndef bmp_write8
 #define bmp_write8(addr, c) *cast(unsigned byte,addr) = (c)
 #define bmp_write15(addr, c) *cast(unsigned short,addr) = (c)
 #define bmp_write16(addr, c) *cast(unsigned short,addr) = (c)
 #define bmp_write32(addr, c) *cast(unsigned integer,addr) = (c)
 #define bmp_read8(addr) (*cast(unsigned byte,addr))
 #define bmp_read15(addr) (*cast(unsigned short ,addr))
 #define bmp_read16(addr) (*cast(unsigned short ,addr))
 #define bmp_read32(addr) (*cast(unsigned integer,addr))
 declare function bmp_read24 cdecl alias "bmp_read24" (byval addr as uinteger) as integer
 declare sub bmp_write24 cdecl alias "bmp_write24" (byval addr as uinteger, byval c as integer)
#endif

#endif
