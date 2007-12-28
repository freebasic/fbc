''
''
'' sys\select -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_select_bi__
#define __crt_sys_select_bi__

#include once "crt/sys/types.bi"

#if defined(__FB_LINUX__)
#include once "crt/sys/linux/select.bi"
#else
#error Platform unsupported
#endif

type sigset_t as __sigset_t

#include once "crt/sys/time.bi"

type suseconds_t as __suseconds_t

type __fd_mask as integer

#define __NFDBITS (8 * len(__fd_mask))
#define	__FDELT(d) ((d) \ __NFDBITS)
#define	__FDMASK(d) cast(__fd_mask, 1 shl ((d) mod __NFDBITS))

type fd_set
	___fds_bits(0 to 1024 \ (8 * len(__fd_mask))-1) as __fd_mask
	#define __FDS_BITS(set) (set)->___fds_bits
end type

#define	FD_SETSIZE __FD_SETSIZE

type fd_mask as __fd_mask
# define NFDBITS __NFDBITS

#define	FD_SET_(fd, fdsetp) __FD_SET(fd, fdsetp)
#define	FD_CLR(fd, fdsetp) __FD_CLR(fd, fdsetp)
#define	FD_ISSET(fd, fdsetp) __FD_ISSET(fd, fdsetp)
#define	FD_ZERO(fdsetp) __FD_ZERO(fdsetp)

declare function select_ cdecl alias "select" (byval __nfds as integer, byval __readfds as fd_set ptr, byval __writefds as fd_set ptr, byval __exceptfds as fd_set ptr, byval __timeout as timeval ptr) as integer
#define selectsocket select_

#endif
