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

#inclib "mprapi"

extern "Windows"

#define _RASSAPI_H_
const RASSAPI_MAX_PHONENUMBER_SIZE = 128
const RASSAPI_MAX_MEDIA_NAME = 16
const RASSAPI_MAX_PORT_NAME = 16
const RASSAPI_MAX_DEVICE_NAME = 128
const RASSAPI_MAX_DEVICETYPE_NAME = 16
const RASSAPI_MAX_PARAM_KEY_SIZE = 32
const RASPRIV_NoCallback = &h01
const RASPRIV_AdminSetCallback = &h02
const RASPRIV_CallerSetCallback = &h04
const RASPRIV_DialinPrivilege = &h08
#define RASPRIV_CallbackType ((RASPRIV_AdminSetCallback or RASPRIV_CallerSetCallback) or RASPRIV_NoCallback)
const RAS_MODEM_OPERATIONAL = 1
const RAS_MODEM_NOT_RESPONDING = 2
const RAS_MODEM_HARDWARE_FAILURE = 3
const RAS_MODEM_INCORRECT_RESPONSE = 4
const RAS_MODEM_UNKNOWN = 5
const RAS_PORT_NON_OPERATIONAL = 1
const RAS_PORT_DISCONNECTED = 2
const RAS_PORT_CALLING_BACK = 3
const RAS_PORT_LISTENING = 4
const RAS_PORT_AUTHENTICATING = 5
const RAS_PORT_AUTHENTICATED = 6
const RAS_PORT_INITIALIZING = 7

type RAS_PARAMS_FORMAT as long
enum
	ParamNumber = 0
	ParamString = 1
end enum

type RAS_PARAMS_VALUE_String
	Length as DWORD
	Data as PCHAR
end type

union RAS_PARAMS_VALUE
	Number as DWORD
	String as RAS_PARAMS_VALUE_String
end union

type RAS_PARAMETERS
	P_Key as zstring * 32
	P_Type as RAS_PARAMS_FORMAT
	P_Attributes as UBYTE
	P_Value as RAS_PARAMS_VALUE
end type

type _RAS_USER_0
	bfPrivilege as UBYTE
	szPhoneNumber as wstring * 128 + 1
end type

type RAS_USER_0 as _RAS_USER_0
type PRAS_USER_0 as _RAS_USER_0 ptr

type _RAS_PORT_0
	wszPortName as wstring * 16
	wszDeviceType as wstring * 16
	wszDeviceName as wstring * 128
	wszMediaName as wstring * 16
	reserved as DWORD
	Flags as DWORD
	wszUserName as wstring * 256 + 1
	wszComputer as wstring * 16
	dwStartSessionTime as DWORD
	wszLogonDomain as wstring * 15 + 1
	fAdvancedServer as WINBOOL
end type

type RAS_PORT_0 as _RAS_PORT_0
type PRAS_PORT_0 as _RAS_PORT_0 ptr
const MEDIA_UNKNOWN = 0
const MEDIA_SERIAL = 1
const MEDIA_RAS10_SERIAL = 2
const MEDIA_X25 = 3
const MEDIA_ISDN = 4
const USER_AUTHENTICATED = &h0001
const MESSENGER_PRESENT = &h0002
const PPP_CLIENT = &h0004
const GATEWAY_ACTIVE = &h0008
const REMOTE_LISTEN = &h0010
const PORT_MULTILINKED = &h0020
type IPADDR as ULONG
const RAS_IPADDRESSLEN = 15
const RAS_IPXADDRESSLEN = 22
const RAS_ATADDRESSLEN = 32

type _RAS_PPP_NBFCP_RESULT
	dwError as DWORD
	dwNetBiosError as DWORD
	szName as zstring * 16 + 1
	wszWksta as wstring * 16 + 1
end type

type RAS_PPP_NBFCP_RESULT as _RAS_PPP_NBFCP_RESULT

type _RAS_PPP_IPCP_RESULT
	dwError as DWORD
	wszAddress as wstring * 15 + 1
end type

type RAS_PPP_IPCP_RESULT as _RAS_PPP_IPCP_RESULT

type _RAS_PPP_IPXCP_RESULT
	dwError as DWORD
	wszAddress as wstring * 22 + 1
end type

type RAS_PPP_IPXCP_RESULT as _RAS_PPP_IPXCP_RESULT

type _RAS_PPP_ATCP_RESULT
	dwError as DWORD
	wszAddress as wstring * 32 + 1
end type

type RAS_PPP_ATCP_RESULT as _RAS_PPP_ATCP_RESULT

type _RAS_PPP_PROJECTION_RESULT
	nbf as RAS_PPP_NBFCP_RESULT
	ip as RAS_PPP_IPCP_RESULT
	ipx as RAS_PPP_IPXCP_RESULT
	at as RAS_PPP_ATCP_RESULT
end type

type RAS_PPP_PROJECTION_RESULT as _RAS_PPP_PROJECTION_RESULT

type _RAS_PORT_1
	rasport0 as RAS_PORT_0
	LineCondition as DWORD
	HardwareCondition as DWORD
	LineSpeed as DWORD
	NumStatistics as WORD
	NumMediaParms as WORD
	SizeMediaParms as DWORD
	ProjResult as RAS_PPP_PROJECTION_RESULT
end type

type RAS_PORT_1 as _RAS_PORT_1
type PRAS_PORT_1 as _RAS_PORT_1 ptr

type _RAS_PORT_STATISTICS
	dwBytesXmited as DWORD
	dwBytesRcved as DWORD
	dwFramesXmited as DWORD
	dwFramesRcved as DWORD
	dwCrcErr as DWORD
	dwTimeoutErr as DWORD
	dwAlignmentErr as DWORD
	dwHardwareOverrunErr as DWORD
	dwFramingErr as DWORD
	dwBufferOverrunErr as DWORD
	dwBytesXmitedUncompressed as DWORD
	dwBytesRcvedUncompressed as DWORD
	dwBytesXmitedCompressed as DWORD
	dwBytesRcvedCompressed as DWORD
	dwPortBytesXmited as DWORD
	dwPortBytesRcved as DWORD
	dwPortFramesXmited as DWORD
	dwPortFramesRcved as DWORD
	dwPortCrcErr as DWORD
	dwPortTimeoutErr as DWORD
	dwPortAlignmentErr as DWORD
	dwPortHardwareOverrunErr as DWORD
	dwPortFramingErr as DWORD
	dwPortBufferOverrunErr as DWORD
	dwPortBytesXmitedUncompressed as DWORD
	dwPortBytesRcvedUncompressed as DWORD
	dwPortBytesXmitedCompressed as DWORD
	dwPortBytesRcvedCompressed as DWORD
end type

type RAS_PORT_STATISTICS as _RAS_PORT_STATISTICS
type PRAS_PORT_STATISTICS as _RAS_PORT_STATISTICS ptr
const RASDOWNLEVEL = 10
const RASADMIN_35 = 35
const RASADMIN_CURRENT = 40

type _RAS_SERVER_0
	TotalPorts as WORD
	PortsInUse as WORD
	RasVersion as DWORD
end type

type RAS_SERVER_0 as _RAS_SERVER_0
type PRAS_SERVER_0 as _RAS_SERVER_0 ptr
declare function RasAdminServerGetInfo(byval lpszServer as const wstring ptr, byval pRasServer0 as PRAS_SERVER_0) as DWORD
declare function RasAdminGetUserAccountServer(byval lpszDomain as const wstring ptr, byval lpszServer as const wstring ptr, byval lpszUserAccountServer as LPWSTR) as DWORD
declare function RasAdminUserGetInfo(byval lpszUserAccountServer as const wstring ptr, byval lpszUser as const wstring ptr, byval pRasUser0 as PRAS_USER_0) as DWORD
declare function RasAdminUserSetInfo(byval lpszUserAccountServer as const wstring ptr, byval lpszUser as const wstring ptr, byval pRasUser0 as const PRAS_USER_0) as DWORD
declare function RasAdminPortEnum(byval lpszServer as const wstring ptr, byval ppRasPort0 as PRAS_PORT_0 ptr, byval pcEntriesRead as WORD ptr) as DWORD
declare function RasAdminPortGetInfo(byval lpszServer as const wstring ptr, byval lpszPort as const wstring ptr, byval pRasPort1 as RAS_PORT_1 ptr, byval pRasStats as RAS_PORT_STATISTICS ptr, byval ppRasParams as RAS_PARAMETERS ptr ptr) as DWORD
declare function RasAdminPortClearStatistics(byval lpszServer as const wstring ptr, byval lpszPort as const wstring ptr) as DWORD
declare function RasAdminPortDisconnect(byval lpszServer as const wstring ptr, byval lpszPort as const wstring ptr) as DWORD
declare function RasAdminFreeBuffer(byval Pointer as PVOID) as DWORD
declare function RasAdminAcceptNewConnection(byval pRasPort1 as RAS_PORT_1 ptr, byval pRasStats as RAS_PORT_STATISTICS ptr, byval pRasParams as RAS_PARAMETERS ptr) as WINBOOL
declare sub RasAdminConnectionHangupNotification(byval pRasPort1 as RAS_PORT_1 ptr, byval pRasStats as RAS_PORT_STATISTICS ptr, byval pRasParams as RAS_PARAMETERS ptr)
declare function RasAdminGetIpAddressForUser(byval lpszUserName as wstring ptr, byval lpszPortName as wstring ptr, byval pipAddress as IPADDR ptr, byval bNotifyRelease as WINBOOL ptr) as DWORD
declare sub RasAdminReleaseIpAddress(byval lpszUserName as wstring ptr, byval lpszPortName as wstring ptr, byval pipAddress as IPADDR ptr)

end extern
