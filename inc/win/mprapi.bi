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

#include once "lmcons.bi"
#include once "ras.bi"

extern "Windows"

#define __ROUTING_MPRADMIN_H__
#define RRAS_SERVICE_NAME __TEXT("RemoteAccess")
const PID_IPX = &h0000002B
const PID_IP = &h00000021
const PID_NBF = &h0000003F
const PID_ATALK = &h00000029
const MAX_INTERFACE_NAME_LEN = 256
const MAX_TRANSPORT_NAME_LEN = 40
const MAX_MEDIA_NAME = 16
const MAX_PORT_NAME = 16
const MAX_DEVICE_NAME = 128
const MAX_PHONE_NUMBER_LEN = 128
const MAX_DEVICETYPE_NAME = 16

type _ROUTER_INTERFACE_TYPE as long
enum
	ROUTER_IF_TYPE_CLIENT
	ROUTER_IF_TYPE_HOME_ROUTER
	ROUTER_IF_TYPE_FULL_ROUTER
	ROUTER_IF_TYPE_DEDICATED
	ROUTER_IF_TYPE_INTERNAL
	ROUTER_IF_TYPE_LOOPBACK
	ROUTER_IF_TYPE_TUNNEL1
	ROUTER_IF_TYPE_DIALOUT
end enum

type ROUTER_INTERFACE_TYPE as _ROUTER_INTERFACE_TYPE

type _ROUTER_CONNECTION_STATE as long
enum
	ROUTER_IF_STATE_UNREACHABLE
	ROUTER_IF_STATE_DISCONNECTED
	ROUTER_IF_STATE_CONNECTING
	ROUTER_IF_STATE_CONNECTED
end enum

type ROUTER_CONNECTION_STATE as _ROUTER_CONNECTION_STATE
const MPR_INTERFACE_OUT_OF_RESOURCES = &h00000001
const MPR_INTERFACE_ADMIN_DISABLED = &h00000002
const MPR_INTERFACE_CONNECTION_FAILURE = &h00000004
const MPR_INTERFACE_SERVICE_PAUSED = &h00000008
const MPR_INTERFACE_DIALOUT_HOURS_RESTRICTION = &h00000010
const MPR_INTERFACE_NO_MEDIA_SENSE = &h00000020
const MPR_INTERFACE_NO_DEVICE = &h00000040

type _MPR_INTERFACE_0
	wszInterfaceName as wstring * 256 + 1
	hInterface as HANDLE
	fEnabled as WINBOOL
	dwIfType as ROUTER_INTERFACE_TYPE
	dwConnectionState as ROUTER_CONNECTION_STATE
	fUnReachabilityReasons as DWORD
	dwLastError as DWORD
end type

type MPR_INTERFACE_0 as _MPR_INTERFACE_0
type PMPR_INTERFACE_0 as _MPR_INTERFACE_0 ptr

type _MPR_IPINIP_INTERFACE_0
	wszFriendlyName as wstring * 256 + 1
	Guid as GUID
end type

type MPR_IPINIP_INTERFACE_0 as _MPR_IPINIP_INTERFACE_0
type PMPR_IPINIP_INTERFACE_0 as _MPR_IPINIP_INTERFACE_0 ptr

type _MPR_INTERFACE_1
	wszInterfaceName as wstring * 256 + 1
	hInterface as HANDLE
	fEnabled as WINBOOL
	dwIfType as ROUTER_INTERFACE_TYPE
	dwConnectionState as ROUTER_CONNECTION_STATE
	fUnReachabilityReasons as DWORD
	dwLastError as DWORD
	lpwsDialoutHoursRestriction as LPWSTR
end type

type MPR_INTERFACE_1 as _MPR_INTERFACE_1
type PMPR_INTERFACE_1 as _MPR_INTERFACE_1 ptr
const MPR_MaxDeviceType = RAS_MaxDeviceType
const MPR_MaxPhoneNumber = RAS_MaxPhoneNumber
const MPR_MaxIpAddress = RAS_MaxIpAddress
const MPR_MaxIpxAddress = RAS_MaxIpxAddress
const MPR_MaxEntryName = RAS_MaxEntryName
const MPR_MaxDeviceName = RAS_MaxDeviceName
const MPR_MaxCallbackNumber = RAS_MaxCallbackNumber
const MPR_MaxAreaCode = RAS_MaxAreaCode
const MPR_MaxPadType = RAS_MaxPadType
const MPR_MaxX25Address = RAS_MaxX25Address
const MPR_MaxFacilities = RAS_MaxFacilities
const MPR_MaxUserData = RAS_MaxUserData
const MPRIO_SpecificIpAddr = RASEO_SpecificIpAddr
const MPRIO_SpecificNameServers = RASEO_SpecificNameServers
const MPRIO_IpHeaderCompression = RASEO_IpHeaderCompression
const MPRIO_RemoteDefaultGateway = RASEO_RemoteDefaultGateway
const MPRIO_DisableLcpExtensions = RASEO_DisableLcpExtensions
const MPRIO_SwCompression = RASEO_SwCompression
const MPRIO_RequireEncryptedPw = RASEO_RequireEncryptedPw
const MPRIO_RequireMsEncryptedPw = RASEO_RequireMsEncryptedPw
const MPRIO_RequireDataEncryption = RASEO_RequireDataEncryption
const MPRIO_NetworkLogon = RASEO_NetworkLogon
const MPRIO_PromoteAlternates = RASEO_PromoteAlternates
const MPRIO_SecureLocalFiles = RASEO_SecureLocalFiles
const MPRIO_RequireEAP = RASEO_RequireEAP
const MPRIO_RequirePAP = RASEO_RequirePAP
const MPRIO_RequireSPAP = RASEO_RequireSPAP
const MPRIO_SharedPhoneNumbers = RASEO_SharedPhoneNumbers
const MPRIO_RequireCHAP = RASEO_RequireCHAP
const MPRIO_RequireMsCHAP = RASEO_RequireMsCHAP
const MPRIO_RequireMsCHAP2 = RASEO_RequireMsCHAP2
const MPRIO_IpSecPreSharedKey = &h80000000
const MPRNP_Ipx = RASNP_Ipx
const MPRNP_Ip = RASNP_Ip
#define MPRDT_Modem RASDT_Modem
#define MPRDT_Isdn RASDT_Isdn
#define MPRDT_X25 RASDT_X25
#define MPRDT_Vpn RASDT_Vpn
#define MPRDT_Pad RASDT_Pad
#define MPRDT_Generic RASDT_Generic
#define MPRDT_Serial RASDT_Serial
#define MPRDT_FrameRelay RASDT_FrameRelay
#define MPRDT_Atm RASDT_Atm
#define MPRDT_Sonet RASDT_Sonet
#define MPRDT_SW56 RASDT_SW56
#define MPRDT_Irda RASDT_Irda
#define MPRDT_Parallel RASDT_Parallel
const MPRET_Phone = RASET_Phone
const MPRET_Vpn = RASET_Vpn
const MPRET_Direct = RASET_Direct
const MPRDM_DialFirst = 0
const MPRDM_DialAll = RASEDM_DialAll
const MPRDM_DialAsNeeded = RASEDM_DialAsNeeded
const MPRIDS_Disabled = RASIDS_Disabled
const MPRIDS_UseGlobalValue = RASIDS_UseGlobalValue
const MPR_ET_None = ET_None
const MPR_ET_Require = ET_Require
const MPR_ET_RequireMax = ET_RequireMax
const MPR_ET_Optional = ET_Optional
const MPR_VS_Default = VS_Default
const MPR_VS_PptpOnly = VS_PptpOnly
const MPR_VS_PptpFirst = VS_PptpFirst
const MPR_VS_L2tpOnly = VS_L2tpOnly
const MPR_VS_L2tpFirst = VS_L2tpFirst

type _MPR_INTERFACE_2
	wszInterfaceName as wstring * 256 + 1
	hInterface as HANDLE
	fEnabled as WINBOOL
	dwIfType as ROUTER_INTERFACE_TYPE
	dwConnectionState as ROUTER_CONNECTION_STATE
	fUnReachabilityReasons as DWORD
	dwLastError as DWORD
	dwfOptions as DWORD
	szLocalPhoneNumber as wstring * 128 + 1
	szAlternates as PWCHAR
	ipaddr as DWORD
	ipaddrDns as DWORD
	ipaddrDnsAlt as DWORD
	ipaddrWins as DWORD
	ipaddrWinsAlt as DWORD
	dwfNetProtocols as DWORD
	szDeviceType as wstring * 16 + 1
	szDeviceName as wstring * 128 + 1
	szX25PadType as wstring * 32 + 1
	szX25Address as wstring * 200 + 1
	szX25Facilities as wstring * 200 + 1
	szX25UserData as wstring * 200 + 1
	dwChannels as DWORD
	dwSubEntries as DWORD
	dwDialMode as DWORD
	dwDialExtraPercent as DWORD
	dwDialExtraSampleSeconds as DWORD
	dwHangUpExtraPercent as DWORD
	dwHangUpExtraSampleSeconds as DWORD
	dwIdleDisconnectSeconds as DWORD
	dwType as DWORD
	dwEncryptionType as DWORD
	dwCustomAuthKey as DWORD
	dwCustomAuthDataSize as DWORD
	lpbCustomAuthData as LPBYTE
	guidId as GUID
	dwVpnStrategy as DWORD
end type

type MPR_INTERFACE_2 as _MPR_INTERFACE_2
type PMPR_INTERFACE_2 as _MPR_INTERFACE_2 ptr

#if _WIN32_WINNT >= &h0600
	type _MPR_INTERFACE_3
		wszInterfaceName as wstring * 256 + 1
		hInterface as HANDLE
		fEnabled as WINBOOL
		dwIfType as ROUTER_INTERFACE_TYPE
		dwConnectionState as ROUTER_CONNECTION_STATE
		fUnReachabilityReasons as DWORD
		dwLastError as DWORD
		dwfOptions as DWORD
		szLocalPhoneNumber as wstring * 128 + 1
		szAlternates as PWCHAR
		ipaddr as DWORD
		ipaddrDns as DWORD
		ipaddrDnsAlt as DWORD
		ipaddrWins as DWORD
		ipaddrWinsAlt as DWORD
		dwfNetProtocols as DWORD
		szDeviceType as wstring * 16 + 1
		szDeviceName as wstring * 128 + 1
		szX25PadType as wstring * 32 + 1
		szX25Address as wstring * 200 + 1
		szX25Facilities as wstring * 200 + 1
		szX25UserData as wstring * 200 + 1
		dwChannels as DWORD
		dwSubEntries as DWORD
		dwDialMode as DWORD
		dwDialExtraPercent as DWORD
		dwDialExtraSampleSeconds as DWORD
		dwHangUpExtraPercent as DWORD
		dwHangUpExtraSampleSeconds as DWORD
		dwIdleDisconnectSeconds as DWORD
		dwType as DWORD
		dwEncryptionType as DWORD
		dwCustomAuthKey as DWORD
		dwCustomAuthDataSize as DWORD
		lpbCustomAuthData as LPBYTE
		guidId as GUID
		dwVpnStrategy as DWORD
		AddressCount as ULONG
		ipv6addrDns as IN6_ADDR
		ipv6addrDnsAlt as IN6_ADDR
		ipv6addr as IN6_ADDR ptr
	end type

	type MPR_INTERFACE_3 as _MPR_INTERFACE_3
	type PMPR_INTERFACE_3 as _MPR_INTERFACE_3 ptr
#endif

type _MPR_DEVICE_0
	szDeviceType as wstring * 16 + 1
	szDeviceName as wstring * 128 + 1
end type

type MPR_DEVICE_0 as _MPR_DEVICE_0
type PMPR_DEVICE_0 as _MPR_DEVICE_0 ptr

type _MPR_DEVICE_1
	szDeviceType as wstring * 16 + 1
	szDeviceName as wstring * 128 + 1
	szLocalPhoneNumber as wstring * 128 + 1
	szAlternates as PWCHAR
end type

type MPR_DEVICE_1 as _MPR_DEVICE_1
type PMPR_DEVICE_1 as _MPR_DEVICE_1 ptr

type _MPR_CREDENTIALSEX_0
	dwSize as DWORD
	lpbCredentialsInfo as LPBYTE
end type

type MPR_CREDENTIALSEX_0 as _MPR_CREDENTIALSEX_0
type PMPR_CREDENTIALSEX_0 as _MPR_CREDENTIALSEX_0 ptr

type _MPR_CREDENTIALSEX_1
	dwSize as DWORD
	lpbCredentialsInfo as LPBYTE
end type

type MPR_CREDENTIALSEX_1 as _MPR_CREDENTIALSEX_1
type PMPR_CREDENTIALSEX_1 as _MPR_CREDENTIALSEX_1 ptr

type _MPR_TRANSPORT_0
	dwTransportId as DWORD
	hTransport as HANDLE
	wszTransportName as wstring * 40 + 1
end type

type MPR_TRANSPORT_0 as _MPR_TRANSPORT_0
type PMPR_TRANSPORT_0 as _MPR_TRANSPORT_0 ptr

type _MPR_IFTRANSPORT_0
	dwTransportId as DWORD
	hIfTransport as HANDLE
	wszIfTransportName as wstring * 40 + 1
end type

type MPR_IFTRANSPORT_0 as _MPR_IFTRANSPORT_0
type PMPR_IFTRANSPORT_0 as _MPR_IFTRANSPORT_0 ptr

type _MPR_SERVER_0
	fLanOnlyMode as WINBOOL
	dwUpTime as DWORD
	dwTotalPorts as DWORD
	dwPortsInUse as DWORD
end type

type MPR_SERVER_0 as _MPR_SERVER_0
type PMPR_SERVER_0 as _MPR_SERVER_0 ptr
const MPR_ENABLE_RAS_ON_DEVICE = &h00000001
const MPR_ENABLE_ROUTING_ON_DEVICE = &h00000002

type _MPR_SERVER_1
	dwNumPptpPorts as DWORD
	dwPptpPortFlags as DWORD
	dwNumL2tpPorts as DWORD
	dwL2tpPortFlags as DWORD
end type

type MPR_SERVER_1 as _MPR_SERVER_1
type PMPR_SERVER_1 as _MPR_SERVER_1 ptr

type _RAS_PORT_CONDITION as long
enum
	RAS_PORT_NON_OPERATIONAL
	RAS_PORT_DISCONNECTED
	RAS_PORT_CALLING_BACK
	RAS_PORT_LISTENING
	RAS_PORT_AUTHENTICATING
	RAS_PORT_AUTHENTICATED
	RAS_PORT_INITIALIZING
end enum

type RAS_PORT_CONDITION as _RAS_PORT_CONDITION

type _RAS_HARDWARE_CONDITION as long
enum
	RAS_HARDWARE_OPERATIONAL
	RAS_HARDWARE_FAILURE
end enum

type RAS_HARDWARE_CONDITION as _RAS_HARDWARE_CONDITION

type _RAS_PORT_0
	hPort as HANDLE
	hConnection as HANDLE
	dwPortCondition as RAS_PORT_CONDITION
	dwTotalNumberOfCalls as DWORD
	dwConnectDuration as DWORD
	wszPortName as wstring * 16 + 1
	wszMediaName as wstring * 16 + 1
	wszDeviceName as wstring * 128 + 1
	wszDeviceType as wstring * 16 + 1
end type

type RAS_PORT_0 as _RAS_PORT_0
type PRAS_PORT_0 as _RAS_PORT_0 ptr

type _RAS_PORT_1
	hPort as HANDLE
	hConnection as HANDLE
	dwHardwareCondition as RAS_HARDWARE_CONDITION
	dwLineSpeed as DWORD
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
	dwCompressionRatioIn as DWORD
	dwCompressionRatioOut as DWORD
end type

type RAS_PORT_1 as _RAS_PORT_1
type PRAS_PORT_1 as _RAS_PORT_1 ptr
const IPADDRESSLEN = 15
const IPXADDRESSLEN = 22
const ATADDRESSLEN = 32
const MAXIPADRESSLEN = 64

type _PPP_NBFCP_INFO
	dwError as DWORD
	wszWksta as wstring * 16 + 1
end type

type PPP_NBFCP_INFO as _PPP_NBFCP_INFO

type _PPP_IPCP_INFO
	dwError as DWORD
	wszAddress as wstring * 15 + 1
	wszRemoteAddress as wstring * 15 + 1
end type

type PPP_IPCP_INFO as _PPP_IPCP_INFO
const PPP_IPCP_VJ = &h00000001

type _PPP_IPCP_INFO2
	dwError as DWORD
	wszAddress as wstring * 15 + 1
	wszRemoteAddress as wstring * 15 + 1
	dwOptions as DWORD
	dwRemoteOptions as DWORD
end type

type PPP_IPCP_INFO2 as _PPP_IPCP_INFO2

type _PPP_IPXCP_INFO
	dwError as DWORD
	wszAddress as wstring * 22 + 1
end type

type PPP_IPXCP_INFO as _PPP_IPXCP_INFO

type _PPP_ATCP_INFO
	dwError as DWORD
	wszAddress as wstring * 32 + 1
end type

type PPP_ATCP_INFO as _PPP_ATCP_INFO

type _PPP_INFO
	nbf as PPP_NBFCP_INFO
	ip as PPP_IPCP_INFO
	ipx as PPP_IPXCP_INFO
	at as PPP_ATCP_INFO
end type

type PPP_INFO as _PPP_INFO
const RASCCPCA_MPPC = &h00000006
const RASCCPCA_STAC = &h00000005
const PPP_CCP_COMPRESSION = &h00000001
const PPP_CCP_ENCRYPTION40BITOLD = &h00000010
const PPP_CCP_ENCRYPTION40BIT = &h00000020
const PPP_CCP_ENCRYPTION128BIT = &h00000040
const PPP_CCP_ENCRYPTION56BIT = &h00000080
const PPP_CCP_HISTORYLESS = &h01000000

type _PPP_CCP_INFO
	dwError as DWORD
	dwCompressionAlgorithm as DWORD
	dwOptions as DWORD
	dwRemoteCompressionAlgorithm as DWORD
	dwRemoteOptions as DWORD
end type

type PPP_CCP_INFO as _PPP_CCP_INFO
const PPP_LCP_PAP = &hC023
const PPP_LCP_SPAP = &hC027
const PPP_LCP_CHAP = &hC223
const PPP_LCP_EAP = &hC227
const PPP_LCP_CHAP_MD5 = &h05
const PPP_LCP_CHAP_MS = &h80
const PPP_LCP_CHAP_MSV2 = &h81
const PPP_LCP_MULTILINK_FRAMING = &h00000001
const PPP_LCP_PFC = &h00000002
const PPP_LCP_ACFC = &h00000004
const PPP_LCP_SSHF = &h00000008
const PPP_LCP_DES_56 = &h00000010
const PPP_LCP_3_DES = &h00000020

type _PPP_LCP_INFO
	dwError as DWORD
	dwAuthenticationProtocol as DWORD
	dwAuthenticationData as DWORD
	dwRemoteAuthenticationProtocol as DWORD
	dwRemoteAuthenticationData as DWORD
	dwTerminateReason as DWORD
	dwRemoteTerminateReason as DWORD
	dwOptions as DWORD
	dwRemoteOptions as DWORD
	dwEapTypeId as DWORD
	dwRemoteEapTypeId as DWORD
end type

type PPP_LCP_INFO as _PPP_LCP_INFO

type _PPP_INFO_2
	nbf as PPP_NBFCP_INFO
	ip as PPP_IPCP_INFO2
	ipx as PPP_IPXCP_INFO
	at as PPP_ATCP_INFO
	ccp as PPP_CCP_INFO
	lcp as PPP_LCP_INFO
end type

type PPP_INFO_2 as _PPP_INFO_2
const RAS_FLAGS_PPP_CONNECTION = &h00000001
const RAS_FLAGS_MESSENGER_PRESENT = &h00000002
const RAS_FLAGS_QUARANTINE_PRESENT = &h00000008

type _RAS_CONNECTION_0
	hConnection as HANDLE
	hInterface as HANDLE
	dwConnectDuration as DWORD
	dwInterfaceType as ROUTER_INTERFACE_TYPE
	dwConnectionFlags as DWORD
	wszInterfaceName as wstring * 256 + 1
	wszUserName as wstring * 256 + 1
	wszLogonDomain as wstring * 15 + 1
	wszRemoteComputer as wstring * 16 + 1
end type

type RAS_CONNECTION_0 as _RAS_CONNECTION_0
type PRAS_CONNECTION_0 as _RAS_CONNECTION_0 ptr

type _RAS_CONNECTION_1
	hConnection as HANDLE
	hInterface as HANDLE
	PppInfo as PPP_INFO
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
	dwCompressionRatioIn as DWORD
	dwCompressionRatioOut as DWORD
end type

type RAS_CONNECTION_1 as _RAS_CONNECTION_1
type PRAS_CONNECTION_1 as _RAS_CONNECTION_1 ptr

type _RAS_CONNECTION_2
	hConnection as HANDLE
	wszUserName as wstring * 256 + 1
	dwInterfaceType as ROUTER_INTERFACE_TYPE
	guid as GUID
	PppInfo2 as PPP_INFO_2
end type

type RAS_CONNECTION_2 as _RAS_CONNECTION_2
type PRAS_CONNECTION_2 as _RAS_CONNECTION_2 ptr
const RASPRIV_NoCallback = &h01
const RASPRIV_AdminSetCallback = &h02
const RASPRIV_CallerSetCallback = &h04
const RASPRIV_DialinPrivilege = &h08
const RASPRIV2_DialinPolicy = &h1
#define RASPRIV_CallbackType ((RASPRIV_AdminSetCallback or RASPRIV_CallerSetCallback) or RASPRIV_NoCallback)

type _RAS_USER_0
	bfPrivilege as UBYTE
	wszPhoneNumber as wstring * 128 + 1
end type

type RAS_USER_0 as _RAS_USER_0
type PRAS_USER_0 as _RAS_USER_0 ptr

type _RAS_USER_1
	bfPrivilege as UBYTE
	wszPhoneNumber as wstring * 128 + 1
	bfPrivilege2 as UBYTE
end type

type RAS_USER_1 as _RAS_USER_1
type PRAS_USER_1 as _RAS_USER_1 ptr
type RAS_SERVER_HANDLE as HANDLE
type MPR_SERVER_HANDLE as HANDLE
type MIB_SERVER_HANDLE as HANDLE

declare function MprAdminConnectionEnum(byval hRasServer as RAS_SERVER_HANDLE, byval dwLevel as DWORD, byval lplpbBuffer as LPBYTE ptr, byval dwPrefMaxLen as DWORD, byval lpdwEntriesRead as LPDWORD, byval lpdwTotalEntries as LPDWORD, byval lpdwResumeHandle as LPDWORD) as DWORD
declare function MprAdminPortEnum(byval hRasServer as RAS_SERVER_HANDLE, byval dwLevel as DWORD, byval hConnection as HANDLE, byval lplpbBuffer as LPBYTE ptr, byval dwPrefMaxLen as DWORD, byval lpdwEntriesRead as LPDWORD, byval lpdwTotalEntries as LPDWORD, byval lpdwResumeHandle as LPDWORD) as DWORD
declare function MprAdminConnectionGetInfo(byval hRasServer as RAS_SERVER_HANDLE, byval dwLevel as DWORD, byval hConnection as HANDLE, byval lplpbBuffer as LPBYTE ptr) as DWORD
declare function MprAdminPortGetInfo(byval hRasServer as RAS_SERVER_HANDLE, byval dwLevel as DWORD, byval hPort as HANDLE, byval lplpbBuffer as LPBYTE ptr) as DWORD
declare function MprAdminConnectionClearStats(byval hRasServer as RAS_SERVER_HANDLE, byval hConnection as HANDLE) as DWORD
declare function MprAdminPortClearStats(byval hRasServer as RAS_SERVER_HANDLE, byval hPort as HANDLE) as DWORD
declare function MprAdminPortReset(byval hRasServer as RAS_SERVER_HANDLE, byval hPort as HANDLE) as DWORD
declare function MprAdminPortDisconnect(byval hRasServer as RAS_SERVER_HANDLE, byval hPort as HANDLE) as DWORD
declare function MprAdminAcceptNewConnection(byval pRasConnection0 as RAS_CONNECTION_0 ptr, byval pRasConnection1 as RAS_CONNECTION_1 ptr) as WINBOOL
declare function MprAdminAcceptNewConnection2(byval pRasConnection0 as RAS_CONNECTION_0 ptr, byval pRasConnection1 as RAS_CONNECTION_1 ptr, byval pRasConnection2 as RAS_CONNECTION_2 ptr) as WINBOOL
declare function MprAdminAcceptNewLink(byval pRasPort0 as RAS_PORT_0 ptr, byval pRasPort1 as RAS_PORT_1 ptr) as WINBOOL
declare sub MprAdminConnectionHangupNotification(byval pRasConnection0 as RAS_CONNECTION_0 ptr, byval pRasConnection1 as RAS_CONNECTION_1 ptr)
declare sub MprAdminConnectionHangupNotification2(byval pRasConnection0 as RAS_CONNECTION_0 ptr, byval pRasConnection1 as RAS_CONNECTION_1 ptr, byval pRasConnection2 as RAS_CONNECTION_2 ptr)
declare function MprAdminConnectionRemoveQuarantine(byval hRasServer as HANDLE, byval hRasConnection as HANDLE, byval fIsIpAddress as WINBOOL) as DWORD
declare sub MprAdminLinkHangupNotification(byval pRasPort0 as RAS_PORT_0 ptr, byval pRasPort1 as RAS_PORT_1 ptr)
declare function MprAdminGetIpAddressForUser(byval lpwszUserName as wstring ptr, byval lpwszPortName as wstring ptr, byval lpdwIpAddress as DWORD ptr, byval bNotifyRelease as WINBOOL ptr) as DWORD
declare sub MprAdminReleaseIpAddress(byval lpszUserName as wstring ptr, byval lpszPortName as wstring ptr, byval lpdwIpAddress as DWORD ptr)
declare function MprAdminInitializeDll() as DWORD
declare function MprAdminTerminateDll() as DWORD
declare function MprAdminUserGetInfo(byval lpszServer as const wstring ptr, byval lpszUser as const wstring ptr, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE) as DWORD
declare function MprAdminUserSetInfo(byval lpszServer as const wstring ptr, byval lpszUser as const wstring ptr, byval dwLevel as DWORD, byval lpbBuffer as const LPBYTE) as DWORD
declare function MprAdminSendUserMessage(byval hMprServer as MPR_SERVER_HANDLE, byval hConnection as HANDLE, byval lpwszMessage as LPWSTR) as DWORD
declare function MprAdminGetPDCServer(byval lpszDomain as const wstring ptr, byval lpszServer as const wstring ptr, byval lpszPDCServer as LPWSTR) as DWORD
declare function MprAdminIsServiceRunning(byval lpwsServerName as LPWSTR) as WINBOOL
declare function MprAdminServerConnect(byval lpwsServerName as LPWSTR, byval phMprServer as MPR_SERVER_HANDLE ptr) as DWORD
declare sub MprAdminServerDisconnect(byval hMprServer as MPR_SERVER_HANDLE)
declare function MprAdminServerGetCredentials(byval hMprServer as MPR_SERVER_HANDLE, byval dwLevel as DWORD, byval lplpbBuffer as LPBYTE ptr) as DWORD
declare function MprAdminServerSetCredentials(byval hMprServer as MPR_SERVER_HANDLE, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE) as DWORD
declare function MprAdminBufferFree(byval pBuffer as LPVOID) as DWORD
declare function MprAdminGetErrorString(byval dwError as DWORD, byval lpwsErrorString as LPWSTR ptr) as DWORD
declare function MprAdminServerGetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval dwLevel as DWORD, byval lplpbBuffer as LPBYTE ptr) as DWORD
declare function MprAdminServerSetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE) as DWORD
declare function MprAdminEstablishDomainRasServer(byval pszDomain as PWCHAR, byval pszMachine as PWCHAR, byval bEnable as WINBOOL) as DWORD
declare function MprAdminIsDomainRasServer(byval pszDomain as PWCHAR, byval pszMachine as PWCHAR, byval pbIsRasServer as PBOOL) as DWORD
declare function MprAdminTransportCreate(byval hMprServer as MPR_SERVER_HANDLE, byval dwTransportId as DWORD, byval lpwsTransportName as LPWSTR, byval pGlobalInfo as LPBYTE, byval dwGlobalInfoSize as DWORD, byval pClientInterfaceInfo as LPBYTE, byval dwClientInterfaceInfoSize as DWORD, byval lpwsDLLPath as LPWSTR) as DWORD
declare function MprAdminTransportSetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval dwTransportId as DWORD, byval pGlobalInfo as LPBYTE, byval dwGlobalInfoSize as DWORD, byval pClientInterfaceInfo as LPBYTE, byval dwClientInterfaceInfoSize as DWORD) as DWORD
declare function MprAdminTransportGetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval dwTransportId as DWORD, byval ppGlobalInfo as LPBYTE ptr, byval lpdwGlobalInfoSize as LPDWORD, byval ppClientInterfaceInfo as LPBYTE ptr, byval lpdwClientInterfaceInfoSize as LPDWORD) as DWORD
declare function MprAdminDeviceEnum(byval hMprServer as MPR_SERVER_HANDLE, byval dwLevel as DWORD, byval lplpbBuffer as LPBYTE ptr, byval lpdwTotalEntries as LPDWORD) as DWORD
declare function MprAdminInterfaceGetHandle(byval hMprServer as MPR_SERVER_HANDLE, byval lpwsInterfaceName as LPWSTR, byval phInterface as HANDLE ptr, byval fIncludeClientInterfaces as WINBOOL) as DWORD
declare function MprAdminInterfaceCreate(byval hMprServer as MPR_SERVER_HANDLE, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE, byval phInterface as HANDLE ptr) as DWORD
declare function MprAdminInterfaceGetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwLevel as DWORD, byval lplpbBuffer as LPBYTE ptr) as DWORD
declare function MprAdminInterfaceSetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE) as DWORD
declare function MprAdminInterfaceDelete(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE) as DWORD
declare function MprAdminInterfaceDeviceGetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwIndex as DWORD, byval dwLevel as DWORD, byval lplpBuffer as LPBYTE ptr) as DWORD
declare function MprAdminInterfaceDeviceSetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwIndex as DWORD, byval dwLevel as DWORD, byval lplpBuffer as LPBYTE) as DWORD
declare function MprAdminInterfaceTransportRemove(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwTransportId as DWORD) as DWORD
declare function MprAdminInterfaceTransportAdd(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwTransportId as DWORD, byval pInterfaceInfo as LPBYTE, byval dwInterfaceInfoSize as DWORD) as DWORD
declare function MprAdminInterfaceTransportGetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwTransportId as DWORD, byval ppInterfaceInfo as LPBYTE ptr, byval lpdwpInterfaceInfoSize as LPDWORD) as DWORD
declare function MprAdminInterfaceTransportSetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwTransportId as DWORD, byval pInterfaceInfo as LPBYTE, byval dwInterfaceInfoSize as DWORD) as DWORD
declare function MprAdminInterfaceEnum(byval hMprServer as MPR_SERVER_HANDLE, byval dwLevel as DWORD, byval lplpbBuffer as LPBYTE ptr, byval dwPrefMaxLen as DWORD, byval lpdwEntriesRead as LPDWORD, byval lpdwTotalEntries as LPDWORD, byval lpdwResumeHandle as LPDWORD) as DWORD
declare function MprSetupIpInIpInterfaceFriendlyNameEnum(byval pwszMachineName as PWCHAR, byval lplpBuffer as LPBYTE ptr, byval lpdwEntriesRead as LPDWORD) as DWORD
declare function MprSetupIpInIpInterfaceFriendlyNameFree(byval lpBuffer as LPVOID) as DWORD
declare function MprSetupIpInIpInterfaceFriendlyNameCreate(byval pwszMachineName as PWCHAR, byval pNameInformation as PMPR_IPINIP_INTERFACE_0) as DWORD
declare function MprSetupIpInIpInterfaceFriendlyNameDelete(byval pwszMachineName as PWCHAR, byval pGuid as GUID ptr) as DWORD
declare function MprAdminInterfaceSetCredentials(byval lpwsServer as LPWSTR, byval lpwsInterfaceName as LPWSTR, byval lpwsUserName as LPWSTR, byval lpwsDomainName as LPWSTR, byval lpwsPassword as LPWSTR) as DWORD
declare function MprAdminInterfaceGetCredentials(byval lpwsServer as LPWSTR, byval lpwsInterfaceName as LPWSTR, byval lpwsUserName as LPWSTR, byval lpwsPassword as LPWSTR, byval lpwsDomainName as LPWSTR) as DWORD
declare function MprAdminInterfaceSetCredentialsEx(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE) as DWORD
declare function MprAdminInterfaceGetCredentialsEx(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwLevel as DWORD, byval lplpbBuffer as LPBYTE ptr) as DWORD
declare function MprAdminInterfaceConnect(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval hEvent as HANDLE, byval fSynchronous as WINBOOL) as DWORD
declare function MprAdminInterfaceDisconnect(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE) as DWORD
declare function MprAdminInterfaceUpdateRoutes(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwProtocolId as DWORD, byval hEvent as HANDLE) as DWORD
declare function MprAdminInterfaceQueryUpdateResult(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE, byval dwProtocolId as DWORD, byval lpdwUpdateResult as LPDWORD) as DWORD
declare function MprAdminInterfaceUpdatePhonebookInfo(byval hMprServer as MPR_SERVER_HANDLE, byval hInterface as HANDLE) as DWORD
declare function MprAdminRegisterConnectionNotification(byval hMprServer as MPR_SERVER_HANDLE, byval hEventNotification as HANDLE) as DWORD
declare function MprAdminDeregisterConnectionNotification(byval hMprServer as MPR_SERVER_HANDLE, byval hEventNotification as HANDLE) as DWORD
declare function MprAdminMIBServerConnect(byval lpwsServerName as LPWSTR, byval phMibServer as MIB_SERVER_HANDLE ptr) as DWORD
declare sub MprAdminMIBServerDisconnect(byval hMibServer as MIB_SERVER_HANDLE)
declare function MprAdminMIBEntryCreate(byval hMibServer as MIB_SERVER_HANDLE, byval dwPid as DWORD, byval dwRoutingPid as DWORD, byval lpEntry as LPVOID, byval dwEntrySize as DWORD) as DWORD
declare function MprAdminMIBEntryDelete(byval hMibServer as MIB_SERVER_HANDLE, byval dwProtocolId as DWORD, byval dwRoutingPid as DWORD, byval lpEntry as LPVOID, byval dwEntrySize as DWORD) as DWORD
declare function MprAdminMIBEntrySet(byval hMibServer as MIB_SERVER_HANDLE, byval dwProtocolId as DWORD, byval dwRoutingPid as DWORD, byval lpEntry as LPVOID, byval dwEntrySize as DWORD) as DWORD
declare function MprAdminMIBEntryGet(byval hMibServer as MIB_SERVER_HANDLE, byval dwProtocolId as DWORD, byval dwRoutingPid as DWORD, byval lpInEntry as LPVOID, byval dwInEntrySize as DWORD, byval lplpOutEntry as LPVOID ptr, byval lpOutEntrySize as LPDWORD) as DWORD
declare function MprAdminMIBEntryGetFirst(byval hMibServer as MIB_SERVER_HANDLE, byval dwProtocolId as DWORD, byval dwRoutingPid as DWORD, byval lpInEntry as LPVOID, byval dwInEntrySize as DWORD, byval lplpOutEntry as LPVOID ptr, byval lpOutEntrySize as LPDWORD) as DWORD
declare function MprAdminMIBEntryGetNext(byval hMibServer as MIB_SERVER_HANDLE, byval dwProtocolId as DWORD, byval dwRoutingPid as DWORD, byval lpInEntry as LPVOID, byval dwInEntrySize as DWORD, byval lplpOutEntry as LPVOID ptr, byval lpOutEntrySize as LPDWORD) as DWORD
declare function MprAdminMIBGetTrapInfo(byval hMibServer as MIB_SERVER_HANDLE, byval dwProtocolId as DWORD, byval dwRoutingPid as DWORD, byval lpInData as LPVOID, byval dwInDataSize as DWORD, byval lplpOutData as LPVOID ptr, byval lpOutDataSize as LPDWORD) as DWORD
declare function MprAdminMIBSetTrapInfo(byval dwProtocolId as DWORD, byval dwRoutingPid as DWORD, byval hEvent as HANDLE, byval lpInData as LPVOID, byval dwInDataSize as DWORD, byval lplpOutData as LPVOID ptr, byval lpOutDataSize as LPDWORD) as DWORD
declare function MprAdminMIBBufferFree(byval pBuffer as LPVOID) as DWORD
declare function MprConfigServerInstall(byval dwLevel as DWORD, byval pBuffer as PVOID) as DWORD
declare function MprConfigServerConnect(byval lpwsServerName as LPWSTR, byval phMprConfig as HANDLE ptr) as DWORD
declare sub MprConfigServerDisconnect(byval hMprConfig as HANDLE)
declare function MprConfigServerRefresh(byval hMprConfig as HANDLE) as DWORD
declare function MprConfigBufferFree(byval pBuffer as LPVOID) as DWORD
declare function MprConfigServerGetInfo(byval hMprConfig as HANDLE, byval dwLevel as DWORD, byval lplpbBuffer as LPBYTE ptr) as DWORD
declare function MprConfigServerSetInfo(byval hMprServer as MPR_SERVER_HANDLE, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE) as DWORD
declare function MprConfigServerBackup(byval hMprConfig as HANDLE, byval lpwsPath as LPWSTR) as DWORD
declare function MprConfigServerRestore(byval hMprConfig as HANDLE, byval lpwsPath as LPWSTR) as DWORD
declare function MprConfigTransportCreate(byval hMprConfig as HANDLE, byval dwTransportId as DWORD, byval lpwsTransportName as LPWSTR, byval pGlobalInfo as LPBYTE, byval dwGlobalInfoSize as DWORD, byval pClientInterfaceInfo as LPBYTE, byval dwClientInterfaceInfoSize as DWORD, byval lpwsDLLPath as LPWSTR, byval phRouterTransport as HANDLE ptr) as DWORD
declare function MprConfigTransportDelete(byval hMprConfig as HANDLE, byval hRouterTransport as HANDLE) as DWORD
declare function MprConfigTransportGetHandle(byval hMprConfig as HANDLE, byval dwTransportId as DWORD, byval phRouterTransport as HANDLE ptr) as DWORD
declare function MprConfigTransportSetInfo(byval hMprConfig as HANDLE, byval hRouterTransport as HANDLE, byval pGlobalInfo as LPBYTE, byval dwGlobalInfoSize as DWORD, byval pClientInterfaceInfo as LPBYTE, byval dwClientInterfaceInfoSize as DWORD, byval lpwsDLLPath as LPWSTR) as DWORD
declare function MprConfigTransportGetInfo(byval hMprConfig as HANDLE, byval hRouterTransport as HANDLE, byval ppGlobalInfo as LPBYTE ptr, byval lpdwGlobalInfoSize as LPDWORD, byval ppClientInterfaceInfo as LPBYTE ptr, byval lpdwClientInterfaceInfoSize as LPDWORD, byval lplpwsDLLPath as LPWSTR ptr) as DWORD
declare function MprConfigTransportEnum(byval hMprConfig as HANDLE, byval dwLevel as DWORD, byval lplpBuffer as LPBYTE ptr, byval dwPrefMaxLen as DWORD, byval lpdwEntriesRead as LPDWORD, byval lpdwTotalEntries as LPDWORD, byval lpdwResumeHandle as LPDWORD) as DWORD
declare function MprConfigInterfaceCreate(byval hMprConfig as HANDLE, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE, byval phRouterInterface as HANDLE ptr) as DWORD
declare function MprConfigInterfaceDelete(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE) as DWORD
declare function MprConfigInterfaceGetHandle(byval hMprConfig as HANDLE, byval lpwsInterfaceName as LPWSTR, byval phRouterInterface as HANDLE ptr) as DWORD
declare function MprConfigInterfaceGetInfo(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE, byval dwLevel as DWORD, byval lplpBuffer as LPBYTE ptr, byval lpdwBufferSize as LPDWORD) as DWORD
declare function MprConfigInterfaceSetInfo(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE, byval dwLevel as DWORD, byval lpbBuffer as LPBYTE) as DWORD
declare function MprConfigInterfaceEnum(byval hMprConfig as HANDLE, byval dwLevel as DWORD, byval lplpBuffer as LPBYTE ptr, byval dwPrefMaxLen as DWORD, byval lpdwEntriesRead as LPDWORD, byval lpdwTotalEntries as LPDWORD, byval lpdwResumeHandle as LPDWORD) as DWORD
declare function MprConfigInterfaceTransportAdd(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE, byval dwTransportId as DWORD, byval lpwsTransportName as LPWSTR, byval pInterfaceInfo as LPBYTE, byval dwInterfaceInfoSize as DWORD, byval phRouterIfTransport as HANDLE ptr) as DWORD
declare function MprConfigInterfaceTransportRemove(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE, byval hRouterIfTransport as HANDLE) as DWORD
declare function MprConfigInterfaceTransportGetHandle(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE, byval dwTransportId as DWORD, byval phRouterIfTransport as HANDLE ptr) as DWORD
declare function MprConfigInterfaceTransportGetInfo(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE, byval hRouterIfTransport as HANDLE, byval ppInterfaceInfo as LPBYTE ptr, byval lpdwInterfaceInfoSize as LPDWORD) as DWORD
declare function MprConfigInterfaceTransportSetInfo(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE, byval hRouterIfTransport as HANDLE, byval pInterfaceInfo as LPBYTE, byval dwInterfaceInfoSize as DWORD) as DWORD
declare function MprConfigInterfaceTransportEnum(byval hMprConfig as HANDLE, byval hRouterInterface as HANDLE, byval dwLevel as DWORD, byval lplpBuffer as LPBYTE ptr, byval dwPrefMaxLen as DWORD, byval lpdwEntriesRead as LPDWORD, byval lpdwTotalEntries as LPDWORD, byval lpdwResumeHandle as LPDWORD) as DWORD
declare function MprConfigGetFriendlyName(byval hMprConfig as HANDLE, byval pszGuidName as PWCHAR, byval pszBuffer as PWCHAR, byval dwBufferSize as DWORD) as DWORD
declare function MprConfigGetGuidName(byval hMprConfig as HANDLE, byval pszFriendlyName as PWCHAR, byval pszBuffer as PWCHAR, byval dwBufferSize as DWORD) as DWORD
declare function MprInfoCreate(byval dwVersion as DWORD, byval lplpNewHeader as LPVOID ptr) as DWORD
declare function MprInfoDelete(byval lpHeader as LPVOID) as DWORD
declare function MprInfoRemoveAll(byval lpHeader as LPVOID, byval lplpNewHeader as LPVOID ptr) as DWORD
declare function MprInfoDuplicate(byval lpHeader as LPVOID, byval lplpNewHeader as LPVOID ptr) as DWORD
declare function MprInfoBlockAdd(byval lpHeader as LPVOID, byval dwInfoType as DWORD, byval dwItemSize as DWORD, byval dwItemCount as DWORD, byval lpItemData as LPBYTE, byval lplpNewHeader as LPVOID ptr) as DWORD
declare function MprInfoBlockRemove(byval lpHeader as LPVOID, byval dwInfoType as DWORD, byval lplpNewHeader as LPVOID ptr) as DWORD
declare function MprInfoBlockSet(byval lpHeader as LPVOID, byval dwInfoType as DWORD, byval dwItemSize as DWORD, byval dwItemCount as DWORD, byval lpItemData as LPBYTE, byval lplpNewHeader as LPVOID ptr) as DWORD
declare function MprInfoBlockFind(byval lpHeader as LPVOID, byval dwInfoType as DWORD, byval lpdwItemSize as LPDWORD, byval lpdwItemCount as LPDWORD, byval lplpItemData as LPBYTE ptr) as DWORD
declare function MprInfoBlockQuerySize(byval lpHeader as LPVOID) as DWORD
#define MprInfoBlockExists(h, t) (MprInfoBlockFind((h), (t), NULL, NULL, NULL) = NO_ERROR)

#if _WIN32_WINNT >= &h0600
	type _RAS_QUARANTINE_STATE as long
	enum
		RAS_QUAR_STATE_NORMAL
		RAS_QUAR_STATE_QUARANTINE
		RAS_QUAR_STATE_PROBATION
		RAS_QUAR_STATE_NOT_CAPABLE
	end enum

	type RAS_QUARANTINE_STATE as _RAS_QUARANTINE_STATE

	type _MPR_FILTER_0
		fEnabled as WINBOOL
	end type

	type MPR_FILTER_0 as _MPR_FILTER_0
	type PMPR_FILTER_0 as _MPR_FILTER_0 ptr

	type _MPR_SERVER_2
		dwNumPptpPorts as DWORD
		dwPptpPortFlags as DWORD
		dwNumL2tpPorts as DWORD
		dwL2tpPortFlags as DWORD
		dwNumSstpPorts as DWORD
		dwSstpPortFlags as DWORD
	end type

	type MPR_SERVER_2 as _MPR_SERVER_2
	type PMPR_SERVER_2 as _MPR_SERVER_2 ptr

	type _PPP_IPV6CP_INFO
		dwVersion as DWORD
		dwSize as DWORD
		dwError as DWORD
		bInterfaceIdentifier(0 to 7) as UBYTE
		bRemoteInterfaceIdentifier(0 to 7) as UBYTE
		dwOptions as DWORD
		dwRemoteOptions as DWORD
		bPrefix(0 to 7) as UBYTE
		dwPrefixLength as DWORD
	end type

	type PPP_IPV6_CP_INFO as _PPP_IPV6CP_INFO
	type PPPP_IPV6_CP_INFO as _PPP_IPV6CP_INFO ptr

	type _PPP_INFO_3
		nbf as PPP_NBFCP_INFO
		ip as PPP_IPCP_INFO2
		ipv6 as PPP_IPV6_CP_INFO
		ccp as PPP_CCP_INFO
		lcp as PPP_LCP_INFO
	end type

	type PPP_INFO_3 as _PPP_INFO_3

	type _RAS_CONNECTION_3
		dwVersion as DWORD
		dwSize as DWORD
		hConnection as HANDLE
		wszUserName as wstring * 256 + 1
		dwInterfaceType as ROUTER_INTERFACE_TYPE
		guid as GUID
		PppInfo3 as PPP_INFO_3
		rasQuarState as RAS_QUARANTINE_STATE
		timer as FILETIME
	end type

	type RAS_CONNECTION_3 as _RAS_CONNECTION_3
	type PRAS_CONNECTION_3 as _RAS_CONNECTION_3 ptr
	declare function MprAdminAcceptNewConnection3(byval pRasConnection0 as RAS_CONNECTION_0 ptr, byval pRasConnection1 as RAS_CONNECTION_1 ptr, byval pRasConnection2 as RAS_CONNECTION_2 ptr, byval pRasConnection3 as RAS_CONNECTION_3 ptr) as WINBOOL
	declare function MprAdminAcceptReauthentication(byval pRasConnection0 as RAS_CONNECTION_0 ptr, byval pRasConnection1 as RAS_CONNECTION_1 ptr, byval pRasConnection2 as RAS_CONNECTION_2 ptr, byval pRasConnection3 as RAS_CONNECTION_3 ptr) as WINBOOL
	declare sub MprAdminConnectionHangupNotification3(byval pRasConnection0 as RAS_CONNECTION_0 ptr, byval pRasConnection1 as RAS_CONNECTION_1 ptr, byval pRasConnection2 as RAS_CONNECTION_2 ptr, byval pRasConnection3 as RAS_CONNECTION_3 ptr)
	declare function MprAdminGetIpv6AddressForUser(byval lpwszUserName as wstring ptr, byval lpwszPortName as wstring ptr, byval lpdwIpv6Address as IN6_ADDR ptr, byval bNotifyRelease as WINBOOL ptr) as DWORD
	declare function MprAdminReleaseIpv6AddressForUser(byval lpwszUserName as wstring ptr, byval lpwszPortName as wstring ptr, byval lpdwIpv6Address as IN6_ADDR ptr) as DWORD
	declare function MprConfigFilterGetInfo(byval hMprConfig as HANDLE, byval dwLevel as DWORD, byval dwTransportId as DWORD, byval lpBuffer as LPBYTE) as DWORD
	declare function MprConfigFilterSetInfo(byval hMprConfig as HANDLE, byval dwLevel as DWORD, byval dwTransportId as DWORD, byval lpBuffer as LPBYTE) as DWORD
#endif

#if _WIN32_WINNT >= &h0601
	const MPRAPI_RAS_CONNECTION_OBJECT_REVISION_1 = &h01
	const MPRAPI_MPR_SERVER_OBJECT_REVISION_1 = &h01
	const MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_1 = &h01

	type MPRAPI_OBJECT_TYPE as long
	enum
		MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT = &h1
		MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT = &h2
		MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT = &h3
		MPRAPI_OBJECT_TYPE_AUTH_VALIDATION_OBJECT = &h4
		MPRAPI_OBJECT_TYPE_UPDATE_CONNECTION_OBJECT = &h5
	end enum

	type _MPRAPI_OBJECT_HEADER
		revision as UCHAR
		as UCHAR type
		size as USHORT
	end type

	type MPRAPI_OBJECT_HEADER as _MPRAPI_OBJECT_HEADER
	type PMPRAPI_OBJECT_HEADER as _MPRAPI_OBJECT_HEADER ptr

	type _AUTH_VALIDATION_EX
		Header as MPRAPI_OBJECT_HEADER
		hRasConnection as HANDLE
		wszUserName as wstring * 256 + 1
		wszLogonDomain as wstring * 15 + 1
		AuthInfoSize as DWORD
		AuthInfo(0 to 0) as UBYTE
	end type

	type AUTH_VALIDATION_EX as _AUTH_VALIDATION_EX
	type PAUTH_VALIDATION_EX as _AUTH_VALIDATION_EX ptr
	const RAS_FLAGS_PPP_CONNECTION = &h00000001
	const RAS_FLAGS_MESSENGER_PRESENT = &h00000002
	const RAS_FLAGS_QUARANTINE_PRESENT = &h00000008
	const RAS_FLAGS_ARAP_CONNECTION = &h00000010
	const RAS_FLAGS_IKEV2_CONNECTION = &h00000010
	const RAS_FLAGS_DORMANT = &h00000020
	const IPADDRESSLEN = 15

	type _PPP_PROJECTION_INFO
		dwIPv4NegotiationError as DWORD
		wszAddress as wstring * 15 + 1
		wszRemoteAddress as wstring * 15 + 1
		dwIPv4Options as DWORD
		dwIPv4RemoteOptions as DWORD
		IPv4SubInterfaceIndex as ULONG64
		dwIPv6NegotiationError as DWORD
		bInterfaceIdentifier(0 to 7) as UBYTE
		bRemoteInterfaceIdentifier(0 to 7) as UBYTE
		bPrefix(0 to 7) as UBYTE
		dwPrefixLength as DWORD
		IPv6SubInterfaceIndex as ULONG64
		dwLcpError as DWORD
		dwAuthenticationProtocol as DWORD
		dwAuthenticationData as DWORD
		dwRemoteAuthenticationProtocol as DWORD
		dwRemoteAuthenticationData as DWORD
		dwLcpTerminateReason as DWORD
		dwLcpRemoteTerminateReason as DWORD
		dwLcpOptions as DWORD
		dwLcpRemoteOptions as DWORD
		dwEapTypeId as DWORD
		dwRemoteEapTypeId as DWORD
		dwCcpError as DWORD
		dwCompressionAlgorithm as DWORD
		dwCcpOptions as DWORD
		dwRemoteCompressionAlgorithm as DWORD
		dwCcpRemoteOptions as DWORD
	end type

	type PPP_PROJECTION_INFO as _PPP_PROJECTION_INFO
	type PPPP_PROJECTION_INFO as _PPP_PROJECTION_INFO ptr

	type _IKEV2_PROJECTION_INFO
		dwIPv4NegotiationError as DWORD
		wszAddress as wstring * 15 + 1
		wszRemoteAddress as wstring * 15 + 1
		IPv4SubInterfaceIndex as ULONG64
		dwIPv6NegotiationError as DWORD
		bInterfaceIdentifier(0 to 7) as UBYTE
		bRemoteInterfaceIdentifier(0 to 7) as UBYTE
		bPrefix(0 to 7) as UBYTE
		dwPrefixLength as DWORD
		IPv6SubInterfaceIndex as ULONG64
		dwOptions as DWORD
		dwAuthenticationProtocol as DWORD
		dwEapTypeId as DWORD
		dwCompressionAlgorithm as DWORD
		dwEncryptionMethod as DWORD
	end type

	type IKEV2_PROJECTION_INFO as _IKEV2_PROJECTION_INFO
	type PIKEV2_PROJECTION_INFO as _IKEV2_PROJECTION_INFO ptr

	type _PROJECTION_INFO
		projectionInfoType as UCHAR

		union
			Ikev2ProjectionInfo as IKEV2_PROJECTION_INFO
			PppProjectionInfo as PPP_PROJECTION_INFO
		end union
	end type

	type PROJECTION_INFO as _PROJECTION_INFO
	type PPROJECTION_INFO as _PROJECTION_INFO ptr

	type _RAS_CONNECTION_EX
		Header as MPRAPI_OBJECT_HEADER
		dwConnectDuration as DWORD
		dwInterfaceType as ROUTER_INTERFACE_TYPE
		dwConnectionFlags as DWORD
		wszInterfaceName as wstring * 256 + 1
		wszUserName as wstring * 256 + 1
		wszLogonDomain as wstring * 15 + 1
		wszRemoteComputer as wstring * 16 + 1
		guid as GUID
		rasQuarState as RAS_QUARANTINE_STATE
		probationTime as FILETIME
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
		dwCompressionRatioIn as DWORD
		dwCompressionRatioOut as DWORD
		dwNumSwitchOvers as DWORD
		wszRemoteEndpointAddress as wstring * 64 + 1
		wszLocalEndpointAddress as wstring * 64 + 1
		ProjectionInfo as PROJECTION_INFO
		hConnection as HANDLE
		hInterface as HANDLE
	end type

	type RAS_CONNECTION_EX as _RAS_CONNECTION_EX
	type PRAS_CONNECTION_EX as _RAS_CONNECTION_EX ptr

	type _RAS_UPDATE_CONNECTION
		Header as MPRAPI_OBJECT_HEADER
		dwIfIndex as DWORD
		wszLocalEndpointAddress as wstring * 64 + 1
		wszRemoteEndpointAddress as wstring * 64 + 1
	end type

	type RAS_UPDATE_CONNECTION as _RAS_UPDATE_CONNECTION
	type PRAS_UPDATE_CONNECTION as _RAS_UPDATE_CONNECTION ptr
	const MPRAPI_IKEV2_SET_TUNNEL_CONFIG_PARAMS = &h01

	type _IKEV2_TUNNEL_CONFIG_PARAMS
		dwIdleTimeout as DWORD
		dwNetworkBlackoutTime as DWORD
		dwSaLifeTime as DWORD
		dwSaDataSizeForRenegotiation as DWORD
		dwConfigOptions as DWORD
		dwTotalCertificates as DWORD
		certificateNames as CERT_NAME_BLOB ptr
	end type

	type IKEV2_TUNNEL_CONFIG_PARAMS as _IKEV2_TUNNEL_CONFIG_PARAMS
	type PIKEV2_TUNNEL_CONFIG_PARAMS as _IKEV2_TUNNEL_CONFIG_PARAMS ptr

	type _IKEV2_CONFIG_PARAMS
		dwNumPorts as DWORD
		dwPortFlags as DWORD
		dwTunnelConfigParamFlags as DWORD
		TunnelConfigParams as IKEV2_TUNNEL_CONFIG_PARAMS
	end type

	type IKEV2_CONFIG_PARAMS as _IKEV2_CONFIG_PARAMS
	type PIKEV2_CONFIG_PARAMS as _IKEV2_CONFIG_PARAMS ptr

	type _PPTP_CONFIG_PARAMS
		dwNumPorts as DWORD
		dwPortFlags as DWORD
	end type

	type PPTP_CONFIG_PARAMS as _PPTP_CONFIG_PARAMS
	type PPPTP_CONFIG_PARAMS as _PPTP_CONFIG_PARAMS ptr

	type _L2TP_CONFIG_PARAMS
		dwNumPorts as DWORD
		dwPortFlags as DWORD
	end type

	type L2TP_CONFIG_PARAMS as _L2TP_CONFIG_PARAMS
	type PL2TP_CONFIG_PARAMS as _L2TP_CONFIG_PARAMS ptr

	type _SSTP_CERT_INFO
		isDefault as BOOL
		certBlob as CRYPT_HASH_BLOB
	end type

	type SSTP_CERT_INFO as _SSTP_CERT_INFO
	type PSSTP_CERT_INFO as _SSTP_CERT_INFO ptr

	type _SSTP_CONFIG_PARAMS
		dwNumPorts as DWORD
		dwPortFlags as DWORD
		isUseHttps as BOOL
		certAlgorithm as DWORD
		sstpCertDetails as SSTP_CERT_INFO
	end type

	type SSTP_CONFIG_PARAMS as _SSTP_CONFIG_PARAMS
	type PSSTP_CONFIG_PARAMS as _SSTP_CONFIG_PARAMS ptr

	type _MPRAPI_TUNNEL_CONFIG_PARAMS
		IkeConfigParams as IKEV2_CONFIG_PARAMS
		PptpConfigParams as PPTP_CONFIG_PARAMS
		L2tpConfigParams as L2TP_CONFIG_PARAMS
		SstpConfigParams as SSTP_CONFIG_PARAMS
	end type

	type MPRAPI_TUNNEL_CONFIG_PARAMS as _MPRAPI_TUNNEL_CONFIG_PARAMS
	type PMPRAPI_TUNNEL_CONFIG_PARAMS as _MPRAPI_TUNNEL_CONFIG_PARAMS ptr

	type _MPR_SERVER_SET_CONFIG_EX
		Header as MPRAPI_OBJECT_HEADER
		setConfigForProtocols as DWORD
		ConfigParams as MPRAPI_TUNNEL_CONFIG_PARAMS
	end type

	type MPR_SERVER_SET_CONFIG_EX as _MPR_SERVER_SET_CONFIG_EX
	type PMPR_SERVER_SET_CONFIG_EX as _MPR_SERVER_SET_CONFIG_EX ptr

	type _MPR_SERVER_EX
		Header as MPRAPI_OBJECT_HEADER
		fLanOnlyMode as DWORD
		dwUpTime as DWORD
		dwTotalPorts as DWORD
		dwPortsInUse as DWORD
		Reserved as DWORD
		ConfigParams as MPRAPI_TUNNEL_CONFIG_PARAMS
	end type

	type MPR_SERVER_EX as _MPR_SERVER_EX
	type PMPR_SERVER_EX as _MPR_SERVER_EX ptr
	type PMPRADMINGETIPADDRESSFORUSER as function(byval as wstring ptr, byval as wstring ptr, byval as DWORD ptr, byval as WINBOOL ptr) as DWORD
	type PMPRADMINRELEASEIPADRESS as sub(byval as wstring ptr, byval as wstring ptr, byval as DWORD ptr)
	type PMPRADMINGETIPV6ADDRESSFORUSER as function(byval as wstring ptr, byval as wstring ptr, byval as IN6_ADDR ptr, byval as WINBOOL ptr) as DWORD
	type PMPRADMINRELEASEIPV6ADDRESSFORUSER as sub(byval as wstring ptr, byval as wstring ptr, byval as IN6_ADDR ptr)
	type PMPRADMINACCEPTNEWLINK as function(byval as RAS_PORT_0 ptr, byval as RAS_PORT_1 ptr) as WINBOOL
	type PMPRADMINLINKHANGUPNOTIFICATION as sub(byval as RAS_PORT_0 ptr, byval as RAS_PORT_1 ptr)
	type PMPRADMINTERMINATEDLL as function() as DWORD
	type PMPRADMINACCEPTNEWCONNECTIONEX as function(byval as RAS_CONNECTION_EX ptr) as BOOL
	type PMPRADMINACCEPTREAUTHENTICATIONEX as function(byval as RAS_CONNECTION_EX ptr) as BOOL
	type PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX as sub(byval as RAS_CONNECTION_EX ptr)

	type _MPRAPI_ADMIN_DLL_CALLBACKS
		revision as UCHAR
		lpfnMprAdminGetIpAddressForUser as PMPRADMINGETIPADDRESSFORUSER
		lpfnMprAdminReleaseIpAddress as PMPRADMINRELEASEIPADRESS
		lpfnMprAdminGetIpv6AddressForUser as PMPRADMINGETIPV6ADDRESSFORUSER
		lpfnMprAdminReleaseIpV6AddressForUser as PMPRADMINRELEASEIPV6ADDRESSFORUSER
		lpfnRasAdminAcceptNewLink as PMPRADMINACCEPTNEWLINK
		lpfnRasAdminLinkHangupNotification as PMPRADMINLINKHANGUPNOTIFICATION
		lpfnRasAdminTerminateDll as PMPRADMINTERMINATEDLL
		lpfnRasAdminAcceptNewConnectionEx as PMPRADMINACCEPTNEWCONNECTIONEX
		lpfnRasAdminAcceptReauthenticationEx as PMPRADMINACCEPTREAUTHENTICATIONEX
		lpfnRasAdminConnectionHangupNotificationEx as PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX
	end type

	type MPRAPI_ADMIN_DLL_CALLBACKS as _MPRAPI_ADMIN_DLL_CALLBACKS
	type PMPRAPI_ADMIN_DLL_CALLBACKS as _MPRAPI_ADMIN_DLL_CALLBACKS ptr
	declare function MprConfigServerSetInfoEx(byval hMprConfig as HANDLE, byval pSetServerConfig as MPR_SERVER_SET_CONFIG_EX ptr) as DWORD
	declare function MprConfigServerGetInfoEx(byval hMprConfig as HANDLE, byval pServerInfo as MPR_SERVER_EX ptr) as DWORD
	declare function MprAdminConnectionEnumEx(byval hRasServer as RAS_SERVER_HANDLE, byval pObjectHeader as PMPRAPI_OBJECT_HEADER, byval dwPreferedMaxLen as DWORD, byval lpdwEntriesRead as LPDWORD, byval lpdwTotalEntries as LPDWORD, byval ppRasConn as PRAS_CONNECTION_EX ptr, byval lpdwResumeHandle as LPDWORD) as DWORD
	declare function MprAdminConnectionGetInfoEx(byval hRasServer as RAS_SERVER_HANDLE, byval hConnection as HANDLE, byval pRasConnection as PRAS_CONNECTION_EX) as DWORD
	declare function MprAdminInitializeDllEx(byval pAdminCallbacks as PMPRAPI_ADMIN_DLL_CALLBACKS) as DWORD
	declare function MprAdminIsServiceInitialized(byval lpwsServerName as LPWSTR, byval fIsServiceInitialized as WINBOOL ptr) as DWORD
	declare function MprAdminServerGetInfoEx(byval hMprServer as MPR_SERVER_HANDLE, byval pServerInfo as MPR_SERVER_EX ptr) as DWORD
	declare function MprAdminServerSetInfoEx(byval hMprServer as MPR_SERVER_HANDLE, byval pServerInfo as MPR_SERVER_SET_CONFIG_EX ptr) as DWORD
#endif

end extern
