''
''
'' stdio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_win32_stdio_bi__
#define __crt_win32_stdio_bi__

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

type fpos_t as longint

extern "c"
declare function snprintf (byval as zstring ptr, byval as size_t, byval as zstring ptr, ...) as integer
declare function vsnprintf (byval as zstring ptr, byval as size_t, byval as zstring ptr, byval as va_list) as integer
declare function popen (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function pclose (byval as FILE ptr) as integer
declare function _flushall () as integer
declare function _fgetchar () as integer
declare function _fputchar (byval as integer) as integer
declare function _fdopen (byval as integer, byval as zstring ptr) as FILE ptr
declare function _fileno (byval as FILE ptr) as integer
declare function _fcloseall () as integer
declare function _getmaxstdio () as integer
declare function _setmaxstdio (byval as integer) as integer
declare function _snwprintf (byval as wchar_t ptr, byval as size_t, byval as wchar_t ptr, ...) as integer
declare function _vsnwprintf (byval as wchar_t ptr, byval as size_t, byval as wchar_t ptr, byval as va_list) as integer
declare function _getws (byval as wchar_t ptr) as wchar_t ptr
declare function _putws (byval as wchar_t ptr) as integer
declare function _wfdopen (byval as integer, byval as wchar_t ptr) as FILE ptr
declare function _wfopen (byval as wchar_t ptr, byval as wchar_t ptr) as FILE ptr
declare function _wfreopen (byval as wchar_t ptr, byval as wchar_t ptr, byval as FILE ptr) as FILE ptr
declare function _wfsopen (byval as wchar_t ptr, byval as wchar_t ptr, byval as integer) as FILE ptr
declare function _wtmpnam (byval as wchar_t ptr) as wchar_t ptr
declare function _wtempnam (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function _wrename (byval as wchar_t ptr, byval as wchar_t ptr) as integer
declare function _wremove (byval as wchar_t ptr) as integer
declare sub _wperror (byval as wchar_t ptr)
declare function _wpopen (byval as wchar_t ptr, byval as wchar_t ptr) as FILE ptr
declare function _fgetwchar () as wint_t
declare function _fputwchar (byval as wint_t) as wint_t
declare function _tempnam (byval as zstring ptr, byval as zstring ptr) as zstring ptr
end extern

#endif