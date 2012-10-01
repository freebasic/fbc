''
''
'' allegro\unicode -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_unicode_bi__
#define __allegro_unicode_bi__

#include once "allegro/base.bi"

#define U_ASCII AL_ID(asc("A"),asc("S"),asc("C"),asc("8"))
#define U_ASCII_CP AL_ID(asc("A"),asc("S"),asc("C"),asc("P"))
#define U_UNICODE AL_ID(asc("U"),asc("N"),asc("I"),asc("C"))
#define U_UTF8 AL_ID(asc("U"),asc("T"),asc("F"),asc("8"))
#define U_CURRENT AL_ID(asc("c"),asc("u"),asc("r"),asc("."))

declare sub set_uformat cdecl alias "set_uformat" (byval type as integer)
declare function get_uformat cdecl alias "get_uformat" () as integer
declare sub register_uformat cdecl alias "register_uformat" (byval type as integer, byval u_getc as function cdecl(byval as zstring ptr) as integer, byval u_getx as function cdecl(byval as byte ptr ptr) as integer, byval u_setc as function cdecl(byval as zstring ptr, byval as integer) as integer, byval u_width as function cdecl(byval as zstring ptr) as integer, byval u_cwidth as function cdecl(byval as integer) as integer, byval u_isok as function cdecl(byval as integer) as integer, byval u_width_max as integer)
declare sub set_ucodepage cdecl alias "set_ucodepage" (byval table as ushort ptr, byval extras as ushort ptr)
declare function need_uconvert cdecl alias "need_uconvert" (byval s as zstring ptr, byval type as integer, byval newtype as integer) as integer
declare function uconvert_size cdecl alias "uconvert_size" (byval s as zstring ptr, byval type as integer, byval newtype as integer) as integer
declare sub do_uconvert cdecl alias "do_uconvert" (byval s as zstring ptr, byval type as integer, byval buf as zstring ptr, byval newtype as integer, byval size as integer)
declare function uconvert cdecl alias "uconvert" (byval s as zstring ptr, byval type as integer, byval buf as zstring ptr, byval newtype as integer, byval size as integer) as zstring ptr
declare function uwidth_max cdecl alias "uwidth_max" (byval type as integer) as integer

#define uconvert_ascii(s, buf) uconvert(s, U_ASCII, buf, U_CURRENT, sizeof(buf))
#define uconvert_toascii(s, buf) uconvert(s, U_CURRENT, buf, U_ASCII, sizeof(buf))

#define EMPTY_STRING_ chr(0,0,0,0)

extern _AL_DLL __empty_string alias "empty_string" as byte
#define empty_string *cast( zstring ptr, @__empty_string )
extern _AL_DLL ugetc alias "ugetc" as function cdecl(byval as zstring ptr) as integer
extern _AL_DLL ugetx alias "ugetx" as function cdecl(byval as byte ptr ptr) as integer
extern _AL_DLL ugetxc alias "ugetxc" as function cdecl(byval as byte ptr ptr) as integer
extern _AL_DLL usetc alias "usetc" as function cdecl(byval as zstring ptr, byval as integer) as integer
extern _AL_DLL uwidth alias "uwidth" as function cdecl(byval as zstring ptr) as integer
extern _AL_DLL ucwidth alias "ucwidth" as function cdecl(byval as integer) as integer
extern _AL_DLL uisok alias "uisok" as function cdecl(byval as integer) as integer

declare function uoffset cdecl alias "uoffset" (byval s as zstring ptr, byval index as integer) as integer
declare function ugetat cdecl alias "ugetat" (byval s as zstring ptr, byval index as integer) as integer
declare function usetat cdecl alias "usetat" (byval s as zstring ptr, byval index as integer, byval c as integer) as integer
declare function uinsert cdecl alias "uinsert" (byval s as zstring ptr, byval index as integer, byval c as integer) as integer
declare function uremove cdecl alias "uremove" (byval s as zstring ptr, byval index as integer) as integer
declare function utolower cdecl alias "utolower" (byval c as integer) as integer
declare function utoupper cdecl alias "utoupper" (byval c as integer) as integer
declare function uisspace cdecl alias "uisspace" (byval c as integer) as integer
declare function uisdigit cdecl alias "uisdigit" (byval c as integer) as integer
declare function ustrsize cdecl alias "ustrsize" (byval s as zstring ptr) as integer
declare function ustrsizez cdecl alias "ustrsizez" (byval s as zstring ptr) as integer
declare function _ustrdup cdecl alias "_ustrdup" (byval src as zstring ptr, byval malloc_func as sub cdecl(byval as size_t)) as zstring ptr
declare function ustrzcpy cdecl alias "ustrzcpy" (byval dest as zstring ptr, byval size as integer, byval src as zstring ptr) as zstring ptr
declare function ustrzcat cdecl alias "ustrzcat" (byval dest as zstring ptr, byval size as integer, byval src as zstring ptr) as zstring ptr
declare function ustrlen cdecl alias "ustrlen" (byval s as zstring ptr) as integer
declare function ustrcmp cdecl alias "ustrcmp" (byval s1 as zstring ptr, byval s2 as zstring ptr) as integer
declare function ustrzncpy cdecl alias "ustrzncpy" (byval dest as zstring ptr, byval size as integer, byval src as zstring ptr, byval n as integer) as zstring ptr
declare function ustrzncat cdecl alias "ustrzncat" (byval dest as zstring ptr, byval size as integer, byval src as zstring ptr, byval n as integer) as zstring ptr
declare function ustrncmp cdecl alias "ustrncmp" (byval s1 as zstring ptr, byval s2 as zstring ptr, byval n as integer) as integer
declare function ustricmp cdecl alias "ustricmp" (byval s1 as zstring ptr, byval s2 as zstring ptr) as integer
declare function ustrlwr cdecl alias "ustrlwr" (byval s as zstring ptr) as zstring ptr
declare function ustrupr cdecl alias "ustrupr" (byval s as zstring ptr) as zstring ptr
declare function ustrchr cdecl alias "ustrchr" (byval s as zstring ptr, byval c as integer) as zstring ptr
declare function ustrrchr cdecl alias "ustrrchr" (byval s as zstring ptr, byval c as integer) as zstring ptr
declare function ustrstr cdecl alias "ustrstr" (byval s1 as zstring ptr, byval s2 as zstring ptr) as zstring ptr
declare function ustrpbrk cdecl alias "ustrpbrk" (byval s as zstring ptr, byval set as zstring ptr) as zstring ptr
declare function ustrtok cdecl alias "ustrtok" (byval s as zstring ptr, byval set as zstring ptr) as zstring ptr
declare function ustrtok_r cdecl alias "ustrtok_r" (byval s as zstring ptr, byval set as zstring ptr, byval last as byte ptr ptr) as zstring ptr
declare function uatof cdecl alias "uatof" (byval s as zstring ptr) as double
declare function ustrtol cdecl alias "ustrtol" (byval s as zstring ptr, byval endp as byte ptr ptr, byval base as integer) as integer
declare function ustrtod cdecl alias "ustrtod" (byval s as zstring ptr, byval endp as byte ptr ptr) as double
declare function ustrerror cdecl alias "ustrerror" (byval err as integer) as zstring ptr
declare function uszprintf cdecl alias "uszprintf" (byval buf as zstring ptr, byval size as integer, byval format as zstring ptr, ...) as integer
declare function uvszprintf cdecl alias "uvszprintf" (byval buf as zstring ptr, byval size as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function usprintf cdecl alias "usprintf" (byval buf as zstring ptr, byval format as zstring ptr, ...) as integer

#ifndef ustrdup
#define ustrdup(src) _ustrdup(src, malloc)
#endif

#define ustrcpy(dest, src) ustrzcpy(dest, INT_MAX, src)
#define ustrcat(dest, src) ustrzcat(dest, INT_MAX, src)
#define ustrncpy(dest, src, n) ustrzncpy(dest, INT_MAX, src, n)
#define ustrncat(dest, src, n) ustrzncat(dest, INT_MAX, src, n)
#define uvsprintf(buf, format_, args) uvszprintf(buf, INT_MAX, format_, args)

#endif
