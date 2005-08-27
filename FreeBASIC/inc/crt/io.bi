''
''
'' io -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __io_bi__
#define __io_bi__

#include once "crt/stdio.bi"
#include once "crt/sys/types.bi"

#define _A_NORMAL &h00000000
#define _A_RDONLY &h00000001
#define _A_HIDDEN &h00000002
#define _A_SYSTEM &h00000004
#define _A_VOLID &h00000008
#define _A_SUBDIR &h00000010
#define _A_ARCH &h00000020

type _finddata_t
	attrib as uinteger
	time_create as time_t
	time_access as time_t
	time_write as time_t
	size as _fsize_t
	name as zstring * (260)
end type

type _finddatai64_t
	attrib as uinteger
	time_create as time_t
	time_access as time_t
	time_write as time_t
	size as longint
	name as zstring * (260)
end type

declare function _findfirst cdecl alias "_findfirst" (byval as zstring ptr, byval as _finddata_t ptr) as integer
declare function _findnext cdecl alias "_findnext" (byval as integer, byval as _finddata_t ptr) as integer
declare function _findclose cdecl alias "_findclose" (byval as integer) as integer
declare function _chdir cdecl alias "_chdir" (byval as zstring ptr) as integer
declare function _getcwd cdecl alias "_getcwd" (byval as zstring ptr, byval as integer) as zstring ptr
declare function _mkdir cdecl alias "_mkdir" (byval as zstring ptr) as integer
declare function _mktemp cdecl alias "_mktemp" (byval as zstring ptr) as zstring ptr
declare function _rmdir cdecl alias "_rmdir" (byval as zstring ptr) as integer
declare function _chmod cdecl alias "_chmod" (byval as zstring ptr, byval as integer) as integer
declare function _filelengthi64 cdecl alias "_filelengthi64" (byval as integer) as longint
declare function _findfirsti64 cdecl alias "_findfirsti64" (byval as zstring ptr, byval as _finddatai64_t ptr) as integer
declare function _findnexti64 cdecl alias "_findnexti64" (byval as integer, byval as _finddatai64_t ptr) as integer
declare function _lseeki64 cdecl alias "_lseeki64" (byval as integer, byval as longint, byval as integer) as longint
declare function _telli64 cdecl alias "_telli64" (byval as integer) as longint

#define HANDLE_MAX (20)
#define F_OK 0
#define X_OK 1
#define W_OK 2
#define R_OK 4

declare function _access cdecl alias "_access" (byval as zstring ptr, byval as integer) as integer
declare function _chsize cdecl alias "_chsize" (byval as integer, byval as integer) as integer
declare function _close cdecl alias "_close" (byval as integer) as integer
declare function _commit cdecl alias "_commit" (byval as integer) as integer
declare function _creat cdecl alias "_creat" (byval as zstring ptr, byval as integer) as integer
declare function _dup cdecl alias "_dup" (byval as integer) as integer
declare function _dup2 cdecl alias "_dup2" (byval as integer, byval as integer) as integer
declare function _filelength cdecl alias "_filelength" (byval as integer) as integer
declare function _get_osfhandle cdecl alias "_get_osfhandle" (byval as integer) as integer
declare function _isatty cdecl alias "_isatty" (byval as integer) as integer
declare function _eof cdecl alias "_eof" (byval as integer) as integer
declare function _locking cdecl alias "_locking" (byval as integer, byval as integer, byval as integer) as integer
declare function _lseek cdecl alias "_lseek" (byval as integer, byval as integer, byval as integer) as integer
declare function _open cdecl alias "_open" (byval as zstring ptr, byval as integer, ...) as integer
declare function _open_osfhandle cdecl alias "_open_osfhandle" (byval as integer, byval as integer) as integer
declare function _pipe cdecl alias "_pipe" (byval as integer ptr, byval as uinteger, byval as integer) as integer
declare function _read cdecl alias "_read" (byval as integer, byval as any ptr, byval as uinteger) as integer
declare function _setmode cdecl alias "_setmode" (byval as integer, byval as integer) as integer
declare function _sopen cdecl alias "_sopen" (byval as zstring ptr, byval as integer, byval as integer, ...) as integer
declare function _tell cdecl alias "_tell" (byval as integer) as integer
declare function _umask cdecl alias "_umask" (byval as integer) as integer
declare function _unlink cdecl alias "_unlink" (byval as zstring ptr) as integer
declare function _write cdecl alias "_write" (byval as integer, byval as any ptr, byval as uinteger) as integer

#endif
