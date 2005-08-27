''
''
'' string -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __string_bi__
#define __string_bi__

#include once "crt/stddef.bi"

declare function memchr cdecl alias "memchr" (byval as any ptr, byval as integer, byval as size_t) as any ptr
declare function memcmp cdecl alias "memcmp" (byval as any ptr, byval as any ptr, byval as size_t) as integer
declare function memcpy cdecl alias "memcpy" (byval as any ptr, byval as any ptr, byval as size_t) as any ptr
declare function memmove cdecl alias "memmove" (byval as any ptr, byval as any ptr, byval as size_t) as any ptr
declare function memset cdecl alias "memset" (byval as any ptr, byval as integer, byval as size_t) as any ptr
declare function strcat cdecl alias "strcat" (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strchr cdecl alias "strchr" (byval as zstring ptr, byval as integer) as zstring ptr
declare function strcmp cdecl alias "strcmp" (byval as zstring ptr, byval as zstring ptr) as integer
declare function strcoll cdecl alias "strcoll" (byval as zstring ptr, byval as zstring ptr) as integer
declare function strcpy cdecl alias "strcpy" (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strcspn cdecl alias "strcspn" (byval as zstring ptr, byval as zstring ptr) as size_t
declare function strerror cdecl alias "strerror" (byval as integer) as zstring ptr
declare function strlen cdecl alias "strlen" (byval as zstring ptr) as size_t
declare function strncat cdecl alias "strncat" (byval as zstring ptr, byval as zstring ptr, byval as size_t) as zstring ptr
declare function strncmp cdecl alias "strncmp" (byval as zstring ptr, byval as zstring ptr, byval as size_t) as integer
declare function strncpy cdecl alias "strncpy" (byval as zstring ptr, byval as zstring ptr, byval as size_t) as zstring ptr
declare function strpbrk cdecl alias "strpbrk" (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strrchr cdecl alias "strrchr" (byval as zstring ptr, byval as integer) as zstring ptr
declare function strspn cdecl alias "strspn" (byval as zstring ptr, byval as zstring ptr) as size_t
declare function strstr cdecl alias "strstr" (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strtok cdecl alias "strtok" (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strxfrm cdecl alias "strxfrm" (byval as zstring ptr, byval as zstring ptr, byval as size_t) as size_t
declare function _strerror cdecl alias "_strerror" (byval as zstring ptr) as zstring ptr
declare function _memccpy cdecl alias "_memccpy" (byval as any ptr, byval as any ptr, byval as integer, byval as size_t) as any ptr
declare function _memicmp cdecl alias "_memicmp" (byval as any ptr, byval as any ptr, byval as size_t) as integer
declare function _strdup cdecl alias "_strdup" (byval as zstring ptr) as zstring ptr
declare function _strcmpi cdecl alias "_strcmpi" (byval as zstring ptr, byval as zstring ptr) as integer
declare function _stricmp cdecl alias "_stricmp" (byval as zstring ptr, byval as zstring ptr) as integer
declare function _stricoll cdecl alias "_stricoll" (byval as zstring ptr, byval as zstring ptr) as integer
declare function _strlwr cdecl alias "_strlwr" (byval as zstring ptr) as zstring ptr
declare function _strnicmp cdecl alias "_strnicmp" (byval as zstring ptr, byval as zstring ptr, byval as size_t) as integer
declare function _strnset cdecl alias "_strnset" (byval as zstring ptr, byval as integer, byval as size_t) as zstring ptr
declare function _strrev cdecl alias "_strrev" (byval as zstring ptr) as zstring ptr
declare function _strset cdecl alias "_strset" (byval as zstring ptr, byval as integer) as zstring ptr
declare function _strupr cdecl alias "_strupr" (byval as zstring ptr) as zstring ptr
declare sub _swab cdecl alias "_swab" (byval as zstring ptr, byval as zstring ptr, byval as size_t)
declare function _strncoll cdecl alias "_strncoll" (byval as zstring ptr, byval as zstring ptr, byval as size_t) as integer
declare function _strnicoll cdecl alias "_strnicoll" (byval as zstring ptr, byval as zstring ptr, byval as size_t) as integer
declare function wcscat cdecl alias "wcscat" (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcschr cdecl alias "wcschr" (byval as wchar_t ptr, byval as wchar_t) as wchar_t ptr
declare function wcscmp cdecl alias "wcscmp" (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function wcscoll cdecl alias "wcscoll" (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function wcscpy cdecl alias "wcscpy" (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcscspn cdecl alias "wcscspn" (byval as wchar_t ptr, byval as wchar_t ptr) as size_t
declare function wcslen cdecl alias "wcslen" (byval as wchar_t ptr) as size_t
declare function wcsncat cdecl alias "wcsncat" (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as wchar_t ptr
declare function wcsncmp cdecl alias "wcsncmp" (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as integer
declare function wcsncpy cdecl alias "wcsncpy" (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as wchar_t ptr
declare function wcspbrk cdecl alias "wcspbrk" (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcsrchr cdecl alias "wcsrchr" (byval as wchar_t ptr, byval as wchar_t) as wchar_t ptr
declare function wcsspn cdecl alias "wcsspn" (byval as wchar_t ptr, byval as wchar_t ptr) as size_t
declare function wcsstr cdecl alias "wcsstr" (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcstok cdecl alias "wcstok" (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcsxfrm cdecl alias "wcsxfrm" (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as size_t
declare function _wcsdup cdecl alias "_wcsdup" (byval as wchar_t ptr) as wchar_t ptr
declare function _wcsicmp cdecl alias "_wcsicmp" (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function _wcsicoll cdecl alias "_wcsicoll" (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function _wcslwr cdecl alias "_wcslwr" (byval as wchar_t ptr) as wchar_t ptr
declare function _wcsnicmp cdecl alias "_wcsnicmp" (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as integer
declare function _wcsnset cdecl alias "_wcsnset" (byval as wchar_t ptr, byval as wchar_t, byval as size_t) as wchar_t ptr
declare function _wcsrev cdecl alias "_wcsrev" (byval as wchar_t ptr) as wchar_t ptr
declare function _wcsset cdecl alias "_wcsset" (byval as wchar_t ptr, byval as wchar_t) as wchar_t ptr
declare function _wcsupr cdecl alias "_wcsupr" (byval as wchar_t ptr) as wchar_t ptr
declare function _wcsncoll cdecl alias "_wcsncoll" (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as integer
declare function _wcsnicoll cdecl alias "_wcsnicoll" (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as integer

#endif
