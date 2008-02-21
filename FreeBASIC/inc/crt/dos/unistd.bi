''
''
'' unistd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_dos_unistd_bi__
#define __crt_dos_unistd_bi__

#include "crt/sys/types.bi"

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

#define F_ULOCK 0
#define F_LOCK 1
#define F_TLOCK 2
#define F_TEST 3

#undef NULL
#define NULL 0

#define F_OK 1
#define R_OK 2
#define W_OK 4
#define X_OK 8

#define STDIN_FILENO 0
#define STDOUT_FILENO 1
#define STDERR_FILENO 2

#define _CS_PATH 1
#define _CS_POSIX_V6_ILP32_OFF32_CFLAGS 2
#define _CS_POSIX_V6_ILP32_OFF32_LDFLAGS 3
#define _CS_POSIX_V6_ILP32_OFF32_LIBS 4

#define _PC_CHOWN_RESTRICTED 1
#define _PC_LINK_MAX 2
#define _PC_MAX_CANON 3
#define _PC_MAX_INPUT 4
#define _PC_NAME_MAX 5
#define _PC_NO_TRUNC 6
#define _PC_PATH_MAX 7
#define _PC_PIPE_BUF 8
#define _PC_VDISABLE 9

#define _POSIX_CHOWN_RESTRICTED 0
#undef  _POSIX_JOB_CONTROL
#define _POSIX_NO_TRUNC 0
#undef  _POSIX_SAVED_IDS
#define _POSIX_VDISABLE -1
#define _POSIX_VERSION 199009L
#define _POSIX_V6_ILP32_OFF32 1

#define _SC_ARG_MAX 1
#define _SC_CHILD_MAX 2
#define _SC_CLK_TCK 3
#define _SC_JOB_CONTROL 4
#define _SC_NGROUPS_MAX 5
#define _SC_OPEN_MAX 6
#define _SC_SAVED_IDS 7
#define _SC_STREAM_MAX 8
#define _SC_TZNAME_MAX 9
#define _SC_VERSION 10
#define _SC_V6_ILP32_OFF32 11


extern optarg alias "optarg" as zstring ptr
extern optind alias "optind" as integer
extern opterr alias "opterr" as integer
extern optopt alias "optopt" as integer

extern "c"

declare sub __exit (byval _status as integer)
declare sub _exit (byval _status as integer)
declare function access_ (byval _path as zstring ptr, byval _amode as integer) as integer
declare function alarm (byval _seconds as uinteger) as uinteger
declare function chdir_ (byval _path as zstring ptr) as integer
declare function chown (byval _path as zstring ptr, byval _owner as uid_t, byval _group as gid_t) as integer
declare function close_ (byval _filedes as integer) as integer
declare function confstr (byval _name as integer, byval _buf as zstring ptr, byval _len as size_t) as size_t
declare function ctermid (byval _s as zstring ptr) as zstring ptr
declare function dup (byval _filedes as integer) as integer
declare function dup2 (byval _filedes as integer, byval _filedes2 as integer) as integer
declare function execl (byval _path as zstring ptr, byval _arg as zstring ptr, ...) as integer
declare function execle (byval _path as zstring ptr, byval _arg as zstring ptr, ...) as integer
declare function execlp (byval _file as zstring ptr, byval _arg as zstring ptr, ...) as integer
declare function execv (byval _path as zstring ptr, byval _argv as zstring ptr ptr) as integer
declare function execve (byval _path as zstring ptr, byval _argv as zstring ptr ptr, byval _envp as zstring ptr ptr) as integer
declare function execvp (byval _file as zstring ptr, byval _argv as zstring ptr ptr) as integer
declare function fchdir (byval _fd as integer) as integer
declare function fork () as pid_t
declare function fpathconf (byval _filedes as integer, byval _name as integer) as long
declare function getcwd (byval _buf as zstring ptr, byval _size as size_t) as zstring ptr
declare function getegid () as gid_t
declare function geteuid () as uid_t
declare function getgid () as gid_t
declare function getgroups (byval _gidsetsize as integer, byval _grouplist as gid_t ptr) as integer
declare function getlogin () as zstring ptr
declare function getopt (byval _argc as integer, byval _argv as zstring ptr ptr, byval _optstring as zstring ptr) as integer
declare function getpgrp () as pid_t
declare function getpid () as pid_t
declare function getppid () as pid_t
declare function getuid () as uid_t
declare function isatty (byval _filedes as integer) as integer
declare function link (byval _existing as zstring ptr, byval _new as zstring ptr) as integer
declare function lseek (byval _filedes as integer, byval _offset as off_t, byval _whence as integer) as off_t
declare function pathconf (byval _path as zstring ptr, byval _name as integer) as long
declare function pause () as integer
declare function pipe (byval _filedes as integer ptr) as integer
declare function pwrite (byval _filedes as integer, byval _buf as any ptr, byval _nbyte as size_t, byval _offset as off_t) as ssize_t
declare function read_ (byval _filedes as integer, byval _buf as any ptr, byval _nbyte as size_t) as ssize_t
declare function rmdir_ (byval _path as zstring ptr) as integer
declare function setgid (byval _gid as gid_t) as integer
declare function setpgid (byval _pid as pid_t, byval _pgid as pid_t) as integer
declare function setsid () as pid_t
declare function setuid (byval uid as uid_t) as integer
declare function sleep_ (byval _seconds as uinteger) as uinteger
declare function sysconf (byval _name as integer) as long
declare function tcgetpgrp (byval _filedes as integer) as pid_t
declare function tcsetpgrp (byval _filedes as integer, byval _pgrp_id as pid_t) as integer
declare function ttyname (byval _filedes as integer) as zstring ptr
declare function unlink (byval _path as zstring ptr) as integer
declare function write_ (byval _filedes as integer, byval _buf as any ptr, byval _nbyte as size_t) as ssize_t

#define D_OK	0x10

declare function basename (byval _fn as zstring ptr) as zstring ptr
declare function brk (byval _heaptop as any ptr) as integer
declare function dirname (byval _fn as zstring ptr) as zstring ptr
declare function __file_exists (byval _fn as zstring ptr) as integer
declare function fchown (byval fd as integer, byval owner as uid_t, byval group as gid_t) as integer
declare function fsync (byval _fd as integer) as integer
declare function ftruncate (byval as integer, byval as off_t) as integer
declare function getdtablesize () as integer
declare function gethostname (byval buf as zstring ptr, byval size as integer) as integer
declare function getpagesize () as integer
declare function getwd (byval __buffer as zstring ptr) as zstring ptr
declare function lchown (byval _file as zstring ptr, byval owner as integer, byval group as integer) as integer
declare function lockf (byval _filedes as integer, byval _cmd as integer, byval _len as off_t) as integer
declare function llockf (byval _filedes as integer, byval _cmd as integer, byval _len as off_t) as integer
declare function llseek (byval _filedes as integer, byval _offset as off_t, byval _whence as integer) as off_t
declare function nice (byval _increment as integer) as integer
declare function readlink (byval __file as zstring ptr, byval __buffer as zstring ptr, byval __size as size_t) as integer
declare function sbrk (byval _delta as integer) as any ptr
declare function symlink (byval as zstring ptr, byval as zstring ptr) as integer
declare function sync () as integer
declare function truncate (byval as zstring ptr, byval as off_t) as integer
declare function usleep (byval _useconds as uinteger) as uinteger
declare function vfork () as pid_t

end extern

#endif
