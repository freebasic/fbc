''
''
'' winsock -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winsock_bi__
#define __win_winsock_bi__

#include once "windows.bi"

#inclib "wsock32"

#ifndef _BSDTYPES_DEFINED
#define _BSDTYPES_DEFINED
type u_char as ubyte
type u_short as ushort
type u_int as uinteger
type u_long as uinteger
#endif

type SOCKET as u_int

#ifndef FD_SETSIZE
#define FD_SETSIZE 64
#endif

#define SD_RECEIVE &h00
#define SD_SEND &h01
#define SD_BOTH &h02

#ifndef fd_set
type fd_set
	fd_count as u_int
	fd_array(0 to 64-1) as SOCKET
end type
#endif

declare function __WSAFDIsSet alias "__WSAFDIsSet" (byval as SOCKET, byval as fd_set ptr) as integer

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
#define FD_SET_(fd, set) if( cptr(fd_set ptr, set)->fd_count < FD_SETSIZE ) then _
							cptr(fd_set ptr, set)->fd_array(cptr(fd_set ptr, set)->fd_count) = (fd) : _
							cptr(fd_set ptr, set)->fd_count += 1 : _
						 end if
#endif

#ifndef FD_ZERO
#define FD_ZERO(set) cptr(fd_set ptr, set)->fd_count= 0
#endif

#ifndef FD_ISSET
#define FD_ISSET(fd, set) __WSAFDIsSet( cuint(fd), cptr(fd_set ptr, set) )
#endif

#ifndef timeval
type timeval
	tv_sec as integer
	tv_usec as integer
end type
#endif

#ifndef timerisset
#define timerisset(tvp)	 (((tvp)->tv_sec <> 0) or ((tvp)->tv_usec <> 0))
#endif

#ifndef timercmp
#define timercmp(tvp, uvp, cmp) iif((tvp)->tv_sec <> (uvp)->tv_sec, (tvp)->tv_sec cmp (uvp)->tv_sec, (tvp)->tv_usec cmp (uvp)->tv_usec)
#endif

#ifndef timerclear
#define timerclear(tvp)	(tvp)->tv_sec = 0: (tvp)->tv_usec = 0
#endif

type hostent
	h_name as zstring ptr
	h_aliases as zstring ptr ptr
	h_addrtype as short
	h_length as short
	h_addr_list as u_int ptr ptr
#define h_addr h_addr_list[0]	
end type

type linger
	l_onoff as u_short
	l_linger as u_short
end type

#define IOCPARM_MASK &h7f
#define IOC_VOID &h20000000
#define IOC_OUT &h40000000
#define IOC_IN &h80000000
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
	n_name as zstring ptr
	n_aliases as zstring ptr ptr
	n_addrtype as short
	n_net as u_long
end type

type servent
	s_name as zstring ptr
	s_aliases as zstring ptr ptr
	s_port as short
	s_proto as zstring ptr
end type

type protoent
	p_name as zstring ptr
	p_aliases as zstring ptr ptr
	p_proto as short
end type

#define IPPROTO_IP 0
#define IPPROTO_ICMP 1
#define IPPROTO_IGMP 2
#define IPPROTO_GGP 3
#define IPPROTO_TCP 6
#define IPPROTO_PUP 12
#define IPPROTO_UDP 17
#define IPPROTO_IDP 22
#define IPPROTO_ND 77
#define IPPROTO_RAW 255
#define IPPROTO_MAX 256
#define IPPORT_ECHO 7
#define IPPORT_DISCARD 9
#define IPPORT_SYSTAT 11
#define IPPORT_DAYTIME 13
#define IPPORT_NETSTAT 15
#define IPPORT_FTP 21
#define IPPORT_TELNET 23
#define IPPORT_SMTP 25
#define IPPORT_TIMESERVER 37
#define IPPORT_NAMESERVER 42
#define IPPORT_WHOIS 43
#define IPPORT_MTP 57
#define IPPORT_TFTP 69
#define IPPORT_RJE 77
#define IPPORT_FINGER 79
#define IPPORT_TTYLINK 87
#define IPPORT_SUPDUP 95
#define IPPORT_EXECSERVER 512
#define IPPORT_LOGINSERVER 513
#define IPPORT_CMDSERVER 514
#define IPPORT_EFSSERVER 520
#define IPPORT_BIFFUDP 512
#define IPPORT_WHOSERVER 513
#define IPPORT_ROUTESERVER 520
#define IPPORT_RESERVED 1024
#define IMPLINK_IP 155
#define IMPLINK_LOWEXPER 156
#define IMPLINK_HIGHEXPER 158

type in_addr_S_un_S_un_w
	s_w1 as u_short
	s_w2 as u_short
end type

type in_addr_S_un_S_un_b
	s_b1 as u_char
	s_b2 as u_char
	s_b3 as u_char
	s_b4 as u_char
end type

union in_addr
	S_addr as u_long
	S_un_w as in_addr_S_un_S_un_w
	S_un_b as in_addr_S_un_S_un_b
#define s_host  S_un_b.s_b2
#define s_net   S_un_b.s_b1
#define s_imp   S_un_w.s_w2
#define s_impno S_un_b.s_b4
#define s_lh    S_un_b.s_b3
end union

#define IN_CLASSA(i)	((i) and &h80000000)
#define IN_CLASSA_NET &hff000000
#define IN_CLASSA_NSHIFT 24
#define IN_CLASSA_HOST &h00ffffff
#define IN_CLASSA_MAX 128
#define IN_CLASSB(i)	(((i) and &hc0000000) = &h80000000)
#define IN_CLASSB_NET &hffff0000
#define IN_CLASSB_NSHIFT 16
#define IN_CLASSB_HOST &h0000ffff
#define IN_CLASSB_MAX 65536
#define IN_CLASSC(i)	(((i) and &he0000000) = &hc0000000)
#define IN_CLASSC_NET &hffffff00
#define IN_CLASSC_NSHIFT 8
#define IN_CLASSC_HOST &hff
#define INADDR_ANY	      0
#define INADDR_LOOPBACK &h7f000001
#define INADDR_BROADCAST	&hffffffff
#define INADDR_NONE &hffffffff

type sockaddr_in
	sin_family as short
	sin_port as u_short
	sin_addr as in_addr
	sin_zero(0 to 7) as byte
end type

#define WSADESCRIPTION_LEN 256
#define WSASYS_STATUS_LEN 128

type WSAData
	wVersion as WORD
	wHighVersion as WORD
	szDescription as zstring * WSADESCRIPTION_LEN+1
	szSystemStatus as zstring * WSASYS_STATUS_LEN+1
	iMaxSockets as ushort
	iMaxUdpDg as ushort
	lpVendorInfo as zstring ptr
end type

type LPWSADATA as WSADATA ptr

#define IP_OPTIONS 1
#define SO_DEBUG 1
#define SO_ACCEPTCONN 2
#define SO_REUSEADDR 4
#define SO_KEEPALIVE 8
#define SO_DONTROUTE 16
#define SO_BROADCAST 32
#define SO_USELOOPBACK 64
#define SO_LINGER 128
#define SO_OOBINLINE 256
#define SO_SNDBUF &h1001
#define SO_RCVBUF &h1002
#define SO_SNDLOWAT &h1003
#define SO_RCVLOWAT &h1004
#define SO_SNDTIMEO &h1005
#define SO_RCVTIMEO &h1006
#define SO_ERROR &h1007
#define SO_TYPE &h1008
#define IP_MULTICAST_IF 2
#define IP_MULTICAST_TTL 3
#define IP_MULTICAST_LOOP 4
#define IP_ADD_MEMBERSHIP 5
#define IP_DROP_MEMBERSHIP 6
#define IP_DEFAULT_MULTICAST_TTL 1
#define IP_DEFAULT_MULTICAST_LOOP 1
#define IP_MAX_MEMBERSHIPS 20

type ip_mreq
	imr_multiaddr as in_addr
	imr_interface as in_addr
end type

#define INVALID_SOCKET cuint(not 0)
#define SOCKET_ERROR (-1)
#define SOCK_STREAM 1
#define SOCK_DGRAM 2
#define SOCK_RAW 3
#define SOCK_RDM 4
#define SOCK_SEQPACKET 5
#define TCP_NODELAY &h0001
#define AF_UNSPEC 0
#define AF_UNIX 1
#define AF_INET 2
#define AF_IMPLINK 3
#define AF_PUP 4
#define AF_CHAOS 5
#define AF_IPX 6
#define AF_NS 6
#define AF_ISO 7
#define AF_OSI 7
#define AF_ECMA 8
#define AF_DATAKIT 9
#define AF_CCITT 10
#define AF_SNA 11
#define AF_DECnet 12
#define AF_DLI 13
#define AF_LAT 14
#define AF_HYLINK 15
#define AF_APPLETALK 16
#define AF_NETBIOS 17
#define AF_VOICEVIEW 18
#define AF_FIREFOX 19
#define AF_UNKNOWN1 20
#define AF_BAN 21
#define AF_ATM 22
#define AF_INET6 23
#define AF_MAX 24

#ifndef sockaddr
	type sockaddr
		sa_family as u_short
		sa_data(0 to 13) as byte
	end type
#endif

type sockproto
	sp_family as u_short
	sp_protocol as u_short
end type

#define PF_UNSPEC 0
#define PF_UNIX 1
#define PF_INET 2
#define PF_IMPLINK 3
#define PF_PUP 4
#define PF_CHAOS 5
#define PF_NS 6
#define PF_IPX 6
#define PF_ISO 7
#define PF_OSI 7
#define PF_ECMA 8
#define PF_DATAKIT 9
#define PF_CCITT 10
#define PF_SNA 11
#define PF_DECnet 12
#define PF_DLI 13
#define PF_LAT 14
#define PF_HYLINK 15
#define PF_APPLETALK 16
#define PF_VOICEVIEW 18
#define PF_FIREFOX 19
#define PF_UNKNOWN1 20
#define PF_BAN 21
#define PF_ATM 22
#define PF_INET6 23
#define PF_MAX 24
#define SOL_SOCKET &hffff
#define SOMAXCONN 5
#define MSG_OOB 1
#define MSG_PEEK 2
#define MSG_DONTROUTE 4
#define MSG_MAXIOVLEN 16
#define MSG_PARTIAL &h8000
#define MAXGETHOSTSTRUCT 1024
#define FD_READ 1
#define FD_WRITE 2
#define FD_OOB 4
#define FD_ACCEPT 8
#define FD_CONNECT 16
#define FD_CLOSE 32

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

#define WSANO_ADDRESS 11004L
#define h_errno WSAGetLastError()
#define HOST_NOT_FOUND 11001L
#define TRY_AGAIN 11002L
#define NO_RECOVERY 11003L
#define NO_DATA 11004L
#define NO_ADDRESS 11004L

declare function accept alias "accept" (byval as SOCKET, byval as sockaddr ptr, byval as integer ptr) as SOCKET
declare function bind alias "bind" (byval as SOCKET, byval as sockaddr ptr, byval as integer) as integer
declare function closesocket alias "closesocket" (byval as SOCKET) as integer
declare function connect alias "connect" (byval as SOCKET, byval as sockaddr ptr, byval as integer) as integer
declare function ioctlsocket alias "ioctlsocket" (byval as SOCKET, byval as integer, byval as u_long ptr) as integer
declare function getpeername alias "getpeername" (byval as SOCKET, byval as sockaddr ptr, byval as integer ptr) as integer
declare function getsockname alias "getsockname" (byval as SOCKET, byval as sockaddr ptr, byval as integer ptr) as integer
declare function getsockopt alias "getsockopt" (byval as SOCKET, byval as integer, byval as integer, byval as zstring ptr, byval as integer ptr) as integer
declare function inet_addr alias "inet_addr" (byval as zstring ptr) as uinteger
declare function inet_ntoa alias "inet_ntoa" (byval as in_addr) as zstring ptr
declare function listen alias "listen" (byval as SOCKET, byval as integer) as integer
declare function recv alias "recv" (byval as SOCKET, byval as zstring ptr, byval as integer, byval as integer) as integer
declare function recvfrom alias "recvfrom" (byval as SOCKET, byval as zstring ptr, byval as integer, byval as integer, byval as sockaddr ptr, byval as integer ptr) as integer
declare function send alias "send" (byval as SOCKET, byval as zstring ptr, byval as integer, byval as integer) as integer
declare function sendto alias "sendto" (byval as SOCKET, byval as zstring ptr, byval as integer, byval as integer, byval as sockaddr ptr, byval as integer) as integer
declare function setsockopt alias "setsockopt" (byval as SOCKET, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function shutdown alias "shutdown" (byval as SOCKET, byval as integer) as integer
declare function socket_ alias "socket" (byval as integer, byval as integer, byval as integer) as SOCKET
#define opensocket socket_
declare function gethostbyaddr alias "gethostbyaddr" (byval as zstring ptr, byval as integer, byval as integer) as hostent ptr
declare function gethostbyname alias "gethostbyname" (byval as zstring ptr) as hostent ptr
declare function getservbyport alias "getservbyport" (byval as integer, byval as zstring ptr) as servent ptr
declare function getservbyname alias "getservbyname" (byval as zstring ptr, byval as zstring ptr) as servent ptr
declare function getprotobynumber alias "getprotobynumber" (byval as integer) as protoent ptr
declare function getprotobyname alias "getprotobyname" (byval as zstring ptr) as protoent ptr
declare function WSAStartup alias "WSAStartup" (byval as WORD, byval as LPWSADATA) as integer
declare function WSACleanup alias "WSACleanup" () as integer
declare sub WSASetLastError alias "WSASetLastError" (byval as integer)
declare function WSAGetLastError alias "WSAGetLastError" () as integer
declare function WSAIsBlocking alias "WSAIsBlocking" () as BOOL
declare function WSAUnhookBlockingHook alias "WSAUnhookBlockingHook" () as integer
declare function WSASetBlockingHook alias "WSASetBlockingHook" (byval as FARPROC) as FARPROC
declare function WSACancelBlockingCall alias "WSACancelBlockingCall" () as integer
declare function WSAAsyncGetServByName alias "WSAAsyncGetServByName" (byval as HWND, byval as u_int, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as integer) as HANDLE
declare function WSAAsyncGetServByPort alias "WSAAsyncGetServByPort" (byval as HWND, byval as u_int, byval as integer, byval as zstring ptr, byval as zstring ptr, byval as integer) as HANDLE
declare function WSAAsyncGetProtoByName alias "WSAAsyncGetProtoByName" (byval as HWND, byval as u_int, byval as zstring ptr, byval as zstring ptr, byval as integer) as HANDLE
declare function WSAAsyncGetProtoByNumber alias "WSAAsyncGetProtoByNumber" (byval as HWND, byval as u_int, byval as integer, byval as zstring ptr, byval as integer) as HANDLE
declare function WSAAsyncGetHostByName alias "WSAAsyncGetHostByName" (byval as HWND, byval as u_int, byval as zstring ptr, byval as zstring ptr, byval as integer) as HANDLE
declare function WSAAsyncGetHostByAddr alias "WSAAsyncGetHostByAddr" (byval as HWND, byval as u_int, byval as zstring ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as HANDLE
declare function WSACancelAsyncRequest alias "WSACancelAsyncRequest" (byval as HANDLE) as integer
declare function WSAAsyncSelect alias "WSAAsyncSelect" (byval as SOCKET, byval as HWND, byval as u_int, byval as integer) as integer
declare function htonl alias "htonl" (byval as u_long) as u_long
declare function ntohl alias "ntohl" (byval as u_long) as u_long
declare function htons alias "htons" (byval as u_short) as u_short
declare function ntohs alias "ntohs" (byval as u_short) as u_short
declare function select_ alias "select" (byval nfds as integer, byval as fd_set ptr, byval as fd_set ptr, byval as fd_set ptr, byval as timeval ptr) as integer
#define selectsocket select_
declare function gethostname alias "gethostname" (byval as zstring ptr, byval as integer) as integer

type PSOCKADDR as sockaddr ptr
type LPSOCKADDR as sockaddr ptr
type PSOCKADDR_IN as sockaddr_in ptr
type LPSOCKADDR_IN as sockaddr_in ptr
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

#include once "win/mswsock.bi"

#endif
