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
#define _IOREAD 1
#define _IOWRT 2
#define _IORW &h0080
#define FILENAME_MAX 260
#define FOPEN_MAX 20
#define TMP_MAX 32767
#define _P_tmpdir $"\"
#define L_tmpnam (16)
#define _IOFBF &h0000
#define _IOLBF &h0040
#define _IONBF &h0004
#define _IOMYBUF &h0008
#define _IOEOF &h0010
#define _IOERR &h0020
#define _IOSTRG &h0040
#define BUFSIZ 512
#define STDIN_FILENO 0
#define STDOUT_FILENO 1
#define STDERR_FILENO 2

type _iobuf
	_ptr as zstring ptr
	_cnt as integer
	_base as zstring ptr
	_flag as integer
	_file as integer
	_charbuf as integer
	_bufsiz as integer
	_tmpfname as zstring ptr
end type

type FILE as _iobuf

extern import _iob(0 to 2) alias "_iob" as FILE
#define stdin (@_iob(STDIN_FILENO))
#define stdout (@_iob(STDOUT_FILENO))
#define stderr (@_iob(STDERR_FILENO))

#elseif defined(__FB_DOS__)
#define _IOFBF 1
#define _IONBF 2
#define _IOLBF 4
#define BUFSIZ 16384
#define FILENAME_MAX 260
#define FOPEN_MAX 20
#define P_tmpdir "c:/"
#define L_tmpnam 260
#define TMP_MAX 999999

type FILE
	_cnt as integer
	_ptr as zstring ptr
	_base as zstring ptr
	_bufsiz as integer
	_flag as integer
	_file as integer
	_name_to_remove as zstring ptr
	_fillsize as integer
end type

extern as FILE __dj_stdin alias "__dj_stdin", __dj_stdout alias "__dj_stdout", __dj_stderr alias "__dj_stderr"
#define stdin (@__dj_stdin)
#define stdout (@__dj_stdout)
#define stderr (@__dj_stderr)
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

#if defined(__FB_DOS__)
type fpos_t as uinteger
#else
type fpos_t as longint
#endif

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

#ifdef __FB_WIN32__
declare function snprintf cdecl alias "_snprintf" (byval as zstring ptr, byval as size_t, byval as zstring ptr, ...) as integer
declare function vsnprintf cdecl alias "_vsnprintf" (byval as zstring ptr, byval as size_t, byval as zstring ptr, byval as va_list) as integer
declare function popen cdecl alias "_popen" (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function pclose cdecl alias "_pclose" (byval as FILE ptr) as integer
declare function _flushall cdecl alias "_flushall" () as integer
declare function _fgetchar cdecl alias "_fgetchar" () as integer
declare function _fputchar cdecl alias "_fputchar" (byval as integer) as integer
declare function _fdopen cdecl alias "_fdopen" (byval as integer, byval as zstring ptr) as FILE ptr
declare function _fileno cdecl alias "_fileno" (byval as FILE ptr) as integer
declare function _fcloseall cdecl alias "_fcloseall" () as integer
declare function _getmaxstdio cdecl alias "_getmaxstdio" () as integer
declare function _setmaxstdio cdecl alias "_setmaxstdio" (byval as integer) as integer
declare function _snwprintf cdecl alias "_snwprintf" (byval as wchar_t ptr, byval as size_t, byval as wchar_t ptr, ...) as integer
declare function _vsnwprintf cdecl alias "_vsnwprintf" (byval as wchar_t ptr, byval as size_t, byval as wchar_t ptr, byval as va_list) as integer
declare function _getws cdecl alias "_getws" (byval as wchar_t ptr) as wchar_t ptr
declare function _putws cdecl alias "_putws" (byval as wchar_t ptr) as integer
declare function _wfdopen cdecl alias "_wfdopen" (byval as integer, byval as wchar_t ptr) as FILE ptr
declare function _wfopen cdecl alias "_wfopen" (byval as wchar_t ptr, byval as wchar_t ptr) as FILE ptr
declare function _wfreopen cdecl alias "_wfreopen" (byval as wchar_t ptr, byval as wchar_t ptr, byval as FILE ptr) as FILE ptr
declare function _wfsopen cdecl alias "_wfsopen" (byval as wchar_t ptr, byval as wchar_t ptr, byval as integer) as FILE ptr
declare function _wtmpnam cdecl alias "_wtmpnam" (byval as wchar_t ptr) as wchar_t ptr
declare function _wtempnam cdecl alias "_wtempnam" (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function _wrename cdecl alias "_wrename" (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function _wremove cdecl alias "_wremove" (byval as wchar_t ptr) as integer
declare sub _wperror cdecl alias "_wperror" (byval as wchar_t ptr)
declare function _wpopen cdecl alias "_wpopen" (byval as wchar_t ptr, byval as wchar_t ptr) as FILE ptr
declare function _fgetwchar cdecl alias "_fgetwchar" () as wint_t
declare function _fputwchar cdecl alias "_fputwchar" (byval as wint_t) as wint_t
declare function _getw cdecl alias "_getw" (byval as FILE ptr) as integer
declare function _putw cdecl alias "_putw" (byval as integer, byval as FILE ptr) as integer
declare function _tempnam cdecl alias "_tempnam" (byval as zstring ptr, byval as zstring ptr) as zstring ptr
#else '' __FB_WIN32__
declare function snprintf cdecl alias "snprintf" (byval s as zstring ptr, byval n as size_t, byval format as zstring ptr, ...) as integer
declare function vsnprintf cdecl alias "vsnprintf" (byval s as zstring ptr, byval n as size_t, byval format as zstring ptr, byval arg as va_list) as integer
declare function popen cdecl alias "popen" (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function pclose cdecl alias "pclose" (byval as FILE ptr) as integer
'' !!!WRITEME!!!
#endif

#endif
