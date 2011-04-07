''
''
'' string -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_string_bi__
#define __crt_string_bi__

#include once "crt/stddef.bi"

extern "c"

declare function memchr (byval as any ptr, byval as integer, byval as size_t) as any ptr
declare function memcmp (byval as any ptr, byval as any ptr, byval as size_t) as integer
declare function memcpy (byval as any ptr, byval as any ptr, byval as size_t) as any ptr
declare function memmove (byval as any ptr, byval as any ptr, byval as size_t) as any ptr
declare function memset (byval as any ptr, byval as integer, byval as size_t) as any ptr
declare function strcat (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strchr (byval as zstring ptr, byval as integer) as zstring ptr
declare function strcmp (byval as zstring ptr, byval as zstring ptr) as integer
declare function strcoll (byval as zstring ptr, byval as zstring ptr) as integer
declare function strcpy (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strcspn (byval as zstring ptr, byval as zstring ptr) as size_t
declare function strerror (byval as integer) as zstring ptr
declare function strlen (byval as zstring ptr) as size_t
declare function strncat (byval as zstring ptr, byval as zstring ptr, byval as size_t) as zstring ptr
declare function strncmp (byval as zstring ptr, byval as zstring ptr, byval as size_t) as integer
declare function strncpy (byval as zstring ptr, byval as zstring ptr, byval as size_t) as zstring ptr
declare function strpbrk (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strrchr (byval as zstring ptr, byval as integer) as zstring ptr
declare function strspn (byval as zstring ptr, byval as zstring ptr) as size_t
declare function strstr (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strtok (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function strxfrm (byval as zstring ptr, byval as zstring ptr, byval as size_t) as size_t
declare function wcscat (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcschr (byval as wchar_t ptr, byval as wchar_t) as wchar_t ptr
declare function wcscmp (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function wcscoll (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function wcscpy (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcscspn (byval as wchar_t ptr, byval as wchar_t ptr) as size_t
declare function wcslen (byval as wchar_t ptr) as size_t
declare function wcsncat (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as wchar_t ptr
declare function wcsncmp (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as integer
declare function wcsncpy (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as wchar_t ptr
declare function wcspbrk (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcsrchr (byval as wchar_t ptr, byval as wchar_t) as wchar_t ptr
declare function wcsspn (byval as wchar_t ptr, byval as wchar_t ptr) as size_t
declare function wcsstr (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcstok (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function wcsxfrm (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as size_t

#ifdef __FB_WIN32__
declare function _strerror (byval as zstring ptr) as zstring ptr
declare function _memccpy (byval as any ptr, byval as any ptr, byval as integer, byval as size_t) as any ptr
declare function _memicmp (byval as any ptr, byval as any ptr, byval as size_t) as integer
declare function _strdup (byval as zstring ptr) as zstring ptr
declare function _strcmpi (byval as zstring ptr, byval as zstring ptr) as integer
declare function _stricmp (byval as zstring ptr, byval as zstring ptr) as integer
declare function _stricoll (byval as zstring ptr, byval as zstring ptr) as integer
declare function _strlwr (byval as zstring ptr) as zstring ptr
declare function _strnicmp (byval as zstring ptr, byval as zstring ptr, byval as size_t) as integer
declare function _strnset (byval as zstring ptr, byval as integer, byval as size_t) as zstring ptr
declare function _strrev (byval as zstring ptr) as zstring ptr
declare function _strset (byval as zstring ptr, byval as integer) as zstring ptr
declare function _strupr (byval as zstring ptr) as zstring ptr
declare sub _swab (byval as zstring ptr, byval as zstring ptr, byval as size_t)
declare function _strncoll (byval as zstring ptr, byval as zstring ptr, byval as size_t) as integer
declare function _strnicoll (byval as zstring ptr, byval as zstring ptr, byval as size_t) as integer
declare function _wcsdup (byval as wchar_t ptr) as wchar_t ptr
declare function _wcsicmp (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function _wcsicoll (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function _wcslwr (byval as wchar_t ptr) as wchar_t ptr
declare function _wcsnicmp (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as integer
declare function _wcsnset (byval as wchar_t ptr, byval as wchar_t, byval as size_t) as wchar_t ptr
declare function _wcsrev (byval as wchar_t ptr) as wchar_t ptr
declare function _wcsset (byval as wchar_t ptr, byval as wchar_t) as wchar_t ptr
declare function _wcsupr (byval as wchar_t ptr) as wchar_t ptr
declare function _wcsncoll (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as integer
declare function _wcsnicoll (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as integer
#endif

end extern

#endif
