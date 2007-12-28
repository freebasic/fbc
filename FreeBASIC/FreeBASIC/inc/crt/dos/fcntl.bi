''
''
'' fcntl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_dos_fcntl_bi__
#define __crt_dos_fcntl_bi__

#define FD_CLOEXEC &h0001
#define F_DUPFD 1
#define F_GETFD 2
#define F_GETFL 3
#define F_GETLK 4
#define F_SETFD 5
#define F_SETFL 6
#define F_SETLK 7
#define F_SETLKW 8
#define F_UNLCK 0
#define F_RDLCK 1
#define F_WRLCK 2
#define O_RDONLY &h0000
#define O_WRONLY &h0001
#define O_RDWR &h0002
#define O_ACCMODE &h0003
#define O_BINARY &h0004
#define O_TEXT &h0008
#define O_NOINHERIT &h0080
#define O_CREAT &h0100
#define O_EXCL &h0200
#define O_NOCTTY &h0400
#define O_TRUNC &h0800
#define O_APPEND &h1000
#define O_NONBLOCK &h2000

#include once "crt/sys/dos/types.bi"

type flock
	l_len as off_t
	l_pid as pid_t
	l_start as off_t
	l_type as short
	l_whence as short
end type

extern _fmode alias "_fmode" as integer

declare function open_ cdecl alias "open" (byval _path as zstring ptr, byval _oflag as integer, ...) as integer
declare function creat cdecl alias "creat" (byval _path as zstring ptr, byval _mode as mode_t) as integer
declare function fcntl cdecl alias "fcntl" (byval _fildes as integer, byval _cmd as integer, ...) as integer

#define SH_COMPAT &h0000
#define SH_DENYRW &h0010
#define SH_DENYWR &h0020
#define SH_DENYRD &h0030
#define SH_DENYNO &h0040
#define _SH_COMPAT SH_COMPAT
#define _SH_DENYRW SH_DENYRW
#define _SH_DENYWR SH_DENYWR
#define _SH_DENYRD SH_DENYRD
#define _SH_DENYNO SH_DENYNO

extern __djgpp_share_flags alias "__djgpp_share_flags" as integer

#define S_IREAD S_IRUSR
#define S_IWRITE S_IWUSR
#define S_IEXEC S_IXUSR
#define _O_RDONLY O_RDONLY
#define _O_WRONLY O_WRONLY
#define _O_RDWR O_RDWR
#define _O_APPEND O_APPEND
#define _O_CREAT O_CREAT
#define _O_TRUNC O_TRUNC
#define _O_EXCL O_EXCL
#define _O_TEXT O_TEXT
#define _O_BINARY O_BINARY
#define _O_NOINHERIT O_NOINHERIT
#define _FILESYS_UNKNOWN &h80000000U
#define _FILESYS_CASE_SENSITIVE &h0001
#define _FILESYS_CASE_PRESERVED &h0002
#define _FILESYS_UNICODE &h0004
#define _FILESYS_LFN_SUPPORTED &h4000
#define _FILESYS_VOL_COMPRESSED &h8000

declare function _get_volume_info cdecl alias "_get_volume_info" (byval _path as zstring ptr, byval _max_file_len as integer ptr, byval _max_path_len as integer ptr, byval _filesystype as zstring ptr) as uinteger
declare function _use_lfn_ cdecl alias "_use_lfn" (byval _path as zstring ptr) as byte
declare function _lfn_gen_short_fname cdecl alias "_lfn_gen_short_fname" (byval _long_fname as zstring ptr, byval _short_fname as zstring ptr) as zstring ptr

#define _LFN_CTIME 1
#define _LFN_ATIME 2

declare function _lfn_get_ftime cdecl alias "_lfn_get_ftime" (byval _handle as integer, byval _which as integer) as uinteger
declare function _preserve_fncase cdecl alias "_preserve_fncase" () as byte
#define _USE_LFN _use_lfn_(0)

#endif