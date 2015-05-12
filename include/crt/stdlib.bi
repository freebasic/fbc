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
#elseif defined(__FB_LINUX__)
#include once "crt/linux/stdlib.bi"
#endif

type div_t
	quot as integer
	rem_ as integer
end type

type ldiv_t
	quot as integer
	rem_ as integer
end type

type lldiv_t
	quot as longint
	rem_ as longint
end type

extern "c"
declare sub exit_ alias "exit" (byval as integer)
declare function system_ alias "system" (byval as zstring ptr) as integer
declare function abs_ alias "abs" (byval as integer) as integer
declare function atof (byval as zstring ptr) as double
declare function atoi (byval as zstring ptr) as integer
declare function atol (byval as zstring ptr) as integer
declare function strtod (byval as zstring ptr, byval as byte ptr ptr) as double
declare function strtof (byval nptr as zstring ptr, byval endptr as byte ptr ptr) as single
declare function strtold (byval __restrict__ as zstring ptr, byval __restrict__ as byte ptr ptr) as double
declare function strtol (byval as zstring ptr, byval as byte ptr ptr, byval as integer) as integer
declare function strtoul (byval as zstring ptr, byval as byte ptr ptr, byval as integer) as uinteger
declare function wcstod (byval as wchar_t ptr, byval as wchar_t ptr ptr) as double
declare function wcstof (byval nptr as wchar_t ptr, byval endptr as wchar_t ptr ptr) as single
declare function wcstold (byval __restrict__ as wchar_t ptr, byval __restrict__ as wchar_t ptr ptr) as double
declare function wcstol (byval as wchar_t ptr, byval as wchar_t ptr ptr, byval as integer) as integer
declare function wcstoul (byval as wchar_t ptr, byval as wchar_t ptr ptr, byval as integer) as uinteger
declare function wcstombs (byval as zstring ptr, byval as wchar_t ptr, byval as size_t) as size_t
declare function wctomb (byval as zstring ptr, byval as wchar_t) as integer
declare function mblen (byval as zstring ptr, byval as size_t) as integer
declare function mbstowcs (byval as wchar_t ptr, byval as zstring ptr, byval as size_t) as size_t
declare function mbtowc (byval as wchar_t ptr, byval as zstring ptr, byval as size_t) as integer
declare function rand () as integer
declare sub srand (byval as uinteger)
declare function calloc (byval as size_t, byval as size_t) as any ptr
declare function malloc (byval as size_t) as any ptr
declare function realloc (byval as any ptr, byval as size_t) as any ptr
declare sub free (byval as any ptr)
declare sub abort ()
declare function atexit (byval as sub cdecl()) as integer
declare function getenv (byval as zstring ptr) as zstring ptr
declare function bsearch (byval as any ptr, byval as any ptr, byval as size_t, byval as size_t, byval as function cdecl(byval as any ptr, byval as any ptr) as integer) as any ptr
declare sub qsort (byval as any ptr, byval as size_t, byval as size_t, byval as function cdecl(byval as any ptr, byval as any ptr) as integer)
declare function labs (byval as integer) as integer
declare function div (byval as integer, byval as integer) as div_t
declare function ldiv (byval as integer, byval as integer) as ldiv_t
declare function lldiv (byval as longint, byval as longint) as lldiv_t
declare function llabs (byval _j as longint) as longint
declare function strtoll (byval __restrict__ as zstring ptr, byval __restrict as byte ptr ptr, byval as integer) as longint
declare function strtoull (byval __restrict__ as zstring ptr, byval __restrict__ as byte ptr ptr, byval as integer) as ulongint
declare function atoll (byval as zstring ptr) as longint
declare function wtoll (byval as wchar_t ptr) as longint
declare function lltoa (byval as longint, byval as zstring ptr, byval as integer) as zstring ptr
declare function ulltoa (byval as ulongint, byval as zstring ptr, byval as integer) as zstring ptr
declare function lltow (byval as longint, byval as wchar_t ptr, byval as integer) as wchar_t ptr
declare function ulltow (byval as ulongint, byval as wchar_t ptr, byval as integer) as wchar_t ptr
end extern

#endif
