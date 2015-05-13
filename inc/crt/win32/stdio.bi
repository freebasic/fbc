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
	_cnt as long
	_base as zstring ptr
	_flag as long
	_file as long
	_charbuf as long
	_bufsiz as long
	_tmpfname as zstring ptr
end type

type FILE as _iobuf

extern "c"

#ifdef __FB_64BIT__
	declare function __iob_func() as FILE ptr
	#define stdin (@(__iob_func())[STDIN_FILENO])
	#define stdout (@(__iob_func())[STDOUT_FILENO])
	#define stderr (@(__iob_func())[STDERR_FILENO])
#else
	extern import _iob(0 to 2) alias "_iob" as FILE
	#define stdin (@_iob(STDIN_FILENO))
	#define stdout (@_iob(STDOUT_FILENO))
	#define stderr (@_iob(STDERR_FILENO))
#endif

type fpos_t as longint

declare function snprintf (byval as zstring ptr, byval as size_t, byval as zstring ptr, ...) as long
declare function vsnprintf (byval as zstring ptr, byval as size_t, byval as zstring ptr, byval as va_list) as long
declare function popen (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function pclose (byval as FILE ptr) as long
declare function _flushall () as long
declare function _fgetchar () as long
declare function _fputchar (byval as long) as long
declare function _fdopen (byval as long, byval as zstring ptr) as FILE ptr
declare function _fileno (byval as FILE ptr) as long
declare function _fcloseall () as long
declare function _getmaxstdio () as long
declare function _setmaxstdio (byval as long) as long
declare function _snwprintf (byval as wchar_t ptr, byval as size_t, byval as wchar_t ptr, ...) as long
declare function _vsnwprintf (byval as wchar_t ptr, byval as size_t, byval as wchar_t ptr, byval as va_list) as long
declare function _getws (byval as wchar_t ptr) as wchar_t ptr
declare function _putws (byval as wchar_t ptr) as long
declare function _wfdopen (byval as long, byval as wchar_t ptr) as FILE ptr
declare function _wfopen (byval as wchar_t ptr, byval as wchar_t ptr) as FILE ptr
declare function _wfreopen (byval as wchar_t ptr, byval as wchar_t ptr, byval as FILE ptr) as FILE ptr
declare function _wfsopen (byval as wchar_t ptr, byval as wchar_t ptr, byval as long) as FILE ptr
declare function _wtmpnam (byval as wchar_t ptr) as wchar_t ptr
declare function _wtempnam (byval as wchar_t ptr, byval as wchar_t ptr) as wchar_t ptr
declare function _wrename (byval as wchar_t ptr, byval as wchar_t ptr) as long
declare function _wremove (byval as wchar_t ptr) as long
declare sub _wperror (byval as wchar_t ptr)
declare function _wpopen (byval as wchar_t ptr, byval as wchar_t ptr) as FILE ptr
declare function _fgetwchar () as wint_t
declare function _fputwchar (byval as wint_t) as wint_t
declare function _tempnam (byval as zstring ptr, byval as zstring ptr) as zstring ptr
end extern

#endif
