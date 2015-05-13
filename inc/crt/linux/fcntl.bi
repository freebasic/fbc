''
''
'' fcntl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_linux_fcntl_bi__
#define __crt_linux_fcntl_bi__

'' begin_include "bits/fcntl.bi"

#include once "crt/sys/types.bi"

#define O_ACCMODE 0003
#define O_RDONLY 00
#define O_WRONLY 01
#define O_RDWR 02
#define O_CREAT 0100
#define O_EXCL 0200
#define O_NOCTTY 0400
#define O_TRUNC 01000
#define O_APPEND 02000
#define O_NONBLOCK 04000
#define O_NDELAY 04000
#define O_SYNC 010000
#define O_FSYNC 010000
#define O_ASYNC 020000
#define F_DUPFD 0
#define F_GETFD 1
#define F_SETFD 2
#define F_GETFL 3
#define F_SETFL 4
#define F_GETLK 5
#define F_SETLK 6
#define F_SETLKW 7
#define F_GETLK64 12
#define F_SETLK64 13
#define F_SETLKW64 14
#define FD_CLOEXEC 1
#define F_RDLCK 0
#define F_WRLCK 1
#define F_UNLCK 2
#define F_EXLCK 4
#define F_SHLCK 8

type flock
	l_type as short
	l_whence as short
	l_start as __off_t
	l_len as __off_t
	l_pid as __pid_t
end type

declare function readahead cdecl alias "readahead" (byval __fd as integer, byval __offset as __off64_t, byval __count as size_t) as ssize_t

'' end_include "bits/fcntl.bi"

#define R_OK 4
#define W_OK 2
#define X_OK 1
#define F_OK 0

declare function fcntl cdecl alias "fcntl" (byval __fd as integer, byval __cmd as integer, ...) as integer
declare function open_ cdecl alias "open" (byval __file as zstring ptr, byval __oflag as integer, ...) as integer
declare function creat cdecl alias "creat" (byval __file as zstring ptr, byval __mode as __mode_t) as integer

#define F_ULOCK 0
#define F_LOCK 1
#define F_TLOCK 2
#define F_TEST 3

declare function lockf cdecl alias "lockf" (byval __fd as integer, byval __cmd as integer, byval __len as __off_t) as integer

#endif