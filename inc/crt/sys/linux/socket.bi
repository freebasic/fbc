''
''
'' sys\socket -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_linux_socket_bi__
#define __crt_sys_linux_socket_bi__

#include once "crt/sys/uio.bi"

#ifndef socklen_t
type socklen_t as __socklen_t
#endif

enum __socket_type
	SOCK_STREAM = 1
	SOCK_DGRAM = 2
	SOCK_RAW = 3
	SOCK_RDM = 4
	SOCK_SEQPACKET = 5
	SOCK_PACKET = 10
end enum

#define PF_UNSPEC 0
#define PF_LOCAL 1
#define PF_UNIX 1
#define PF_FILE 1
#define PF_INET 2
#define PF_AX25 3
#define PF_IPX 4
#define PF_APPLETALK 5
#define PF_NETROM 6
#define PF_BRIDGE 7
#define PF_ATMPVC 8
#define PF_X25 9
#define PF_INET6 10
#define PF_ROSE 11
#define PF_DECnet 12
#define PF_NETBEUI 13
#define PF_SECURITY 14
#define PF_KEY 15
#define PF_NETLINK 16
#define PF_ROUTE 16
#define PF_PACKET 17
#define PF_ASH 18
#define PF_ECONET 19
#define PF_ATMSVC 20
#define PF_SNA 22
#define PF_IRDA 23
#define PF_PPPOX 24
#define PF_WANPIPE 25
#define PF_BLUETOOTH 31
#define PF_MAX 32

#define	AF_UNSPEC	PF_UNSPEC
#define	AF_LOCAL	PF_LOCAL
#define	AF_UNIX		PF_UNIX
#define	AF_FILE		PF_FILE
#define	AF_INET		PF_INET
#define	AF_AX25		PF_AX25
#define	AF_IPX		PF_IPX
#define	AF_APPLETALK	PF_APPLETALK
#define	AF_NETROM	PF_NETROM
#define	AF_BRIDGE	PF_BRIDGE
#define	AF_ATMPVC	PF_ATMPVC
#define	AF_X25		PF_X25
#define	AF_INET6	PF_INET6
#define	AF_ROSE		PF_ROSE
#define	AF_DECnet	PF_DECnet
#define	AF_NETBEUI	PF_NETBEUI
#define	AF_SECURITY	PF_SECURITY
#define	AF_KEY		PF_KEY
#define	AF_NETLINK	PF_NETLINK
#define	AF_ROUTE	PF_ROUTE
#define	AF_PACKET	PF_PACKET
#define	AF_ASH		PF_ASH
#define	AF_ECONET	PF_ECONET
#define	AF_ATMSVC	PF_ATMSVC
#define	AF_SNA		PF_SNA
#define	AF_IRDA		PF_IRDA
#define	AF_PPPOX	PF_PPPOX
#define	AF_WANPIPE	PF_WANPIPE
#define	AF_BLUETOOTH	PF_BLUETOOTH
#define	AF_MAX		PF_MAX

#define SOL_RAW 255
#define SOL_DECNET 261
#define SOL_X25 262
#define SOL_PACKET 263
#define SOL_ATM 264
#define SOL_AAL 265
#define SOL_IRDA 266
#define SOMAXCONN 128

'' begin include: bits/sockaddr.bi
type sa_family_t as ushort
'' end include: bits/sockaddr.bi

#ifndef sockaddr
	type sockaddr
		sa_family as sa_family_t
		sa_data(0 to 14-1) as byte
	end type
#endif

#define _SS_SIZE 128

type sockaddr_storage
	ss_family as sa_family_t
	__ss_align as __uint32_t
	__ss_padding(0 to _SS_SIZE-(2*len(__uint32_t))-1) as byte
end type

enum 
	MSG_OOB = &h01
	MSG_PEEK = &h02
	MSG_DONTROUTE = &h04
	MSG_CTRUNC = &h08
	MSG_PROXY = &h10
	MSG_TRUNC = &h20
	MSG_DONTWAIT = &h40
	MSG_EOR = &h80
	MSG_WAITALL = &h100
	MSG_FIN = &h200
	MSG_SYN = &h400
	MSG_CONFIRM = &h800
	MSG_RST = &h1000
	MSG_ERRQUEUE = &h2000
	MSG_NOSIGNAL = &h4000
	MSG_MORE = &h8000
end enum

type msghdr
	msg_name as any ptr
	msg_namelen as socklen_t
	msg_iov as iovec ptr
	msg_iovlen as size_t
	msg_control as any ptr
	msg_controllen as size_t
	msg_flags as long
end type

type cmsghdr
	cmsg_len as size_t
	cmsg_level as long
	cmsg_type as long
	__cmsg_data(0 to 0) as ubyte
end type

declare function __cmsg_nxthdr cdecl alias "__cmsg_nxthdr" (byval __mhdr as msghdr ptr, byval __cmsg as cmsghdr ptr) as cmsghdr ptr

enum 
	SCM_RIGHTS = &h01
	SCM_CREDENTIALS = &h02
end enum

type ucred
	pid as pid_t
	uid as uid_t
	gid as gid_t
end type

'' begin include: asm/socket.bi

'' begin include: asm/sockbios.bi
#define FIOSETOWN &h8901
#define SIOCSPGRP &h8902
#define FIOGETOWN &h8903
#define SIOCGPGRP &h8904
#define SIOCATMARK &h8905
#define SIOCGSTAMP &h8906
'' end include: asm/sockbios.bi

#define SOL_SOCKET 1
#define SO_DEBUG 1
#define SO_REUSEADDR 2
#define SO_TYPE 3
#define SO_ERROR 4
#define SO_DONTROUTE 5
#define SO_BROADCAST 6
#define SO_SNDBUF 7
#define SO_RCVBUF 8
#define SO_KEEPALIVE 9
#define SO_OOBINLINE 10
#define SO_NO_CHECK 11
#define SO_PRIORITY 12
#define SO_LINGER 13
#define SO_BSDCOMPAT 14
#define SO_PASSCRED 16
#define SO_PEERCRED 17
#define SO_RCVLOWAT 18
#define SO_SNDLOWAT 19
#define SO_RCVTIMEO 20
#define SO_SNDTIMEO 21
#define SO_SECURITY_AUTHENTICATION 22
#define SO_SECURITY_ENCRYPTION_TRANSPORT 23
#define SO_SECURITY_ENCRYPTION_NETWORK 24
#define SO_BINDTODEVICE 25
#define SO_ATTACH_FILTER 26
#define SO_DETACH_FILTER 27
#define SO_PEERNAME 28
#define SO_TIMESTAMP 29
#define SCM_TIMESTAMP 29
#define SO_ACCEPTCONN 30
#define SO_PEERSEC 31
'' end include: asm/socket.bi

type linger
	l_onoff as long
	l_linger as long
end type

#endif