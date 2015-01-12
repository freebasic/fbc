#pragma once

#include once "_mingw_unicode.bi"
#include once "winsock2.bi"
#include once "inaddr.bi"
#include once "winapifamily.bi"
#include once "ws2ipdef.bi"
#include once "mstcpip.bi"

'' The following symbols have been renamed:
''     typedef ADDRINFO => ADDRINFO_
''     #define GetAddrInfo => GetAddrInfo_
''     #define FreeAddrInfo => FreeAddrInfo_
''     #define GetNameInfo => GetNameInfo_
''     #if _WIN32_WINNT = &h0602
''         typedef addrinfoexA => addrinfoexA_
''         inside struct addrinfoExA:
''             field ai_canonname => ai_canonname_
''         typedef addrinfoexW => addrinfoexW_
''         inside struct addrinfoExW:
''             field ai_canonname => ai_canonname_
''     #endif

extern "C"

#if _WIN32_WINNT = &h0602
	type addrinfoexA_ as addrinfoexA__
	type addrinfoexW_ as addrinfoexW__
#endif

#define _WS2TCPIP_H_
#define _MINGW_IP_MREQ1_H

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
	imsf_slist(0 to 0) as in_addr
end type

#define IP_MSFILTER_SIZE(numsrc) ((sizeof(ip_msfilter) - sizeof(in_addr)) + ((numsrc) * sizeof(in_addr)))
#define SIO_GET_INTERFACE_LIST _IOR(asc("t"), 127, u_long)
#define SIO_GET_INTERFACE_LIST_EX _IOR(asc("t"), 126, u_long)
#define SIO_SET_MULTICAST_FILTER _IOW(asc("t"), 125, u_long)
#define SIO_GET_MULTICAST_FILTER _IOW(asc("t"), 124 or IOC_IN, u_long)
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
#define IP_RECEIVE_BROADCAST 22
#define PROTECTION_LEVEL_UNRESTRICTED 10
#define PROTECTION_LEVEL_DEFAULT 20
#define PROTECTION_LEVEL_RESTRICTED 30
#define UDP_NOCHECKSUM 1
#define UDP_CHECKSUM_COVERAGE 20
#define TCP_EXPEDITED_1122 &h0002
#define SS_PORT(ssp) cptr(sockaddr_in ptr, (ssp))->sin_port
#define IN6ADDR_ANY_INIT (0)
#define IN6ADDR_LOOPBACK_INIT (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)

extern in6addr_any as const in6_addr
extern in6addr_loopback as const in6_addr

#define WS2TCPIP_INLINE __CRT_INLINE

private function IN6_ADDR_EQUAL(byval a as const in6_addr ptr, byval b as const in6_addr ptr) as long
	return -(memcmp(cptr(any ptr, a), cptr(any ptr, b), sizeof(in6_addr)) = 0)
end function

private function IN6_IS_ADDR_UNSPECIFIED(byval a as const in6_addr ptr) as long
	return -((((((((a->u.Word(0) = 0) andalso (a->u.Word(1) = 0)) andalso (a->u.Word(2) = 0)) andalso (a->u.Word(3) = 0)) andalso (a->u.Word(4) = 0)) andalso (a->u.Word(5) = 0)) andalso (a->u.Word(6) = 0)) andalso (a->u.Word(7) = 0))
end function

private function IN6_IS_ADDR_LOOPBACK(byval a as const in6_addr ptr) as long
	return -((((((((a->u.Word(0) = 0) andalso (a->u.Word(1) = 0)) andalso (a->u.Word(2) = 0)) andalso (a->u.Word(3) = 0)) andalso (a->u.Word(4) = 0)) andalso (a->u.Word(5) = 0)) andalso (a->u.Word(6) = 0)) andalso (a->u.Word(7) = &h0100))
end function

private function IN6_IS_ADDR_MULTICAST(byval a as const in6_addr ptr) as long
	return -(a->u.Byte(0) = &hff)
end function

private function IN6_IS_ADDR_LINKLOCAL(byval a as const in6_addr ptr) as long
	return -((a->u.Byte(0) = &hfe) andalso ((a->u.Byte(1) and &hc0) = &h80))
end function

private function IN6_IS_ADDR_SITELOCAL(byval a as const in6_addr ptr) as long
	return -((a->u.Byte(0) = &hfe) andalso ((a->u.Byte(1) and &hc0) = &hc0))
end function

private function IN6_IS_ADDR_V4MAPPED(byval a as const in6_addr ptr) as long
	return -((((((a->u.Word(0) = 0) andalso (a->u.Word(1) = 0)) andalso (a->u.Word(2) = 0)) andalso (a->u.Word(3) = 0)) andalso (a->u.Word(4) = 0)) andalso (a->u.Word(5) = &hffff))
end function

private function IN6_IS_ADDR_V4COMPAT(byval a as const in6_addr ptr) as long
	return -(((((((a->u.Word(0) = 0) andalso (a->u.Word(1) = 0)) andalso (a->u.Word(2) = 0)) andalso (a->u.Word(3) = 0)) andalso (a->u.Word(4) = 0)) andalso (a->u.Word(5) = 0)) andalso ((((a->u.Word(6) = 0) andalso (a->u.Byte(14) = 0)) andalso ((a->u.Byte(15) = 0) orelse (a->u.Byte(15) = 1))) = 0))
end function

private function IN6_IS_ADDR_MC_NODELOCAL(byval a as const in6_addr ptr) as long
	return -(IN6_IS_ADDR_MULTICAST(a) andalso ((a->u.Byte(1) and &hf) = 1))
end function

private function IN6_IS_ADDR_MC_LINKLOCAL(byval a as const in6_addr ptr) as long
	return -(IN6_IS_ADDR_MULTICAST(a) andalso ((a->u.Byte(1) and &hf) = 2))
end function

private function IN6_IS_ADDR_MC_SITELOCAL(byval a as const in6_addr ptr) as long
	return -(IN6_IS_ADDR_MULTICAST(a) andalso ((a->u.Byte(1) and &hf) = 5))
end function

private function IN6_IS_ADDR_MC_ORGLOCAL(byval a as const in6_addr ptr) as long
	return -(IN6_IS_ADDR_MULTICAST(a) andalso ((a->u.Byte(1) and &hf) = 8))
end function

private function IN6_IS_ADDR_MC_GLOBAL(byval a as const in6_addr ptr) as long
	return -(IN6_IS_ADDR_MULTICAST(a) andalso ((a->u.Byte(1) and &hf) = &he))
end function

private function IN6ADDR_ISANY(byval a as const sockaddr_in6 ptr) as long
	return -((a->sin6_family = 23) andalso IN6_IS_ADDR_UNSPECIFIED(@a->sin6_addr))
end function

private function IN6ADDR_ISLOOPBACK(byval a as const sockaddr_in6 ptr) as long
	return -((a->sin6_family = 23) andalso IN6_IS_ADDR_LOOPBACK(@a->sin6_addr))
end function

private sub IN6_SET_ADDR_UNSPECIFIED(byval a as in6_addr ptr)
	memset(@a->u.Byte(0), 0, sizeof(in6_addr))
end sub

private sub IN6_SET_ADDR_LOOPBACK(byval a as in6_addr ptr)
	memset(@a->u.Byte(0), 0, sizeof(in6_addr))
	a->u.Byte(15) = 1
end sub

private sub IN6ADDR_SETANY(byval a as sockaddr_in6 ptr)
	a->sin6_family = 23
	a->sin6_port = 0
	a->sin6_flowinfo = 0
	IN6_SET_ADDR_UNSPECIFIED(@a->sin6_addr)
	a->sin6_scope_id = 0
end sub

private sub IN6ADDR_SETLOOPBACK(byval a as sockaddr_in6 ptr)
	a->sin6_family = 23
	a->sin6_port = 0
	a->sin6_flowinfo = 0
	IN6_SET_ADDR_LOOPBACK(@a->sin6_addr)
	a->sin6_scope_id = 0
end sub

type _INTERFACE_INFO_EX
	iiFlags as u_long
	iiAddress as SOCKET_ADDRESS
	iiBroadcastAddress as SOCKET_ADDRESS
	iiNetmask as SOCKET_ADDRESS
end type

type INTERFACE_INFO_EX as _INTERFACE_INFO_EX
type LPINTERFACE_INFO_EX as _INTERFACE_INFO_EX ptr

#define IFF_UP &h00000001
#define IFF_BROADCAST &h00000002
#define IFF_LOOPBACK &h00000004
#define IFF_POINTTOPOINT &h00000008
#define IFF_MULTICAST &h00000010

type in_pktinfo
	ipi_addr as in_addr
	ipi_ifindex as UINT
end type

type in6_pktinfo
	ipi6_addr as in6_addr
	ipi6_ifindex as UINT
end type

#define EAI_AGAIN WSATRY_AGAIN
#define EAI_BADFLAGS WSAEINVAL
#define EAI_FAIL WSANO_RECOVERY
#define EAI_FAMILY WSAEAFNOSUPPORT
#define EAI_MEMORY WSA_NOT_ENOUGH_MEMORY
#define EAI_NONAME WSAHOST_NOT_FOUND
#define EAI_SERVICE WSATYPE_NOT_FOUND
#define EAI_SOCKTYPE WSAESOCKTNOSUPPORT
#define EAI_NODATA 11004

type addrinfo
	ai_flags as long
	ai_family as long
	ai_socktype as long
	ai_protocol as long
	ai_addrlen as uinteger
	ai_canonname as zstring ptr
	ai_addr as sockaddr ptr
	ai_next as addrinfo ptr
end type

type ADDRINFOA as addrinfo
type PADDRINFOA as addrinfo ptr

type addrinfoW
	ai_flags as long
	ai_family as long
	ai_socktype as long
	ai_protocol as long
	ai_addrlen as uinteger
	ai_canonname as PWSTR
	ai_addr as sockaddr ptr
	ai_next as addrinfoW ptr
end type

type PADDRINFOW as addrinfoW ptr

#ifdef UNICODE
	type ADDRINFOT as addrinfoW
	type PADDRINFOT as addrinfoW ptr
#else
	type ADDRINFOT as ADDRINFOA
	type PADDRINFOT as ADDRINFOA ptr
#endif

type ADDRINFO_ as ADDRINFOA
type LPADDRINFO as ADDRINFOA ptr

#define AI_PASSIVE &h1
#define AI_CANONNAME &h2
#define AI_NUMERICHOST &h4

#if _WIN32_WINNT = &h0602
	#define AI_ADDRCONFIG &h0400
	#define AI_NON_AUTHORITATIVE &h04000
	#define AI_SECURE &h08000
	#define AI_RETURN_PREFERRED_NAMES &h010000
#endif

#ifdef UNICODE
	#define GetAddrInfo_ GetAddrInfoW
#else
	#define GetAddrInfo_ GetAddrInfoA
#endif

#ifdef __FB_64BIT__
	declare function getaddrinfo(byval nodename as const zstring ptr, byval servname as const zstring ptr, byval hints as const addrinfo ptr, byval res as addrinfo ptr ptr) as long
	declare function GetAddrInfoW(byval pNodeName as PCWSTR, byval pServiceName as PCWSTR, byval pHints as const addrinfoW ptr, byval ppResult as PADDRINFOW ptr) as long
#else
	declare function getaddrinfo stdcall(byval nodename as const zstring ptr, byval servname as const zstring ptr, byval hints as const addrinfo ptr, byval res as addrinfo ptr ptr) as long
	declare function GetAddrInfoW stdcall(byval pNodeName as PCWSTR, byval pServiceName as PCWSTR, byval pHints as const addrinfoW ptr, byval ppResult as PADDRINFOW ptr) as long
#endif

#define GetAddrInfoA getaddrinfo

#ifdef UNICODE
	#define FreeAddrInfo_ FreeAddrInfoW
#else
	#define FreeAddrInfo_ FreeAddrInfoA
#endif

#ifdef __FB_64BIT__
	declare sub freeaddrinfo(byval pAddrInfo as LPADDRINFO)
	declare sub FreeAddrInfoW(byval pAddrInfo as PADDRINFOW)
#else
	declare sub freeaddrinfo stdcall(byval pAddrInfo as LPADDRINFO)
	declare sub FreeAddrInfoW stdcall(byval pAddrInfo as PADDRINFOW)
#endif

#define FreeAddrInfoA freeaddrinfo

type socklen_t as long

#ifdef UNICODE
	#define GetNameInfo_ GetNameInfoW
#else
	#define GetNameInfo_ GetNameInfoA
#endif

#ifdef __FB_64BIT__
	declare function getnameinfo(byval sa as const sockaddr ptr, byval salen as socklen_t, byval host as zstring ptr, byval hostlen as DWORD, byval serv as zstring ptr, byval servlen as DWORD, byval flags as long) as long
	declare function GetNameInfoW(byval pSockaddr as const sockaddr ptr, byval SockaddrLength as socklen_t, byval pNodeBuffer as PWCHAR, byval NodeBufferSize as DWORD, byval pServiceBuffer as PWCHAR, byval ServiceBufferSize as DWORD, byval Flags as INT_) as INT_
#else
	declare function getnameinfo stdcall(byval sa as const sockaddr ptr, byval salen as socklen_t, byval host as zstring ptr, byval hostlen as DWORD, byval serv as zstring ptr, byval servlen as DWORD, byval flags as long) as long
	declare function GetNameInfoW stdcall(byval pSockaddr as const sockaddr ptr, byval SockaddrLength as socklen_t, byval pNodeBuffer as PWCHAR, byval NodeBufferSize as DWORD, byval pServiceBuffer as PWCHAR, byval ServiceBufferSize as DWORD, byval Flags as INT_) as INT_
#endif

#define GetNameInfoA getnameinfo

#ifdef UNICODE
	#define gai_strerror gai_strerrorW
#else
	#define gai_strerror gai_strerrorA
#endif

#define GAI_STRERROR_BUFFER_SIZE 1024

declare function gai_strerrorA(byval as long) as zstring ptr
declare function gai_strerrorW(byval as long) as wstring ptr

#define NI_MAXHOST 1025
#define NI_MAXSERV 32
#define INET_ADDRSTRLEN 22
#define INET6_ADDRSTRLEN 65
#define NI_NOFQDN &h01
#define NI_NUMERICHOST &h02
#define NI_NAMEREQD &h04
#define NI_NUMERICSERV &h08
#define NI_DGRAM &h10

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define addrinfoEx addrinfoExW
	#define PADDRINFOEX PADDRINFOEXW
	#define GetAddrInfoEx GetAddrInfoExW
	#define SetAddrInfoEx SetAddrInfoExW
	#define FreeAddrInfoEx FreeAddrInfoExW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define addrinfoEx addrinfoExA
	#define PADDRINFOEX PADDRINFOEXA
	#define GetAddrInfoEx GetAddrInfoExA
	#define SetAddrInfoEx SetAddrInfoExA
	#define FreeAddrInfoEx FreeAddrInfoExA
#endif

#if _WIN32_WINNT = &h0602
	type addrinfoExA
		ai_flags as long
		ai_family as long
		ai_socktype as long
		ai_protocol as long
		ai_addrlen as uinteger
		ai_canonname_ as LPCSTR
		ai_addr as sockaddr ptr
		ai_blob as any ptr
		ai_bloblen as uinteger
		ai_provider as LPGUID
		ai_next as addrinfoexA_ ptr
	end type

	type PADDRINFOEXA as addrinfoExA ptr

	type addrinfoExW
		ai_flags as long
		ai_family as long
		ai_socktype as long
		ai_protocol as long
		ai_addrlen as uinteger
		ai_canonname_ as LPCWSTR
		ai_addr as sockaddr ptr
		ai_blob as any ptr
		ai_bloblen as uinteger
		ai_provider as LPGUID
		ai_next as addrinfoexW_ ptr
	end type

	type PADDRINFOEXW as addrinfoExW ptr
	type LPLOOKUPSERVICE_COMPLETION_ROUTINE as PVOID
#endif

#if defined(__FB_64BIT__) and (_WIN32_WINNT = &h0602)
	declare function GetAddrInfoExA(byval pName as PCSTR, byval pServiceName as PCSTR, byval dwNameSpace as DWORD, byval lpNspId as LPGUID, byval pHints as const addrinfoExA ptr, byval ppResult as PADDRINFOEXA ptr, byval timeout as PTIMEVAL, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPLOOKUPSERVICE_COMPLETION_ROUTINE, byval lpNameHandle as LPHANDLE) as long
	declare function GetAddrInfoExW(byval pName as PCWSTR, byval pServiceName as PCWSTR, byval dwNameSpace as DWORD, byval lpNspId as LPGUID, byval pHints as const addrinfoExW ptr, byval ppResult as PADDRINFOEXW ptr, byval timeout as PTIMEVAL, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPLOOKUPSERVICE_COMPLETION_ROUTINE, byval lpNameHandle as LPHANDLE) as long
	declare function SetAddrInfoExA(byval pName as PCSTR, byval pServiceName as PCSTR, byval pAddresses as SOCKET_ADDRESS ptr, byval dwAddressCount as DWORD, byval lpBlob as LPBLOB, byval dwFlags as DWORD, byval dwNameSpace as DWORD, byval lpNspId as LPGUID, byval timeout as PTIMEVAL, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPLOOKUPSERVICE_COMPLETION_ROUTINE, byval lpNameHandle as LPHANDLE) as long
	declare function SetAddrInfoExW(byval pName as PCWSTR, byval pServiceName as PCWSTR, byval pAddresses as SOCKET_ADDRESS ptr, byval dwAddressCount as DWORD, byval lpBlob as LPBLOB, byval dwFlags as DWORD, byval dwNameSpace as DWORD, byval lpNspId as LPGUID, byval timeout as PTIMEVAL, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPLOOKUPSERVICE_COMPLETION_ROUTINE, byval lpNameHandle as LPHANDLE) as long
	declare sub FreeAddrInfoExA(byval pAddrInfo as PADDRINFOEXA)
	declare sub FreeAddrInfoExW(byval pAddrInfo as PADDRINFOEXW)
	declare function WSAImpersonateSocketPeer(byval Socket as SOCKET, byval PeerAddress as const sockaddr ptr, byval peerAddressLen as ULONG) as long
	declare function WSAQuerySocketSecurity(byval Socket as SOCKET, byval SecurityQueryTemplate as const SOCKET_SECURITY_QUERY_TEMPLATE ptr, byval SecurityQueryTemplateLen as ULONG, byval SecurityQueryInfo as SOCKET_SECURITY_QUERY_INFO ptr, byval SecurityQueryInfoLen as ULONG ptr, byval Overlapped as LPWSAOVERLAPPED, byval CompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as long
	declare function WSARevertImpersonation() as long
	declare function WSASetSocketPeerTargetName(byval Socket as SOCKET, byval PeerTargetName as const SOCKET_PEER_TARGET_NAME ptr, byval PeerTargetNameLen as ULONG, byval Overlapped as LPWSAOVERLAPPED, byval CompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as long
	declare function WSASetSocketSecurity(byval Socket as SOCKET, byval SecuritySettings as const SOCKET_SECURITY_SETTINGS ptr, byval SecuritySettingsLen as ULONG, byval Overlapped as LPWSAOVERLAPPED, byval CompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as long
#elseif (not defined(__FB_64BIT__)) and (_WIN32_WINNT = &h0602)
	declare function GetAddrInfoExA stdcall(byval pName as PCSTR, byval pServiceName as PCSTR, byval dwNameSpace as DWORD, byval lpNspId as LPGUID, byval pHints as const addrinfoExA ptr, byval ppResult as PADDRINFOEXA ptr, byval timeout as PTIMEVAL, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPLOOKUPSERVICE_COMPLETION_ROUTINE, byval lpNameHandle as LPHANDLE) as long
	declare function GetAddrInfoExW stdcall(byval pName as PCWSTR, byval pServiceName as PCWSTR, byval dwNameSpace as DWORD, byval lpNspId as LPGUID, byval pHints as const addrinfoExW ptr, byval ppResult as PADDRINFOEXW ptr, byval timeout as PTIMEVAL, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPLOOKUPSERVICE_COMPLETION_ROUTINE, byval lpNameHandle as LPHANDLE) as long
	declare function SetAddrInfoExA stdcall(byval pName as PCSTR, byval pServiceName as PCSTR, byval pAddresses as SOCKET_ADDRESS ptr, byval dwAddressCount as DWORD, byval lpBlob as LPBLOB, byval dwFlags as DWORD, byval dwNameSpace as DWORD, byval lpNspId as LPGUID, byval timeout as PTIMEVAL, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPLOOKUPSERVICE_COMPLETION_ROUTINE, byval lpNameHandle as LPHANDLE) as long
	declare function SetAddrInfoExW stdcall(byval pName as PCWSTR, byval pServiceName as PCWSTR, byval pAddresses as SOCKET_ADDRESS ptr, byval dwAddressCount as DWORD, byval lpBlob as LPBLOB, byval dwFlags as DWORD, byval dwNameSpace as DWORD, byval lpNspId as LPGUID, byval timeout as PTIMEVAL, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPLOOKUPSERVICE_COMPLETION_ROUTINE, byval lpNameHandle as LPHANDLE) as long
	declare sub FreeAddrInfoExA stdcall(byval pAddrInfo as PADDRINFOEXA)
	declare sub FreeAddrInfoExW stdcall(byval pAddrInfo as PADDRINFOEXW)
	declare function WSAImpersonateSocketPeer stdcall(byval Socket as SOCKET, byval PeerAddress as const sockaddr ptr, byval peerAddressLen as ULONG) as long
	declare function WSAQuerySocketSecurity stdcall(byval Socket as SOCKET, byval SecurityQueryTemplate as const SOCKET_SECURITY_QUERY_TEMPLATE ptr, byval SecurityQueryTemplateLen as ULONG, byval SecurityQueryInfo as SOCKET_SECURITY_QUERY_INFO ptr, byval SecurityQueryInfoLen as ULONG ptr, byval Overlapped as LPWSAOVERLAPPED, byval CompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as long
	declare function WSARevertImpersonation stdcall() as long
	declare function WSASetSocketPeerTargetName stdcall(byval Socket as SOCKET, byval PeerTargetName as const SOCKET_PEER_TARGET_NAME ptr, byval PeerTargetNameLen as ULONG, byval Overlapped as LPWSAOVERLAPPED, byval CompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as long
	declare function WSASetSocketSecurity stdcall(byval Socket as SOCKET, byval SecuritySettings as const SOCKET_SECURITY_SETTINGS ptr, byval SecuritySettingsLen as ULONG, byval Overlapped as LPWSAOVERLAPPED, byval CompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as long
#endif

#if _WIN32_WINNT = &h0602
	#define InetNtopA inet_ntop
#endif

#if defined(__FB_64BIT__) and (_WIN32_WINNT = &h0602)
	declare function InetNtopW(byval Family as INT_, byval pAddr as PVOID, byval pStringBuf as LPWSTR, byval StringBufSIze as uinteger) as LPCWSTR
	declare function inet_ntop(byval Family as INT_, byval pAddr as PVOID, byval pStringBuf as LPSTR, byval StringBufSize as uinteger) as LPCSTR
#elseif (not defined(__FB_64BIT__)) and (_WIN32_WINNT = &h0602)
	declare function InetNtopW stdcall(byval Family as INT_, byval pAddr as PVOID, byval pStringBuf as LPWSTR, byval StringBufSIze as uinteger) as LPCWSTR
	declare function inet_ntop stdcall(byval Family as INT_, byval pAddr as PVOID, byval pStringBuf as LPSTR, byval StringBufSize as uinteger) as LPCSTR
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define InetNtop InetNtopW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define InetNtop InetNtopA
#endif

#if _WIN32_WINNT = &h0602
	#define InetPtonA inet_pton
#endif

#if defined(__FB_64BIT__) and (_WIN32_WINNT = &h0602)
	declare function InetPtonW(byval Family as INT_, byval pStringBuf as LPCWSTR, byval pAddr as PVOID) as INT_
	declare function inet_pton(byval Family as INT_, byval pStringBuf as LPCSTR, byval pAddr as PVOID) as INT_
#elseif (not defined(__FB_64BIT__)) and (_WIN32_WINNT = &h0602)
	declare function InetPtonW stdcall(byval Family as INT_, byval pStringBuf as LPCWSTR, byval pAddr as PVOID) as INT_
	declare function inet_pton stdcall(byval Family as INT_, byval pStringBuf as LPCSTR, byval pAddr as PVOID) as INT_
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define InetPton InetPtonW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define InetPton InetPtonA
#endif

end extern
