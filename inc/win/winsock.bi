'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "wsock32"

#include once "windows.bi"
#include once "crt/sys/time.bi"
#include once "_bsd_types.bi"
#include once "inaddr.bi"

'' The following symbols have been renamed:
''     procedure select => select_
''     procedure socket => socket_

extern "Windows"

#define _WINSOCKAPI_
#define ___WSA_SOCKET_TYPES_H
type SOCKET as UINT_PTR
const INVALID_SOCKET = cast(SOCKET, not 0)
const SOCKET_ERROR = -1
#define ___WSA_FD_TYPES_H
const FD_SETSIZE = 64

type FD_SET
	fd_count as u_int
	fd_array(0 to 63) as SOCKET
end type

declare function __WSAFDIsSet(byval as SOCKET, byval as FD_SET ptr) as long

#macro FD_CLR(fd, set)
	scope
		dim __i as u_int
		while __i < cptr(fd_set ptr, set)->fd_count
			if cptr(fd_set ptr, set)->fd_array(__i) = fd then
				while __i < cptr(fd_set ptr, set)->fd_count - 1
					cptr(fd_set ptr, set)->fd_array(__i) = cptr(fd_set ptr, set)->fd_array(__i + 1)
					__i += 1
				wend
				cptr(fd_set ptr, set)->fd_count -= 1
				exit while
			end if
			__i += 1
		wend
	end scope
#endmacro
#define FD_ZERO(set) scope : cptr(FD_SET ptr, (set))->fd_count = 0 : end scope
#define FD_ISSET(fd, set) __WSAFDIsSet(cast(SOCKET, (fd)), cptr(FD_SET ptr, (set)))
#define _FD_SET_WINSOCK_DEFINED
#macro FD_SET_(fd, set)
	scope
		if cptr(fd_set ptr, set)->fd_count < FD_SETSIZE then
			cptr(fd_set ptr, set)->fd_array(cptr(fd_set ptr, set)->fd_count) = (fd)
			cptr(fd_set ptr, set)->fd_count += 1
		end if
	end scope
#endmacro
type PFD_SET as FD_SET ptr
type LPFD_SET as FD_SET ptr
#define _MINGW_IP_TYPES_H
#define h_addr h_addr_list[0]

type HOSTENT
	h_name as zstring ptr
	h_aliases as zstring ptr ptr
	h_addrtype as short
	h_length as short
	h_addr_list as zstring ptr ptr
end type

type netent
	n_name as zstring ptr
	n_aliases as zstring ptr ptr
	n_addrtype as short
	n_net as u_long
end type

type SERVENT
	s_name as zstring ptr
	s_aliases as zstring ptr ptr

	#ifdef __FB_64BIT__
		s_proto as zstring ptr
	#endif

	s_port as short

	#ifndef __FB_64BIT__
		s_proto as zstring ptr
	#endif
end type

type PROTOENT
	p_name as zstring ptr
	p_aliases as zstring ptr ptr
	p_proto as short
end type

type sockproto
	sp_family as u_short
	sp_protocol as u_short
end type

type LINGER
	l_onoff as u_short
	l_linger as u_short
end type

type SOCKADDR
	sa_family as u_short
	sa_data as zstring * 14
end type

type SOCKADDR_IN
	sin_family as short
	sin_port as u_short
	sin_addr as IN_ADDR
	sin_zero as zstring * 8
end type

type PHOSTENT as HOSTENT ptr
type LPHOSTENT as HOSTENT ptr
type PSERVENT as SERVENT ptr
type LPSERVENT as SERVENT ptr
type PPROTOENT as PROTOENT ptr
type LPPROTOENT as PROTOENT ptr
type PSOCKADDR as SOCKADDR ptr
type LPSOCKADDR as SOCKADDR ptr
type PSOCKADDR_IN as SOCKADDR_IN ptr
type LPSOCKADDR_IN as SOCKADDR_IN ptr
type PLINGER as LINGER ptr
type LPLINGER as LINGER ptr
type PTIMEVAL as TIMEVAL ptr
type LPTIMEVAL as TIMEVAL ptr
#define _MINGW_IP_MREQ1_H

type ip_mreq
	imr_multiaddr as IN_ADDR
	imr_interface as IN_ADDR
end type

#define __MINGW_WSADATA_H
const WSADESCRIPTION_LEN = 256
const WSASYS_STATUS_LEN = 128

type WSADATA
	wVersion as WORD
	wHighVersion as WORD

	#ifndef __FB_64BIT__
		szDescription as zstring * 256 + 1
		szSystemStatus as zstring * 128 + 1
	#endif

	iMaxSockets as ushort
	iMaxUdpDg as ushort
	lpVendorInfo as zstring ptr

	#ifdef __FB_64BIT__
		szDescription as zstring * 256 + 1
		szSystemStatus as zstring * 128 + 1
	#endif
end type

type LPWSADATA as WSADATA ptr
#define __MINGW_TRANSMIT_FILE_H

type _TRANSMIT_FILE_BUFFERS
	Head as LPVOID
	HeadLength as DWORD
	Tail as LPVOID
	TailLength as DWORD
end type

type TRANSMIT_FILE_BUFFERS as _TRANSMIT_FILE_BUFFERS
type PTRANSMIT_FILE_BUFFERS as _TRANSMIT_FILE_BUFFERS ptr
type LPTRANSMIT_FILE_BUFFERS as _TRANSMIT_FILE_BUFFERS ptr

const IOCPARM_MASK = &h7f
const IOC_VOID = &h20000000
const IOC_OUT = &h40000000
const IOC_IN = &h80000000
const IOC_INOUT = IOC_IN or IOC_OUT
#define _IO(x, y) ((IOC_VOID or ((x) shl 8)) or (y))
#define _IOR(x, y, t) (((IOC_OUT or ((clng(sizeof(t)) and IOCPARM_MASK) shl 16)) or ((x) shl 8)) or (y))
#define _IOW(x, y, t) (((IOC_IN or ((clng(sizeof(t)) and IOCPARM_MASK) shl 16)) or ((x) shl 8)) or (y))
#define FIONREAD _IOR(asc("f"), 127, u_long)
#define FIONBIO _IOW(asc("f"), 126, u_long)
#define FIOASYNC _IOW(asc("f"), 125, u_long)
#define SIOCSHIWAT _IOW(asc("s"), 0, u_long)
#define SIOCGHIWAT _IOR(asc("s"), 1, u_long)
#define SIOCSLOWAT _IOW(asc("s"), 2, u_long)
#define SIOCGLOWAT _IOR(asc("s"), 3, u_long)
#define SIOCATMARK _IOR(asc("s"), 7, u_long)
const IPPROTO_IP = 0
const IPPROTO_ICMP = 1
const IPPROTO_IGMP = 2
const IPPROTO_GGP = 3
const IPPROTO_TCP = 6
const IPPROTO_PUP = 12
const IPPROTO_UDP = 17
const IPPROTO_IDP = 22
const IPPROTO_ND = 77
const IPPROTO_RAW = 255
const IPPROTO_MAX = 256
const IPPORT_ECHO = 7
const IPPORT_DISCARD = 9
const IPPORT_SYSTAT = 11
const IPPORT_DAYTIME = 13
const IPPORT_NETSTAT = 15
const IPPORT_FTP = 21
const IPPORT_TELNET = 23
const IPPORT_SMTP = 25
const IPPORT_TIMESERVER = 37
const IPPORT_NAMESERVER = 42
const IPPORT_WHOIS = 43
const IPPORT_MTP = 57
const IPPORT_TFTP = 69
const IPPORT_RJE = 77
const IPPORT_FINGER = 79
const IPPORT_TTYLINK = 87
const IPPORT_SUPDUP = 95
const IPPORT_EXECSERVER = 512
const IPPORT_LOGINSERVER = 513
const IPPORT_CMDSERVER = 514
const IPPORT_EFSSERVER = 520
const IPPORT_BIFFUDP = 512
const IPPORT_WHOSERVER = 513
const IPPORT_ROUTESERVER = 520
const IPPORT_RESERVED = 1024
const IMPLINK_IP = 155
const IMPLINK_LOWEXPER = 156
const IMPLINK_HIGHEXPER = 158
#define IN_CLASSA(i) ((clng(i) and &h80000000) = 0)
const IN_CLASSA_NET = &hff000000
const IN_CLASSA_NSHIFT = 24
const IN_CLASSA_HOST = &h00ffffff
const IN_CLASSA_MAX = 128
#define IN_CLASSB(i) ((clng(i) and &hc0000000) = &h80000000)
const IN_CLASSB_NET = &hffff0000
const IN_CLASSB_NSHIFT = 16
const IN_CLASSB_HOST = &h0000ffff
const IN_CLASSB_MAX = 65536
#define IN_CLASSC(i) ((clng(i) and &he0000000) = &hc0000000)
const IN_CLASSC_NET = &hffffff00
const IN_CLASSC_NSHIFT = 8
const IN_CLASSC_HOST = &h000000ff
#define INADDR_ANY cast(u_long, &h00000000)
const INADDR_LOOPBACK = &h7f000001
#define INADDR_BROADCAST cast(u_long, &hffffffff)
const INADDR_NONE = &hffffffff
const IP_OPTIONS = 1
const IP_MULTICAST_IF = 2
const IP_MULTICAST_TTL = 3
const IP_MULTICAST_LOOP = 4
const IP_ADD_MEMBERSHIP = 5
const IP_DROP_MEMBERSHIP = 6
const IP_TTL = 7
const IP_TOS = 8
const IP_DONTFRAGMENT = 9
const IP_DEFAULT_MULTICAST_TTL = 1
const IP_DEFAULT_MULTICAST_LOOP = 1
const IP_MAX_MEMBERSHIPS = 20
const SOCK_STREAM = 1
const SOCK_DGRAM = 2
const SOCK_RAW = 3
const SOCK_RDM = 4
const SOCK_SEQPACKET = 5
const SO_DEBUG = &h0001
const SO_ACCEPTCONN = &h0002
const SO_REUSEADDR = &h0004
const SO_KEEPALIVE = &h0008
const SO_DONTROUTE = &h0010
const SO_BROADCAST = &h0020
const SO_USELOOPBACK = &h0040
const SO_LINGER = &h0080
const SO_OOBINLINE = &h0100
const SO_DONTLINGER = cast(u_int, not SO_LINGER)
const SO_SNDBUF = &h1001
const SO_RCVBUF = &h1002
const SO_SNDLOWAT = &h1003
const SO_RCVLOWAT = &h1004
const SO_SNDTIMEO = &h1005
const SO_RCVTIMEO = &h1006
const SO_ERROR = &h1007
const SO_TYPE = &h1008
const SO_CONNDATA = &h7000
const SO_CONNOPT = &h7001
const SO_DISCDATA = &h7002
const SO_DISCOPT = &h7003
const SO_CONNDATALEN = &h7004
const SO_CONNOPTLEN = &h7005
const SO_DISCDATALEN = &h7006
const SO_DISCOPTLEN = &h7007
const SO_OPENTYPE = &h7008
const SO_SYNCHRONOUS_ALERT = &h10
const SO_SYNCHRONOUS_NONALERT = &h20
const SO_MAXDG = &h7009
const SO_MAXPATHDG = &h700A
const SO_UPDATE_ACCEPT_CONTEXT = &h700B
const SO_CONNECT_TIME = &h700C
const TCP_NODELAY = &h0001
const TCP_BSDURGENT = &h7000
const AF_UNSPEC = 0
const AF_UNIX = 1
const AF_INET = 2
const AF_IMPLINK = 3
const AF_PUP = 4
const AF_CHAOS = 5
const AF_IPX = 6
const AF_NS = 6
const AF_ISO = 7
const AF_OSI = AF_ISO
const AF_ECMA = 8
const AF_DATAKIT = 9
const AF_CCITT = 10
const AF_SNA = 11
const AF_DECnet = 12
const AF_DLI = 13
const AF_LAT = 14
const AF_HYLINK = 15
const AF_APPLETALK = 16
const AF_NETBIOS = 17
const AF_VOICEVIEW = 18
const AF_FIREFOX = 19
const AF_UNKNOWN1 = 20
const AF_BAN = 21
const AF_MAX = 22
const PF_UNSPEC = AF_UNSPEC
const PF_UNIX = AF_UNIX
const PF_INET = AF_INET
const PF_IMPLINK = AF_IMPLINK
const PF_PUP = AF_PUP
const PF_CHAOS = AF_CHAOS
const PF_NS = AF_NS
const PF_IPX = AF_IPX
const PF_ISO = AF_ISO
const PF_OSI = AF_OSI
const PF_ECMA = AF_ECMA
const PF_DATAKIT = AF_DATAKIT
const PF_CCITT = AF_CCITT
const PF_SNA = AF_SNA
const PF_DECnet = AF_DECnet
const PF_DLI = AF_DLI
const PF_LAT = AF_LAT
const PF_HYLINK = AF_HYLINK
const PF_APPLETALK = AF_APPLETALK
const PF_VOICEVIEW = AF_VOICEVIEW
const PF_FIREFOX = AF_FIREFOX
const PF_UNKNOWN1 = AF_UNKNOWN1
const PF_BAN = AF_BAN
const PF_MAX = AF_MAX
const SOL_SOCKET = &hffff
const SOMAXCONN = 5
const MSG_OOB = &h1
const MSG_PEEK = &h2
const MSG_DONTROUTE = &h4
const MSG_MAXIOVLEN = 16
const MSG_PARTIAL = &h8000
const MAXGETHOSTSTRUCT = 1024
const FD_READ = &h01
const FD_WRITE = &h02
const FD_OOB = &h04
const FD_ACCEPT = &h08
const FD_CONNECT = &h10
const FD_CLOSE = &h20
#define __WSA_ERR_MACROS_DEFINED
#define h_errno WSAGetLastError()
const HOST_NOT_FOUND = WSAHOST_NOT_FOUND
const TRY_AGAIN = WSATRY_AGAIN
const NO_RECOVERY = WSANO_RECOVERY
const NO_DATA = WSANO_DATA
const WSANO_ADDRESS = WSANO_DATA
const NO_ADDRESS = WSANO_ADDRESS

declare function accept(byval s as SOCKET, byval addr as SOCKADDR ptr, byval addrlen as long ptr) as SOCKET
declare function bind(byval s as SOCKET, byval name as const SOCKADDR ptr, byval namelen as long) as long
declare function closesocket(byval s as SOCKET) as long
declare function connect(byval s as SOCKET, byval name as const SOCKADDR ptr, byval namelen as long) as long
declare function ioctlsocket(byval s as SOCKET, byval cmd as long, byval argp as u_long ptr) as long
declare function getpeername(byval s as SOCKET, byval name as SOCKADDR ptr, byval namelen as long ptr) as long
declare function getsockname(byval s as SOCKET, byval name as SOCKADDR ptr, byval namelen as long ptr) as long
declare function getsockopt(byval s as SOCKET, byval level as long, byval optname as long, byval optval as zstring ptr, byval optlen as long ptr) as long
declare function htonl(byval hostlong as u_long) as u_long
declare function htons(byval hostshort as u_short) as u_short
declare function inet_addr(byval cp as const zstring ptr) as ulong
declare function inet_ntoa(byval in as IN_ADDR) as zstring ptr
declare function listen(byval s as SOCKET, byval backlog as long) as long
declare function ntohl(byval netlong as u_long) as u_long
declare function ntohs(byval netshort as u_short) as u_short
declare function recv(byval s as SOCKET, byval buf as zstring ptr, byval len as long, byval flags as long) as long
declare function recvfrom(byval s as SOCKET, byval buf as zstring ptr, byval len as long, byval flags as long, byval from as SOCKADDR ptr, byval fromlen as long ptr) as long
declare function select_ alias "select"(byval nfds as long, byval readfds as FD_SET ptr, byval writefds as FD_SET ptr, byval exceptfds as FD_SET ptr, byval timeout as const PTIMEVAL) as long
#define selectsocket select_
declare function send(byval s as SOCKET, byval buf as const zstring ptr, byval len as long, byval flags as long) as long
declare function sendto(byval s as SOCKET, byval buf as const zstring ptr, byval len as long, byval flags as long, byval to as const SOCKADDR ptr, byval tolen as long) as long
declare function setsockopt(byval s as SOCKET, byval level as long, byval optname as long, byval optval as const zstring ptr, byval optlen as long) as long
declare function shutdown(byval s as SOCKET, byval how as long) as long
declare function socket_ alias "socket"(byval af as long, byval type as long, byval protocol as long) as SOCKET
#define opensocket socket_
declare function gethostbyaddr(byval addr as const zstring ptr, byval len as long, byval type as long) as HOSTENT ptr
declare function gethostbyname(byval name as const zstring ptr) as HOSTENT ptr
declare function gethostname(byval name as zstring ptr, byval namelen as long) as long
declare function getservbyport(byval port as long, byval proto as const zstring ptr) as SERVENT ptr
declare function getservbyname(byval name as const zstring ptr, byval proto as const zstring ptr) as SERVENT ptr
declare function getprotobynumber(byval number as long) as PROTOENT ptr
declare function getprotobyname(byval name as const zstring ptr) as PROTOENT ptr
declare function WSAStartup(byval wVersionRequested as WORD, byval lpWSAData as LPWSADATA) as long
declare function WSACleanup() as long
declare sub WSASetLastError(byval iError as long)
declare function WSAGetLastError() as long
declare function WSAIsBlocking() as WINBOOL
declare function WSAUnhookBlockingHook() as long
declare function WSASetBlockingHook(byval lpBlockFunc as FARPROC) as FARPROC
declare function WSACancelBlockingCall() as long
declare function WSAAsyncGetServByName(byval hWnd as HWND, byval wMsg as u_int, byval name as const zstring ptr, byval proto as const zstring ptr, byval buf as zstring ptr, byval buflen as long) as HANDLE
declare function WSAAsyncGetServByPort(byval hWnd as HWND, byval wMsg as u_int, byval port as long, byval proto as const zstring ptr, byval buf as zstring ptr, byval buflen as long) as HANDLE
declare function WSAAsyncGetProtoByName(byval hWnd as HWND, byval wMsg as u_int, byval name as const zstring ptr, byval buf as zstring ptr, byval buflen as long) as HANDLE
declare function WSAAsyncGetProtoByNumber(byval hWnd as HWND, byval wMsg as u_int, byval number as long, byval buf as zstring ptr, byval buflen as long) as HANDLE
declare function WSAAsyncGetHostByName(byval hWnd as HWND, byval wMsg as u_int, byval name as const zstring ptr, byval buf as zstring ptr, byval buflen as long) as HANDLE
declare function WSAAsyncGetHostByAddr(byval hWnd as HWND, byval wMsg as u_int, byval addr as const zstring ptr, byval len as long, byval type as long, byval buf as zstring ptr, byval buflen as long) as HANDLE
declare function WSACancelAsyncRequest(byval hAsyncTaskHandle as HANDLE) as long
declare function WSAAsyncSelect(byval s as SOCKET, byval hWnd as HWND, byval wMsg as u_int, byval lEvent as long) as long
#define __WINSOCK_WS1_SHARED
declare function WSARecvEx(byval s as SOCKET, byval buf as zstring ptr, byval len as long, byval flags as long ptr) as long

const TF_DISCONNECT = &h01
const TF_REUSE_SOCKET = &h02
const TF_WRITE_BEHIND = &h04

declare function TransmitFile(byval hSocket as SOCKET, byval hFile as HANDLE, byval nNumberOfBytesToWrite as DWORD, byval nNumberOfBytesPerSend as DWORD, byval lpOverlapped as LPOVERLAPPED, byval lpTransmitBuffers as LPTRANSMIT_FILE_BUFFERS, byval dwReserved as DWORD) as WINBOOL
declare function AcceptEx(byval sListenSocket as SOCKET, byval sAcceptSocket as SOCKET, byval lpOutputBuffer as PVOID, byval dwReceiveDataLength as DWORD, byval dwLocalAddressLength as DWORD, byval dwRemoteAddressLength as DWORD, byval lpdwBytesReceived as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare sub GetAcceptExSockaddrs(byval lpOutputBuffer as PVOID, byval dwReceiveDataLength as DWORD, byval dwLocalAddressLength as DWORD, byval dwRemoteAddressLength as DWORD, byval LocalSockaddr as SOCKADDR ptr ptr, byval LocalSockaddrLength as LPINT, byval RemoteSockaddr as SOCKADDR ptr ptr, byval RemoteSockaddrLength as LPINT)

#define __MSWSOCK_WS1_SHARED
#define WSAMAKEASYNCREPLY(buflen, error) MAKELONG(buflen, error)
#define WSAMAKESELECTREPLY(event, error) MAKELONG(event, error)
#define WSAGETASYNCBUFLEN(lParam) LOWORD(lParam)
#define WSAGETASYNCERROR(lParam) HIWORD(lParam)
#define WSAGETSELECTEVENT(lParam) LOWORD(lParam)
#define WSAGETSELECTERROR(lParam) HIWORD(lParam)

end extern
