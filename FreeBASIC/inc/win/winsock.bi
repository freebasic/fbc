''
''
''  Definitions for winsock 1.1
''  
''  Portions Copyright (c) 1980, 1983, 1988, 1993
''  The Regents of the University of California.  All rights reserved.
''
''  Portions Copyright (c) 1993 by Digital Equipment Corporation.
''

#ifndef _WINSOCK_H
#define _WINSOCK_H

#ifdef __FB_WIN32__
#inclib "wsock32"
#else
#endif

#if not defined( _BSDTYPES_DEFINED )
type u_char as ubyte
type u_short as ushort
type u_int as uinteger
type u_long as uinteger
#define _BSDTYPES_DEFINED
#endif

#define SOCKET u_int

#ifndef FD_SETSIZE
#define FD_SETSIZE	64
#endif

'' shutdown() how types 
#define SD_RECEIVE      &h00
#define SD_SEND         &h01
#define SD_BOTH         &h02

#ifndef _SYS_TYPES_FD_SET
 
#ifndef FD_SET
type fd_set
	fd_count					as u_int
	fd_array(0 to FD_SETSIZE-1) as SOCKET
end type
#endif

declare function __WSAFDIsSet alias "__WSAFDIsSet" (byval s as SOCKET, byval set as fd_set ptr) as integer

#ifndef FD_CLR
private sub FD_CLR(byval fd as integer, byval set as fd_set ptr)
	dim i as u_int
	for i = 0 to set->fd_count-1
		if( set->fd_array(i) = (fd) ) then
			do while( i < set->fd_count-1 )
				set->fd_array(i) = set->fd_array(i+1)
				i += 1
			loop
		end if
		set->fd_count -= 1
	next i
end sub
#endif

#ifndef FD_SET_
#define FD_SET_(fd, set) if( set->fd_count < FD_SETSIZE ) then set->fd_array(set->fd_count) = (fd) : set->fd_count += 1
#endif

#ifndef FD_ZERO
#define FD_ZERO(set) set->fd_count= 0
#endif

#ifndef FD_ISSET
#define FD_ISSET(fd, set) __WSAFDIsSet(fd, set)
#endif

#ifndef _TIMEVAL_DEFINED
#define _TIMEVAL_DEFINED
type timeval
	tv_sec		as long
	tv_usec		as long
end type
#define timerisset(tvp)	 (tvp->tv_sec or tvp->tv_usec)
#define timercmp(tvp, uvp, cmp) iif( tvp->tv_sec <> uvp->tv_sec, tvp->tv_sec cmp uvp->tv_sec, tvp->tv_usec cmp uvp->tv_usec)
#define timerclear(tvp)	 tvp->tv_sec = 0 : tvp->tv_usec = 0
#endif '' _TIMEVAL_DEFINED 

type hostent
	h_name		as byte ptr
	h_aliases	as byte ptr ptr
	h_addrtype	as short
	h_length	as short
	h_addr_list	as u_int ptr ptr
#define h_addr h_addr_list[0]
end type
type linger
	l_onoff		as u_short
	l_linger	as u_short
end type

#define IOCPARM_MASK	&h7f
#define IOC_VOID	&h20000000
#define IOC_OUT	&h40000000
#define IOC_IN	&h80000000
#define IOC_INOUT	(IOC_IN or IOC_OUT)

#define _IO(x,y)	(IOC_VOID or ((x) shl 8) or (y))
#define _IOR(x,y,t)	(IOC_OUT or ((len(t) and IOCPARM_MASK) shl 16) or ((x) shl 8) or (y))
#define _IOW(x,y,t)	(IOC_IN or ((len(t) and IOCPARM_MASK) shl 16) or ((x) shl 8) or (y))
#define FIONBIO	_IOW(asc("f"), 126, u_long)


#define FIONREAD	_IOR(asc("f"), 127, u_long)
#define FIOASYNC	_IOW(asc("f"), 125, u_long)
#define SIOCSHIWAT	_IOW(asc("s"),  0, u_long)
#define SIOCGHIWAT	_IOR(asc("s"),  1, u_long)
#define SIOCSLOWAT	_IOW(asc("s"),  2, u_long)
#define SIOCGLOWAT	_IOR(asc("s"),  3, u_long)
#define SIOCATMARK	_IOR(asc("s"),  7, u_long)

type netent 
	n_name		as byte ptr
	n_aliases	as byte ptr ptr
	n_addrtype	as short
	n_net		as u_long
end type
type servent 
	s_name		as byte ptr
	s_aliases	as byte ptr ptr
	s_port		as short
	s_proto		as byte ptr
end type
type protoent
	p_name		as byte ptr
	p_aliases	as byte ptr ptr
	p_proto		as short
end type


#define IPPROTO_IP	0
#define IPPROTO_ICMP	1
#define IPPROTO_IGMP 2
#define IPPROTO_GGP 3
#define IPPROTO_TCP	6
#define IPPROTO_PUP	12
#define IPPROTO_UDP	17
#define IPPROTO_IDP	22
#define IPPROTO_ND	77
#define IPPROTO_RAW	255
#define IPPROTO_MAX	256
#define IPPORT_ECHO	7
#define IPPORT_DISCARD	9
#define IPPORT_SYSTAT	11
#define IPPORT_DAYTIME  13
#define IPPORT_NETSTAT  15
#define IPPORT_FTP      21
#define IPPORT_TELNET   23
#define IPPORT_SMTP     25
#define IPPORT_TIMESERVER 37
#define IPPORT_NAMESERVER 42
#define IPPORT_WHOIS	43
#define IPPORT_MTP	57
#define IPPORT_TFTP	69
#define IPPORT_RJE	77
#define IPPORT_FINGER	79
#define IPPORT_TTYLINK	87
#define IPPORT_SUPDUP	95
#define IPPORT_EXECSERVER	512
#define IPPORT_LOGINSERVER	513
#define IPPORT_CMDSERVER	514
#define IPPORT_EFSSERVER	520
#define IPPORT_BIFFUDP	512
#define IPPORT_WHOSERVER	513
#define IPPORT_ROUTESERVER	520
#define IPPORT_RESERVED	1024
#define IMPLINK_IP	155
#define IMPLINK_LOWEXPER	156
#define IMPLINK_HIGHEXPER       158

type S_un_b_
	s_b1 		as u_char
	s_b2 		as u_char
	s_b3 		as u_char
	s_b4 		as u_char
end type

type S_un_w_ 
	s_w1		as u_short
	s_w2		as u_short
end type

union in_addr
	S_un_b		as S_un_b_	
	S_un_w		as S_un_w_ 
	S_addr		as u_long
end union

#define IN_CLASSA(i)	((i) and &h80000000)
#define IN_CLASSA_NET	&hff000000
#define IN_CLASSA_NSHIFT	24
#define IN_CLASSA_HOST	&h00ffffff
#define IN_CLASSA_MAX	128
#define IN_CLASSB(i)	(((i) and &hc0000000) = &h80000000)
#define IN_CLASSB_NET	   &hffff0000
#define IN_CLASSB_NSHIFT	16
#define IN_CLASSB_HOST	  &h0000ffff
#define IN_CLASSB_MAX	   65536
#define IN_CLASSC(i)	(((i) and &he0000000) = &hc0000000)
#define IN_CLASSC_NET	   &hffffff00
#define IN_CLASSC_NSHIFT	8
#define IN_CLASSC_HOST	  &hff
#define INADDR_ANY	      0
#define INADDR_LOOPBACK	 &h7f000001
#define INADDR_BROADCAST	&hffffffff
#define INADDR_NONE	&hffffffff

type sockaddr_in
	sin_family		as short
	sin_port		as u_short
	sin_addr		as in_addr
	sin_zero(0 to 7) as byte
end type

#define WSADESCRIPTION_LEN	256
#define WSASYS_STATUS_LEN	128

type WSAData
	wVersion		as short
	wHighVersion	as short
	szDescription	as string * WSADESCRIPTION_LEN+1-1
	szSystemStatus	as string * WSASYS_STATUS_LEN+1-1
	iMaxSockets		as ushort
	iMaxUdpDg		as ushort
	lpVendorInfo	as byte ptr
end type
type LPWSADATA as WSADATA ptr

#define IP_OPTIONS	1
#define SO_DEBUG	1
#define SO_ACCEPTCONN	2
#define SO_REUSEADDR	4
#define SO_KEEPALIVE	8
#define SO_DONTROUTE	16
#define SO_BROADCAST	32
#define SO_USELOOPBACK	64
#define SO_LINGER	128
#define SO_OOBINLINE	256
#define SO_DONTLINGER	(not SO_LINGER)
#define SO_SNDBUF	&h1001
#define SO_RCVBUF	&h1002
#define SO_SNDLOWAT	&h1003
#define SO_RCVLOWAT	&h1004
#define SO_SNDTIMEO	&h1005
#define SO_RCVTIMEO	&h1006
#define SO_ERROR	&h1007
#define SO_TYPE	&h1008

''
'' Note that the next 5 IP defines are specific to WinSock 1.1 (wsock32.dll).
'' They will cause errors or unexpected results if used with the
'' (gs)etsockopts exported from the WinSock 2 lib, ws2_32.dll. Refer ws2tcpip.h.
          
#define IP_MULTICAST_IF	2
#define IP_MULTICAST_TTL	3
#define IP_MULTICAST_LOOP	4
#define IP_ADD_MEMBERSHIP	5
#define IP_DROP_MEMBERSHIP  6

#define IP_DEFAULT_MULTICAST_TTL   1
#define IP_DEFAULT_MULTICAST_LOOP  1
#define IP_MAX_MEMBERSHIPS	 20

type ip_mreq
	imr_multiaddr		as in_addr
	imr_interface		as in_addr
end type

#define INVALID_SOCKET (not 0)
#define SOCKET_ERROR	(-1)
#define SOCK_STREAM	1
#define SOCK_DGRAM	2
#define SOCK_RAW	3
#define SOCK_RDM	4
#define SOCK_SEQPACKET	5
#define TCP_NODELAY	&h0001
#define AF_UNSPEC	0
#define AF_UNIX	1
#define AF_INET	2
#define AF_IMPLINK	3
#define AF_PUP	4
#define AF_CHAOS	5
#define AF_IPX	6
#define AF_NS	6
#define AF_ISO	7
#define AF_OSI	AF_ISO
#define AF_ECMA	8
#define AF_DATAKIT	9
#define AF_CCITT	10
#define AF_SNA	11
#define AF_DECnet	12
#define AF_DLI	13
#define AF_LAT	14
#define AF_HYLINK	15
#define AF_APPLETALK	16
#define AF_NETBIOS	17
#define AF_VOICEVIEW	18
#define	AF_FIREFOX	19
#define	AF_UNKNOWN1	20
#define	AF_BAN	21
#define AF_ATM	22
#define AF_INET6	23
#define AF_MAX	24

type sockaddr
	sa_family		as u_short
	sa_data(0 to 13) as byte
end type

type sockproto
	sp_family		as u_short
	sp_protocol		as u_short
end type

#define PF_UNSPEC	AF_UNSPEC
#define PF_UNIX	AF_UNIX
#define PF_INET	AF_INET
#define PF_IMPLINK	AF_IMPLINK
#define PF_PUP	AF_PUP
#define PF_CHAOS	AF_CHAOS
#define PF_NS	AF_NS
#define PF_IPX	AF_IPX
#define PF_ISO	AF_ISO
#define PF_OSI	AF_OSI
#define PF_ECMA	AF_ECMA
#define PF_DATAKIT	AF_DATAKIT
#define PF_CCITT	AF_CCITT
#define PF_SNA	AF_SNA
#define PF_DECnet	AF_DECnet
#define PF_DLI	AF_DLI
#define PF_LAT	AF_LAT
#define PF_HYLINK	AF_HYLINK
#define PF_APPLETALK	AF_APPLETALK
#define PF_VOICEVIEW	AF_VOICEVIEW
#define PF_FIREFOX	AF_FIREFOX
#define PF_UNKNOWN1	AF_UNKNOWN1
#define PF_BAN	AF_BAN
#define PF_ATM	AF_ATM
#define PF_INET6	AF_INET6
#define PF_MAX	AF_MAX
#define SOL_SOCKET	&hffff
#define SOMAXCONN	5

#define MSG_OOB	1
#define MSG_PEEK	2
#define MSG_DONTROUTE	4

#define MSG_MAXIOVLEN	16
#define MSG_PARTIAL	&h8000
#define MAXGETHOSTSTRUCT	1024
#define FD_READ	1
#define FD_WRITE	2
#define FD_OOB	4
#define FD_ACCEPT	8
#define FD_CONNECT	16
#define FD_CLOSE	32
#ifndef WSABASEERR
#define WSABASEERR	10000
#define WSAEINTR	(WSABASEERR+4)
#define WSAEBADF	(WSABASEERR+9)
#define WSAEACCES	(WSABASEERR+13)
#define WSAEFAULT	(WSABASEERR+14)
#define WSAEINVAL	(WSABASEERR+22)
#define WSAEMFILE	(WSABASEERR+24)
#define WSAEWOULDBLOCK	(WSABASEERR+35)
#define WSAEINPROGRESS	(WSABASEERR+36)
#define WSAEALREADY	(WSABASEERR+37)
#define WSAENOTSOCK	(WSABASEERR+38)
#define WSAEDESTADDRREQ	(WSABASEERR+39)
#define WSAEMSGSIZE	(WSABASEERR+40)
#define WSAEPROTOTYPE	(WSABASEERR+41)
#define WSAENOPROTOOPT	(WSABASEERR+42)
#define WSAEPROTONOSUPPORT	(WSABASEERR+43)
#define WSAESOCKTNOSUPPORT	(WSABASEERR+44)
#define WSAEOPNOTSUPP	(WSABASEERR+45)
#define WSAEPFNOSUPPORT	(WSABASEERR+46)
#define WSAEAFNOSUPPORT	(WSABASEERR+47)
#define WSAEADDRINUSE	(WSABASEERR+48)
#define WSAEADDRNOTAVAIL	(WSABASEERR+49)
#define WSAENETDOWN	(WSABASEERR+50)
#define WSAENETUNREACH	(WSABASEERR+51)
#define WSAENETRESET	(WSABASEERR+52)
#define WSAECONNABORTED	(WSABASEERR+53)
#define WSAECONNRESET	(WSABASEERR+54)
#define WSAENOBUFS	(WSABASEERR+55)
#define WSAEISCONN	(WSABASEERR+56)
#define WSAENOTCONN	(WSABASEERR+57)
#define WSAESHUTDOWN	(WSABASEERR+58)
#define WSAETOOMANYREFS	(WSABASEERR+59)
#define WSAETIMEDOUT	(WSABASEERR+60)
#define WSAECONNREFUSED	(WSABASEERR+61)
#define WSAELOOP	(WSABASEERR+62)
#define WSAENAMETOOLONG	(WSABASEERR+63)
#define WSAEHOSTDOWN	(WSABASEERR+64)
#define WSAEHOSTUNREACH	(WSABASEERR+65)
#define WSAENOTEMPTY	(WSABASEERR+66)
#define WSAEPROCLIM	(WSABASEERR+67)
#define WSAEUSERS	(WSABASEERR+68)
#define WSAEDQUOT	(WSABASEERR+69)
#define WSAESTALE	(WSABASEERR+70)
#define WSAEREMOTE	(WSABASEERR+71)
#define WSAEDISCON	(WSABASEERR+101)
#define WSASYSNOTREADY	(WSABASEERR+91)
#define WSAVERNOTSUPPORTED	(WSABASEERR+92)
#define WSANOTINITIALISED	(WSABASEERR+93)
#define WSAHOST_NOT_FOUND	(WSABASEERR+1001)
#define WSATRY_AGAIN	(WSABASEERR+1002)
#define WSANO_RECOVERY	(WSABASEERR+1003)
#define WSANO_DATA	(WSABASEERR+1004)
#endif '' !WSABASEERR 

#define WSANO_ADDRESS	WSANO_DATA

#define h_errno WSAGetLastError()
#define HOST_NOT_FOUND	WSAHOST_NOT_FOUND
#define TRY_AGAIN	WSATRY_AGAIN
#define NO_RECOVERY	WSANO_RECOVERY
#define NO_DATA	WSANO_DATA
#define NO_ADDRESS	WSANO_ADDRESS

declare function accept alias "accept" (byval as SOCKET, byval as sockaddr ptr, byval as integer ptr) as SOCKET
declare function bind alias "bind" (byval as SOCKET, byval as sockaddr ptr, byval as integer) as integer
declare function closesocket alias "closesocket" (byval as SOCKET) as integer
declare function connect alias "connect" (byval as SOCKET, byval as sockaddr ptr, byval as integer) as integer
declare function ioctlsocket alias "ioctlsocket" (byval as SOCKET, byval as long, byval as u_long ptr) as integer
declare function getpeername alias "getpeername" (byval as SOCKET, byval as sockaddr ptr, byval as integer ptr) as integer
declare function getsockname alias "getsockname" (byval as SOCKET, byval as sockaddr ptr, byval as integer ptr) as integer
declare function getsockopt alias "getsockopt" (byval as SOCKET, byval as integer, byval as integer, byval as byte ptr, byval as integer ptr) as integer
declare function inet_addr alias "inet_addr" (byval as string) as uinteger
declare function inet_ntoa stdcall alias "inet_ntoa" (byval as in_addr) as zstring ptr
declare function listen alias "listen" (byval as SOCKET, byval as integer) as integer
declare function recv alias "recv" (byval as SOCKET, byval as byte ptr, byval as integer, byval as integer) as integer
declare function recvfrom alias "recvfrom" (byval as SOCKET, byval as byte ptr, byval as integer, byval as integer, byval as sockaddr ptr, byval as integer ptr) as integer
declare function send alias "send" (byval as SOCKET, byval as byte ptr, byval as integer, byval as integer) as integer
declare function sendto alias "sendto" (byval as SOCKET, byval as byte ptr, byval as integer, byval as integer, byval as sockaddr ptr, byval as integer) as integer
declare function setsockopt alias "setsockopt" (byval as SOCKET, byval as integer, byval as integer, byval as byte ptr, byval as integer) as integer
declare function shutdown alias "shutdown" (byval as SOCKET, byval as integer) as integer
declare function opensocket alias "socket" (byval as integer, byval as integer, byval as integer) as SOCKET

declare function gethostbyaddr alias "gethostbyaddr" (byval as byte ptr, byval as integer, byval as integer) as hostent ptr
declare function gethostbyname alias "gethostbyname" (byval as string) as hostent ptr
declare function getservbyport alias "getservbyport" (byval as integer, byval as string) as servent ptr
declare function getservbyname alias "getservbyname" (byval as string, byval as string) as servent ptr
declare function getprotobynumber alias "getprotobynumber" (byval as integer) as protoent ptr
declare function getprotobyname alias "getprotobyname" (byval as string) as protoent ptr

declare function WSAStartup alias "WSAStartup" (byval as short, byval as LPWSADATA) as integer
declare function WSACleanup alias "WSACleanup" () as integer
declare sub 	 WSASetLastError alias "WSASetLastError" (byval as integer)
declare function WSAGetLastError alias "WSAGetLastError" () as integer
declare function WSAIsBlocking alias "WSAIsBlocking" () as integer
declare function WSAUnhookBlockingHook alias "WSAUnhookBlockingHook" () as integer
declare function WSASetBlockingHook alias "WSASetBlockingHook" (byval as sub) as sub
declare function WSACancelBlockingCall alias "WSACancelBlockingCall" () as integer
declare function WSAAsyncGetServByName alias "WSAAsyncGetServByName" (byval as integer, byval as u_int, byval as byte ptr, byval as byte ptr, byval as byte ptr, byval as integer) as integer
declare function WSAAsyncGetServByPort alias "WSAAsyncGetServByPort" (byval as integer, byval as u_int, byval as integer, byval as byte ptr, byval as byte ptr, byval as integer) as integer
declare function WSAAsyncGetProtoByName alias "WSAAsyncGetProtoByName" (byval as integer, byval as u_int, byval as byte ptr, byval as byte ptr, byval as integer) as integer
declare function WSAAsyncGetProtoByNumber alias "WSAAsyncGetProtoByNumber" (byval as integer, byval as u_int, byval as integer, byval as byte ptr, byval as integer) as integer
declare function WSAAsyncGetHostByName alias "WSAAsyncGetHostByName" (byval as integer, byval as u_int, byval as byte ptr, byval as byte ptr, byval as integer) as integer
declare function WSAAsyncGetHostByAddr alias "WSAAsyncGetHostByAddr" (byval as integer, byval as u_int, byval as byte ptr, byval as integer, byval as integer, byval as byte ptr, byval as integer) as integer
declare function WSACancelAsyncRequest alias "WSACancelAsyncRequest" (byval as integer) as integer
declare function WSAAsyncSelect alias "WSAAsyncSelect" (byval as SOCKET, byval as integer, byval as u_int, byval as long) as integer
declare function htonl alias "htonl" (byval as u_long) as u_long
declare function ntohl alias "ntohl" (byval as u_long) as u_long
declare function htons alias "htons" (byval as u_short) as u_short
declare function ntohs alias "ntohs" (byval as u_short) as u_short
declare function selectsocket alias "select" (byval as integer, byval as fd_set ptr, byval as fd_set ptr, byval as fd_set ptr, byval as timeval ptr) as integer
declare function gethostname alias "gethostname" (byval as byte ptr, byval as integer) as integer


#ifndef MAKELONG
#define MAKELONG(a,b) ((a) shl 16 or ((b) and &h0000FFFF))
#define MAKEWORD(a,b) ((a) shl 8 or ((b) and &h000000FF))
#endif

#define WSAMAKEASYNCREPLY(b,e)	MAKELONG(b,e)
#define WSAMAKESELECTREPLY(e,error_)	MAKELONG(e,error_)
#define WSAGETASYNCBUFLEN(l)	LOWORD(l)
#define WSAGETASYNCERROR(l)	HIWORD(l)
#define WSAGETSELECTEVENT(l)	LOWORD(l)
#define WSAGETSELECTERROR(l)	HIWORD(l)

type PSOCKADDR as sockaddr ptr
type LPSOCKADDR as sockaddr ptr
type PSOCKADDR_IN as sockaddr_in ptr
type LPSOCKADDR_IN as ockaddr_in ptr
type PLINGER as linger ptr
type LPLINGER as linger ptr
type PIN_ADDR as in_addr ptr
type LPIN_ADDR as in_addr ptr
type PFD_SET as fd_set ptr
type LPFD_SET as fd_set ptr
type PHOSTENT as hostent ptr
type LPHOSTENT as hostent ptr
type PSERVENT as servent ptr
type LPSERVENT as servent ptr
type PPROTOENT as protoent ptr
type LPPROTOENT as protoent ptr
type PTIMEVAL as timeval ptr
type LPTIMEVAL as timeval ptr

#endif
