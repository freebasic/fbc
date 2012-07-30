''
''
'' winsock2 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winsock2_bi__
#define __win_winsock2_bi__

#include once "windows.bi"

#inclib "ws2_32"

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
#define FD_CLR(fd,set) _
  scope :_
  dim i as integer :_
  for i = 0 to cptr(fd_set ptr, set)->fd_count-1:_
    if( cptr(fd_set ptr, set)->fd_array(i) = fd ) then :_
      do while( i < cptr(fd_set ptr, set)->fd_count-1 ) :_
        cptr(fd_set ptr, set)->fd_array(i) = cptr(fd_set ptr, set)->fd_array(i+1) :_
        i += 1 :_
      loop :_
      cptr(fd_set ptr, set)->fd_count -= 1 :_
      exit for
    end if :_
  next :_
  end scope
#endif

#ifndef FD_SET_
#define FD_SET_(fd,set)												_
	scope															:_
		dim i as integer											:_
																	:_
		for i = 0 to cptr(fd_set ptr, set)->fd_count-1				:_
			if( cptr(fd_set ptr, set)->fd_array(i) = fd ) then		:_
				exit for											:_
			end if													:_
		next 														:_
																	:_
		if( i = cptr(fd_set ptr, set)->fd_count ) then				:_
			if( cptr(fd_set ptr, set)->fd_count < FD_SETSIZE ) then	:_
				cptr(fd_set ptr, set)->fd_array(i) = fd				:_
				cptr(fd_set ptr, set)->fd_count += 1				:_
			end if													:_
		end if														:_
	end scope
#endif

#ifndef FD_ZERO
#define FD_ZERO(set) cptr(fd_set ptr, set)->fd_count=0
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
#define IPPROTO_HOPOPTS 0
#define IPPROTO_IPV6 41
#define IPPROTO_ROUTING 43
#define IPPROTO_FRAGMENT 44
#define IPPROTO_ESP 50
#define IPPROTO_AH 51
#define IPPROTO_ICMPV6 58
#define IPPROTO_NONE 59
#define IPPROTO_DSTOPTS 60
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
	S_un_b as in_addr_S_un_S_un_b
	S_un_w as in_addr_S_un_S_un_w
	S_addr as u_long
#define s_host  S_un_b.s_b2
#define s_net   S_un_b.s_b1
#define s_imp   S_un_w.s_w2
#define s_impno S_un_b.s_b4
#define s_lh    S_un_b.s_b3
end union

#define IN_CLASSA(i)	(cint(i) and &h80000000)
#define IN_CLASSA_NET &hff000000
#define IN_CLASSA_NSHIFT 24
#define IN_CLASSA_HOST &h00ffffff
#define IN_CLASSA_MAX 128
#define IN_CLASSB(i)	((cint(i) and &hc0000000) = &h80000000)
#define IN_CLASSB_NET &hffff0000
#define IN_CLASSB_NSHIFT 16
#define IN_CLASSB_HOST &h0000ffff
#define IN_CLASSB_MAX 65536
#define IN_CLASSC(i)	((cint(i) and &he0000000) = &hc0000000)
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
#define SO_DONTLINGER cuint(not SO_LINGER)
#define SO_OOBINLINE 256
#define SO_SNDBUF &h1001
#define SO_RCVBUF &h1002
#define SO_SNDLOWAT &h1003
#define SO_RCVLOWAT &h1004
#define SO_SNDTIMEO &h1005
#define SO_RCVTIMEO &h1006
#define SO_ERROR &h1007
#define SO_TYPE &h1008
#define INVALID_SOCKET cuint(-1)
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
#define AF_CLUSTER 24
#define AF_12844 25
#define AF_IRDA 26
#define AF_NETDES 28
#define AF_MAX 29

#ifndef sockaddr
	type sockaddr
		sa_family as u_short
		sa_data(0 to 13) as byte
	end type
#endif

type sockaddr_storage
	ss_family as short
	__ss_pad1(0 to 5) as byte
	__ss_align as longint
	__ss_pad2(0 to 111) as byte
end type

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
#define PF_MAX 29
#define SOL_SOCKET &hffff
#define SOMAXCONN &h7fffffff
#define MSG_OOB 1
#define MSG_PEEK 2
#define MSG_DONTROUTE 4
#define MSG_MAXIOVLEN 16
#define MSG_PARTIAL &h8000
#define MAXGETHOSTSTRUCT 1024
#define FD_READ_BIT 0
#define FD_READ (1 shl 0)
#define FD_WRITE_BIT 1
#define FD_WRITE (1 shl 1)
#define FD_OOB_BIT 2
#define FD_OOB (1 shl 2)
#define FD_ACCEPT_BIT 3
#define FD_ACCEPT (1 shl 3)
#define FD_CONNECT_BIT 4
#define FD_CONNECT (1 shl 4)
#define FD_CLOSE_BIT 5
#define FD_CLOSE (1 shl 5)
#define FD_QOS_BIT 6
#define FD_QOS (1 shl 6)
#define FD_GROUP_QOS_BIT 7
#define FD_GROUP_QOS (1 shl 7)
#define FD_ROUTING_INTERFACE_CHANGE_BIT 8
#define FD_ROUTING_INTERFACE_CHANGE (1 shl 8)
#define FD_ADDRESS_LIST_CHANGE_BIT 9
#define FD_ADDRESS_LIST_CHANGE (1 shl 9)
#define FD_MAX_EVENTS 10
#define FD_ALL_EVENTS ((1 shl 10) -1)

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

#define WSAENOMORE	(WSABASEERR+102)
#define WSAECANCELLED	(WSABASEERR+103)
#define WSAEINVALIDPROCTABLE	(WSABASEERR+104)
#define WSAEINVALIDPROVIDER	(WSABASEERR+105)
#define WSAEPROVIDERFAILEDINIT	(WSABASEERR+106)
#define WSASYSCALLFAILURE	(WSABASEERR+107)
#define WSASERVICE_NOT_FOUND	(WSABASEERR+108)
#define WSATYPE_NOT_FOUND	(WSABASEERR+109)
#define WSA_E_NO_MORE	(WSABASEERR+110)
#define WSA_E_CANCELLED	(WSABASEERR+111)
#define WSAEREFUSED	(WSABASEERR+112)

#define WSA_QOS_RECEIVERS	(WSABASEERR + 1005)
#define WSA_QOS_SENDERS	(WSABASEERR + 1006)
#define WSA_QOS_NO_SENDERS	(WSABASEERR + 1007)
#define WSA_QOS_NO_RECEIVERS	(WSABASEERR + 1008)
#define WSA_QOS_REQUEST_CONFIRMED	(WSABASEERR + 1009)
#define WSA_QOS_ADMISSION_FAILURE	(WSABASEERR + 1010)
#define WSA_QOS_POLICY_FAILURE	(WSABASEERR + 1011)
#define WSA_QOS_BAD_STYLE	(WSABASEERR + 1012)
#define WSA_QOS_BAD_OBJECT	(WSABASEERR + 1013)
#define WSA_QOS_TRAFFIC_CTRL_ERROR	(WSABASEERR + 1014)
#define WSA_QOS_GENERIC_ERROR	(WSABASEERR + 1015)
#define WSA_QOS_ESERVICETYPE	(WSABASEERR + 1016)
#define WSA_QOS_EFLOWSPEC	(WSABASEERR + 1017)
#define WSA_QOS_EPROVSPECBUF	(WSABASEERR + 1018)
#define WSA_QOS_EFILTERSTYLE	(WSABASEERR + 1019)
#define WSA_QOS_EFILTERTYPE	(WSABASEERR + 1020)
#define WSA_QOS_EFILTERCOUNT	(WSABASEERR + 1021)
#define WSA_QOS_EOBJLENGTH	(WSABASEERR + 1022)
#define WSA_QOS_EFLOWCOUNT	(WSABASEERR + 1023)
#define WSA_QOS_EUNKOWNPSOBJ	(WSABASEERR + 1024)
#define WSA_QOS_EPOLICYOBJ	(WSABASEERR + 1025)
#define WSA_QOS_EFLOWDESC	(WSABASEERR + 1026)
#define WSA_QOS_EPSFLOWSPEC	(WSABASEERR + 1027)
#define WSA_QOS_EPSFILTERSPEC	(WSABASEERR + 1028)
#define WSA_QOS_ESDMODEOBJ	(WSABASEERR + 1029)
#define WSA_QOS_ESHAPERATEOBJ	(WSABASEERR + 1030)
#define WSA_QOS_RESERVED_PETYPE	(WSABASEERR + 1031)
#endif ''WSABASEERR 

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

#define WSAMAKEASYNCREPLY(b,e)	MAKELONG(b,e)
#define WSAMAKESELECTREPLY(e,_error)	MAKELONG(e,_error)
#define WSAGETASYNCBUFLEN(l)	LOWORD(l)
#define WSAGETASYNCERROR(l)	HIWORD(l)
#define WSAGETSELECTEVENT(l)	LOWORD(l)
#define WSAGETSELECTERROR(l)	HIWORD(l)

type PSOCKADDR as sockaddr ptr
type LPSOCKADDR as sockaddr ptr
type PSOCKADDR_STORAGE as sockaddr_storage ptr
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

#define ADDR_ANY	INADDR_ANY

#define	IN_CLASSD(i)	((cint(i) and &hf0000000) = &he0000000)
#define IN_CLASSD_NET &hf0000000
#define IN_CLASSD_NSHIFT 28
#define IN_CLASSD_HOST &h0fffffff
#define	IN_MULTICAST(i)	IN_CLASSD(i)
#define FROM_PROTOCOL_INFO (-1)
#define SO_DONTLINGER cuint(not SO_LINGER)
#define SO_GROUP_ID &h2001
#define SO_GROUP_PRIORITY &h2002
#define SO_MAX_MSG_SIZE &h2003
#define SO_PROTOCOL_INFOA &h2004
#define SO_PROTOCOL_INFOW &h2005
#ifdef UNICODE
#define SO_PROTOCOL_INFO SO_PROTOCOL_INFOW
#else
#define SO_PROTOCOL_INFO SO_PROTOCOL_INFOA
#endif
#define PVD_CONFIG &h3001
#define MSG_INTERRUPT &h10
#define MSG_MAXIOVLEN 16

#define	WSAAPI WINAPI
type WSAEVENT as HANDLE
type LPWSAEVENT as LPHANDLE
type WSAOVERLAPPED as OVERLAPPED
type LPWSAOVERLAPPED as OVERLAPPED ptr

#define WSA_IO_PENDING (997L)
#define WSA_IO_INCOMPLETE (996L)
#define WSA_INVALID_HANDLE (6L)
#define WSA_INVALID_PARAMETER (87L)
#define WSA_NOT_ENOUGH_MEMORY (8L)
#define WSA_OPERATION_ABORTED (995L)
#define	WSA_INVALID_EVENT NULL
#define WSA_MAXIMUM_WAIT_EVENTS (64)
#define WSA_WAIT_EVENT_0 (0)
#define WSA_WAIT_IO_COMPLETION (&hC0)
#define WSA_WAIT_TIMEOUT (258L)
#define WSA_INFINITE (&hFFFFFFFF)

type WSABUF
	len as uinteger
	buf as zstring ptr
end type

type LPWSABUF as WSABUF ptr

enum GUARANTEE
	BestEffortService
	ControlledLoadService
	PredictiveService
	GuaranteedDelayService
	GuaranteedService
end enum

type SERVICETYPE as uinteger

type FLOWSPEC
	TokenRate as uinteger
	TokenBucketSize as uinteger
	PeakBandwidth as uinteger
	Latency as uinteger
	DelayVariation as uinteger
	ServiceType as SERVICETYPE
	MaxSduSize as uinteger
	MinimumPolicedSize as uinteger
end type

type PFLOWSPEC as FLOWSPEC ptr
type LPFLOWSPEC as FLOWSPEC ptr

type QOS
	SendingFlowspec as FLOWSPEC
	ReceivingFlowspec as FLOWSPEC
	ProviderSpecific as WSABUF
end type

type LPQOS as QOS ptr

#define CF_ACCEPT &h0000
#define CF_REJECT &h0001
#define CF_DEFER &h0002
#define SD_RECEIVE &h00
#define SD_SEND &h01
#define SD_BOTH &h02

type GROUP as uinteger

#define SG_UNCONSTRAINED_GROUP &h01
#define SG_CONSTRAINED_GROUP &h02

type WSANETWORKEVENTS
	lNetworkEvents as integer
	iErrorCode(0 to 10-1) as integer
end type

type LPWSANETWORKEVENTS as WSANETWORKEVENTS ptr

#define MAX_PROTOCOL_CHAIN 7
#define BASE_PROTOCOL 1
#define LAYERED_PROTOCOL 0

enum WSAESETSERVICEOP
	RNRSERVICE_REGISTER = 0
	RNRSERVICE_DEREGISTER
	RNRSERVICE_DELETE
end enum

type PWSAESETSERVICEOP as WSAESETSERVICEOP
type LPWSAESETSERVICEOP as WSAESETSERVICEOP

type AFPROTOCOLS
	iAddressFamily as INT_
	iProtocol as INT_
end type

type PAFPROTOCOLS as AFPROTOCOLS ptr
type LPAFPROTOCOLS as AFPROTOCOLS ptr

enum WSAECOMPARATOR
	COMP_EQUAL = 0
	COMP_NOTLESS
end enum

type PWSAECOMPARATOR as WSAECOMPARATOR
type LPWSAECOMPARATOR as WSAECOMPARATOR

type WSAVERSION
	dwVersion as DWORD
	ecHow as WSAECOMPARATOR
end type

type PWSAVERSION as WSAVERSION ptr
type LPWSAVERSION as WSAVERSION ptr

#ifndef SOCKET_ADDRESS
type SOCKET_ADDRESS
	lpSockaddr as LPSOCKADDR
	iSockaddrLength as INT_
end type

type PSOCKET_ADDRESS as SOCKET_ADDRESS ptr
type LPSOCKET_ADDRESS as SOCKET_ADDRESS ptr

type CSADDR_INFO
	LocalAddr as SOCKET_ADDRESS
	RemoteAddr as SOCKET_ADDRESS
	iSocketType as INT_
	iProtocol as INT_
end type

type PCSADDR_INFO as CSADDR_INFO ptr
type LPCSADDR_INFO as CSADDR_INFO ptr
#endif

type SOCKET_ADDRESS_LIST
	iAddressCount as INT_
	Address(0 to 1-1) as SOCKET_ADDRESS
end type

type LPSOCKET_ADDRESS_LIST as SOCKET_ADDRESS_LIST ptr

#ifndef BLOB
type BLOB
	cbSize as ULONG
	pBlobData as UBYTE ptr
end type

type PBLOB as BLOB ptr
type LPBLOB as BLOB ptr
#endif

#ifndef UNICODE
type WSAQUERYSETA
	dwSize as DWORD
	lpszServiceInstanceName as LPSTR
	lpServiceClassId as LPGUID
	lpVersion as LPWSAVERSION
	lpszComment as LPSTR
	dwNameSpace as DWORD
	lpNSProviderId as LPGUID
	lpszContext as LPSTR
	dwNumberOfProtocols as DWORD
	lpafpProtocols as LPAFPROTOCOLS
	lpszQueryString as LPSTR
	dwNumberOfCsAddrs as DWORD
	lpcsaBuffer as LPCSADDR_INFO
	dwOutputFlags as DWORD
	lpBlob as LPBLOB
end type

type PWSAQUERYSETA as WSAQUERYSETA ptr
type LPWSAQUERYSETA as WSAQUERYSETA ptr

type WSANSCLASSINFOA
	lpszName as LPSTR
	dwNameSpace as DWORD
	dwValueType as DWORD
	dwValueSize as DWORD
	lpValue as LPVOID
end type

type PWSANSCLASSINFOA as WSANSCLASSINFOA ptr
type LPWSANSCLASSINFOA as WSANSCLASSINFOA ptr

type WSASERVICECLASSINFOA
	lpServiceClassId as LPGUID
	lpszServiceClassName as LPSTR
	dwCount as DWORD
	lpClassInfos as LPWSANSCLASSINFOA
end type

type PWSASERVICECLASSINFOA as WSASERVICECLASSINFOA ptr
type LPWSASERVICECLASSINFOA as WSASERVICECLASSINFOA ptr

type WSANAMESPACE_INFOA
	NSProviderId as GUID
	dwNameSpace as DWORD
	fActive as BOOL
	dwVersion as DWORD
	lpszIdentifier as LPSTR
end type

type PWSANAMESPACE_INFOA as WSANAMESPACE_INFOA ptr
type LPWSANAMESPACE_INFOA as WSANAMESPACE_INFOA ptr

#else ''UNICODE
type WSAQUERYSETW
	dwSize as DWORD
	lpszServiceInstanceName as LPWSTR
	lpServiceClassId as LPGUID
	lpVersion as LPWSAVERSION
	lpszComment as LPWSTR
	dwNameSpace as DWORD
	lpNSProviderId as LPGUID
	lpszContext as LPWSTR
	dwNumberOfProtocols as DWORD
	lpafpProtocols as LPAFPROTOCOLS
	lpszQueryString as LPWSTR
	dwNumberOfCsAddrs as DWORD
	lpcsaBuffer as LPCSADDR_INFO
	dwOutputFlags as DWORD
	lpBlob as LPBLOB
end type

type PWSAQUERYSETW as WSAQUERYSETW ptr
type LPWSAQUERYSETW as WSAQUERYSETW ptr

#define LUP_DEEP &h0001
#define LUP_CONTAINERS &h0002
#define LUP_NOCONTAINERS &h0004
#define LUP_NEAREST &h0008
#define LUP_RETURN_NAME &h0010
#define LUP_RETURN_TYPE &h0020
#define LUP_RETURN_VERSION &h0040
#define LUP_RETURN_COMMENT &h0080
#define LUP_RETURN_ADDR &h0100
#define LUP_RETURN_BLOB &h0200
#define LUP_RETURN_ALIASES &h0400
#define LUP_RETURN_QUERY_STRING &h0800
#define LUP_RETURN_ALL &h0FF0
#define LUP_RES_SERVICE &h8000
#define LUP_FLUSHCACHE &h1000
#define LUP_FLUSHPREVIOUS &h2000


type WSANSCLASSINFOW
	lpszName as LPWSTR
	dwNameSpace as DWORD
	dwValueType as DWORD
	dwValueSize as DWORD
	lpValue as LPVOID
end type

type PWSANSCLASSINFOW as WSANSCLASSINFOW ptr
type LPWSANSCLASSINFOW as WSANSCLASSINFOW ptr

type WSASERVICECLASSINFOW
	lpServiceClassId as LPGUID
	lpszServiceClassName as LPWSTR
	dwCount as DWORD
	lpClassInfos as LPWSANSCLASSINFOW
end type

type PWSASERVICECLASSINFOW as WSASERVICECLASSINFOW ptr
type LPWSASERVICECLASSINFOW as WSASERVICECLASSINFOW ptr

type WSANAMESPACE_INFOW
	NSProviderId as GUID
	dwNameSpace as DWORD
	fActive as BOOL
	dwVersion as DWORD
	lpszIdentifier as LPWSTR
end type

type PWSANAMESPACE_INFOW as WSANAMESPACE_INFOW ptr
type LPWSANAMESPACE_INFOW as WSANAMESPACE_INFOW ptr

#endif ''UNICODE

#ifndef UNICODE
type WSAQUERYSET as WSAQUERYSETA
type PWSAQUERYSET as PWSAQUERYSETA
type LPWSAQUERYSET as LPWSAQUERYSETA
type WSANSCLASSINFO as WSANSCLASSINFOA
type PWSANSCLASSINFO as PWSANSCLASSINFOA
type LPWSANSCLASSINFO as LPWSANSCLASSINFOA
type WSASERVICECLASSINFO as WSASERVICECLASSINFOA
type PWSASERVICECLASSINFO as PWSASERVICECLASSINFOA
type LPWSASERVICECLASSINFO as LPWSASERVICECLASSINFOA
type WSANAMESPACE_INFO as WSANAMESPACE_INFOA
type PWSANAMESPACE_INFO as PWSANAMESPACE_INFOA
type LPWSANAMESPACE_INFO as LPWSANAMESPACE_INFOA
#else ''UNICODE
type WSAQUERYSET as WSAQUERYSETW
type PWSAQUERYSET as PWSAQUERYSETW
type LPWSAQUERYSET as LPWSAQUERYSETW
type WSANSCLASSINFO as WSANSCLASSINFOW
type PWSANSCLASSINFO as PWSANSCLASSINFOW
type LPWSANSCLASSINFO as LPWSANSCLASSINFOW
type WSASERVICECLASSINFO as WSASERVICECLASSINFOW
type PWSASERVICECLASSINFO as PWSASERVICECLASSINFOW
type LPWSASERVICECLASSINFO as LPWSASERVICECLASSINFOW
type WSANAMESPACE_INFO as WSANAMESPACE_INFOW
type PWSANAMESPACE_INFO as PWSANAMESPACE_INFOW
type LPWSANAMESPACE_INFO as LPWSANAMESPACE_INFOW
#endif ''UNICODE

type WSAPROTOCOLCHAIN
	ChainLen as integer
	ChainEntries(0 to 7-1) as DWORD
end type

type LPWSAPROTOCOLCHAIN as WSAPROTOCOLCHAIN ptr

#define WSAPROTOCOL_LEN 255

#ifndef UNICODE
type WSAPROTOCOL_INFOA
	dwServiceFlags1 as DWORD
	dwServiceFlags2 as DWORD
	dwServiceFlags3 as DWORD
	dwServiceFlags4 as DWORD
	dwProviderFlags as DWORD
	ProviderId as GUID
	dwCatalogEntryId as DWORD
	ProtocolChain as WSAPROTOCOLCHAIN
	iVersion as integer
	iAddressFamily as integer
	iMaxSockAddr as integer
	iMinSockAddr as integer
	iSocketType as integer
	iProtocol as integer
	iProtocolMaxOffset as integer
	iNetworkByteOrder as integer
	iSecurityScheme as integer
	dwMessageSize as DWORD
	dwProviderReserved as DWORD
	szProtocol as zstring * WSAPROTOCOL_LEN+1
end type

type LPWSAPROTOCOL_INFOA as WSAPROTOCOL_INFOA ptr
type WSAPROTOCOL_INFO as WSAPROTOCOL_INFOA
type LPWSAPROTOCOL_INFO as LPWSAPROTOCOL_INFOA

#else ''UNICODE
type WSAPROTOCOL_INFOW
	dwServiceFlags1 as DWORD
	dwServiceFlags2 as DWORD
	dwServiceFlags3 as DWORD
	dwServiceFlags4 as DWORD
	dwProviderFlags as DWORD
	ProviderId as GUID
	dwCatalogEntryId as DWORD
	ProtocolChain as WSAPROTOCOLCHAIN
	iVersion as integer
	iAddressFamily as integer
	iMaxSockAddr as integer
	iMinSockAddr as integer
	iSocketType as integer
	iProtocol as integer
	iProtocolMaxOffset as integer
	iNetworkByteOrder as integer
	iSecurityScheme as integer
	dwMessageSize as DWORD
	dwProviderReserved as DWORD
	szProtocol as wstring * 255+1
end type

type LPWSAPROTOCOL_INFOW as WSAPROTOCOL_INFOW ptr
type WSAPROTOCOL_INFO as WSAPROTOCOL_INFOW
type LPWSAPROTOCOL_INFO as LPWSAPROTOCOL_INFOW
#endif

type LPCONDITIONPROC as function (byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS, byval as LPWSABUF, byval as LPWSABUF, byval as GROUP ptr, byval as DWORD) as integer
type LPWSAOVERLAPPED_COMPLETION_ROUTINE as sub (byval as DWORD, byval as DWORD, byval as LPWSAOVERLAPPED, byval as DWORD)

enum WSACOMPLETIONTYPE
	NSP_NOTIFY_IMMEDIATELY = 0
	NSP_NOTIFY_HWND
	NSP_NOTIFY_EVENT
	NSP_NOTIFY_PORT
	NSP_NOTIFY_APC
end enum

type PWSACOMPLETIONTYPE as WSACOMPLETIONTYPE
type LPWSACOMPLETIONTYPE as WSACOMPLETIONTYPE

type WSACOMPLETION_Parameters_Port
	lpOverlapped as LPWSAOVERLAPPED
	hPort as HANDLE
	Key as ULONG_PTR
end type

type WSACOMPLETION_Parameters_Apc
	lpOverlapped as LPWSAOVERLAPPED
	lpfnCompletionProc as LPWSAOVERLAPPED_COMPLETION_ROUTINE
end type

type WSACOMPLETION_Parameters_Event
	lpOverlapped as LPWSAOVERLAPPED
end type

type WSACOMPLETION_Parameters_WindowMessage
	hWnd as HWND
	uMsg as UINT
	context as WPARAM
end type

union WSACOMPLETION_Parameters
	WindowMessage as WSACOMPLETION_Parameters_WindowMessage
	Event as WSACOMPLETION_Parameters_Event
	Apc as WSACOMPLETION_Parameters_Apc
	Port as WSACOMPLETION_Parameters_Port
end union

type WSACOMPLETION
	Type as WSACOMPLETIONTYPE
	Parameters as WSACOMPLETION_Parameters
end type

type PWSACOMPLETION as WSACOMPLETION ptr
type LPWSACOMPLETION as WSACOMPLETION ptr

#define PFL_MULTIPLE_PROTO_ENTRIES &h00000001
#define PFL_RECOMMENDED_PROTO_ENTRY &h00000002
#define PFL_HIDDEN &h00000004
#define PFL_MATCHES_PROTOCOL_ZERO &h00000008
#define XP1_CONNECTIONLESS &h00000001
#define XP1_GUARANTEED_DELIVERY &h00000002
#define XP1_GUARANTEED_ORDER &h00000004
#define XP1_MESSAGE_ORIENTED &h00000008
#define XP1_PSEUDO_STREAM &h00000010
#define XP1_GRACEFUL_CLOSE &h00000020
#define XP1_EXPEDITED_DATA &h00000040
#define XP1_CONNECT_DATA &h00000080
#define XP1_DISCONNECT_DATA &h00000100
#define XP1_SUPPORT_BROADCAST &h00000200
#define XP1_SUPPORT_MULTIPOINT &h00000400
#define XP1_MULTIPOINT_CONTROL_PLANE &h00000800
#define XP1_MULTIPOINT_DATA_PLANE &h00001000
#define XP1_QOS_SUPPORTED &h00002000
#define XP1_INTERRUPT &h00004000
#define XP1_UNI_SEND &h00008000
#define XP1_UNI_RECV &h00010000
#define XP1_IFS_HANDLES &h00020000
#define XP1_PARTIAL_MESSAGE &h00040000
#define BIGENDIAN &h0000
#define LITTLEENDIAN &h0001
#define SECURITY_PROTOCOL_NONE &h0000
#define JL_SENDER_ONLY &h01
#define JL_RECEIVER_ONLY &h02
#define JL_BOTH &h04
#define WSA_FLAG_OVERLAPPED &h01
#define WSA_FLAG_MULTIPOINT_C_ROOT &h02
#define WSA_FLAG_MULTIPOINT_C_LEAF &h04
#define WSA_FLAG_MULTIPOINT_D_ROOT &h08
#define WSA_FLAG_MULTIPOINT_D_LEAF &h10
#define IOC_UNIX &h00000000
#define IOC_WS2 &h08000000
#define IOC_PROTOCOL &h10000000
#define IOC_VENDOR &h18000000
#define _WSAIO(x,y) (IOC_VOID or (x) or (y))
#define _WSAIOR(x,y) (IOC_OUT or (x) or (y))
#define _WSAIOW(x,y) (IOC_IN or (x) or (y))
#define _WSAIORW(x,y) (IOC_INOUT or (x) or (y))
#define SIO_ASSOCIATE_HANDLE (&h80000000 or (&h08000000) or (1))
#define SIO_ENABLE_CIRCULAR_QUEUEING (&h20000000 or (&h08000000) or (2))
#define SIO_FIND_ROUTE (&h40000000 or (&h08000000) or (3))
#define SIO_FLUSH (&h20000000 or (&h08000000) or (4))
#define SIO_GET_BROADCAST_ADDRESS (&h40000000 or (&h08000000) or (5))
#define SIO_GET_EXTENSION_FUNCTION_POINTER ((&h80000000 or &h40000000) or (&h08000000) or (6))
#define SIO_GET_QOS ((&h80000000 or &h40000000) or (&h08000000) or (7))
#define SIO_GET_GROUP_QOS ((&h80000000 or &h40000000) or (&h08000000) or (8))
#define SIO_MULTIPOINT_LOOPBACK (&h80000000 or (&h08000000) or (9))
#define SIO_MULTICAST_SCOPE (&h80000000 or (&h08000000) or (10))
#define SIO_SET_QOS (&h80000000 or (&h08000000) or (11))
#define SIO_SET_GROUP_QOS (&h80000000 or (&h08000000) or (12))
#define SIO_TRANSLATE_HANDLE ((&h80000000 or &h40000000) or (&h08000000) or (13))
#define SIO_ROUTING_INTERFACE_QUERY ((&h80000000 or &h40000000) or (&h08000000) or (20))
#define SIO_ROUTING_INTERFACE_CHANGE (&h80000000 or (&h08000000) or (21))
#define SIO_ADDRESS_LIST_QUERY (&h40000000 or (&h08000000) or (22))
#define SIO_ADDRESS_LIST_CHANGE (&h20000000 or (&h08000000) or (23))
#define SIO_QUERY_TARGET_PNP_HANDLE (&h40000000 or (&h08000000) or (24))
#define SIO_NSP_NOTIFY_CHANGE (&h80000000 or (&h08000000) or (25))
#define TH_NETDEV &h00000001
#define TH_TAPI &h00000002

declare function WSAAccept alias "WSAAccept" (byval as SOCKET, byval as sockaddr ptr, byval as LPINT, byval as LPCONDITIONPROC, byval as DWORD) as SOCKET
declare function WSACloseEvent alias "WSACloseEvent" (byval as HANDLE) as BOOL
declare function WSAConnect alias "WSAConnect" (byval as SOCKET, byval as sockaddr ptr, byval as integer, byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS) as integer
declare function WSACreateEvent alias "WSACreateEvent" () as HANDLE
declare function WSAEnumNetworkEvents alias "WSAEnumNetworkEvents" (byval as SOCKET, byval as HANDLE, byval as LPWSANETWORKEVENTS) as integer
declare function WSAEventSelect alias "WSAEventSelect" (byval as SOCKET, byval as HANDLE, byval as integer) as integer
declare function WSAGetOverlappedResult alias "WSAGetOverlappedResult" (byval as SOCKET, byval as LPWSAOVERLAPPED, byval as LPDWORD, byval as BOOL, byval as LPDWORD) as BOOL
declare function WSAGetQOSByName alias "WSAGetQOSByName" (byval as SOCKET, byval as LPWSABUF, byval as LPQOS) as BOOL
declare function WSAHtonl alias "WSAHtonl" (byval as SOCKET, byval as uinteger, byval as uinteger ptr) as integer
declare function WSAHtons alias "WSAHtons" (byval as SOCKET, byval as ushort, byval as ushort ptr) as integer
declare function WSAIoctl alias "WSAIoctl" (byval as SOCKET, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
declare function WSAJoinLeaf alias "WSAJoinLeaf" (byval as SOCKET, byval as sockaddr ptr, byval as integer, byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS, byval as DWORD) as SOCKET
declare function WSALookupServiceEnd alias "WSALookupServiceEnd" (byval as HANDLE) as INT_
declare function WSANSPIoctl alias "WSANSPIoctl" (byval as HANDLE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPWSACOMPLETION) as integer
declare function WSANtohl alias "WSANtohl" (byval as SOCKET, byval as uinteger, byval as uinteger ptr) as integer
declare function WSANtohs alias "WSANtohs" (byval as SOCKET, byval as ushort, byval as ushort ptr) as integer
declare function WSARecv alias "WSARecv" (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
declare function WSARecvDisconnect alias "WSARecvDisconnect" (byval as SOCKET, byval as LPWSABUF) as integer
declare function WSARecvFrom alias "WSARecvFrom" (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as sockaddr ptr, byval as LPINT, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
declare function WSARemoveServiceClass alias "WSARemoveServiceClass" (byval as LPGUID) as INT_
declare function WSAResetEvent alias "WSAResetEvent" (byval as HANDLE) as BOOL
declare function WSASend alias "WSASend" (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as DWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
declare function WSASendDisconnect alias "WSASendDisconnect" (byval as SOCKET, byval as LPWSABUF) as integer
declare function WSASendTo alias "WSASendTo" (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as DWORD, byval as sockaddr ptr, byval as integer, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
declare function WSASetEvent alias "WSASetEvent" (byval as HANDLE) as BOOL
declare function WSAWaitForMultipleEvents alias "WSAWaitForMultipleEvents" (byval as DWORD, byval as HANDLE ptr, byval as BOOL, byval as DWORD, byval as BOOL) as DWORD

#ifdef UNICODE
declare function WSAAddressToString alias "WSAAddressToStringW" (byval as LPSOCKADDR, byval as DWORD, byval as LPWSAPROTOCOL_INFOW, byval as LPWSTR, byval as LPDWORD) as INT_
declare function WSADuplicateSocket alias "WSADuplicateSocketW" (byval as SOCKET, byval as DWORD, byval as LPWSAPROTOCOL_INFOW) as integer
declare function WSAEnumNameSpaceProviders alias "WSAEnumNameSpaceProvidersW" (byval as LPDWORD, byval as LPWSANAMESPACE_INFOW) as INT_
declare function WSAEnumProtocols alias "WSAEnumProtocolsW" (byval as LPINT, byval as LPWSAPROTOCOL_INFOW, byval as LPDWORD) as integer
declare function WSAGetServiceClassInfo alias "WSAGetServiceClassInfoW" (byval as LPGUID, byval as LPGUID, byval as LPDWORD, byval as LPWSASERVICECLASSINFOW) as INT_
declare function WSAGetServiceClassNameByClassId alias "WSAGetServiceClassNameByClassIdW" (byval as LPGUID, byval as LPWSTR, byval as LPDWORD) as INT_
declare function WSAInstallServiceClass alias "WSAInstallServiceClassW" (byval as LPWSASERVICECLASSINFOW) as INT_
declare function WSALookupServiceBegin alias "WSALookupServiceBeginW" (byval lpqsRestrictions as LPWSAQUERYSETW, byval as DWORD, byval as LPHANDLE) as INT_
declare function WSALookupServiceNext alias "WSALookupServiceNextW" (byval as HANDLE, byval as DWORD, byval as LPDWORD, byval as LPWSAQUERYSETW) as INT_
declare function WSASetService alias "WSASetServiceW" (byval as LPWSAQUERYSETW, byval as WSAESETSERVICEOP, byval as DWORD) as INT_
declare function WSASocket alias "WSASocketW" (byval as integer, byval as integer, byval as integer, byval as LPWSAPROTOCOL_INFOW, byval as GROUP, byval as DWORD) as SOCKET
declare function WSAStringToAddress alias "WSAStringToAddressW" (byval as LPWSTR, byval as INT_, byval as LPWSAPROTOCOL_INFOW, byval as LPSOCKADDR, byval as LPINT) as INT_

type LPFN_WSAADDRESSTOSTRING as function (byval as LPSOCKADDR, byval as DWORD, byval as LPWSAPROTOCOL_INFOW, byval as LPWSTR, byval as LPDWORD) as INT_
type LPFN_WSADUPLICATESOCKET as function (byval as SOCKET, byval as DWORD, byval as LPWSAPROTOCOL_INFOW) as integer
type LPFN_WSAENUMNAMESPACEPROVIDERS as function (byval as LPDWORD, byval as LPWSANAMESPACE_INFOW) as INT_
type LPFN_WSAENUMPROTOCOLS as function (byval as LPINT, byval as LPWSAPROTOCOL_INFOW, byval as LPDWORD) as integer
type LPFN_WSAGETSERVICECLASSINFO as function (byval as LPGUID, byval as LPGUID, byval as LPDWORD, byval as LPWSASERVICECLASSINFOW) as INT_
type LPFN_WSAGETSERVICECLASSNAMEBYCLASSID as function (byval as LPGUID, byval as LPWSTR, byval as LPDWORD) as INT_
type LPFN_WSAINSTALLSERVICECLASS as function (byval as LPWSASERVICECLASSINFOW) as INT_
type LPFN_WSALOOKUPSERVICEBEGIN as function (byval as LPWSAQUERYSETW, byval as DWORD, byval as LPHANDLE) as INT_
type LPFN_WSALOOKUPSERVICENEXT as function (byval as HANDLE, byval as DWORD, byval as LPDWORD, byval as LPWSAQUERYSETW) as INT_
type LPFN_WSASETSERVICE as function (byval as LPWSAQUERYSETW, byval as WSAESETSERVICEOP, byval as DWORD) as INT_
type LPFN_WSASOCKET as function (byval as integer, byval as integer, byval as integer, byval as LPWSAPROTOCOL_INFOW, byval as GROUP, byval as DWORD) as SOCKET
type LPFN_WSASTRINGTOADDRESS as function (byval as LPWSTR, byval as INT_, byval as LPWSAPROTOCOL_INFOW, byval as LPSOCKADDR, byval as LPINT) as INT_

#else ''UNICODE
declare function WSAAddressToString alias "WSAAddressToStringA" (byval as LPSOCKADDR, byval as DWORD, byval as LPWSAPROTOCOL_INFOA, byval as LPSTR, byval as LPDWORD) as INT_
declare function WSADuplicateSocket alias "WSADuplicateSocketA" (byval as SOCKET, byval as DWORD, byval as LPWSAPROTOCOL_INFOA) as integer
declare function WSAEnumNameSpaceProviders alias "WSAEnumNameSpaceProvidersA" (byval as LPDWORD, byval as LPWSANAMESPACE_INFOA) as INT_
declare function WSAEnumProtocols alias "WSAEnumProtocolsA" (byval as LPINT, byval as LPWSAPROTOCOL_INFOA, byval as LPDWORD) as integer
declare function WSAGetServiceClassInfo alias "WSAGetServiceClassInfoA" (byval as LPGUID, byval as LPGUID, byval as LPDWORD, byval as LPWSASERVICECLASSINFOA) as INT_
declare function WSAGetServiceClassNameByClassId alias "WSAGetServiceClassNameByClassIdA" (byval as LPGUID, byval as LPSTR, byval as LPDWORD) as INT_
declare function WSAInstallServiceClass alias "WSAInstallServiceClassA" (byval as LPWSASERVICECLASSINFOA) as INT_
declare function WSALookupServiceBegin alias "WSALookupServiceBeginA" (byval as LPWSAQUERYSETA, byval as DWORD, byval as LPHANDLE) as INT_
declare function WSALookupServiceNext alias "WSALookupServiceNextA" (byval as HANDLE, byval as DWORD, byval as LPDWORD, byval as LPWSAQUERYSETA) as INT_
declare function WSASetService alias "WSASetServiceA" (byval as LPWSAQUERYSETA, byval as WSAESETSERVICEOP, byval as DWORD) as INT_
declare function WSASocket alias "WSASocketA" (byval as integer, byval as integer, byval as integer, byval as LPWSAPROTOCOL_INFOA, byval as GROUP, byval as DWORD) as SOCKET
declare function WSAStringToAddress alias "WSAStringToAddressA" (byval as LPSTR, byval as INT_, byval as LPWSAPROTOCOL_INFOA, byval as LPSOCKADDR, byval as LPINT) as INT_

type LPFN_WSAADDRESSTOSTRING as function (byval as LPSOCKADDR, byval as DWORD, byval as LPWSAPROTOCOL_INFOA, byval as LPSTR, byval as LPDWORD) as INT_
type LPFN_WSADUPLICATESOCKET as function (byval as SOCKET, byval as DWORD, byval as LPWSAPROTOCOL_INFOA) as integer
type LPFN_WSAENUMNAMESPACEPROVIDERS as function (byval as LPDWORD, byval as LPWSANAMESPACE_INFOA) as INT_
type LPFN_WSAENUMPROTOCOLS as function (byval as LPINT, byval as LPWSAPROTOCOL_INFOA, byval as LPDWORD) as integer
type LPFN_WSAGETSERVICECLASSINFO as function (byval as LPGUID, byval as LPGUID, byval as LPDWORD, byval as LPWSASERVICECLASSINFOA) as INT_
type LPFN_WSAGETSERVICECLASSNAMEBYCLASSID as function (byval as LPGUID, byval as LPSTR, byval as LPDWORD) as INT_
type LPFN_WSAINSTALLSERVICECLASS as function (byval as LPWSASERVICECLASSINFOA) as INT_
type LPFN_WSALOOKUPSERVICEBEGIN as function (byval as LPWSAQUERYSETA, byval as DWORD, byval as LPHANDLE) as INT_
type LPFN_WSALOOKUPSERVICENEXT as function (byval as HANDLE, byval as DWORD, byval as LPDWORD, byval as LPWSAQUERYSETA) as INT_
type LPFN_WSASETSERVICE as function (byval as LPWSAQUERYSETA, byval as WSAESETSERVICEOP, byval as DWORD) as INT_
type LPFN_WSASOCKET as function (byval as integer, byval as integer, byval as integer, byval as LPWSAPROTOCOL_INFOA, byval as GROUP, byval as DWORD) as SOCKET
type LPFN_WSASTRINGTOADDRESS as function (byval as LPSTR, byval as INT_, byval as LPWSAPROTOCOL_INFOA, byval as LPSOCKADDR, byval as LPINT) as INT_
#endif ''UNICODE

type LPFN_WSAACCEPT as function (byval as SOCKET, byval as sockaddr ptr, byval as LPINT, byval as LPCONDITIONPROC, byval as DWORD) as SOCKET
type LPFN_WSACLOSEEVENT as function (byval as HANDLE) as BOOL
type LPFN_WSACONNECT as function (byval as SOCKET, byval as sockaddr ptr, byval as integer, byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS) as integer
type LPFN_WSACREATEEVENT as function () as HANDLE
type LPFN_WSAENUMNETWORKEVENTS as function (byval as SOCKET, byval as HANDLE, byval as LPWSANETWORKEVENTS) as integer
type LPFN_WSAEVENTSELECT as function (byval as SOCKET, byval as HANDLE, byval as integer) as integer
type LPFN_WSAGETOVERLAPPEDRESULT as function (byval as SOCKET, byval as LPWSAOVERLAPPED, byval as LPDWORD, byval as BOOL, byval as LPDWORD) as BOOL
type LPFN_WSAGETQOSBYNAME as function (byval as SOCKET, byval as LPWSABUF, byval as LPQOS) as BOOL
type LPFN_WSAHTONL as function (byval as SOCKET, byval as uinteger, byval as uinteger ptr) as integer
type LPFN_WSAHTONS as function (byval as SOCKET, byval as ushort, byval as ushort ptr) as integer
type LPFN_WSAIOCTL as function (byval as SOCKET, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
type LPFN_WSAJOINLEAF as function (byval as SOCKET, byval as sockaddr ptr, byval as integer, byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS, byval as DWORD) as SOCKET
type LPFN_WSALOOKUPSERVICEEND as function (byval as HANDLE) as INT_
type LPFN_WSANSPIoctl as function (byval as HANDLE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPWSACOMPLETION) as integer
type LPFN_WSANTOHL as function (byval as SOCKET, byval as uinteger, byval as uinteger ptr) as integer
type LPFN_WSANTOHS as function (byval as SOCKET, byval as ushort, byval as ushort ptr) as integer
type LPFN_WSARECV as function (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
type LPFN_WSARECVDISCONNECT as function (byval as SOCKET, byval as LPWSABUF) as integer
type LPFN_WSARECVFROM as function (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as sockaddr ptr, byval as LPINT, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
type LPFN_WSAREMOVESERVICECLASS as function (byval as LPGUID) as INT_
type LPFN_WSARESETEVENT as function (byval as HANDLE) as BOOL
type LPFN_WSASEND as function (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as DWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
type LPFN_WSASENDDISCONNECT as function (byval as SOCKET, byval as LPWSABUF) as integer
type LPFN_WSASENDTO as function (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as DWORD, byval as sockaddr ptr, byval as integer, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer
type LPFN_WSASETEVENT as function (byval as HANDLE) as BOOL
type LPFN_WSAWAITFORMULTIPLEEVENTS as function (byval as DWORD, byval as HANDLE ptr, byval as BOOL, byval as DWORD, byval as BOOL) as DWORD

#endif
