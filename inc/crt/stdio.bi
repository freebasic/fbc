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

#include once "crt/long.bi"
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

extern "c"
declare function rename (byval as zstring ptr, byval as zstring ptr) as long
declare function fopen (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function freopen (byval as zstring ptr, byval as zstring ptr, byval as FILE ptr) as FILE ptr
declare function fflush (byval as FILE ptr) as long
declare function fclose (byval as FILE ptr) as long
declare function remove (byval as zstring ptr) as long
declare function tmpfile () as FILE ptr
declare function tmpnam (byval as zstring ptr) as zstring ptr
declare function tempnam (byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function setvbuf (byval as FILE ptr, byval as zstring ptr, byval as long, byval as size_t) as long
declare sub setbuf (byval as FILE ptr, byval as zstring ptr)
declare function fprintf (byval as FILE ptr, byval as zstring ptr, ...) as long
declare function printf (byval as zstring ptr, ...) as long
declare function sprintf (byval as zstring ptr, byval as zstring ptr, ...) as long
declare function vfprintf (byval as FILE ptr, byval as zstring ptr, byval as va_list) as long
declare function vprintf (byval as zstring ptr, byval as va_list) as long
declare function vsprintf (byval as zstring ptr, byval as zstring ptr, byval as va_list) as long
declare function vscanf (byval as zstring ptr, byval as va_list) as long
declare function vfscanf (byval as FILE ptr, byval as zstring ptr, byval as va_list) as long
declare function vsscanf (byval as zstring ptr, byval as zstring ptr, byval as va_list) as long
declare function fscanf (byval as FILE ptr, byval as zstring ptr, ...) as long
declare function scanf (byval as zstring ptr, ...) as long
declare function sscanf (byval as zstring ptr, byval as zstring ptr, ...) as long
declare function fgetc (byval as FILE ptr) as long
declare function fgets (byval as zstring ptr, byval as long, byval as FILE ptr) as zstring ptr
declare function fputc (byval as long, byval as FILE ptr) as long
declare function fputs (byval as zstring ptr, byval as FILE ptr) as long
declare function getc (byval as FILE ptr) as long
declare function getchar () as long
declare function gets (byval as zstring ptr) as zstring ptr
declare function putc (byval as long, byval as FILE ptr) as long
declare function putchar (byval as long) as long
declare function puts (byval as zstring ptr) as long
declare function ungetc (byval as long, byval as FILE ptr) as long
declare function fread (byval as any ptr, byval as size_t, byval as size_t, byval as FILE ptr) as size_t
declare function fwrite (byval as any ptr, byval as size_t, byval as size_t, byval as FILE ptr) as size_t
declare function fseek (byval as FILE ptr, byval as clong, byval as long) as long
declare function ftell (byval as FILE ptr) as clong
declare sub rewind (byval as FILE ptr)
declare function fgetpos (byval as FILE ptr, byval as fpos_t ptr) as long
declare function fsetpos (byval as FILE ptr, byval as fpos_t ptr) as long
declare sub clearerr (byval as FILE ptr)
declare function feof (byval as FILE ptr) as long
declare function ferror (byval as FILE ptr) as long
declare sub perror (byval as zstring ptr)
declare function fwprintf (byval as FILE ptr, byval as wchar_t ptr, ...) as long
declare function wprintf (byval as wchar_t ptr, ...) as long
declare function swprintf (byval as wchar_t ptr, byval as wchar_t ptr, ...) as long
declare function vfwprintf (byval as FILE ptr, byval as wchar_t ptr, byval as va_list) as long
declare function vwprintf (byval as wchar_t ptr, byval as va_list) as long
declare function vswprintf (byval as wchar_t ptr, byval as wchar_t ptr, byval as va_list) as long
declare function fwscanf (byval as FILE ptr, byval as wchar_t ptr, ...) as long
declare function wscanf (byval as wchar_t ptr, ...) as long
declare function swscanf (byval as wchar_t ptr, byval as wchar_t ptr, ...) as long
declare function fgetwc (byval as FILE ptr) as wint_t
declare function fputwc (byval as wchar_t, byval as FILE ptr) as wint_t
declare function ungetwc (byval as wchar_t, byval as FILE ptr) as wint_t
declare function fgetws (byval as wchar_t ptr, byval as long, byval as FILE ptr) as wchar_t ptr
declare function fputws (byval as wchar_t ptr, byval as FILE ptr) as long
declare function getwc (byval as FILE ptr) as wint_t
declare function getwchar () as wint_t
declare function putwc (byval as wint_t, byval as FILE ptr) as wint_t
declare function putwchar (byval as wint_t) as wint_t
declare function snwprintf (byval s as wchar_t ptr, byval n as size_t, byval format as wchar_t ptr, ...) as long
declare function vsnwprintf (byval s as wchar_t ptr, byval n as size_t, byval format as wchar_t ptr, byval arg as va_list) as long
declare function vwscanf (byval as wchar_t ptr, byval as va_list) as long
declare function vfwscanf (byval as FILE ptr, byval as wchar_t ptr, byval as va_list) as long
declare function vswscanf (byval as wchar_t ptr, byval as wchar_t ptr, byval as va_list) as long
declare function wpopen (byval as wchar_t ptr, byval as wchar_t ptr) as FILE ptr
end extern

#endif
