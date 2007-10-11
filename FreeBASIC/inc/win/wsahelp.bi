''
''
'' wsahelp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_wsahelp_bi__
#define __win_wsahelp_bi__

#ifndef UNICODE
#error UNICODE only
#endif

#include once "win/winsock2.bi"
#include once "win/ntsecapi.bi"

#define WSH_NOTIFY_BIND &h00000001
#define WSH_NOTIFY_LISTEN &h00000002
#define WSH_NOTIFY_CONNECT &h00000004
#define WSH_NOTIFY_ACCEPT &h00000008
#define WSH_NOTIFY_SHUTDOWN_RECEIVE &h00000010
#define WSH_NOTIFY_SHUTDOWN_SEND &h00000020
#define WSH_NOTIFY_SHUTDOWN_ALL &h00000040
#define WSH_NOTIFY_CLOSE &h00000080
#define WSH_NOTIFY_CONNECT_ERROR &h00000100
#define SOL_INTERNAL &hFFFE
#define SO_CONTEXT 1

enum SOCKADDR_ADDRESS_INFO
	SockaddrAddressInfoNormal
	SockaddrAddressInfoWildcard
	SockaddrAddressInfoBroadcast
	SockaddrAddressInfoLoopback
end enum

type PSOCKADDR_ADDRESS_INFO as SOCKADDR_ADDRESS_INFO

enum SOCKADDR_ENDPOINT_INFO
	SockaddrEndpointInfoNormal
	SockaddrEndpointInfoWildcard
	SockaddrEndpointInfoReserved
end enum

type PSOCKADDR_ENDPOINT_INFO as SOCKADDR_ENDPOINT_INFO

type SOCKADDR_INFO
	AddressInfo as SOCKADDR_ADDRESS_INFO
	EndpointInfo as SOCKADDR_ENDPOINT_INFO
end type

type PSOCKADDR_INFO as SOCKADDR_INFO ptr

type WINSOCK_MAPPING_Mapping
	AddressFamily as DWORD
	SocketType as DWORD
	Protocol as DWORD
end type

type WINSOCK_MAPPING
	Rows as DWORD
	Columns as DWORD
	Mapping as WINSOCK_MAPPING_Mapping ptr
end type

type PWINSOCK_MAPPING as WINSOCK_MAPPING ptr

type SOCKADDR_INFO
	AddressInfo as SOCKADDR_ADDRESS_INFO
	EndpointInfo as SOCKADDR_ENDPOINT_INFO
end type

type PSOCKADDR_INFO as SOCKADDR_INFO ptr

declare function WSHAddressToString alias "WSHAddressToString" (byval as LPSOCKADDR, byval as INT_, byval as LPWSAPROTOCOL_INFOW, byval as LPWSTR, byval as LPDWORD) as INT_
declare function WSHEnumProtocols alias "WSHEnumProtocols" (byval as LPINT, byval as LPWSTR, byval as LPVOID, byval as LPDWORD) as INT_
declare function WSHGetBroadcastSockaddr alias "WSHGetBroadcastSockaddr" (byval as PVOID, byval as PSOCKADDR, byval as PINT) as INT_
declare function WSHGetProviderGuid alias "WSHGetProviderGuid" (byval as LPWSTR, byval as LPGUID) as INT_
declare function WSHGetSockaddrType alias "WSHGetSockaddrType" (byval as PSOCKADDR, byval as DWORD, byval as PSOCKADDR_INFO) as INT_
declare function WSHGetSocketInformation alias "WSHGetSocketInformation" (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as INT_, byval as INT_, byval as PCHAR, byval as INT_) as INT_
declare function WSHGetWildcardSockaddr alias "WSHGetWildcardSockaddr" (byval as PVOID, byval as PSOCKADDR, byval as PINT) as INT_
declare function WSHGetWinsockMapping alias "WSHGetWinsockMapping" (byval as PWINSOCK_MAPPING, byval as DWORD) as DWORD
declare function WSHGetWSAProtocolInfo alias "WSHGetWSAProtocolInfo" (byval as LPWSTR, byval as LPWSAPROTOCOL_INFOW ptr, byval as LPDWORD) as INT_
declare function WSHIoctl alias "WSHIoctl" (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval as LPBOOL) as INT_
declare function WSHJoinLeaf alias "WSHJoinLeaf" (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as PVOID, byval as SOCKET, byval as PSOCKADDR, byval as DWORD, byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS, byval as DWORD) as INT_
declare function WSHNotify alias "WSHNotify" (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as DWORD) as INT_
declare function WSHOpenSocket alias "WSHOpenSocket" (byval as PINT, byval as PINT, byval as PINT, byval as PUNICODE_STRING, byval as PVOID, byval as PDWORD) as INT_
declare function WSHOpenSocket2 alias "WSHOpenSocket2" (byval as PINT, byval as PINT, byval as PINT, byval as GROUP, byval as DWORD, byval as PUNICODE_STRING, byval as PVOID ptr, byval as PDWORD) as INT_
declare function WSHSetSocketInformation alias "WSHSetSocketInformation" (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as INT_, byval as INT_, byval as PCHAR, byval as INT_) as INT_
declare function WSHStringToAddress alias "WSHStringToAddress" (byval as LPWSTR, byval as DWORD, byval as LPWSAPROTOCOL_INFOW, byval as LPSOCKADDR, byval as LPDWORD) as INT_

type PWSH_ADDRESS_TO_STRING as function (byval as LPSOCKADDR, byval as INT_, byval as LPWSAPROTOCOL_INFOW, byval as LPWSTR, byval as LPDWORD) as INT_
type PWSH_ENUM_PROTOCOLS as function (byval as LPINT, byval as LPWSTR, byval as LPVOID, byval as LPDWORD) as INT_
type PWSH_GET_BROADCAST_SOCKADDR as function (byval as PVOID, byval as PSOCKADDR, byval as PINT) as INT_
type PWSH_GET_PROVIDER_GUID as function (byval as LPWSTR, byval as LPGUID) as INT_
type PWSH_GET_SOCKADDR_TYPE as function (byval as PSOCKADDR, byval as DWORD, byval as PSOCKADDR_INFO) as INT_
type PWSH_GET_SOCKET_INFORMATION as function (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as INT_, byval as INT_, byval as PCHAR, byval as INT_) as INT_
type PWSH_GET_WILDCARD_SOCKEADDR as function (byval as PVOID, byval as PSOCKADDR, byval as PINT) as INT_
type PWSH_GET_WINSOCK_MAPPING as function (byval as PWINSOCK_MAPPING, byval as DWORD) as DWORD
type PWSH_GET_WSAPROTOCOL_INFO as function (byval as LPWSTR, byval as LPWSAPROTOCOL_INFOW ptr, byval as LPDWORD) as INT_
type PWSH_IOCTL as function (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval as LPBOOL) as INT_
type PWSH_JOIN_LEAF as function (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as PVOID, byval as SOCKET, byval as PSOCKADDR, byval as DWORD, byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS, byval as DWORD) as INT_
type PWSH_NOTIFY as function (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as DWORD) as INT_
type PWSH_OPEN_SOCKET as function (byval as PINT, byval as PINT, byval as PINT, byval as PUNICODE_STRING, byval as PVOID, byval as PDWORD) as INT_
type PWSH_OPEN_SOCKET2 as function (byval as PINT, byval as PINT, byval as PINT, byval as GROUP, byval as DWORD, byval as PUNICODE_STRING, byval as PVOID ptr, byval as PDWORD) as INT_
type PWSH_SET_SOCKET_INFORMATION as function (byval as PVOID, byval as SOCKET, byval as HANDLE, byval as HANDLE, byval as INT_, byval as INT_, byval as PCHAR, byval as INT_) as INT_
type PWSH_STRING_TO_ADDRESS as function (byval as LPWSTR, byval as DWORD, byval as LPWSAPROTOCOL_INFOW, byval as LPSOCKADDR, byval as LPDWORD) as INT_

#endif
