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
#include once "crt/sys/uio.bi"

extern "C"

#define O_ACCMODE	&o3
#define O_RDONLY	&o0
#define O_WRONLY	&o1
#define O_RDWR		&o2
#define O_CREAT		&o100
#define O_EXCL		&o200
#define O_NOCTTY	&o400
#define O_TRUNC		&o1000
#define O_APPEND	&o2000
#define O_NONBLOCK	&o4000
#define O_NDELAY	O_NONBLOCK
#define O_SYNC		&o4010000
#define O_FSYNC		O_SYNC
#define O_ASYNC		&o20000
#define O_DIRECTORY	&o200000
#define O_NOFOLLOW	&o400000
#define O_CLOEXEC	&o2000000
#define O_DIRECT	&o40000
#define O_NOATIME	&o1000000
#define O_PATH		&o10000000
#define O_DSYNC		&o10000
#define O_RSYNC		O_SYNC
#ifdef __FB_64BIT__
	#define O_LARGEFILE	0
#else
	#define O_LARGEFILE	&o100000
#endif

#define F_DUPFD		0
#define F_GETFD		1
#define F_SETFD		2
#define F_GETFL		3
#define F_SETFL		4
#define F_GETLK		5
#define F_SETLK		6
#define F_SETLKW	7
#ifdef __FB_64BIT__
	#define F_GETLK64	5
	#define F_SETLK64	6
	#define F_SETLKW64	7
#else
	#define F_GETLK64	12
	#define F_SETLK64	13
	#define F_SETLKW64	14
#endif
#define F_SETOWN	8
#define F_GETOWN	9
#define F_SETSIG	10
#define F_GETSIG	11
#define F_SETOWN_EX	15
#define F_GETOWN_EX	16
#define F_SETLEASE	1024
#define F_GETLEASE	1025
#define F_NOTIFY	1026
#define F_SETPIPE_SZ	1031
#define F_GETPIPE_SZ	1032
#define F_DUPFD_CLOEXEC 1030
#define FD_CLOEXEC	1
#define F_RDLCK		0
#define F_WRLCK		1
#define F_UNLCK		2
#define F_EXLCK		4
#define F_SHLCK		8

#define LOCK_SH	1
#define LOCK_EX	2
#define LOCK_NB	4
#define LOCK_UN	8
#define LOCK_MAND	32
#define LOCK_READ	64
#define LOCK_WRITE	128
#define LOCK_RW		192

#define DN_ACCESS	&h00000001
#define DN_MODIFY	&h00000002
#define DN_CREATE	&h00000004
#define DN_DELETE	&h00000008
#define DN_RENAME	&h00000010
#define DN_ATTRIB	&h00000020
#define DN_MULTISHOT	&h80000000

type flock
	l_type as short
	l_whence as short
	l_start as __off_t
	l_len as __off_t
	l_pid as __pid_t
end type

enum __pid_type
	F_OWNER_TID = 0
	F_OWNER_PID
	F_OWNER_PGRP
	F_OWNER_GID = F_OWNER_PGRP
end enum

type f_owner_ex
	type as __pid_type
	pid as __pid_t
end type

#define POSIX_FADV_NORMAL	0
#define POSIX_FADV_RANDOM	1
#define POSIX_FADV_SEQUENTIAL	2
#define POSIX_FADV_WILLNEED	3
#define POSIX_FADV_DONTNEED	4
#define POSIX_FADV_NOREUSE	5

#define SYNC_FILE_RANGE_WAIT_BEFORE	1
#define SYNC_FILE_RANGE_WRITE		2
#define SYNC_FILE_RANGE_WAIT_AFTER	4

#define SPLICE_F_MOVE		1
#define SPLICE_F_NONBLOCK	2
#define SPLICE_F_MORE		4
#define SPLICE_F_GIFT		8

type file_handle
	handle_bytes as ulong
	handle_type as long
	f_handle as ubyte ptr
end type

#define MAX_HANDLE_SZ	128

#define AT_FDCWD		-100
#define AT_SYMLINK_NOFOLLOW	&h100
#define AT_REMOVEDIR		&h200
#define AT_SYMLINK_FOLLOW	&h400
#define AT_NO_AUTOMOUNT		&h800
#define AT_EMPTY_PATH		&h1000
#define AT_EACCESS		&h200

declare function readahead (byval __fd as long, byval __offset as __off64_t, byval __count as uinteger) as integer
declare function sync_file_range (byval __fd as long, byval __offset as __off64_t, byval __count as __off64_t, byval __flags as ulong) as long
declare function vmsplice (byval __fdout as long, byval __iov as const iovec ptr, byval __count as uinteger, byval __flags as ulong) as integer
declare function splice (byval __fdin as long, byval __offin as __off64_t ptr, byval __fdout as long, byval __offout as __off64_t ptr, byval __len as uinteger, byval __flags as ulong) as integer
declare function tee (byval __fdin as long, byval __fdout as long, byval __len as uinteger, byval __flags as ulong) as integer
declare function fallocate   (byval __fd as long, byval __mode as long, byval __offset as __off_t  , byval __len as __off_t  ) as long
declare function fallocate64 (byval __fd as long, byval __mode as long, byval __offset as __off64_t, byval __len as __off64_t) as long
declare function name_to_handle_at (byval __dfd as long, byval __name as const zstring ptr, byval __handle as file_handle ptr, byval __mnt_id as long ptr, byval __flags as long) as long
declare function open_by_handle_at (byval __mountdirfd as long, byval __handle as file_handle ptr, byval __flags as long) as long

'' end_include "bits/fcntl.bi"

#define R_OK 4
#define W_OK 2
#define X_OK 1
#define F_OK 0

declare function fcntl (byval __fd as long, byval __cmd as long, ...) as long
declare function open_ alias "open" (byval __file as const zstring ptr, byval __oflag as long, ...) as long
declare function open64 (byval __file as const zstring ptr, byval __oflag as long, ...) as long
declare function openat   (byval __fd as long, byval __file as const zstring ptr, byval __oflag as long, ...) as long
declare function openat64 (byval __fd as long, byval __file as const zstring ptr, byval __oflag as long, ...) as long
declare function creat   (byval __file as const zstring ptr, byval __mode as __mode_t) as long
declare function creat64 (byval __file as const zstring ptr, byval __mode as __mode_t) as long

#ifndef F_LOCK
#define F_ULOCK 0
#define F_LOCK  1
#define F_TLOCK 2
#define F_TEST  3
declare function lockf   (byval __fd as long, byval __cmd as long, byval __len as __off_t) as long
declare function lockf64 (byval __fd as long, byval __cmd as long, byval __len as __off64_t) as long
#endif

declare function posix_fadvise     (byval __fd as long, byval __offset as __off_t  , byval __len as __off_t  , byval __advise as long) as long
declare function posix_fadvise64   (byval __fd as long, byval __offset as __off64_t, byval __len as __off64_t, byval __advise as long) as long
declare function posix_fallocate   (byval __fd as long, byval __offset as __off_t  , byval __len as __off_t  ) as long
declare function posix_fallocate64 (byval __fd as long, byval __offset as __off64_t, byval __len as __off64_t) as long

end extern

#endif
