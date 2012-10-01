''
''
'' ws2tcpip -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ws2tcpip_bi__
#define __win_ws2tcpip_bi__

#if defined(__win_winsock_bi__) and not defined(__win_winsock2_bi__)
#error "ws2tcpip.bi is not compatable with winsock.bi. Include winsock2.bi instead."
#endif

#include once "win/winsock2.bi"

#define IP_OPTIONS 1
#define IP_HDRINCL 2
#define IP_TOS 3
#define IP_TTL 4
#define IP_MULTICAST_IF 9
#define IP_MULTICAST_TTL 10
#define IP_MULTICAST_LOOP 11
#define IP_ADD_MEMBERSHIP 12
#define IP_DROP_MEMBERSHIP 13
#define IP_DONTFRAGMENT 14
#define IP_ADD_SOURCE_MEMBERSHIP 15
#define IP_DROP_SOURCE_MEMBERSHIP 16
#define IP_BLOCK_SOURCE 17
#define IP_UNBLOCK_SOURCE 18
#define IP_PKTINFO 19
#define IPV6_UNICAST_HOPS 4
#define IPV6_MULTICAST_IF 9
#define IPV6_MULTICAST_HOPS 10
#define IPV6_MULTICAST_LOOP 11
#define IPV6_ADD_MEMBERSHIP 12
#define IPV6_DROP_MEMBERSHIP 13
#define IPV6_JOIN_GROUP 12
#define IPV6_LEAVE_GROUP 13
#define IPV6_PKTINFO 19
#define IP_DEFAULT_MULTICAST_TTL 1
#define IP_DEFAULT_MULTICAST_LOOP 1
#define IP_MAX_MEMBERSHIPS 20
#define TCP_EXPEDITED_1122 2
#define UDP_NOCHECKSUM 1
#define IFF_UP 1
#define IFF_BROADCAST 2
#define IFF_LOOPBACK 4
#define IFF_POINTTOPOINT 8
#define IFF_MULTICAST 16
#define INET_ADDRSTRLEN 16
#define INET6_ADDRSTRLEN 46
#define NI_MAXHOST 1025
#define NI_MAXSERV 32
#define NI_NOFQDN &h01
#define NI_NUMERICHOST &h02
#define NI_NAMEREQD &h04
#define NI_NUMERICSERV &h08
#define NI_DGRAM &h10
#define AI_PASSIVE 1
#define AI_CANONNAME 2
#define AI_NUMERICHOST 4
#define EAI_AGAIN	WSATRY_AGAIN
#define EAI_BADFLAGS	WSAEINVAL
#define EAI_FAIL	WSANO_RECOVERY
#define EAI_FAMILY	WSAEAFNOSUPPORT
#define EAI_MEMORY	WSA_NOT_ENOUGH_MEMORY
#define EAI_NODATA	WSANO_DATA
#define EAI_NONAME	WSAHOST_NOT_FOUND
#define EAI_SERVICE	WSATYPE_NOT_FOUND
#define EAI_SOCKTYPE	WSAESOCKTNOSUPPORT

type ip_mreq
	imr_multiaddr as in_addr
	imr_interface as in_addr
end type

type ip_mreq_source
	imr_multiaddr as in_addr
	imr_sourceaddr as in_addr
	imr_interface as in_addr
end type

type ip_msfilter
	imsf_multiaddr as in_addr
	imsf_interface as in_addr
	imsf_fmode as u_long
	imsf_numsrc as u_long
	imsf_slist(0 to 1-1) as in_addr
end type

#define IP_MSFILTER_SIZE(numsrc) (sizeof(ip_msfilter) - sizeof(in_addr) + (numsrc) * sizeof(in_addr))

type in_pktinfo
	ipi_addr as IN_ADDR
	ipi_ifindex as UINT
end type

union in6_addr__NESTED___S6_un
	_S6_u8(0 to 16-1) as u_char
	_S6_u16(0 to 8-1) as u_short
	_S6_u32(0 to 4-1) as u_long
end union

type in6_addr
	_S6_un as in6_addr__NESTED___S6_un
end type

#define s6_addr		_S6_un._S6_u8
#define s6_addr16	_S6_un._S6_u16
#define s6_addr32	_S6_un._S6_u16
#define in_addr6	in6_addr
#define _s6_bytes	_S6_un._S6_u8
#define _s6_words	_S6_un._S6_u16

type PIN6_ADDR as in6_addr ptr
type LPIN6_ADDR as in6_addr ptr

type sockaddr_in6
	sin6_family as short
	sin6_port as u_short
	sin6_flowinfo as u_long
	sin6_addr as in6_addr
	sin6_scope_id as u_long
end type

type PSOCKADDR_IN6 as sockaddr_in6 ptr
type LPSOCKADDR_IN6 as sockaddr_in6 ptr
extern in6addr_any alias "in6addr_any" as in6_addr
extern in6addr_loopback alias "in6addr_loopback" as in6_addr

#define IN6ADDR_ANY_INIT        ( 0 )
#define IN6ADDR_LOOPBACK_INIT   ( 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 )
#define IN6_ARE_ADDR_EQUAL(a, b) (memcmp(cast(any ptr, a), cast(any ptr, b), sizeof(in6_addr)) = 0)

type socklen_t as integer

type ipv6_mreq
	ipv6mr_multiaddr as in6_addr
	ipv6mr_interface as uinteger
end type

type IPV6_MREG as ipv6_mreq

type in6_pktinfo
	ipi6_addr as IN6_ADDR
	ipi6_ifindex as UINT
end type


type addrinfo
	ai_flags as integer
	ai_family as integer
	ai_socktype as integer
	ai_protocol as integer
	ai_addrlen as size_t
	ai_canonname_ as zstring ptr
	ai_addr as sockaddr ptr
	ai_next as addrinfo ptr
end type

declare sub freeaddrinfo alias "freeaddrinfo" (byval as addrinfo ptr)
declare function getaddrinfo alias "getaddrinfo" (byval as zstring ptr, byval as zstring ptr, byval as addrinfo ptr, byval as addrinfo ptr ptr) as integer
declare function getnameinfo alias "getnameinfo" (byval as sockaddr ptr, byval as socklen_t, byval as zstring ptr, byval as socklen_t, byval as zstring ptr, byval as socklen_t, byval as integer) as integer

#ifdef UNICODE
private function gai_strerror (byval ecode as integer) as wstring ptr
	static message as wstring * (1024 + 1)
	dim dwFlags as DWORD = FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_IGNORE_INSERTS or FORMAT_MESSAGE_MAX_WIDTH_MASK
	dim dwLanguageId as DWORD = MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT)
	FormatMessage(dwFlags, NULL, ecode, dwLanguageId, @message, 1024, NULL)
	return @message
end function
#else
private function gai_strerror (byval ecode as integer) as zstring ptr
	static message as zstring * (1024 + 1)
	dim dwFlags as DWORD = FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_IGNORE_INSERTS or FORMAT_MESSAGE_MAX_WIDTH_MASK
	dim dwLanguageId as DWORD = MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT)
	FormatMessage(dwFlags, NULL, ecode, dwLanguageId, @message, 1024, NULL)
	return @message
end function
#endif

type sockaddr_in6_old
	sin6_family as short
	sin6_port as u_short
	sin6_flowinfo as u_long
	sin6_addr as in6_addr
end type

union sockaddr_gen
	Address as sockaddr
	AddressIn as sockaddr_in
	AddressIn6 as sockaddr_in6_old
end union

type _INTERFACE_INFO
	iiFlags as u_long
	iiAddress as sockaddr_gen
	iiBroadcastAddress as sockaddr_gen
	iiNetmask as sockaddr_gen
end type

type INTERFACE_INFO as _INTERFACE_INFO
type LPINTERFACE_INFO as _INTERFACE_INFO ptr

#endif
