''
''
'' allegro\platform\aldjgpp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_platform_aldjgpp_bi__
#define __allegro_platform_aldjgpp_bi__

#include once "dos/pc.bi"
#include once "crt/dir.bi"
#include once "dos/dpmi.bi"
#include once "dos/go32.bi"
#include once "crt/fcntl.bi"
#include once "dos/sys/farptr.bi"

#inclib "alleg"
#define ALLEGRO_PLATFORM_STR "djgpp"

#define ALLEGRO_DOS
#define ALLEGRO_I386
#define ALLEGRO_LITTLE_ENDIAN
#define ALLEGRO_CONSOLE_OK
#define ALLEGRO_VRAM_SINGLE_SURFACE
#define ALLEGRO_USE_CONSTRUCTOR

declare sub _unlock_dpmi_data cdecl alias "_unlock_dpmi_data" (byval addr as any ptr, byval size as integer)

#define END_OF_FUNCTION(x) sub x##_end() : end sub
#define END_OF_STATIC_FUNCTION(x) private sub x##_end() : end sub
#define LOCK_DATA(d, s) _go32_dpmi_lock_data(cast(any ptr, d), s)
#define LOCK_CODE(c, s) _go32_dpmi_lock_code(cast(any ptr, c), s)
#define UNLOCK_DATA(d,s) _unlock_dpmi_data(cast(any ptr, d), s)
#define LOCK_VARIABLE(x) LOCK_DATA(cast(any ptr, @x), sizeof(x))
#define LOCK_FUNCTION(x) LOCK_CODE(cast(any ptr, @x), cuint(@x##_end) - cuint(@x))

#ifdef _USE_LFN
 #define ALLEGRO_LFN _USE_LFN
#else
 #define ALLEGRO_LFN 0
#endif

#define _video_ds() _dos_ds

#define bmp_select(bmp) _farsetsel((bmp)->seg)
#define bmp_write8(addr, c) _farnspokeb(addr, c)
#define bmp_write15(addr, c) _farnspokew(addr, c)
#define bmp_write16(addr, c) _farnspokew(addr, c)
#define bmp_write24(addr, c) _farnspokew(addr, cint(c) and &hFFFF) : _farnspokeb(cuint(addr)+2, cint(c) shr 16)
#define bmp_write32(addr, c) _farnspokel(addr, c)
#define bmp_read8(addr) _farnspeekb(addr)
#define bmp_read15(addr) _farnspeekw(addr)
#define bmp_read16(addr) _farnspeekw(addr)
#define bmp_read32(addr) _farnspeekl(addr)
#define bmp_read24(addr) (_farnspeekl(addr) and &hFFFFFF)

#define ALLEGRO_ASM_PREFIX "_"
#define ALLEGRO_ASM_USE_FS
#define ALLEGRO_EXTRA_HEADER "allegro/platform/aldos.bi"
#define ALLEGRO_INTERNAL_HEADER "allegro/platform/aintdos.bi"
#define ALLEGRO_ASMCAPA_HEADER "obj/djgpp/asmcapa.h"

#endif
