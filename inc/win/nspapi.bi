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

#include once "_mingw_unicode.bi"

extern "Windows"

#define _NSPAPI_INCLUDED
const SERVICE_RESOURCE = &h00000001
const SERVICE_SERVICE = &h00000002
const SERVICE_LOCAL = &h00000004
const SERVICE_REGISTER = &h00000001
const SERVICE_DEREGISTER = &h00000002
const SERVICE_FLUSH = &h00000003
const SERVICE_ADD_TYPE = &h00000004
const SERVICE_DELETE_TYPE = &h00000005
const SERVICE_FLAG_DEFER = &h00000001
const SERVICE_FLAG_HARD = &h00000002
const PROP_COMMENT = &h00000001
const PROP_LOCALE = &h00000002
const PROP_DISPLAY_HINT = &h00000004
const PROP_VERSION = &h00000008
const PROP_START_TIME = &h00000010
const PROP_MACHINE = &h00000020
const PROP_ADDRESSES = &h00000100
const PROP_SD = &h00000200
const PROP_ALL = &h80000000
const SERVICE_ADDRESS_FLAG_RPC_CN = &h00000001
const SERVICE_ADDRESS_FLAG_RPC_DG = &h00000002
const SERVICE_ADDRESS_FLAG_RPC_NB = &h00000004
const NS_DEFAULT = 0
const NS_SAP = 1
const NS_NDS = 2
const NS_PEER_BROWSE = 3
const NS_TCPIP_LOCAL = 10
const NS_TCPIP_HOSTS = 11
const NS_DNS = 12
const NS_NETBT = 13
const NS_WINS = 14
const NS_NLA = 15

#if _WIN32_WINNT >= &h0600
	const NS_BTH = 16
#endif

const NS_NBP = 20
const NS_MS = 30
const NS_STDA = 31
const NS_NTDS = 32

#if _WIN32_WINNT >= &h0600
	const NS_EMAIL = 37
	const NS_PNRPNAME = 38
	const NS_PNRPCLOUD = 39
#endif

const NS_X500 = 40
const NS_NIS = 41
const NS_VNS = 50
const NSTYPE_HIERARCHICAL = &h00000001
const NSTYPE_DYNAMIC = &h00000002
const NSTYPE_ENUMERABLE = &h00000004
const NSTYPE_WORKGROUP = &h00000008
const XP_CONNECTIONLESS = &h00000001
const XP_GUARANTEED_DELIVERY = &h00000002
const XP_GUARANTEED_ORDER = &h00000004
const XP_MESSAGE_ORIENTED = &h00000008
const XP_PSEUDO_STREAM = &h00000010
const XP_GRACEFUL_CLOSE = &h00000020
const XP_EXPEDITED_DATA = &h00000040
const XP_CONNECT_DATA = &h00000080
const XP_DISCONNECT_DATA = &h00000100
const XP_SUPPORTS_BROADCAST = &h00000200
const XP_SUPPORTS_MULTICAST = &h00000400
const XP_BANDWIDTH_ALLOCATION = &h00000800
const XP_FRAGMENTATION = &h00001000
const XP_ENCRYPTS = &h00002000
const RES_SOFT_SEARCH = &h00000001
const RES_FIND_MULTIPLE = &h00000002
const RES_SERVICE = &h00000004
#define SERVICE_TYPE_VALUE_SAPIDA "SapId"
#define SERVICE_TYPE_VALUE_SAPIDW wstr("SapId")
#define SERVICE_TYPE_VALUE_CONNA "ConnectionOriented"
#define SERVICE_TYPE_VALUE_CONNW wstr("ConnectionOriented")
#define SERVICE_TYPE_VALUE_TCPPORTA "TcpPort"
#define SERVICE_TYPE_VALUE_TCPPORTW wstr("TcpPort")
#define SERVICE_TYPE_VALUE_UDPPORTA "UdpPort"
#define SERVICE_TYPE_VALUE_UDPPORTW wstr("UdpPort")

#ifdef UNICODE
	#define SERVICE_TYPE_VALUE_SAPID SERVICE_TYPE_VALUE_SAPIDW
	#define SERVICE_TYPE_VALUE_CONN SERVICE_TYPE_VALUE_CONNW
	#define SERVICE_TYPE_VALUE_TCPPORT SERVICE_TYPE_VALUE_TCPPORTW
	#define SERVICE_TYPE_VALUE_UDPPORT SERVICE_TYPE_VALUE_UDPPORTW
#else
	#define SERVICE_TYPE_VALUE_SAPID SERVICE_TYPE_VALUE_SAPIDA
	#define SERVICE_TYPE_VALUE_CONN SERVICE_TYPE_VALUE_CONNA
	#define SERVICE_TYPE_VALUE_TCPPORT SERVICE_TYPE_VALUE_TCPPORTA
	#define SERVICE_TYPE_VALUE_UDPPORT SERVICE_TYPE_VALUE_UDPPORTA
#endif

const SET_SERVICE_PARTIAL_SUCCESS = &h00000001

type _NS_INFOA
	dwNameSpace as DWORD
	dwNameSpaceFlags as DWORD
	lpNameSpace as LPSTR
end type

type NS_INFOA as _NS_INFOA
type PNS_INFOA as _NS_INFOA ptr
type LPNS_INFOA as _NS_INFOA ptr

type _NS_INFOW
	dwNameSpace as DWORD
	dwNameSpaceFlags as DWORD
	lpNameSpace as LPWSTR
end type

type NS_INFOW as _NS_INFOW
type PNS_INFOW as _NS_INFOW ptr
type LPNS_INFOW as _NS_INFOW ptr

#ifdef UNICODE
	type NS_INFO as NS_INFOW
	type PNS_INFO as PNS_INFOW
	type LPNS_INFO as LPNS_INFOW
#else
	type NS_INFO as NS_INFOA
	type PNS_INFO as PNS_INFOA
	type LPNS_INFO as LPNS_INFOA
#endif

type _SERVICE_TYPE_VALUE
	dwNameSpace as DWORD
	dwValueType as DWORD
	dwValueSize as DWORD
	dwValueNameOffset as DWORD
	dwValueOffset as DWORD
end type

type SERVICE_TYPE_VALUE as _SERVICE_TYPE_VALUE
type PSERVICE_TYPE_VALUE as _SERVICE_TYPE_VALUE ptr
type LPSERVICE_TYPE_VALUE as _SERVICE_TYPE_VALUE ptr

type _SERVICE_TYPE_VALUE_ABSA
	dwNameSpace as DWORD
	dwValueType as DWORD
	dwValueSize as DWORD
	lpValueName as LPSTR
	lpValue as PVOID
end type

type SERVICE_TYPE_VALUE_ABSA as _SERVICE_TYPE_VALUE_ABSA
type PSERVICE_TYPE_VALUE_ABSA as _SERVICE_TYPE_VALUE_ABSA ptr
type LPSERVICE_TYPE_VALUE_ABSA as _SERVICE_TYPE_VALUE_ABSA ptr

type _SERVICE_TYPE_VALUE_ABSW
	dwNameSpace as DWORD
	dwValueType as DWORD
	dwValueSize as DWORD
	lpValueName as LPWSTR
	lpValue as PVOID
end type

type SERVICE_TYPE_VALUE_ABSW as _SERVICE_TYPE_VALUE_ABSW
type PSERVICE_TYPE_VALUE_ABSW as _SERVICE_TYPE_VALUE_ABSW ptr
type LPSERVICE_TYPE_VALUE_ABSW as _SERVICE_TYPE_VALUE_ABSW ptr

#ifdef UNICODE
	type SERVICE_TYPE_VALUE_ABS as SERVICE_TYPE_VALUE_ABSW
	type PSERVICE_TYPE_VALUE_ABS as PSERVICE_TYPE_VALUE_ABSW
	type LPSERVICE_TYPE_VALUE_ABS as LPSERVICE_TYPE_VALUE_ABSW
#else
	type SERVICE_TYPE_VALUE_ABS as SERVICE_TYPE_VALUE_ABSA
	type PSERVICE_TYPE_VALUE_ABS as PSERVICE_TYPE_VALUE_ABSA
	type LPSERVICE_TYPE_VALUE_ABS as LPSERVICE_TYPE_VALUE_ABSA
#endif

type _SERVICE_TYPE_INFO
	dwTypeNameOffset as DWORD
	dwValueCount as DWORD
	Values(0 to 0) as SERVICE_TYPE_VALUE
end type

type SERVICE_TYPE_INFO as _SERVICE_TYPE_INFO
type PSERVICE_TYPE_INFO as _SERVICE_TYPE_INFO ptr
type LPSERVICE_TYPE_INFO as _SERVICE_TYPE_INFO ptr

type _SERVICE_TYPE_INFO_ABSA
	lpTypeName as LPSTR
	dwValueCount as DWORD
	Values(0 to 0) as SERVICE_TYPE_VALUE_ABSA
end type

type SERVICE_TYPE_INFO_ABSA as _SERVICE_TYPE_INFO_ABSA
type PSERVICE_TYPE_INFO_ABSA as _SERVICE_TYPE_INFO_ABSA ptr
type LPSERVICE_TYPE_INFO_ABSA as _SERVICE_TYPE_INFO_ABSA ptr

type _SERVICE_TYPE_INFO_ABSW
	lpTypeName as LPWSTR
	dwValueCount as DWORD
	Values(0 to 0) as SERVICE_TYPE_VALUE_ABSW
end type

type SERVICE_TYPE_INFO_ABSW as _SERVICE_TYPE_INFO_ABSW
type PSERVICE_TYPE_INFO_ABSW as _SERVICE_TYPE_INFO_ABSW ptr
type LPSERVICE_TYPE_INFO_ABSW as _SERVICE_TYPE_INFO_ABSW ptr

#ifdef UNICODE
	type SERVICE_TYPE_INFO_ABS as SERVICE_TYPE_INFO_ABSW
	type PSERVICE_TYPE_INFO_ABS as PSERVICE_TYPE_INFO_ABSW
	type LPSERVICE_TYPE_INFO_ABS as LPSERVICE_TYPE_INFO_ABSW
#else
	type SERVICE_TYPE_INFO_ABS as SERVICE_TYPE_INFO_ABSA
	type PSERVICE_TYPE_INFO_ABS as PSERVICE_TYPE_INFO_ABSA
	type LPSERVICE_TYPE_INFO_ABS as LPSERVICE_TYPE_INFO_ABSA
#endif

type _SERVICE_ADDRESS
	dwAddressType as DWORD
	dwAddressFlags as DWORD
	dwAddressLength as DWORD
	dwPrincipalLength as DWORD
	lpAddress as UBYTE ptr
	lpPrincipal as UBYTE ptr
end type

type SERVICE_ADDRESS as _SERVICE_ADDRESS
type PSERVICE_ADDRESS as _SERVICE_ADDRESS ptr
type LPSERVICE_ADDRESS as _SERVICE_ADDRESS ptr

type _SERVICE_ADDRESSES
	dwAddressCount as DWORD
	Addresses(0 to 0) as SERVICE_ADDRESS
end type

type SERVICE_ADDRESSES as _SERVICE_ADDRESSES
type PSERVICE_ADDRESSES as _SERVICE_ADDRESSES ptr
type LPSERVICE_ADDRESSES as _SERVICE_ADDRESSES ptr

type _SERVICE_INFOA
	lpServiceType as LPGUID
	lpServiceName as LPSTR
	lpComment as LPSTR
	lpLocale as LPSTR
	dwDisplayHint as DWORD
	dwVersion as DWORD
	dwTime as DWORD
	lpMachineName as LPSTR
	lpServiceAddress as LPSERVICE_ADDRESSES
	ServiceSpecificInfo as BLOB
end type

type SERVICE_INFOA as _SERVICE_INFOA
type PSERVICE_INFOA as _SERVICE_INFOA ptr
type LPSERVICE_INFOA as _SERVICE_INFOA ptr

type _SERVICE_INFOW
	lpServiceType as LPGUID
	lpServiceName as LPWSTR
	lpComment as LPWSTR
	lpLocale as LPWSTR
	dwDisplayHint as DWORD
	dwVersion as DWORD
	dwTime as DWORD
	lpMachineName as LPWSTR
	lpServiceAddress as LPSERVICE_ADDRESSES
	ServiceSpecificInfo as BLOB
end type

type SERVICE_INFOW as _SERVICE_INFOW
type PSERVICE_INFOW as _SERVICE_INFOW ptr
type LPSERVICE_INFOW as _SERVICE_INFOW ptr

#ifdef UNICODE
	type SERVICE_INFO as SERVICE_INFOW
	type PSERVICE_INFO as PSERVICE_INFOW
	type LPSERVICE_INFO as LPSERVICE_INFOW
#else
	type SERVICE_INFO as SERVICE_INFOA
	type PSERVICE_INFO as PSERVICE_INFOA
	type LPSERVICE_INFO as LPSERVICE_INFOA
#endif

type _NS_SERVICE_INFOA
	dwNameSpace as DWORD
	ServiceInfo as SERVICE_INFOA
end type

type NS_SERVICE_INFOA as _NS_SERVICE_INFOA
type PNS_SERVICE_INFOA as _NS_SERVICE_INFOA ptr
type LPNS_SERVICE_INFOA as _NS_SERVICE_INFOA ptr

type _NS_SERVICE_INFOW
	dwNameSpace as DWORD
	ServiceInfo as SERVICE_INFOW
end type

type NS_SERVICE_INFOW as _NS_SERVICE_INFOW
type PNS_SERVICE_INFOW as _NS_SERVICE_INFOW ptr
type LPNS_SERVICE_INFOW as _NS_SERVICE_INFOW ptr

#ifdef UNICODE
	type NS_SERVICE_INFO as NS_SERVICE_INFOW
	type PNS_SERVICE_INFO as PNS_SERVICE_INFOW
	type LPNS_SERVICE_INFO as LPNS_SERVICE_INFOW
#else
	type NS_SERVICE_INFO as NS_SERVICE_INFOA
	type PNS_SERVICE_INFO as PNS_SERVICE_INFOA
	type LPNS_SERVICE_INFO as LPNS_SERVICE_INFOA
#endif

type _PROTOCOL_INFOA
	dwServiceFlags as DWORD
	iAddressFamily as INT_
	iMaxSockAddr as INT_
	iMinSockAddr as INT_
	iSocketType as INT_
	iProtocol as INT_
	dwMessageSize as DWORD
	lpProtocol as LPSTR
end type

type PROTOCOL_INFOA as _PROTOCOL_INFOA
type PPROTOCOL_INFOA as _PROTOCOL_INFOA ptr
type LPPROTOCOL_INFOA as _PROTOCOL_INFOA ptr

type _PROTOCOL_INFOW
	dwServiceFlags as DWORD
	iAddressFamily as INT_
	iMaxSockAddr as INT_
	iMinSockAddr as INT_
	iSocketType as INT_
	iProtocol as INT_
	dwMessageSize as DWORD
	lpProtocol as LPWSTR
end type

type PROTOCOL_INFOW as _PROTOCOL_INFOW
type PPROTOCOL_INFOW as _PROTOCOL_INFOW ptr
type LPPROTOCOL_INFOW as _PROTOCOL_INFOW ptr

#ifdef UNICODE
	type PROTOCOL_INFO as PROTOCOL_INFOW
	type PPROTOCOL_INFO as PPROTOCOL_INFOW
	type LPPROTOCOL_INFO as LPPROTOCOL_INFOW
#else
	type PROTOCOL_INFO as PROTOCOL_INFOA
	type PPROTOCOL_INFO as PPROTOCOL_INFOA
	type LPPROTOCOL_INFO as LPPROTOCOL_INFOA
#endif

type _NETRESOURCE2A
	dwScope as DWORD
	dwType as DWORD
	dwUsage as DWORD
	dwDisplayType as DWORD
	lpLocalName as LPSTR
	lpRemoteName as LPSTR
	lpComment as LPSTR
	ns_info as NS_INFO
	ServiceType as GUID
	dwProtocols as DWORD
	lpiProtocols as LPINT
end type

type NETRESOURCE2A as _NETRESOURCE2A
type PNETRESOURCE2A as _NETRESOURCE2A ptr
type LPNETRESOURCE2A as _NETRESOURCE2A ptr

type _NETRESOURCE2W
	dwScope as DWORD
	dwType as DWORD
	dwUsage as DWORD
	dwDisplayType as DWORD
	lpLocalName as LPWSTR
	lpRemoteName as LPWSTR
	lpComment as LPWSTR
	ns_info as NS_INFO
	ServiceType as GUID
	dwProtocols as DWORD
	lpiProtocols as LPINT
end type

type NETRESOURCE2W as _NETRESOURCE2W
type PNETRESOURCE2W as _NETRESOURCE2W ptr
type LPNETRESOURCE2W as _NETRESOURCE2W ptr

#ifdef UNICODE
	type NETRESOURCE2 as NETRESOURCE2W
	type PNETRESOURCE2 as PNETRESOURCE2W
	type LPNETRESOURCE2 as LPNETRESOURCE2W
#else
	type NETRESOURCE2 as NETRESOURCE2A
	type PNETRESOURCE2 as PNETRESOURCE2A
	type LPNETRESOURCE2 as LPNETRESOURCE2A
#endif

type LPFN_NSPAPI as function cdecl() as DWORD
type LPSERVICE_CALLBACK_PROC as sub cdecl(byval lParam as LPARAM, byval hAsyncTaskHandle as HANDLE)

type _SERVICE_ASYNC_INFO
	lpServiceCallbackProc as LPSERVICE_CALLBACK_PROC
	lParam as LPARAM
	hAsyncTaskHandle as HANDLE
end type

type SERVICE_ASYNC_INFO as _SERVICE_ASYNC_INFO
type PSERVICE_ASYNC_INFO as _SERVICE_ASYNC_INFO ptr
type LPSERVICE_ASYNC_INFO as _SERVICE_ASYNC_INFO ptr
declare function EnumProtocolsA(byval lpiProtocols as LPINT, byval lpProtocolBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as INT_

#ifndef UNICODE
	declare function EnumProtocols alias "EnumProtocolsA"(byval lpiProtocols as LPINT, byval lpProtocolBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as INT_
#endif

declare function EnumProtocolsW(byval lpiProtocols as LPINT, byval lpProtocolBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as INT_

#ifdef UNICODE
	declare function EnumProtocols alias "EnumProtocolsW"(byval lpiProtocols as LPINT, byval lpProtocolBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as INT_
#endif

declare function GetAddressByNameA(byval dwNameSpace as DWORD, byval lpServiceType as LPGUID, byval lpServiceName as LPSTR, byval lpiProtocols as LPINT, byval dwResolution as DWORD, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO, byval lpCsaddrBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpAliasBuffer as LPSTR, byval lpdwAliasBufferLength as LPDWORD) as INT_

#ifndef UNICODE
	declare function GetAddressByName alias "GetAddressByNameA"(byval dwNameSpace as DWORD, byval lpServiceType as LPGUID, byval lpServiceName as LPSTR, byval lpiProtocols as LPINT, byval dwResolution as DWORD, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO, byval lpCsaddrBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpAliasBuffer as LPSTR, byval lpdwAliasBufferLength as LPDWORD) as INT_
#endif

declare function GetAddressByNameW(byval dwNameSpace as DWORD, byval lpServiceType as LPGUID, byval lpServiceName as LPWSTR, byval lpiProtocols as LPINT, byval dwResolution as DWORD, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO, byval lpCsaddrBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpAliasBuffer as LPWSTR, byval lpdwAliasBufferLength as LPDWORD) as INT_

#ifdef UNICODE
	declare function GetAddressByName alias "GetAddressByNameW"(byval dwNameSpace as DWORD, byval lpServiceType as LPGUID, byval lpServiceName as LPWSTR, byval lpiProtocols as LPINT, byval dwResolution as DWORD, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO, byval lpCsaddrBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpAliasBuffer as LPWSTR, byval lpdwAliasBufferLength as LPDWORD) as INT_
#endif

declare function GetTypeByNameA(byval lpServiceName as LPSTR, byval lpServiceType as LPGUID) as INT_

#ifndef UNICODE
	declare function GetTypeByName alias "GetTypeByNameA"(byval lpServiceName as LPSTR, byval lpServiceType as LPGUID) as INT_
#endif

declare function GetTypeByNameW(byval lpServiceName as LPWSTR, byval lpServiceType as LPGUID) as INT_

#ifdef UNICODE
	declare function GetTypeByName alias "GetTypeByNameW"(byval lpServiceName as LPWSTR, byval lpServiceType as LPGUID) as INT_
#endif

declare function GetNameByTypeA(byval lpServiceType as LPGUID, byval lpServiceName as LPSTR, byval dwNameLength as DWORD) as INT_

#ifndef UNICODE
	declare function GetNameByType alias "GetNameByTypeA"(byval lpServiceType as LPGUID, byval lpServiceName as LPSTR, byval dwNameLength as DWORD) as INT_
#endif

declare function GetNameByTypeW(byval lpServiceType as LPGUID, byval lpServiceName as LPWSTR, byval dwNameLength as DWORD) as INT_

#ifdef UNICODE
	declare function GetNameByType alias "GetNameByTypeW"(byval lpServiceType as LPGUID, byval lpServiceName as LPWSTR, byval dwNameLength as DWORD) as INT_
#endif

declare function SetServiceA(byval dwNameSpace as DWORD, byval dwOperation as DWORD, byval dwFlags as DWORD, byval lpServiceInfo as LPSERVICE_INFOA, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO, byval lpdwStatusFlags as LPDWORD) as INT_

#ifndef UNICODE
	declare function SetService alias "SetServiceA"(byval dwNameSpace as DWORD, byval dwOperation as DWORD, byval dwFlags as DWORD, byval lpServiceInfo as LPSERVICE_INFOA, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO, byval lpdwStatusFlags as LPDWORD) as INT_
#endif

declare function SetServiceW(byval dwNameSpace as DWORD, byval dwOperation as DWORD, byval dwFlags as DWORD, byval lpServiceInfo as LPSERVICE_INFOW, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO, byval lpdwStatusFlags as LPDWORD) as INT_

#ifdef UNICODE
	declare function SetService alias "SetServiceW"(byval dwNameSpace as DWORD, byval dwOperation as DWORD, byval dwFlags as DWORD, byval lpServiceInfo as LPSERVICE_INFOW, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO, byval lpdwStatusFlags as LPDWORD) as INT_
#endif

declare function GetServiceA(byval dwNameSpace as DWORD, byval lpGuid as LPGUID, byval lpServiceName as LPSTR, byval dwProperties as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferSize as LPDWORD, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO) as INT_

#ifndef UNICODE
	declare function GetService alias "GetServiceA"(byval dwNameSpace as DWORD, byval lpGuid as LPGUID, byval lpServiceName as LPSTR, byval dwProperties as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferSize as LPDWORD, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO) as INT_
#endif

declare function GetServiceW(byval dwNameSpace as DWORD, byval lpGuid as LPGUID, byval lpServiceName as LPWSTR, byval dwProperties as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferSize as LPDWORD, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO) as INT_

#ifdef UNICODE
	declare function GetService alias "GetServiceW"(byval dwNameSpace as DWORD, byval lpGuid as LPGUID, byval lpServiceName as LPWSTR, byval dwProperties as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferSize as LPDWORD, byval lpServiceAsyncInfo as LPSERVICE_ASYNC_INFO) as INT_
#endif

end extern
