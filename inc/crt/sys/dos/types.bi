''
''
'' types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_dos_types_bi__
#define __crt_sys_dos_types_bi__

type dev_t as integer
type ino_t as integer
type mode_t as integer
type nlink_t as integer
type gid_t as integer
type off_t as integer
type pid_t as integer
#ifndef ssize_t
type ssize_t as integer
#endif
type uid_t as integer

#ifndef FD_SETSIZE
#define FD_SETSIZE 256
#endif

#define FD_SET_(n, p) (p)->fd_bits((n) \ 8) or= (1 shl ((n) and 7))
#define FD_CLR(n, p) (p)->fd_bits((n) \ 8) and= not (1 shl ((n) and 7))
#define FD_ISSET(n, p) ((p)->fd_bits((n) \ 8) and (1 shl ((n) and 7)))
#define FD_ZERO(p) memset(cast(any ptr, p), 0, sizeof(*(p)))

type fd_set
	fd_bits(0 to ((FD_SETSIZE) +7)\8-1) as ubyte
end type

type time_t as uinteger

#endif
