''
''
'' io -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_io_bi__
#define __crt_io_bi__

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "crt/stdint.bi"
#include once "crt/sys/types.bi"

#ifdef __FB_WIN32__

#define _A_NORMAL &h00000000
#define _A_RDONLY &h00000001
#define _A_HIDDEN &h00000002
#define _A_SYSTEM &h00000004
#define _A_VOLID &h00000008
#define _A_SUBDIR &h00000010
#define _A_ARCH &h00000020

#ifndef _fsize_t
type _fsize_t as ulong
#endif

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

#define HANDLE_MAX (20)
#define F_OK 0
#define X_OK 1
#define W_OK 2
#define R_OK 4

extern "c"
declare function _findfirst (byval as zstring ptr, byval as _finddata_t ptr) as intptr_t
declare function _findnext (byval as intptr_t, byval as _finddata_t ptr) as long
declare function _findclose (byval as intptr_t) as long
declare function _chdir (byval as zstring ptr) as long
declare function _getcwd (byval as zstring ptr, byval as long) as zstring ptr
declare function _mkdir (byval as zstring ptr) as long
declare function _mktemp (byval as zstring ptr) as zstring ptr
declare function _rmdir (byval as zstring ptr) as long
declare function _chmod (byval as zstring ptr, byval as long) as long
declare function _filelengthi64 (byval as long) as longint
declare function _findfirsti64 (byval as zstring ptr, byval as _finddatai64_t ptr) as intptr_t
declare function _findnexti64 (byval as intptr_t, byval as _finddatai64_t ptr) as long
declare function _lseeki64 (byval as long, byval as longint, byval as long) as longint
declare function _telli64 (byval as long) as longint
declare function _access (byval as zstring ptr, byval as long) as long
declare function _chsize (byval as long, byval as clong) as long
declare function _close (byval as long) as long
declare function _commit (byval as long) as long
declare function _creat (byval as zstring ptr, byval as long) as long
declare function _dup (byval as long) as long
declare function _dup2 (byval as long, byval as long) as long
declare function _filelength (byval as long) as clong
declare function _get_osfhandle (byval as long) as intptr_t
declare function _isatty (byval as long) as long
declare function _eof (byval as long) as long
declare function _locking (byval as long, byval as long, byval as clong) as long
declare function _lseek (byval as long, byval as clong, byval as long) as clong
declare function _open (byval as zstring ptr, byval as long, ...) as long
declare function _open_osfhandle (byval as intptr_t, byval as long) as long
declare function _pipe (byval as long ptr, byval as ulong, byval as long) as long
declare function _read (byval as long, byval as any ptr, byval as ulong) as long
declare function _setmode (byval as long, byval as long) as long
declare function _sopen (byval as zstring ptr, byval as long, byval as long, ...) as long
declare function _tell (byval as long) as clong
declare function _umask (byval as long) as long
declare function _unlink (byval as zstring ptr) as long
declare function _write (byval as long, byval as any ptr, byval as ulong) as long
end extern

#else '' __FB_WIN32__
# error Unsupported platform
#endif

#endif
