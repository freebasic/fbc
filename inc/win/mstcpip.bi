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

#include once "_mingw_unicode.bi"
#include once "winapifamily.bi"

#if _WIN32_WINNT >= &h0502
	extern "Windows"
#endif

#define _MSTCPIP_

type tcp_keepalive
	onoff as u_long
	keepalivetime as u_long
	keepaliveinterval as u_long
end type

#define SIO_RCVALL _WSAIOW(IOC_VENDOR, 1)
#define SIO_RCVALL_MCAST _WSAIOW(IOC_VENDOR, 2)
#define SIO_RCVALL_IGMPMCAST _WSAIOW(IOC_VENDOR, 3)
#define SIO_KEEPALIVE_VALS _WSAIOW(IOC_VENDOR, 4)
#define SIO_ABSORB_RTRALERT _WSAIOW(IOC_VENDOR, 5)
#define SIO_UCAST_IF _WSAIOW(IOC_VENDOR, 6)
#define SIO_LIMIT_BROADCASTS _WSAIOW(IOC_VENDOR, 7)
#define SIO_INDEX_BIND _WSAIOW(IOC_VENDOR, 8)
#define SIO_INDEX_MCASTIF _WSAIOW(IOC_VENDOR, 9)
#define SIO_INDEX_ADD_MCAST _WSAIOW(IOC_VENDOR, 10)
#define SIO_INDEX_DEL_MCAST _WSAIOW(IOC_VENDOR, 11)
const RCVALL_OFF = 0
const RCVALL_ON = 1
const RCVALL_SOCKETLEVELONLY = 2
const RCVALL_IPLEVEL = 3

#if _WIN32_WINNT >= &h0502
	type _SOCKET_SECURITY_PROTOCOL as long
	enum
		SOCKET_SECURITY_PROTOCOL_DEFAULT
		SOCKET_SECURITY_PROTOCOL_IPSEC

		#if _WIN32_WINNT >= &h0601
			SOCKET_SECURITY_PROTOCOL_IPSEC2
		#endif

		SOCKET_SECURITY_PROTOCOL_INVALID
	end enum

	type SOCKET_SECURITY_PROTOCOL as _SOCKET_SECURITY_PROTOCOL
	const SOCKET_SETTINGS_GUARANTEE_ENCRYPTION = &h1
	const SOCKET_SETTINGS_ALLOW_INSECURE = &h2

	type _SOCKET_USAGE_TYPE as long
	enum
		SYSTEM_CRITICAL_SOCKET = 1
	end enum

	type SOCKET_USAGE_TYPE as _SOCKET_USAGE_TYPE

	type _SOCKET_PEER_TARGET_NAME
		SecurityProtocol as SOCKET_SECURITY_PROTOCOL
		PeerAddress as SOCKADDR_STORAGE
		PeerTargetNameStringLen as ULONG
		AllStrings as wstring * 1
	end type

	type SOCKET_PEER_TARGET_NAME as _SOCKET_PEER_TARGET_NAME
	const SOCKET_INFO_CONNECTION_SECURED = &h00000001
	const SOCKET_INFO_CONNECTION_ENCRYPTED = &h00000002
	const SOCKET_INFO_CONNECTION_IMPERSONATED = &h00000004

	type _SOCKET_SECURITY_QUERY_INFO
		SecurityProtocol as SOCKET_SECURITY_PROTOCOL
		Flags as ULONG
		PeerApplicationAccessTokenHandle as UINT64
		PeerMachineAccessTokenHandle as UINT64
	end type

	type SOCKET_SECURITY_QUERY_INFO as _SOCKET_SECURITY_QUERY_INFO

	type _SOCKET_SECURITY_QUERY_TEMPLATE
		SecurityProtocol as SOCKET_SECURITY_PROTOCOL
		PeerAddress as SOCKADDR_STORAGE
		PeerTokenAccessMask as ULONG
	end type

	type SOCKET_SECURITY_QUERY_TEMPLATE as _SOCKET_SECURITY_QUERY_TEMPLATE

	type _SOCKET_SECURITY_SETTINGS
		SecurityProtocol as SOCKET_SECURITY_PROTOCOL
		SecurityFlags as ULONG
	end type

	type SOCKET_SECURITY_SETTINGS as _SOCKET_SECURITY_SETTINGS
	const SOCKET_SETTINGS_IPSEC_SKIP_FILTER_INSTANTIATION = &h00000001

	type _SOCKET_SECURITY_SETTINGS_IPSEC
		SecurityProtocol as SOCKET_SECURITY_PROTOCOL
		SecurityFlags as ULONG
		IpsecFlags as ULONG
		AuthipMMPolicyKey as GUID
		AuthipQMPolicyKey as GUID
		Reserved as GUID
		Reserved2 as UINT64
		UserNameStringLen as ULONG
		DomainNameStringLen as ULONG
		PasswordStringLen as ULONG
		AllStrings as wstring * 1
	end type

	type SOCKET_SECURITY_SETTINGS_IPSEC as _SOCKET_SECURITY_SETTINGS_IPSEC
	declare function RtlIpv6AddressToStringA(byval Addr as const IN6_ADDR ptr, byval S as LPSTR) as LPSTR
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv6AddressToString alias "RtlIpv6AddressToStringA"(byval Addr as const IN6_ADDR ptr, byval S as LPSTR) as LPSTR
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv6AddressToStringW(byval Addr as const IN6_ADDR ptr, byval S as LPWSTR) as LPWSTR
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv6AddressToString alias "RtlIpv6AddressToStringW"(byval Addr as const IN6_ADDR ptr, byval S as LPWSTR) as LPWSTR
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv6AddressToStringExA(byval Address as const IN6_ADDR ptr, byval ScopeId as ULONG, byval Port as USHORT, byval AddressString as LPSTR, byval AddressStringLength as PULONG) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv6AddressToStringEx alias "RtlIpv6AddressToStringExA"(byval Address as const IN6_ADDR ptr, byval ScopeId as ULONG, byval Port as USHORT, byval AddressString as LPSTR, byval AddressStringLength as PULONG) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv6AddressToStringExW(byval Address as const IN6_ADDR ptr, byval ScopeId as ULONG, byval Port as USHORT, byval AddressString as LPWSTR, byval AddressStringLength as PULONG) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv6AddressToStringEx alias "RtlIpv6AddressToStringExW"(byval Address as const IN6_ADDR ptr, byval ScopeId as ULONG, byval Port as USHORT, byval AddressString as LPWSTR, byval AddressStringLength as PULONG) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv4AddressToStringA(byval Addr as const IN_ADDR ptr, byval S as LPSTR) as LPSTR
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv4AddressToString alias "RtlIpv4AddressToStringA"(byval Addr as const IN_ADDR ptr, byval S as LPSTR) as LPSTR
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv4AddressToStringW(byval Addr as const IN_ADDR ptr, byval S as LPWSTR) as LPWSTR
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv4AddressToString alias "RtlIpv4AddressToStringW"(byval Addr as const IN_ADDR ptr, byval S as LPWSTR) as LPWSTR
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv4AddressToStringExA(byval Address as const IN_ADDR ptr, byval Port as USHORT, byval AddressString as LPSTR, byval AddressStringLength as PULONG) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv4AddressToStringEx alias "RtlIpv4AddressToStringExA"(byval Address as const IN_ADDR ptr, byval Port as USHORT, byval AddressString as LPSTR, byval AddressStringLength as PULONG) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv4AddressToStringExW(byval Address as const IN_ADDR ptr, byval Port as USHORT, byval AddressString as LPWSTR, byval AddressStringLength as PULONG) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv4AddressToStringEx alias "RtlIpv4AddressToStringExW"(byval Address as const IN_ADDR ptr, byval Port as USHORT, byval AddressString as LPWSTR, byval AddressStringLength as PULONG) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv4StringToAddressA(byval S as PCSTR, byval Strict as WINBOOLEAN, byval Terminator as LPSTR ptr, byval Addr as IN_ADDR ptr) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv4StringToAddress alias "RtlIpv4StringToAddressA"(byval S as PCSTR, byval Strict as WINBOOLEAN, byval Terminator as LPSTR ptr, byval Addr as IN_ADDR ptr) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv4StringToAddressW(byval S as PCWSTR, byval Strict as WINBOOLEAN, byval Terminator as LPWSTR ptr, byval Addr as IN_ADDR ptr) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv4StringToAddress alias "RtlIpv4StringToAddressW"(byval S as PCWSTR, byval Strict as WINBOOLEAN, byval Terminator as LPWSTR ptr, byval Addr as IN_ADDR ptr) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv4StringToAddressExA(byval AddressString as PCSTR, byval Strict as WINBOOLEAN, byval Address as IN_ADDR ptr, byval Port as PUSHORT) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv4StringToAddressEx alias "RtlIpv4StringToAddressExA"(byval AddressString as PCSTR, byval Strict as WINBOOLEAN, byval Address as IN_ADDR ptr, byval Port as PUSHORT) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv4StringToAddressExW(byval AddressString as PCWSTR, byval Strict as WINBOOLEAN, byval Address as IN_ADDR ptr, byval Port as PUSHORT) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv4StringToAddressEx alias "RtlIpv4StringToAddressExW"(byval AddressString as PCWSTR, byval Strict as WINBOOLEAN, byval Address as IN_ADDR ptr, byval Port as PUSHORT) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv6StringToAddressExA(byval AddressString as PCSTR, byval Address as IN6_ADDR ptr, byval ScopeId as PULONG, byval Port as PUSHORT) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv6StringToAddressEx alias "RtlIpv6StringToAddressExA"(byval AddressString as PCSTR, byval Address as IN6_ADDR ptr, byval ScopeId as PULONG, byval Port as PUSHORT) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	declare function RtlIpv6StringToAddressExW(byval AddressString as PCWSTR, byval Address as IN6_ADDR ptr, byval ScopeId as PULONG, byval Port as PUSHORT) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	declare function RtlIpv6StringToAddressEx alias "RtlIpv6StringToAddressExW"(byval AddressString as PCWSTR, byval Address as IN6_ADDR ptr, byval ScopeId as PULONG, byval Port as PUSHORT) as LONG
#endif

#if _WIN32_WINNT >= &h0502
	end extern
#endif
