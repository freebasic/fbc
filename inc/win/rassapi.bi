''
''
'' rassapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_rassapi_bi__
#define __win_rassapi_bi__

#inclib "mprapi"

#define RASSAPI_MAX_PHONENUMBER_SIZE 128
#define RASSAPI_MAX_MEDIA_NAME 16
#define RASSAPI_MAX_PORT_NAME 16
#define RASSAPI_MAX_DEVICE_NAME 128
#define RASSAPI_MAX_DEVICETYPE_NAME 16
#define RASSAPI_MAX_PARAM_KEY_SIZE 32
#define RASPRIV_NoCallback &h01
#define RASPRIV_AdminSetCallback &h02
#define RASPRIV_CallerSetCallback &h04
#define RASPRIV_DialinPrivilege &h08
#define RASPRIV_CallbackType (&h02 or &h04 or &h01)
#define RAS_MODEM_OPERATIONAL 1
#define RAS_MODEM_NOT_RESPONDING 2
#define RAS_MODEM_HARDWARE_FAILURE 3
#define RAS_MODEM_INCORRECT_RESPONSE 4
#define RAS_MODEM_UNKNOWN 5
#define RAS_PORT_NON_OPERATIONAL 1
#define RAS_PORT_DISCONNECTED 2
#define RAS_PORT_CALLING_BACK 3
#define RAS_PORT_LISTENING 4
#define RAS_PORT_AUTHENTICATING 5
#define RAS_PORT_AUTHENTICATED 6
#define RAS_PORT_INITIALIZING 7
#define MEDIA_UNKNOWN 0
#define MEDIA_SERIAL 1
#define MEDIA_RAS10_SERIAL 2
#define MEDIA_X25 3
#define MEDIA_ISDN 4
#define USER_AUTHENTICATED &h0001
#define MESSENGER_PRESENT &h0002
#define PPP_CLIENT &h0004
#define GATEWAY_ACTIVE &h0008
#define REMOTE_LISTEN &h0010
#define PORT_MULTILINKED &h0020
#define RAS_IPADDRESSLEN 15
#define RAS_IPXADDRESSLEN 22
#define RAS_ATADDRESSLEN 32
#define RASDOWNLEVEL 10
#define RASADMIN_35 35
#define RASADMIN_CURRENT 40

type IPADDR as ULONG

enum RAS_PARAMS_FORMAT
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

type RAS_USER_0
	bfPrivilege as UBYTE
	szPhoneNumber as wstring * 128+1
end type

type PRAS_USER_0 as RAS_USER_0 ptr

type RAS_PORT_0
	wszPortName as wstring * 16
	wszDeviceType as wstring * 16
	wszDeviceName as wstring * 128
	wszMediaName as wstring * 16
	reserved as DWORD
	Flags as DWORD
	wszUserName as wstring * 256+1
	wszComputer as wstring * 16
	dwStartSessionTime as DWORD
	wszLogonDomain as wstring * 15+1
	fAdvancedServer as BOOL
end type

type PRAS_PORT_0 as RAS_PORT_0 ptr

type RAS_PPP_NBFCP_RESULT
	dwError as DWORD
	dwNetBiosError as DWORD
	szName as zstring * 16+1
	wszWksta as wstring * 16+1
end type

type RAS_PPP_IPCP_RESULT
	dwError as DWORD
	wszAddress as wstring * 15+1
end type

type RAS_PPP_IPXCP_RESULT
	dwError as DWORD
	wszAddress as wstring * 22+1
end type

type RAS_PPP_ATCP_RESULT
	dwError as DWORD
	wszAddress as wstring * 32+1
end type

type RAS_PPP_PROJECTION_RESULT
	nbf as RAS_PPP_NBFCP_RESULT
	ip as RAS_PPP_IPCP_RESULT
	ipx as RAS_PPP_IPXCP_RESULT
	at as RAS_PPP_ATCP_RESULT
end type

type RAS_PORT_1
	rasport0 as RAS_PORT_0
	LineCondition as DWORD
	HardwareCondition as DWORD
	LineSpeed as DWORD
	NumStatistics as WORD
	NumMediaParms as WORD
	SizeMediaParms as DWORD
	ProjResult as RAS_PPP_PROJECTION_RESULT
end type

type PRAS_PORT_1 as RAS_PORT_1 ptr

type RAS_PORT_STATISTICS
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

type PRAS_PORT_STATISTICS as RAS_PORT_STATISTICS ptr

type RAS_SERVER_0
	TotalPorts as WORD
	PortsInUse as WORD
	RasVersion as DWORD
end type

type PRAS_SERVER_0 as RAS_SERVER_0 ptr

declare function RasAdminServerGetInfo alias "RasAdminServerGetInfo" (byval as WCHAR ptr, byval as PRAS_SERVER_0) as DWORD
declare function RasAdminGetUserAccountServer alias "RasAdminGetUserAccountServer" (byval as WCHAR ptr, byval as WCHAR ptr, byval as LPWSTR) as DWORD
declare function RasAdminUserGetInfo alias "RasAdminUserGetInfo" (byval as WCHAR ptr, byval as WCHAR ptr, byval as PRAS_USER_0) as DWORD
declare function RasAdminUserSetInfo alias "RasAdminUserSetInfo" (byval as WCHAR ptr, byval as WCHAR ptr, byval as PRAS_USER_0) as DWORD
declare function RasAdminPortEnum alias "RasAdminPortEnum" (byval as WCHAR ptr, byval as PRAS_PORT_0 ptr, byval as WORD ptr) as DWORD
declare function RasAdminPortGetInfo alias "RasAdminPortGetInfo" (byval as WCHAR ptr, byval as WCHAR ptr, byval as RAS_PORT_1 ptr, byval as RAS_PORT_STATISTICS ptr, byval as RAS_PARAMETERS ptr ptr) as DWORD
declare function RasAdminPortClearStatistics alias "RasAdminPortClearStatistics" (byval as WCHAR ptr, byval as WCHAR ptr) as DWORD
declare function RasAdminPortDisconnect alias "RasAdminPortDisconnect" (byval as WCHAR ptr, byval as WCHAR ptr) as DWORD
declare function RasAdminFreeBuffer alias "RasAdminFreeBuffer" (byval as PVOID) as DWORD
declare function RasAdminGetErrorString alias "RasAdminGetErrorString" (byval as UINT, byval as WCHAR ptr, byval as DWORD) as DWORD
declare function RasAdminAcceptNewConnection alias "RasAdminAcceptNewConnection" (byval as RAS_PORT_1 ptr, byval as RAS_PORT_STATISTICS ptr, byval as RAS_PARAMETERS ptr) as BOOL
declare sub RasAdminConnectionHangupNotification alias "RasAdminConnectionHangupNotification" (byval as RAS_PORT_1 ptr, byval as RAS_PORT_STATISTICS ptr, byval as RAS_PARAMETERS ptr)
declare function RasAdminGetIpAddressForUser alias "RasAdminGetIpAddressForUser" (byval as WCHAR ptr, byval as WCHAR ptr, byval as IPADDR ptr, byval as BOOL ptr) as DWORD
declare sub RasAdminReleaseIpAddress alias "RasAdminReleaseIpAddress" (byval as WCHAR ptr, byval as WCHAR ptr, byval as IPADDR ptr)
declare function RasAdminGetUserParms alias "RasAdminGetUserParms" (byval as WCHAR ptr, byval as PRAS_USER_0) as DWORD
declare function RasAdminSetUserParms alias "RasAdminSetUserParms" (byval as WCHAR ptr, byval as DWORD, byval as PRAS_USER_0) as DWORD

#endif
