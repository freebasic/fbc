''
''
'' stdio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_dos_stdio_bi__
#define __crt_dos_stdio_bi__

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

type fpos_t as uinteger

declare function popen cdecl alias "popen" (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function pclose cdecl alias "pclose" (byval as FILE ptr) as integer
declare function getw cdecl alias "getw" (byval as FILE ptr) as integer
declare function putw cdecl alias "putw" (byval as integer, byval as FILE ptr) as integer
declare function snprintf cdecl alias "snprintf" (byval as zstring ptr, byval as size_t, byval as zstring ptr, ...) as long

#endif
