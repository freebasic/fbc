'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      Unicode support routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_UNICODE__H
#define ALLEGRO_UNICODE__H

#include "allegro/base.bi"

#define U_ASCII         AL_ID(asc("A"),ASC("S"),ASC("C"),ASC("8"))
#define U_ASCII_CP      AL_ID(ASC("A"),ASC("S"),ASC("C"),ASC("P"))
#define U_UNICODE       AL_ID(ASC("U"),ASC("N"),ASC("I"),ASC("C"))
#define U_UTF8          AL_ID(ASC("U"),ASC("T"),ASC("F"),ASC("8"))
#define U_CURRENT       AL_ID(ASC("c"),ASC("u"),ASC("r"),ASC("."))

Declare Sub set_uformat CDEcl alias "set_uformat" (ByVal _type As Integer)
Declare Function get_uformat CDecl alias "get_uformat" () As Integer
Declare Sub register_uformat CDecl alias "register_uformat" (ByVal _type As Integer, ByVal u_getc As Function(ByVal s As Byte Ptr) As Integer, ByVal u_getx As Function(ByVal s As Byte Ptr Ptr) As Integer, ByVal u_setc As Function(ByVal s As Byte Ptr, ByVal c As Integer) As Integer, ByVal u_width As Function(ByVal s As Byte Ptr) As Integer, ByVal u_cwidth As Function(ByVal c As Integer) As Integer, ByVal u_isok As Function(ByVal c As Integer) As Integer, ByVal u_width_max As Integer)
Declare Sub set_ucodepage CDecl Alias "set_ucodepage" (ByVal table As UShort Ptr, ByVal extras As UShort Ptr)

Declare Function need_uconvert CDecl Alias "need_uconvert" (ByVal s As Byte Ptr, ByVal _type As Integer, ByVal newtype As Integer) As Integer
Declare Function uconvert_size CDecl Alias "uconvert_size" (ByVal s As Byte Ptr, ByVAl _type As Integer, ByVal newtype As INteger) As Integer
Declare Sub do_uconvert CDecl Alias "do_uconvert" (ByVal s As Byte Ptr, ByVal _type As Integer, ByVal buf As Byte Ptr, ByVal newtype As Integer, ByVal size As Integer)
Declare Function uconvert CDecl Alias "uconvert" (ByVal s As Byte Ptr, ByVal _type As Integer, ByVal buf As Byte Ptr, ByVal newtype As Integer, ByVal size As Integer) AS Byte Ptr
Declare Function uwidth_max CDecl Alias "uwidth_max" (ByVal _type As Integer) As Integer

#define uconvert_ascii(s, buf)      uconvert(s, U_ASCII, buf, U_CURRENT, sizeof(buf))
#define uconvert_toascii(s, buf)    uconvert(s, U_CURRENT, buf, U_ASCII, sizeof(buf))

''#define EMPTY_STRING    "\0\0\0"

Extern Import al_empty_string Alias "empty_string" As Byte ''Ptr
#define empty_string @(al_empty_string)

Extern Import ugetc Alias "ugetc" As Function CDecl(ByVal s As Byte Ptr) As Integer
Extern Import ugetx Alias "ugetx" As Function CDecl(ByVal s As Byte Ptr Ptr) As Integer
Extern Import ugetxc Alias "ugetxc" As Function CDecl(ByVal s As Byte Ptr Ptr) As Integer
Extern Import usetc Alias "usetc" As Function CDecl(ByVal s As Byte Ptr, ByVal c As Integer) As Integer
Extern Import uwidth Alias "uwidth" As Function CDecl(ByVal s As Byte Ptr) As Integer
Extern Import ucwidth Alias "ucwidth" As Function CDecl(ByVal c As Integer) As Integer
Extern Import uisok Alias "uisok" As Function CDecl(ByVal c As Integer) As Integer
Declare Function uoffset CDecl Alias "uoffset" (ByVal s As Byte Ptr, ByVal index As INteger) As INteger
Declare Function ugetat CDecl Alias "ugetat" (ByVal s As Byte Ptr, ByVal index As Integer) As Integer
Declare Function usetat CDecl Alias "usetat" (ByVal s As Byte Ptr, ByVal index As Integer, ByVal c As Integer) As Integer
Declare Function uinsert CDecl Alias "uinsert" (ByVal s As Byte Ptr, ByVal index As Integer, BYVal c As Integer) As Integer
Declare Function uremove CDecl ALias "uremove" (ByVal s As Byte Ptr, ByVal index As Integer) As Integer
Declare Function utolower CDecl Alias "utolower" (ByVal c As Integer) As Integer
Declare Function utoupper CDecl Alias "utoupper" (ByVal c As Integer) As Integer
Declare Function uisspace CDecl Alias "uisspace" (ByVal c As Integer) As Integer
Declare Function uisdigit CDecl Alias "uisdigit" (ByVal c As Integer) As Integer
Declare Function ustrsize CDecl Alias "ustrsize" (ByVal s As Byte Ptr) As Integer
Declare Function ustrsizez CDecl Alias "ustrsizez" (ByVal s As Byte Ptr) As Integer
Declare Function _ustrdup CDecl Alias "_ustrdup" (ByVal src As Byte Ptr, ByVal malloc_func As Function CDecl(ByVal l As size_t) As Any Ptr) As Byte Ptr
Declare Function ustrzcpy CDecl Alias "ustrzcpy" (ByVal dest As Byte Ptr, ByVal size As Integer, ByVal src As Byte Ptr) As Byte Ptr
Declare Function ustrzcat CDecl Alias "ustrzcat" (ByVal dest As Byte Ptr, ByVal size As Integer, ByVal src As Byte Ptr) As Byte Ptr
Declare FUnction ustrlen CDecl Alias "ustrlen" (ByVal s As Byte Ptr) As Integer
Declare Function ustrcmp CDecl Alias "ustrcmp" (ByVal s1 As Byte Ptr, ByVal s2 As Byte Ptr) As Integer
Declare Function ustrzncpy CDecl Alias "ustrzncpy" (ByVal dest As Byte Ptr, ByVal size AS Integer, ByVal src As Byte Ptr, ByVal n As Integer) As Byte Ptr
Declare Function ustrzncat CDecl Alias "ustrzncat" (ByVal dest As Byte Ptr, ByVal size As Integer, ByVal src As Byte Ptr, ByVal n As Integer) As Byte Ptr
Declare Function ustrncmp CDecl Alias "ustrncmp" (ByVal s1 As Byte Ptr, ByVal s2 As Byte Ptr, ByVal n As Integer) As Integer
Declare Function ustricmp CDecl Alias "ustricmp" (ByVal s1 As Byte Ptr, ByVal s2 As Byte Ptr) As Integer
Declare Function ustrlwr CDecl Alias "ustrlwr" (ByVal s As Byte Ptr) As Byte Ptr
Declare Function ustrupr CDecl Alias "ustrupr" (ByVal s As Byte Ptr) As Byte Ptr
Declare Function ustrchr CDecl Alias "ustrchr" (ByVal s As Byte Ptr, ByVal c As Integer) As Byte Ptr
Declare Function ustrrchr CDecl Alias "ustrrchr" (ByVal s As Byte Ptr, ByVal c As Integer) As Byte Ptr
Declare Function ustrstr CDecl Alias "ustrstr" (ByVal s1 As Byte Ptr, ByVal s2 As Byte Ptr) As Byte PTr
Declare Function ustrpbrk CDecl Alias "ustrpbrk" (ByVal s As Byte Ptr, ByVal _set As Byte Ptr) As Byte Ptr
Declare Function ustrtok CDecl Alias "ustrtok" (ByVal s As Byte Ptr, ByVal _set As Byte Ptr) As Byte Ptr
Declare Function ustrtok_r CDecl Alias "ustrtok_r" (ByVal s As Byte Ptr, ByVal _set As Byte Ptr, ByVal _last As Byte Ptr Ptr) As Byte Ptr
Declare Function uatof CDecl Alias "uatof" (ByVal s As Byte Ptr) As Double
Declare Function ustrtol CDecl Alias "ustrtol" (ByVal s As Byte Ptr, ByVal endp As Byte Ptr Ptr, Byval base As Integer) As Integer
Declare Function ustrtod CDecl Alias "ustrtod" (ByVal s As Byte Ptr, ByVal endp As Byte Ptr Ptr) As Double
Declare Function ustrerror CDecl Alias "ustrerror" (ByVal _err As Integer) As Byte Ptr
Declare Function uszprintf CDecl Alias "uszprintf" (ByVal buf As Byte Ptr, ByVal size As Integer, ByVal format As Byte Ptr, ...) As Integer
''AL_FUNC(int, uvszprintf, (char *buf, int size, AL_CONST char *format, va_list args));
Declare Function usprintf CDecl Alias "usprintf" (ByVal buf As Byte Ptr, ByVal format As Byte Ptr, ...) As Integer

#ifndef ustrdup
	#define ustrdup(src)		_ustrdup(src, malloc)
#endif

#define ustrcpy(dest, src)		ustrzcpy(dest, INT_MAX, src)
#define ustrcat(dest, src)		ustrzcat(dest, INT_MAX, src)
#define ustrncpy(dest, src, n)		ustrzncpy(dest, INT_MAX, src, n)
#define ustrncat(dest, src, n)		ustrzncat(dest, INT_MAX, src, n)
#define uvsprintf(buf, format, args)	uvszprintf(buf, INT_MAX, format, args)

#endif
