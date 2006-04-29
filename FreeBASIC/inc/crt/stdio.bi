''
''
'' stdio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_stdio_bi__
#define __crt_stdio_bi__

#include once "crt/stddef.bi"
#include once "crt/stdarg.bi"

#define EOF_ (-1)

#ifndef SEEK_SET
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
#endif

#if defined(__FB_WIN32__)
#include once "crt/win32/stdio.bi"
#elseif defined(__FB_DOS__)
#include once "crt/dos/stdio.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/linux/stdio.bi"
#endif

declare function fopen cdecl alias "fopen" (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function freopen cdecl alias "freopen" (byval as zstring ptr, byval as zstring ptr, byval as FILE ptr) as FILE ptr
declare function fflush cdecl alias "fflush" (byval as FILE ptr) as integer
declare function fclose cdecl alias "fclose" (byval as FILE ptr) as integer
declare function remove cdecl alias "remove" (byval as zstring ptr) as integer
declare function rename_ cdecl alias "rename" (byval as zstring ptr, byval as zstring ptr) as integer
declare function tmpfile cdecl alias "tmpfile" () as FILE ptr
declare function tmpnam cdecl alias "tmpnam" (byval as zstring ptr) as zstring ptr
declare function tempnam cdecl alias "tempnam" (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function setvbuf cdecl alias "setvbuf" (byval as FILE ptr, byval as zstring ptr, byval as integer, byval as size_t) as integer
declare sub setbuf cdecl alias "setbuf" (byval as FILE ptr, byval as zstring ptr)
declare function fprintf cdecl alias "fprintf" (byval as FILE ptr, byval as zstring ptr, ...) as integer
declare function printf cdecl alias "printf" (byval as zstring ptr, ...) as integer
declare function sprintf cdecl alias "sprintf" (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function vfprintf cdecl alias "vfprintf" (byval as FILE ptr, byval as zstring ptr, byval as va_list) as integer
declare function vprintf cdecl alias "vprintf" (byval as zstring ptr, byval as va_list) as integer
declare function vsprintf cdecl alias "vsprintf" (byval as zstring ptr, byval as zstring ptr, byval as va_list) as integer
declare function vscanf cdecl alias "vscanf" (byval __restrict__ as zstring ptr, byval as va_list) as integer
declare function vfscanf cdecl alias "vfscanf" (byval __restrict__ as FILE ptr, byval __restrict__ as zstring ptr, byval as va_list) as integer
declare function vsscanf cdecl alias "vsscanf" (byval __restrict__ as zstring ptr, byval __restrict__ as zstring ptr, byval as va_list) as integer
declare function fscanf cdecl alias "fscanf" (byval as FILE ptr, byval as zstring ptr, ...) as integer
declare function scanf cdecl alias "scanf" (byval as zstring ptr, ...) as integer
declare function sscanf cdecl alias "sscanf" (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function fgetc cdecl alias "fgetc" (byval as FILE ptr) as integer
declare function fgets cdecl alias "fgets" (byval as zstring ptr, byval as integer, byval as FILE ptr) as zstring ptr
declare function fputc cdecl alias "fputc" (byval as integer, byval as FILE ptr) as integer
declare function fputs cdecl alias "fputs" (byval as zstring ptr, byval as FILE ptr) as integer
declare function getc cdecl alias "getc" (byval as FILE ptr) as integer
declare function getchar cdecl alias "getchar" () as integer
declare function gets cdecl alias "gets" (byval as zstring ptr) as zstring ptr
declare function putc cdecl alias "putc" (byval as integer, byval as FILE ptr) as integer
declare function putchar cdecl alias "putchar" (byval as integer) as integer
declare function puts cdecl alias "puts" (byval as zstring ptr) as integer
declare function ungetc cdecl alias "ungetc" (byval as integer, byval as FILE ptr) as integer
declare function fread cdecl alias "fread" (byval as any ptr, byval as size_t, byval as size_t, byval as FILE ptr) as size_t
declare function fwrite cdecl alias "fwrite" (byval as any ptr, byval as size_t, byval as size_t, byval as FILE ptr) as size_t
declare function fseek cdecl alias "fseek" (byval as FILE ptr, byval as integer, byval as integer) as integer
declare function ftell cdecl alias "ftell" (byval as FILE ptr) as integer
declare sub rewind cdecl alias "rewind" (byval as FILE ptr)
declare function fgetpos cdecl alias "fgetpos" (byval as FILE ptr, byval as fpos_t ptr) as integer
declare function fsetpos cdecl alias "fsetpos" (byval as FILE ptr, byval as fpos_t ptr) as integer
declare sub clearerr cdecl alias "clearerr" (byval as FILE ptr)
declare function feof cdecl alias "feof" (byval as FILE ptr) as integer
declare function ferror cdecl alias "ferror" (byval as FILE ptr) as integer
declare sub perror cdecl alias "perror" (byval as zstring ptr)
declare function fwprintf cdecl alias "fwprintf" (byval as FILE ptr, byval as wchar_t ptr, ...) as integer
declare function wprintf cdecl alias "wprintf" (byval as wchar_t ptr, ...) as integer
declare function swprintf cdecl alias "swprintf" (byval as wchar_t ptr, byval as wchar_t ptr, ...) as integer
declare function vfwprintf cdecl alias "vfwprintf" (byval as FILE ptr, byval as wchar_t ptr, byval as va_list) as integer
declare function vwprintf cdecl alias "vwprintf" (byval as wchar_t ptr, byval as va_list) as integer
declare function vswprintf cdecl alias "vswprintf" (byval as wchar_t ptr, byval as wchar_t ptr, byval as va_list) as integer
declare function fwscanf cdecl alias "fwscanf" (byval as FILE ptr, byval as wchar_t ptr, ...) as integer
declare function wscanf cdecl alias "wscanf" (byval as wchar_t ptr, ...) as integer
declare function swscanf cdecl alias "swscanf" (byval as wchar_t ptr, byval as wchar_t ptr, ...) as integer
declare function fgetwc cdecl alias "fgetwc" (byval as FILE ptr) as wint_t
declare function fputwc cdecl alias "fputwc" (byval as wchar_t, byval as FILE ptr) as wint_t
declare function ungetwc cdecl alias "ungetwc" (byval as wchar_t, byval as FILE ptr) as wint_t
declare function fgetws cdecl alias "fgetws" (byval as wchar_t ptr, byval as integer, byval as FILE ptr) as wchar_t ptr
declare function fputws cdecl alias "fputws" (byval as wchar_t ptr, byval as FILE ptr) as integer
declare function getwc cdecl alias "getwc" (byval as FILE ptr) as wint_t
declare function getwchar cdecl alias "getwchar" () as wint_t
declare function putwc cdecl alias "putwc" (byval as wint_t, byval as FILE ptr) as wint_t
declare function putwchar cdecl alias "putwchar" (byval as wint_t) as wint_t
declare function snwprintf cdecl alias "snwprintf" (byval s as wchar_t ptr, byval n as size_t, byval format as wchar_t ptr, ...) as integer
declare function vsnwprintf cdecl alias "vsnwprintf" (byval s as wchar_t ptr, byval n as size_t, byval format as wchar_t ptr, byval arg as va_list) as integer
declare function vwscanf cdecl alias "vwscanf" (byval __restrict__ as wchar_t ptr, byval as va_list) as integer
declare function vfwscanf cdecl alias "vfwscanf" (byval __restrict__ as FILE ptr, byval __restrict__ as wchar_t ptr, byval as va_list) as integer
declare function vswscanf cdecl alias "vswscanf" (byval __restrict__ as wchar_t ptr, byval __restrict__ as wchar_t ptr, byval as va_list) as integer
declare function wpopen cdecl alias "wpopen" (byval as wchar_t ptr, byval as wchar_t ptr) as FILE ptr

#endif
