''
''
'' stdlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_stdlib_bi__
#define __crt_stdlib_bi__

#include once "crt/stddef.bi"

#if defined(__FB_WIN32__)
#include once "crt/win32/stdlib.bi"
#endif

declare function atof cdecl alias "atof" (byval as zstring ptr) as double
declare function atoi cdecl alias "atoi" (byval as zstring ptr) as integer
declare function atol cdecl alias "atol" (byval as zstring ptr) as integer
declare function strtod cdecl alias "strtod" (byval as zstring ptr, byval as byte ptr ptr) as double
declare function strtof cdecl alias "strtof" (byval nptr as zstring ptr, byval endptr as byte ptr ptr) as single
declare function strtold cdecl alias "strtold" (byval __restrict__ as zstring ptr, byval __restrict__ as byte ptr ptr) as double
declare function strtol cdecl alias "strtol" (byval as zstring ptr, byval as byte ptr ptr, byval as integer) as integer
declare function strtoul cdecl alias "strtoul" (byval as zstring ptr, byval as byte ptr ptr, byval as integer) as uinteger
declare function wcstod cdecl alias "wcstod" (byval as wchar_t ptr, byval as wchar_t ptr ptr) as double
declare function wcstof cdecl alias "wcstof" (byval nptr as wchar_t ptr, byval endptr as wchar_t ptr ptr) as single
declare function wcstold cdecl alias "wcstold" (byval __restrict__ as wchar_t ptr, byval __restrict__ as wchar_t ptr ptr) as double
declare function wcstol cdecl alias "wcstol" (byval as wchar_t ptr, byval as wchar_t ptr ptr, byval as integer) as integer
declare function wcstoul cdecl alias "wcstoul" (byval as wchar_t ptr, byval as wchar_t ptr ptr, byval as integer) as uinteger
declare function wcstombs cdecl alias "wcstombs" (byval as zstring ptr, byval as wchar_t ptr, byval as size_t) as size_t
declare function wctomb cdecl alias "wctomb" (byval as zstring ptr, byval as wchar_t) as integer
declare function mblen cdecl alias "mblen" (byval as zstring ptr, byval as size_t) as integer
declare function mbstowcs cdecl alias "mbstowcs" (byval as wchar_t ptr, byval as zstring ptr, byval as size_t) as size_t
declare function mbtowc cdecl alias "mbtowc" (byval as wchar_t ptr, byval as zstring ptr, byval as size_t) as integer
declare function rand cdecl alias "rand" () as integer
declare sub srand cdecl alias "srand" (byval as uinteger)
declare function calloc cdecl alias "calloc" (byval as size_t, byval as size_t) as any ptr
declare function malloc cdecl alias "malloc" (byval as size_t) as any ptr
declare function realloc cdecl alias "realloc" (byval as any ptr, byval as size_t) as any ptr
declare sub free cdecl alias "free" (byval as any ptr)
declare sub abort cdecl alias "abort" ()
declare sub exit_ cdecl alias "exit" (byval as integer)
declare function atexit cdecl alias "atexit" (byval as sub cdecl()) as integer
declare function system_ cdecl alias "system" (byval as zstring ptr) as integer
declare function getenv cdecl alias "getenv" (byval as zstring ptr) as zstring ptr
declare function bsearch cdecl alias "bsearch" (byval as any ptr, byval as any ptr, byval as size_t, byval as size_t, byval as function cdecl(byval as any ptr, byval as any ptr) as integer) as any ptr
declare sub qsort cdecl alias "qsort" (byval as any ptr, byval as size_t, byval as size_t, byval as function cdecl(byval as any ptr, byval as any ptr) as integer)
declare function abs_ cdecl alias "abs" (byval as integer) as integer
declare function labs cdecl alias "labs" (byval as integer) as integer

type div_t
	quot as integer
	rem as integer
end type

type ldiv_t
	quot as integer
	rem as integer
end type

declare function div cdecl alias "div" (byval as integer, byval as integer) as div_t
declare function ldiv cdecl alias "ldiv" (byval as integer, byval as integer) as ldiv_t

type lldiv_t
	quot as longint
	rem as longint
end type

declare function lldiv cdecl alias "lldiv" (byval as longint, byval as longint) as lldiv_t
declare function llabs cdecl alias "llabs" (byval _j as longint) as longint
declare function strtoll cdecl alias "strtoll" (byval __restrict__ as zstring ptr, byval __restrict as byte ptr ptr, byval as integer) as longint
declare function strtoull cdecl alias "strtoull" (byval __restrict__ as zstring ptr, byval __restrict__ as byte ptr ptr, byval as integer) as ulongint
declare function atoll cdecl alias "atoll" (byval as zstring ptr) as longint
declare function wtoll cdecl alias "wtoll" (byval as wchar_t ptr) as longint
declare function lltoa cdecl alias "lltoa" (byval as longint, byval as zstring ptr, byval as integer) as zstring ptr
declare function ulltoa cdecl alias "ulltoa" (byval as ulongint, byval as zstring ptr, byval as integer) as zstring ptr
declare function lltow cdecl alias "lltow" (byval as longint, byval as wchar_t ptr, byval as integer) as wchar_t ptr
declare function ulltow cdecl alias "ulltow" (byval as ulongint, byval as wchar_t ptr, byval as integer) as wchar_t ptr

#endif
