''
''
'' ras -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ras_bi__
#define __win_ras_bi__

#inclib "rasapi32"

#define RAS_MaxDeviceType 16
#define RAS_MaxPhoneNumber 128
#define RAS_MaxIpAddress 15
#define RAS_MaxIpxAddress 21
#define RAS_MaxEntryName 256
#define RAS_MaxDeviceName 128
#define RAS_MaxCallbackNumber 128
#define RAS_MaxAreaCode 10
#define RAS_MaxPadType 32
#define RAS_MaxX25Address 200
#define RAS_MaxFacilities 200
#define RAS_MaxUserData 200
#define RAS_MaxReplyMessage 1024
#define RDEOPT_UsePrefixSuffix &h00000001
#define RDEOPT_PausedStates &h00000002
#define RDEOPT_IgnoreModemSpeaker &h00000004
#define RDEOPT_SetModemSpeaker &h00000008
#define RDEOPT_IgnoreSoftwareCompression &h00000010
#define RDEOPT_SetSoftwareCompression &h00000020
#define RDEOPT_DisableConnectedUI &h00000040
#define RDEOPT_DisableReconnectUI &h00000080
#define RDEOPT_DisableReconnect &h00000100
#define RDEOPT_NoUser &h00000200
#define RDEOPT_PauseOnScript &h00000400
#define RDEOPT_Router &h00000800
#define REN_User &h00000000
#define REN_AllUsers &h00000001
#define VS_Default 0
#define VS_PptpOnly 1
#define VS_PptpFirst 2
#define VS_L2tpOnly 3
#define VS_L2tpFirst 4
#define RASDIALEVENT "RasDialEvent"
#define WM_RASDIALEVENT &hCCCD
#define RASEO_UseCountryAndAreaCodes &h00000001
#define RASEO_SpecificIpAddr &h00000002
#define RASEO_SpecificNameServers &h00000004
#define RASEO_IpHeaderCompression &h00000008
#define RASEO_RemoteDefaultGateway &h00000010
#define RASEO_DisableLcpExtensions &h00000020
#define RASEO_TerminalBeforeDial &h00000040
#define RASEO_TerminalAfterDial &h00000080
#define RASEO_ModemLights &h00000100
#define RASEO_SwCompression &h00000200
#define RASEO_RequireEncryptedPw &h00000400
#define RASEO_RequireMsEncryptedPw &h00000800
#define RASEO_RequireDataEncryption &h00001000
#define RASEO_NetworkLogon &h00002000
#define RASEO_UseLogonCredentials &h00004000
#define RASEO_PromoteAlternates &h00008000
#define RASNP_NetBEUI &h00000001
#define RASNP_Ipx &h00000002
#define RASNP_Ip &h00000004
#define RASFP_Ppp &h00000001
#define RASFP_Slip &h00000002
#define RASFP_Ras &h00000004
#define RASDT_Modem "modem"
#define RASDT_Isdn "isdn"
#define RASDT_X25 "x25"
#define RASDT_Vpn "vpn"
#define RASDT_Pad "pad"
#define RASDT_Generic "GENERIC"
#define RASDT_Serial "SERIAL"
#define RASDT_FrameRelay "FRAMERELAY"
#define RASDT_Atm "ATM"
#define RASDT_Sonet "SONET"
#define RASDT_SW56 "SW56"
#define RASDT_Irda "IRDA"
#define RASDT_Parallel "PARALLEL"
#define RASET_Phone 1
#define RASET_Vpn 2
#define RASET_Direct 3
#define RASET_Internet 4
#define RASCS_PAUSED &h1000
#define RASCS_DONE &h2000

enum RASCONNSTATE
	RASCS_OpenPort = 0
	RASCS_PortOpened
	RASCS_ConnectDevice
	RASCS_DeviceConnected
	RASCS_AllDevicesConnected
	RASCS_Authenticate
	RASCS_AuthNotify
	RASCS_AuthRetry
	RASCS_AuthCallback
	RASCS_AuthChangePassword
	RASCS_AuthProject
	RASCS_AuthLinkSpeed
	RASCS_AuthAck
	RASCS_ReAuthenticate
	RASCS_Authenticated
	RASCS_PrepareForCallback
	RASCS_WaitForModemReset
	RASCS_WaitForCallback
	RASCS_Projected
	RASCS_StartAuthentication
	RASCS_CallbackComplete
	RASCS_LogonNetwork
	RASCS_SubEntryConnected
	RASCS_SubEntryDisconnected
	RASCS_Interactive = &h1000
	RASCS_RetryAuthentication
	RASCS_CallbackSetByCaller
	RASCS_PasswordExpired
	RASCS_Connected = &h2000
	RASCS_Disconnected
end enum

type LPRASCONNSTATE as RASCONNSTATE

enum RASPROJECTION
	RASP_Amb = &h10000
	RASP_PppNbf = &h803F
	RASP_PppIpx = &h802B
	RASP_PppIp = &h8021
	RASP_PppLcp = &hC021
	RASP_Slip = &h20000
end enum

type LPRASPROJECTION as RASPROJECTION

type HRASCONN__
	i as integer
end type

type HRASCONN as HRASCONN__ ptr
type LPHRASCONN as HRASCONN ptr

#ifdef UNICODE
type RASCONNW
	dwSize as DWORD
	hrasconn as HRASCONN
	szEntryName as wstring *256+1
	szDeviceType as wstring *16+1
	szDeviceName as wstring *128+1
end type

type LPRASCONNW as RASCONNW ptr

#else
type RASCONNA
	dwSize as DWORD
	hrasconn as HRASCONN
	szEntryName as zstring * 256+1
	szDeviceType as zstring * 16+1
	szDeviceName as zstring * 128+1
end type

type LPRASCONNA as RASCONNA ptr
#endif

#ifdef UNICODE
type RASCONNSTATUSW
	dwSize as DWORD
	rasconnstate as RASCONNSTATE
	dwError as DWORD
	szDeviceType as wstring *16+1
	szDeviceName as wstring *128+1
end type

type LPRASCONNSTATUSW as RASCONNSTATUSW ptr

#else
type RASCONNSTATUSA
	dwSize as DWORD
	rasconnstate as RASCONNSTATE
	dwError as DWORD
	szDeviceType as zstring * 16+1
	szDeviceName as zstring * 128+1
end type

type LPRASCONNSTATUSA as RASCONNSTATUSA ptr
#endif

#ifdef UNICODE
type RASDIALPARAMSW
	dwSize as DWORD
	szEntryName as wstring *256+1
	szPhoneNumber as wstring *128+1
	szCallbackNumber as wstring *128+1
	szUserName as wstring *256+1
	szPassword as wstring *256+1
	szDomain as wstring *15+1
end type

type LPRASDIALPARAMSW as RASDIALPARAMSW ptr

#else
type RASDIALPARAMSA
	dwSize as DWORD
	szEntryName as zstring * 256+1
	szPhoneNumber as zstring * 128+1
	szCallbackNumber as zstring * 128+1
	szUserName as zstring * 256+1
	szPassword as zstring * 256+1
	szDomain as zstring * 15+1
end type

type LPRASDIALPARAMSA as RASDIALPARAMSA ptr
#endif

type RASDIALEXTENSIONS
	dwSize as DWORD
	dwfOptions as DWORD
	hwndParent as HWND
	reserved as ULONG_PTR
end type

type LPRASDIALEXTENSIONS as RASDIALEXTENSIONS ptr

#ifdef UNICODE
type RASENTRYNAMEW
	dwSize as DWORD
	szEntryName as wstring *256+1
end type

type LPRASENTRYNAMEW as RASENTRYNAMEW ptr

#else
type RASENTRYNAMEA
	dwSize as DWORD
	szEntryName as zstring * 256+1
end type

type LPRASENTRYNAMEA as RASENTRYNAMEA ptr
#endif

#ifdef UNICODE
type RASAMBW
	dwSize as DWORD
	dwError as DWORD
	szNetBiosError as wstring *16+1
	bLana as UBYTE
end type

type LPRASAMBW as RASAMBW ptr

#else
type RASAMBA
	dwSize as DWORD
	dwError as DWORD
	szNetBiosError as zstring * 16+1
	bLana as UBYTE
end type

type LPRASAMBA as RASAMBA ptr
#endif

#ifdef UNICODE
type RASPPPNBFW
	dwSize as DWORD
	dwError as DWORD
	dwNetBiosError as DWORD
	szNetBiosError as wstring *16+1
	szWorkstationName as wstring *16+1
	bLana as UBYTE
end type

type LPRASPPPNBFW as RASPPPNBFW ptr

#else
type RASPPPNBFA
	dwSize as DWORD
	dwError as DWORD
	dwNetBiosError as DWORD
	szNetBiosError as zstring * 16+1
	szWorkstationName as zstring * 16+1
	bLana as UBYTE
end type

type LPRASPPPNBFA as RASPPPNBFA ptr
#endif

#ifdef UNICODE
type RASIPXW
	dwSize as DWORD
	dwError as DWORD
	szIpxAddress as wstring *21+1
end type

type LPRASPPPIPXW as RASIPXW ptr

#else
type RASIPXA
	dwSize as DWORD
	dwError as DWORD
	szIpxAddress as zstring * 21+1
end type

type LPRASPPPIPXA as RASIPXA ptr
#endif

#ifdef UNICODE
type RASPPPIPW
	dwSize as DWORD
	dwError as DWORD
	szIpAddress as wstring *15+1
	szServerIpAddress as wstring *15+1
end type

type LPRASPPPIPW as RASPPPIPW ptr

#else
type RASPPPIPA
	dwSize as DWORD
	dwError as DWORD
	szIpAddress as zstring * 15+1
	szServerIpAddress as zstring * 15+1
end type

type LPRASPPPIPA as RASPPPIPA ptr
#endif

#ifdef UNICODE
type RASPPPLCPW
	dwSize as DWORD
	fBundled as BOOL
end type

type LPRASPPPLCPW as RASPPPLCPW ptr

#else
type RASPPPLCPA
	dwSize as DWORD
	fBundled as BOOL
end type

type LPRASPPPLCPA as RASPPPLCPA ptr
#endif

#ifdef UNICODE
type RASSLIPW
	dwSize as DWORD
	dwError as DWORD
	szIpAddress as wstring *15+1
end type

type LPRASSLIPW as RASSLIPW ptr

#else
type RASSLIPA
	dwSize as DWORD
	dwError as DWORD
	szIpAddress as zstring * 15+1
end type

type LPRASSLIPA as RASSLIPA ptr
#endif

#ifdef UNICODE
type RASDEVINFOW
	dwSize as DWORD
	szDeviceType as wstring *16+1
	szDeviceName as wstring *128+1
end type

type LPRASDEVINFOW as RASDEVINFOW ptr

#else
type RASDEVINFOA
	dwSize as DWORD
	szDeviceType as zstring * 16+1
	szDeviceName as zstring * 128+1
end type

type LPRASDEVINFOA as RASDEVINFOA ptr
#endif

type RASCTRYINFO
	dwSize as DWORD
	dwCountryID as DWORD
	dwNextCountryID as DWORD
	dwCountryCode as DWORD
	dwCountryNameOffset as DWORD
end type

type LPRASCTRYINFO as RASCTRYINFO ptr

#ifdef UNICODE
type RASCTRYINFOW as RASCTRYINFO
type LPRASCTRYINFOW as RASCTRYINFO ptr
#else
type RASCTRYINFOA as RASCTRYINFO
type LPRASCTRYINFOA as RASCTRYINFO ptr
#endif

type RASIPADDR
	a as UBYTE
	b as UBYTE
	c as UBYTE
	d as UBYTE
end type

#ifdef UNICODE
type RASENTRYW
	dwSize as DWORD
	dwfOptions as DWORD
	dwCountryID as DWORD
	dwCountryCode as DWORD
	szAreaCode as wstring *10+1
	szLocalPhoneNumber as wstring *128+1
	dwAlternateOffset as DWORD
	ipaddr as RASIPADDR
	ipaddrDns as RASIPADDR
	ipaddrDnsAlt as RASIPADDR
	ipaddrWins as RASIPADDR
	ipaddrWinsAlt as RASIPADDR
	dwFrameSize as DWORD
	dwfNetProtocols as DWORD
	dwFramingProtocol as DWORD
	szScript as wstring *260
	szAutodialDll as wstring *260
	szAutodialFunc as wstring *260
	szDeviceType as wstring *16+1
	szDeviceName as wstring *128+1
	szX25PadType as wstring *32+1
	szX25Address as wstring *200+1
	szX25Facilities as wstring *200+1
	szX25UserData as wstring *200+1
	dwChannels as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type LPRASENTRYW as RASENTRYW ptr

#else
type RASENTRYA
	dwSize as DWORD
	dwfOptions as DWORD
	dwCountryID as DWORD
	dwCountryCode as DWORD
	szAreaCode as zstring * 10+1
	szLocalPhoneNumber as zstring * 128+1
	dwAlternateOffset as DWORD
	ipaddr as RASIPADDR
	ipaddrDns as RASIPADDR
	ipaddrDnsAlt as RASIPADDR
	ipaddrWins as RASIPADDR
	ipaddrWinsAlt as RASIPADDR
	dwFrameSize as DWORD
	dwfNetProtocols as DWORD
	dwFramingProtocol as DWORD
	szScript as zstring * 260
	szAutodialDll as zstring * 260
	szAutodialFunc as zstring * 260
	szDeviceType as zstring * 16+1
	szDeviceName as zstring * 128+1
	szX25PadType as zstring * 32+1
	szX25Address as zstring * 200+1
	szX25Facilities as zstring * 200+1
	szX25UserData as zstring * 200+1
	dwChannels as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type LPRASENTRYA as RASENTRYA ptr
#endif

#ifdef UNICODE
type RASCONN as RASCONNW
type LPRASCONN as RASCONNW ptr
type RASENTRY as RASENTRYW
type LPRASENTRY as RASENTRYW ptr
type RASCONNSTATUS as RASCONNSTATUSW
type LPRASCONNSTATUS as RASCONNSTATUSW ptr
type RASDIALPARAMS as RASDIALPARAMSW
type LPRASDIALPARAMS as RASDIALPARAMSW ptr
type RASAMB as RASAMBW
type LPRASAM as RASAMBW ptr
type RASPPPNBF as RASPPPNBFW
type LPRASPPPNBF as RASPPPNBFW ptr
type RASPPPIPX as RASPPPIPXW
type LPRASPPPIPX as RASPPPIPXW ptr
type RASPPPIP as RASPPPIPW
type LPRASPPPIP as RASPPPIPW ptr
type RASPPPLCP as RASPPPLCPW
type LPRASPPPLCP as RASPPPLCPW ptr
type RASSLIP as RASSLIPW
type LPRASSLIP as RASSLIPW ptr
type RASDEVINFO as RASDEVINFOW
type LPRASDEVINFO as RASDEVINFOW ptr
type RASENTRYNAME as RASENTRYNAMEW
type LPRASENTRYNAME as RASENTRYNAMEW ptr
#else
type RASCONN as RASCONNA
type LPRASCONN as RASCONNA ptr
type RASENTRY as RASENTRYA
type LPRASENTRY as RASENTRYA ptr
type RASCONNSTATUS as RASCONNSTATUSA
type LPRASCONNSTATUS as RASCONNSTATUSA ptr
type RASDIALPARAMS as RASDIALPARAMSA
type LPRASDIALPARAMS as RASDIALPARAMSA ptr
type RASAMB as RASAMBA
type LPRASAM as RASAMBA ptr
type RASPPPNBF as RASPPPNBFA
type LPRASPPPNBF as RASPPPNBFA ptr
type RASPPPIPX as RASPPPIPXA
type LPRASPPPIPX as RASPPPIPXA ptr
type RASPPPIP as RASPPPIPA
type LPRASPPPIP as RASPPPIPA ptr
type RASPPPLCP as RASPPPLCPA
type LPRASPPPLCP as RASPPPLCPA ptr
type RASSLIP as RASSLIPA
type LPRASSLIP as RASSLIPA ptr
type RASDEVINFO as RASDEVINFOA
type LPRASDEVINFO as RASDEVINFOA ptr
type RASENTRYNAME as RASENTRYNAMEA
type LPRASENTRYNAME as RASENTRYNAMEA ptr
#endif

type RAS_STATS
	dwSize as DWORD
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
	dwBps as DWORD
	dwConnectDuration as DWORD
end type

type ORASADFUNC as function(byval as HWND, byval as LPSTR, byval as DWORD, byval as LPDWORD) as BOOL
type RASDIALFUNC as sub(byval as UINT, byval as RASCONNSTATE, byval as DWORD)
type RASDIALFUNC1 as sub(byval as HRASCONN, byval as UINT, byval as RASCONNSTATE, byval as DWORD, byval as DWORD)
type RASDIALFUNC2 as function(byval as ULONG_PTR, byval as DWORD, byval as HRASCONN, byval as UINT, byval as RASCONNSTATE, byval as DWORD, byval as DWORD) as DWORD

type RasCustomHangUpFn as function cdecl(byval as HRASCONN) as DWORD
type RasCustomDeleteEntryNotifyFn as function cdecl(byval as LPCTSTR, byval as LPCTSTR, byval as DWORD) as DWORD
type RasCustomDialFn as function cdecl(byval as HINSTANCE, byval as LPRASDIALEXTENSIONS, byval as LPCTSTR, byval as LPRASDIALPARAMS, byval as DWORD, byval as LPVOID, byval as LPHRASCONN, byval as DWORD) as DWORD

declare function RasGetLinkStatistics alias "RasGetLinkStatistics" (byval as HRASCONN, byval as DWORD, byval as RAS_STATS ptr) as DWORD
declare function RasGetConnectionStatistics alias "RasGetConnectionStatistics" (byval as HRASCONN, byval as RAS_STATS ptr) as DWORD
declare function RasClearLinkStatistics alias "RasClearLinkStatistics" (byval as HRASCONN, byval as DWORD) as DWORD
declare function RasClearConnectionStatistics alias "RasClearConnectionStatistics" (byval as HRASCONN) as DWORD

#ifdef UNICODE
declare function RasDial alias "RasDialW" (byval as LPRASDIALEXTENSIONS, byval as LPCWSTR, byval as LPRASDIALPARAMSW, byval as DWORD, byval as LPVOID, byval as LPHRASCONN) as DWORD
declare function RasEnumConnections alias "RasEnumConnectionsW" (byval as LPRASCONNW, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function RasEnumEntries alias "RasEnumEntriesW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPRASENTRYNAMEW, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function RasGetConnectStatus alias "RasGetConnectStatusW" (byval as HRASCONN, byval as LPRASCONNSTATUSW) as DWORD
declare function RasGetErrorString alias "RasGetErrorStringW" (byval as UINT, byval as LPWSTR, byval as DWORD) as DWORD
declare function RasHangUp alias "RasHangUpW" (byval as HRASCONN) as DWORD
declare function RasGetProjectionInfo alias "RasGetProjectionInfoW" (byval as HRASCONN, byval as RASPROJECTION, byval as LPVOID, byval as LPDWORD) as DWORD
declare function RasCreatePhonebookEntry alias "RasCreatePhonebookEntryW" (byval as HWND, byval as LPCWSTR) as DWORD
declare function RasEditPhonebookEntry alias "RasEditPhonebookEntryW" (byval as HWND, byval as LPCWSTR, byval as LPCWSTR) as DWORD
declare function RasSetEntryDialParams alias "RasSetEntryDialParamsW" (byval as LPCWSTR, byval as LPRASDIALPARAMSW, byval as BOOL) as DWORD
declare function RasGetEntryDialParams alias "RasGetEntryDialParamsW" (byval as LPCWSTR, byval as LPRASDIALPARAMSW, byval as LPBOOL) as DWORD
declare function RasEnumDevices alias "RasEnumDevicesW" (byval as LPRASDEVINFOW, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function RasGetCountryInfo alias "RasGetCountryInfoW" (byval as LPRASCTRYINFOW, byval as LPDWORD) as DWORD
declare function RasGetEntryProperties alias "RasGetEntryPropertiesW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPRASENTRYW, byval as LPDWORD, byval as LPBYTE, byval as LPDWORD) as DWORD
declare function RasSetEntryProperties alias "RasSetEntryPropertiesW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPRASENTRYW, byval as DWORD, byval as LPBYTE, byval as DWORD) as DWORD
declare function RasRenameEntry alias "RasRenameEntryW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as DWORD
declare function RasDeleteEntry alias "RasDeleteEntryW" (byval as LPCWSTR, byval as LPCWSTR) as DWORD
declare function RasValidateEntryName alias "RasValidateEntryNameW" (byval as LPCWSTR, byval as LPCWSTR) as DWORD

#else
declare function RasDial alias "RasDialA" (byval as LPRASDIALEXTENSIONS, byval as LPCSTR, byval as LPRASDIALPARAMSA, byval as DWORD, byval as LPVOID, byval as LPHRASCONN) as DWORD
declare function RasEnumConnections alias "RasEnumConnectionsA" (byval as LPRASCONNA, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function RasEnumEntries alias "RasEnumEntriesA" (byval as LPCSTR, byval as LPCSTR, byval as LPRASENTRYNAMEA, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function RasGetConnectStatus alias "RasGetConnectStatusA" (byval as HRASCONN, byval as LPRASCONNSTATUSA) as DWORD
declare function RasGetErrorString alias "RasGetErrorStringA" (byval as UINT, byval as LPSTR, byval as DWORD) as DWORD
declare function RasHangUp alias "RasHangUpA" (byval as HRASCONN) as DWORD
declare function RasGetProjectionInfo alias "RasGetProjectionInfoA" (byval as HRASCONN, byval as RASPROJECTION, byval as LPVOID, byval as LPDWORD) as DWORD
declare function RasCreatePhonebookEntry alias "RasCreatePhonebookEntryA" (byval as HWND, byval as LPCSTR) as DWORD
declare function RasEditPhonebookEntry alias "RasEditPhonebookEntryA" (byval as HWND, byval as LPCSTR, byval as LPCSTR) as DWORD
declare function RasSetEntryDialParams alias "RasSetEntryDialParamsA" (byval as LPCSTR, byval as LPRASDIALPARAMSA, byval as BOOL) as DWORD
declare function RasGetEntryDialParams alias "RasGetEntryDialParamsA" (byval as LPCSTR, byval as LPRASDIALPARAMSA, byval as LPBOOL) as DWORD
declare function RasEnumDevices alias "RasEnumDevicesA" (byval as LPRASDEVINFOA, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function RasGetCountryInfo alias "RasGetCountryInfoA" (byval as LPRASCTRYINFOA, byval as LPDWORD) as DWORD
declare function RasGetEntryProperties alias "RasGetEntryPropertiesA" (byval as LPCSTR, byval as LPCSTR, byval as LPRASENTRYA, byval as LPDWORD, byval as LPBYTE, byval as LPDWORD) as DWORD
declare function RasSetEntryProperties alias "RasSetEntryPropertiesA" (byval as LPCSTR, byval as LPCSTR, byval as LPRASENTRYA, byval as DWORD, byval as LPBYTE, byval as DWORD) as DWORD
declare function RasRenameEntry alias "RasRenameEntryA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as DWORD
declare function RasDeleteEntry alias "RasDeleteEntryA" (byval as LPCSTR, byval as LPCSTR) as DWORD
declare function RasValidateEntryName alias "RasValidateEntryNameA" (byval as LPCSTR, byval as LPCSTR) as DWORD
#endif

#endif
