''
''
'' stdio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_linux_stdio_bi__
#define __crt_linux_stdio_bi__

#define _IOFBF 0
#define _IOLBF 1
#define _IONBF 2
#define BUFSIZ 8192
#define FILENAME_MAX 4096
#define FOPEN_MAX 16
#define P_tmpdir "/tmp"
#define L_tmpnam 20
#define TMP_MAX 238328

type _IO_FILE
	_flags as integer
	'' incomplete, shouldn't be used by user apps anyways..
end type
type FILE as _IO_FILE

extern stdin alias "stdin" as _IO_FILE ptr
extern stdout alias "stdout" as _IO_FILE ptr
extern stderr alias "stderr" as _IO_FILE ptr

type fpos_t as longint

declare function snprintf cdecl alias "snprintf" (byval s as zstring ptr, byval n as size_t, byval format as zstring ptr, ...) as integer
declare function vsnprintf cdecl alias "vsnprintf" (byval s as zstring ptr, byval n as size_t, byval format as zstring ptr, byval arg as va_list) as integer
declare function popen cdecl alias "popen" (byval as zstring ptr, byval as zstring ptr) as FILE ptr
declare function pclose cdecl alias "pclose" (byval as FILE ptr) as integer
declare function getw cdecl alias "getw" (byval as FILE ptr) as integer
declare function putw cdecl alias "putw" (byval as integer, byval as FILE ptr) as integer

#endif