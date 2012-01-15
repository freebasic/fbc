''
''
'' nspapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_nspapi_bi__
#define __win_nspapi_bi__

#inclib "wsock32"

#define NS_ALL 0
#define NS_SAP 1
#define NS_NDS 2
#define NS_PEER_BROWSE 3
#define NS_TCPIP_LOCAL 10
#define NS_TCPIP_HOSTS 11
#define NS_DNS 12
#define NS_NETBT 13
#define NS_WINS 14
#define NS_NBP 20
#define NS_MS 30
#define NS_STDA 31
#define NS_NTDS 32
#define NS_X500 40
#define NS_NIS 41
#define NS_NISPLUS 42
#define NS_WRQ 50
#define SERVICE_REGISTER 1
#define SERVICE_DEREGISTER 2
#define SERVICE_FLUSH 3
#define SERVICE_FLAG_HARD &h00000002

#ifndef BLOB
type BLOB
	cbSize as ULONG
	pBlobData as UBYTE ptr
end type

type PBLOB as BLOB ptr
type LPBLOB as BLOB ptr
#endif

#ifndef SERVICE_ADDRESS
type SERVICE_ADDRESS
	dwAddressType as DWORD
	dwAddressFlags as DWORD
	dwAddressLength as DWORD
	dwPrincipalLength as DWORD
	lpAddress as UBYTE ptr
	lpPrincipal as UBYTE ptr
end type
#endif

type SERVICE_ADDRESSES
	dwAddressCount as DWORD
	Addresses(0 to 1-1) as SERVICE_ADDRESS
end type

type PSERVICE_ADDRESSES as SERVICE_ADDRESSES ptr
type LPSERVICE_ADDRESSES as SERVICE_ADDRESSES ptr

#ifndef UNICODE
type SERVICE_INFOA
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

type LPSERVICE_INFOA as SERVICE_INFOA ptr

#else
type SERVICE_INFOW
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

type LPSERVICE_INFOW as SERVICE_INFOW ptr
#endif

type LPSERVICE_ASYNC_INFO as any ptr

#ifdef UNICODE
declare function SetService alias "SetServiceW" (byval as DWORD, byval as DWORD, byval as DWORD, byval as LPSERVICE_INFOW, byval as LPSERVICE_ASYNC_INFO, byval as LPDWORD) as INT_
declare function GetAddressByName alias "GetAddressByNameW" (byval as DWORD, byval as LPGUID, byval as LPWSTR, byval as LPINT, byval as DWORD, byval as LPSERVICE_ASYNC_INFO, byval as LPVOID, byval as LPDWORD, byval as LPTSTR, byval as LPDWORD) as INT_

type SERVICE_INFO as SERVICE_INFOW
type LPSERVICE_INFO as SERVICE_INFOW ptr

#else
declare function SetService alias "SetServiceA" (byval as DWORD, byval as DWORD, byval as DWORD, byval as LPSERVICE_INFOA, byval as LPSERVICE_ASYNC_INFO, byval as LPDWORD) as INT_
declare function GetAddressByName alias "GetAddressByNameA" (byval as DWORD, byval as LPGUID, byval as LPSTR, byval as LPINT, byval as DWORD, byval as LPSERVICE_ASYNC_INFO, byval as LPVOID, byval as LPDWORD, byval as LPTSTR, byval as LPDWORD) as INT_

type SERVICE_INFO as SERVICE_INFOA
type LPSERVICE_INFO as SERVICE_INFOA ptr
#endif

#endif
