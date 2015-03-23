#pragma once

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"

extern "Windows"

#define _WINNETWK_
#define _WNNC_
#define WNNC_NET_MSNET &h00010000
#define WNNC_NET_LANMAN WNNC_NET_SMB
#define WNNC_NET_SMB &h00020000
#define WNNC_NET_NETWARE &h00030000
#define WNNC_NET_VINES &h00040000
#define WNNC_NET_10NET &h00050000
#define WNNC_NET_LOCUS &h00060000
#define WNNC_NET_SUN_PC_NFS &h00070000
#define WNNC_NET_LANSTEP &h00080000
#define WNNC_NET_9TILES &h00090000
#define WNNC_NET_LANTASTIC &h000a0000
#define WNNC_NET_AS400 &h000b0000
#define WNNC_NET_FTP_NFS &h000c0000
#define WNNC_NET_PATHWORKS &h000d0000
#define WNNC_NET_LIFENET &h000e0000
#define WNNC_NET_POWERLAN &h000f0000
#define WNNC_NET_BWNFS &h00100000
#define WNNC_NET_COGENT &h00110000
#define WNNC_NET_FARALLON &h00120000
#define WNNC_NET_APPLETALK &h00130000
#define WNNC_NET_INTERGRAPH &h00140000
#define WNNC_NET_SYMFONET &h00150000
#define WNNC_NET_CLEARCASE &h00160000
#define WNNC_NET_FRONTIER &h00170000
#define WNNC_NET_BMC &h00180000
#define WNNC_NET_DCE &h00190000
#define WNNC_NET_AVID &h001a0000
#define WNNC_NET_DOCUSPACE &h001b0000
#define WNNC_NET_MANGOSOFT &h001c0000
#define WNNC_NET_SERNET &h001d0000
#define WNNC_NET_RIVERFRONT1 &h001e0000
#define WNNC_NET_RIVERFRONT2 &h001f0000
#define WNNC_NET_DECORB &h00200000
#define WNNC_NET_PROTSTOR &h00210000
#define WNNC_NET_FJ_REDIR &h00220000
#define WNNC_NET_DISTINCT &h00230000
#define WNNC_NET_TWINS &h00240000
#define WNNC_NET_RDR2SAMPLE &h00250000
#define WNNC_NET_CSC &h00260000
#define WNNC_NET_3IN1 &h00270000
#define WNNC_NET_EXTENDNET &h00290000
#define WNNC_NET_STAC &h002a0000
#define WNNC_NET_FOXBAT &h002b0000
#define WNNC_NET_YAHOO &h002c0000
#define WNNC_NET_EXIFS &h002d0000
#define WNNC_NET_DAV &h002e0000
#define WNNC_NET_KNOWARE &h002f0000
#define WNNC_NET_OBJECT_DIRE &h00300000
#define WNNC_NET_MASFAX &h00310000
#define WNNC_NET_HOB_NFS &h00320000
#define WNNC_NET_SHIVA &h00330000
#define WNNC_NET_IBMAL &h00340000
#define WNNC_NET_LOCK &h00350000
#define WNNC_NET_TERMSRV &h00360000
#define WNNC_NET_SRT &h00370000
#define WNNC_NET_QUINCY &h00380000
#define WNNC_NET_OPENAFS &h00390000
#define WNNC_NET_AVID1 &h003a0000
#define WNNC_NET_DFS &h003b0000
#define WNNC_NET_KWNP &h003c0000
#define WNNC_NET_ZENWORKS &h003d0000
#define WNNC_NET_DRIVEONWEB &h003e0000
#define WNNC_NET_VMWARE &h003f0000
#define WNNC_NET_RSFX &h00400000
#define WNNC_NET_MFILES &h00410000
#define WNNC_NET_MS_NFS &h00420000
#define WNNC_NET_GOOGLE &h00430000
#define WNNC_NET_NDFS &h00440000
#define WNNC_CRED_MANAGER &hffff0000
#define RESOURCE_CONNECTED &h00000001
#define RESOURCE_GLOBALNET &h00000002
#define RESOURCE_REMEMBERED &h00000003
#define RESOURCE_RECENT &h00000004
#define RESOURCE_CONTEXT &h00000005
#define RESOURCETYPE_ANY &h00000000
#define RESOURCETYPE_DISK &h00000001
#define RESOURCETYPE_PRINT &h00000002
#define RESOURCETYPE_RESERVED &h00000008
#define RESOURCETYPE_UNKNOWN &hFFFFFFFF
#define RESOURCEUSAGE_CONNECTABLE &h00000001
#define RESOURCEUSAGE_CONTAINER &h00000002
#define RESOURCEUSAGE_NOLOCALDEVICE &h00000004
#define RESOURCEUSAGE_SIBLING &h00000008
#define RESOURCEUSAGE_ATTACHED &h00000010
#define RESOURCEUSAGE_ALL ((RESOURCEUSAGE_CONNECTABLE or RESOURCEUSAGE_CONTAINER) or RESOURCEUSAGE_ATTACHED)
#define RESOURCEUSAGE_RESERVED &h80000000
#define RESOURCEDISPLAYTYPE_GENERIC &h00000000
#define RESOURCEDISPLAYTYPE_DOMAIN &h00000001
#define RESOURCEDISPLAYTYPE_SERVER &h00000002
#define RESOURCEDISPLAYTYPE_SHARE &h00000003
#define RESOURCEDISPLAYTYPE_FILE &h00000004
#define RESOURCEDISPLAYTYPE_GROUP &h00000005
#define RESOURCEDISPLAYTYPE_NETWORK &h00000006
#define RESOURCEDISPLAYTYPE_ROOT &h00000007
#define RESOURCEDISPLAYTYPE_SHAREADMIN &h00000008
#define RESOURCEDISPLAYTYPE_DIRECTORY &h00000009
#define RESOURCEDISPLAYTYPE_TREE &h0000000a
#define RESOURCEDISPLAYTYPE_NDSCONTAINER &h0000000b

type _NETRESOURCEA
	dwScope as DWORD
	dwType as DWORD
	dwDisplayType as DWORD
	dwUsage as DWORD
	lpLocalName as LPSTR
	lpRemoteName as LPSTR
	lpComment as LPSTR
	lpProvider as LPSTR
end type

type NETRESOURCEA as _NETRESOURCEA
type LPNETRESOURCEA as _NETRESOURCEA ptr

type _NETRESOURCEW
	dwScope as DWORD
	dwType as DWORD
	dwDisplayType as DWORD
	dwUsage as DWORD
	lpLocalName as LPWSTR
	lpRemoteName as LPWSTR
	lpComment as LPWSTR
	lpProvider as LPWSTR
end type

type NETRESOURCEW as _NETRESOURCEW
type LPNETRESOURCEW as _NETRESOURCEW ptr

#ifdef UNICODE
	type NETRESOURCE as NETRESOURCEW
	type LPNETRESOURCE as LPNETRESOURCEW
#else
	type NETRESOURCE as NETRESOURCEA
	type LPNETRESOURCE as LPNETRESOURCEA
#endif

#define NETPROPERTY_PERSISTENT 1
#define CONNECT_UPDATE_PROFILE &h00000001
#define CONNECT_UPDATE_RECENT &h00000002
#define CONNECT_TEMPORARY &h00000004
#define CONNECT_INTERACTIVE &h00000008
#define CONNECT_PROMPT &h00000010
#define CONNECT_NEED_DRIVE &h00000020
#define CONNECT_REFCOUNT &h00000040
#define CONNECT_REDIRECT &h00000080
#define CONNECT_LOCALDRIVE &h00000100
#define CONNECT_CURRENT_MEDIA &h00000200
#define CONNECT_DEFERRED &h00000400
#define CONNECT_RESERVED &hFF000000
#define CONNECT_COMMANDLINE &h00000800
#define CONNECT_CMD_SAVECRED &h00001000

#ifdef UNICODE
	#define WNetAddConnection WNetAddConnectionW
	#define WNetAddConnection2 WNetAddConnection2W
	#define WNetAddConnection3 WNetAddConnection3W
	#define WNetCancelConnection WNetCancelConnectionW
	#define WNetCancelConnection2 WNetCancelConnection2W
	#define WNetGetConnection WNetGetConnectionW
	#define WNetRestoreConnection WNetRestoreConnectionW
	#define WNetUseConnection WNetUseConnectionW
#else
	#define WNetAddConnection WNetAddConnectionA
	#define WNetAddConnection2 WNetAddConnection2A
	#define WNetAddConnection3 WNetAddConnection3A
	#define WNetCancelConnection WNetCancelConnectionA
	#define WNetCancelConnection2 WNetCancelConnection2A
	#define WNetGetConnection WNetGetConnectionA
	#define WNetRestoreConnection WNetRestoreConnectionA
	#define WNetUseConnection WNetUseConnectionA
#endif

declare function WNetAddConnectionA(byval lpRemoteName as LPCSTR, byval lpPassword as LPCSTR, byval lpLocalName as LPCSTR) as DWORD
declare function WNetAddConnectionW(byval lpRemoteName as LPCWSTR, byval lpPassword as LPCWSTR, byval lpLocalName as LPCWSTR) as DWORD
declare function WNetAddConnection2A(byval lpNetResource as LPNETRESOURCEA, byval lpPassword as LPCSTR, byval lpUserName as LPCSTR, byval dwFlags as DWORD) as DWORD
declare function WNetAddConnection2W(byval lpNetResource as LPNETRESOURCEW, byval lpPassword as LPCWSTR, byval lpUserName as LPCWSTR, byval dwFlags as DWORD) as DWORD
declare function WNetAddConnection3A(byval hwndOwner as HWND, byval lpNetResource as LPNETRESOURCEA, byval lpPassword as LPCSTR, byval lpUserName as LPCSTR, byval dwFlags as DWORD) as DWORD
declare function WNetAddConnection3W(byval hwndOwner as HWND, byval lpNetResource as LPNETRESOURCEW, byval lpPassword as LPCWSTR, byval lpUserName as LPCWSTR, byval dwFlags as DWORD) as DWORD
declare function WNetCancelConnectionA(byval lpName as LPCSTR, byval fForce as WINBOOL) as DWORD
declare function WNetCancelConnectionW(byval lpName as LPCWSTR, byval fForce as WINBOOL) as DWORD
declare function WNetCancelConnection2A(byval lpName as LPCSTR, byval dwFlags as DWORD, byval fForce as WINBOOL) as DWORD
declare function WNetCancelConnection2W(byval lpName as LPCWSTR, byval dwFlags as DWORD, byval fForce as WINBOOL) as DWORD
declare function WNetGetConnectionA(byval lpLocalName as LPCSTR, byval lpRemoteName as LPSTR, byval lpnLength as LPDWORD) as DWORD
declare function WNetGetConnectionW(byval lpLocalName as LPCWSTR, byval lpRemoteName as LPWSTR, byval lpnLength as LPDWORD) as DWORD
declare function WNetRestoreConnectionA(byval hwndParent as HWND, byval lpDevice as LPCSTR) as DWORD
declare function WNetUseConnectionA(byval hwndOwner as HWND, byval lpNetResource as LPNETRESOURCEA, byval lpPassword as LPCSTR, byval lpUserID as LPCSTR, byval dwFlags as DWORD, byval lpAccessName as LPSTR, byval lpBufferSize as LPDWORD, byval lpResult as LPDWORD) as DWORD
declare function WNetUseConnectionW(byval hwndOwner as HWND, byval lpNetResource as LPNETRESOURCEW, byval lpPassword as LPCWSTR, byval lpUserID as LPCWSTR, byval dwFlags as DWORD, byval lpAccessName as LPWSTR, byval lpBufferSize as LPDWORD, byval lpResult as LPDWORD) as DWORD
declare function WNetConnectionDialog(byval hwnd as HWND, byval dwType as DWORD) as DWORD
declare function WNetDisconnectDialog(byval hwnd as HWND, byval dwType as DWORD) as DWORD

#if (_WIN32_WINNT = &h0400) or (_WIN32_WINNT = &h0502)
	declare function WNetRestoreConnectionW(byval hwndParent as HWND, byval lpDevice as LPCWSTR) as DWORD
#else
	declare function WNetRestoreSingleConnectionW(byval hwndParent as HWND, byval lpDevice as LPCWSTR, byval fUseUI as BOOL) as DWORD
#endif

type _CONNECTDLGSTRUCTA
	cbStructure as DWORD
	hwndOwner as HWND
	lpConnRes as LPNETRESOURCEA
	dwFlags as DWORD
	dwDevNum as DWORD
end type

type CONNECTDLGSTRUCTA as _CONNECTDLGSTRUCTA
type LPCONNECTDLGSTRUCTA as _CONNECTDLGSTRUCTA ptr

type _CONNECTDLGSTRUCTW
	cbStructure as DWORD
	hwndOwner as HWND
	lpConnRes as LPNETRESOURCEW
	dwFlags as DWORD
	dwDevNum as DWORD
end type

type CONNECTDLGSTRUCTW as _CONNECTDLGSTRUCTW
type LPCONNECTDLGSTRUCTW as _CONNECTDLGSTRUCTW ptr

#ifdef UNICODE
	type CONNECTDLGSTRUCT as CONNECTDLGSTRUCTW
	type LPCONNECTDLGSTRUCT as LPCONNECTDLGSTRUCTW
#else
	type CONNECTDLGSTRUCT as CONNECTDLGSTRUCTA
	type LPCONNECTDLGSTRUCT as LPCONNECTDLGSTRUCTA
#endif

#define CONNDLG_RO_PATH &h00000001
#define CONNDLG_CONN_POINT &h00000002
#define CONNDLG_USE_MRU &h00000004
#define CONNDLG_HIDE_BOX &h00000008
#define CONNDLG_PERSIST &h00000010
#define CONNDLG_NOT_PERSIST &h00000020

#ifdef UNICODE
	#define WNetConnectionDialog1 WNetConnectionDialog1W
#else
	#define WNetConnectionDialog1 WNetConnectionDialog1A
#endif

declare function WNetConnectionDialog1A(byval lpConnDlgStruct as LPCONNECTDLGSTRUCTA) as DWORD
declare function WNetConnectionDialog1W(byval lpConnDlgStruct as LPCONNECTDLGSTRUCTW) as DWORD

type _DISCDLGSTRUCTA
	cbStructure as DWORD
	hwndOwner as HWND
	lpLocalName as LPSTR
	lpRemoteName as LPSTR
	dwFlags as DWORD
end type

type DISCDLGSTRUCTA as _DISCDLGSTRUCTA
type LPDISCDLGSTRUCTA as _DISCDLGSTRUCTA ptr

type _DISCDLGSTRUCTW
	cbStructure as DWORD
	hwndOwner as HWND
	lpLocalName as LPWSTR
	lpRemoteName as LPWSTR
	dwFlags as DWORD
end type

type DISCDLGSTRUCTW as _DISCDLGSTRUCTW
type LPDISCDLGSTRUCTW as _DISCDLGSTRUCTW ptr

#ifdef UNICODE
	type DISCDLGSTRUCT as DISCDLGSTRUCTW
	type LPDISCDLGSTRUCT as LPDISCDLGSTRUCTW
#else
	type DISCDLGSTRUCT as DISCDLGSTRUCTA
	type LPDISCDLGSTRUCT as LPDISCDLGSTRUCTA
#endif

#define DISC_UPDATE_PROFILE &h00000001
#define DISC_NO_FORCE &h00000040

#ifdef UNICODE
	#define WNetDisconnectDialog1 WNetDisconnectDialog1W
	#define WNetOpenEnum WNetOpenEnumW
	#define WNetEnumResource WNetEnumResourceW
	#define WNetGetResourceParent WNetGetResourceParentW
	#define WNetGetResourceInformation WNetGetResourceInformationW
#else
	#define WNetDisconnectDialog1 WNetDisconnectDialog1A
	#define WNetOpenEnum WNetOpenEnumA
	#define WNetEnumResource WNetEnumResourceA
	#define WNetGetResourceParent WNetGetResourceParentA
	#define WNetGetResourceInformation WNetGetResourceInformationA
#endif

declare function WNetDisconnectDialog1A(byval lpConnDlgStruct as LPDISCDLGSTRUCTA) as DWORD
declare function WNetDisconnectDialog1W(byval lpConnDlgStruct as LPDISCDLGSTRUCTW) as DWORD
declare function WNetOpenEnumA(byval dwScope as DWORD, byval dwType as DWORD, byval dwUsage as DWORD, byval lpNetResource as LPNETRESOURCEA, byval lphEnum as LPHANDLE) as DWORD
declare function WNetOpenEnumW(byval dwScope as DWORD, byval dwType as DWORD, byval dwUsage as DWORD, byval lpNetResource as LPNETRESOURCEW, byval lphEnum as LPHANDLE) as DWORD
declare function WNetEnumResourceA(byval hEnum as HANDLE, byval lpcCount as LPDWORD, byval lpBuffer as LPVOID, byval lpBufferSize as LPDWORD) as DWORD
declare function WNetEnumResourceW(byval hEnum as HANDLE, byval lpcCount as LPDWORD, byval lpBuffer as LPVOID, byval lpBufferSize as LPDWORD) as DWORD
declare function WNetCloseEnum(byval hEnum as HANDLE) as DWORD
declare function WNetGetResourceParentA(byval lpNetResource as LPNETRESOURCEA, byval lpBuffer as LPVOID, byval lpcbBuffer as LPDWORD) as DWORD
declare function WNetGetResourceParentW(byval lpNetResource as LPNETRESOURCEW, byval lpBuffer as LPVOID, byval lpcbBuffer as LPDWORD) as DWORD
declare function WNetGetResourceInformationA(byval lpNetResource as LPNETRESOURCEA, byval lpBuffer as LPVOID, byval lpcbBuffer as LPDWORD, byval lplpSystem as LPSTR ptr) as DWORD
declare function WNetGetResourceInformationW(byval lpNetResource as LPNETRESOURCEW, byval lpBuffer as LPVOID, byval lpcbBuffer as LPDWORD, byval lplpSystem as LPWSTR ptr) as DWORD
#define UNIVERSAL_NAME_INFO_LEVEL &h00000001
#define REMOTE_NAME_INFO_LEVEL &h00000002

type _UNIVERSAL_NAME_INFOA
	lpUniversalName as LPSTR
end type

type UNIVERSAL_NAME_INFOA as _UNIVERSAL_NAME_INFOA
type LPUNIVERSAL_NAME_INFOA as _UNIVERSAL_NAME_INFOA ptr

type _UNIVERSAL_NAME_INFOW
	lpUniversalName as LPWSTR
end type

type UNIVERSAL_NAME_INFOW as _UNIVERSAL_NAME_INFOW
type LPUNIVERSAL_NAME_INFOW as _UNIVERSAL_NAME_INFOW ptr

#ifdef UNICODE
	type UNIVERSAL_NAME_INFO as UNIVERSAL_NAME_INFOW
	type LPUNIVERSAL_NAME_INFO as LPUNIVERSAL_NAME_INFOW
#else
	type UNIVERSAL_NAME_INFO as UNIVERSAL_NAME_INFOA
	type LPUNIVERSAL_NAME_INFO as LPUNIVERSAL_NAME_INFOA
#endif

type _REMOTE_NAME_INFOA
	lpUniversalName as LPSTR
	lpConnectionName as LPSTR
	lpRemainingPath as LPSTR
end type

type REMOTE_NAME_INFOA as _REMOTE_NAME_INFOA
type LPREMOTE_NAME_INFOA as _REMOTE_NAME_INFOA ptr

type _REMOTE_NAME_INFOW
	lpUniversalName as LPWSTR
	lpConnectionName as LPWSTR
	lpRemainingPath as LPWSTR
end type

type REMOTE_NAME_INFOW as _REMOTE_NAME_INFOW
type LPREMOTE_NAME_INFOW as _REMOTE_NAME_INFOW ptr

#ifdef UNICODE
	type REMOTE_NAME_INFO as REMOTE_NAME_INFOW
	type LPREMOTE_NAME_INFO as LPREMOTE_NAME_INFOW
	#define WNetGetUniversalName WNetGetUniversalNameW
	#define WNetGetUser WNetGetUserW
	#define WNetGetProviderName WNetGetProviderNameW
#else
	type REMOTE_NAME_INFO as REMOTE_NAME_INFOA
	type LPREMOTE_NAME_INFO as LPREMOTE_NAME_INFOA
	#define WNetGetUniversalName WNetGetUniversalNameA
	#define WNetGetUser WNetGetUserA
	#define WNetGetProviderName WNetGetProviderNameA
#endif

declare function WNetGetUniversalNameA(byval lpLocalPath as LPCSTR, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval lpBufferSize as LPDWORD) as DWORD
declare function WNetGetUniversalNameW(byval lpLocalPath as LPCWSTR, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval lpBufferSize as LPDWORD) as DWORD
declare function WNetGetUserA(byval lpName as LPCSTR, byval lpUserName as LPSTR, byval lpnLength as LPDWORD) as DWORD
declare function WNetGetUserW(byval lpName as LPCWSTR, byval lpUserName as LPWSTR, byval lpnLength as LPDWORD) as DWORD

#define WNFMT_MULTILINE &h01
#define WNFMT_ABBREVIATED &h02
#define WNFMT_INENUM &h10
#define WNFMT_CONNECTION &h20
declare function WNetGetProviderNameA(byval dwNetType as DWORD, byval lpProviderName as LPSTR, byval lpBufferSize as LPDWORD) as DWORD
declare function WNetGetProviderNameW(byval dwNetType as DWORD, byval lpProviderName as LPWSTR, byval lpBufferSize as LPDWORD) as DWORD

type _NETINFOSTRUCT
	cbStructure as DWORD
	dwProviderVersion as DWORD
	dwStatus as DWORD
	dwCharacteristics as DWORD
	dwHandle as ULONG_PTR
	wNetType as WORD
	dwPrinters as DWORD
	dwDrives as DWORD
end type

type NETINFOSTRUCT as _NETINFOSTRUCT
type LPNETINFOSTRUCT as _NETINFOSTRUCT ptr
#define NETINFO_DLL16 &h00000001
#define NETINFO_DISKRED &h00000004
#define NETINFO_PRINTERRED &h00000008

#ifdef UNICODE
	#define WNetGetNetworkInformation WNetGetNetworkInformationW
#else
	#define WNetGetNetworkInformation WNetGetNetworkInformationA
#endif

declare function WNetGetNetworkInformationA(byval lpProvider as LPCSTR, byval lpNetInfoStruct as LPNETINFOSTRUCT) as DWORD
declare function WNetGetNetworkInformationW(byval lpProvider as LPCWSTR, byval lpNetInfoStruct as LPNETINFOSTRUCT) as DWORD
type PFNGETPROFILEPATHA as function(byval pszUsername as LPCSTR, byval pszBuffer as LPSTR, byval cbBuffer as UINT) as UINT
type PFNGETPROFILEPATHW as function(byval pszUsername as LPCWSTR, byval pszBuffer as LPWSTR, byval cbBuffer as UINT) as UINT

#ifdef UNICODE
	#define PFNGETPROFILEPATH PFNGETPROFILEPATHW
#else
	#define PFNGETPROFILEPATH PFNGETPROFILEPATHA
#endif

type PFNRECONCILEPROFILEA as function(byval pszCentralFile as LPCSTR, byval pszLocalFile as LPCSTR, byval dwFlags as DWORD) as UINT
type PFNRECONCILEPROFILEW as function(byval pszCentralFile as LPCWSTR, byval pszLocalFile as LPCWSTR, byval dwFlags as DWORD) as UINT

#ifdef UNICODE
	#define PFNRECONCILEPROFILE PFNRECONCILEPROFILEW
#else
	#define PFNRECONCILEPROFILE PFNRECONCILEPROFILEA
#endif

#define RP_LOGON &h01
#define RP_INIFILE &h02
type PFNPROCESSPOLICIESA as function(byval hwnd as HWND, byval pszPath as LPCSTR, byval pszUsername as LPCSTR, byval pszComputerName as LPCSTR, byval dwFlags as DWORD) as WINBOOL
type PFNPROCESSPOLICIESW as function(byval hwnd as HWND, byval pszPath as LPCWSTR, byval pszUsername as LPCWSTR, byval pszComputerName as LPCWSTR, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	#define PFNPROCESSPOLICIES PFNPROCESSPOLICIESW
#else
	#define PFNPROCESSPOLICIES PFNPROCESSPOLICIESA
#endif

#define PP_DISPLAYERRORS &h01

#ifdef UNICODE
	#define WNetGetLastError WNetGetLastErrorW
#else
	#define WNetGetLastError WNetGetLastErrorA
#endif

declare function WNetGetLastErrorA(byval lpError as LPDWORD, byval lpErrorBuf as LPSTR, byval nErrorBufSize as DWORD, byval lpNameBuf as LPSTR, byval nNameBufSize as DWORD) as DWORD
declare function WNetGetLastErrorW(byval lpError as LPDWORD, byval lpErrorBuf as LPWSTR, byval nErrorBufSize as DWORD, byval lpNameBuf as LPWSTR, byval nNameBufSize as DWORD) as DWORD
#define WN_SUCCESS NO_ERROR
#define WN_NO_ERROR NO_ERROR
#define WN_NOT_SUPPORTED ERROR_NOT_SUPPORTED
#define WN_CANCEL ERROR_CANCELLED
#define WN_RETRY ERROR_RETRY
#define WN_NET_ERROR ERROR_UNEXP_NET_ERR
#define WN_MORE_DATA ERROR_MORE_DATA
#define WN_BAD_POINTER ERROR_INVALID_ADDRESS
#define WN_BAD_VALUE ERROR_INVALID_PARAMETER
#define WN_BAD_USER ERROR_BAD_USERNAME
#define WN_BAD_PASSWORD ERROR_INVALID_PASSWORD
#define WN_ACCESS_DENIED ERROR_ACCESS_DENIED
#define WN_FUNCTION_BUSY ERROR_BUSY
#define WN_WINDOWS_ERROR ERROR_UNEXP_NET_ERR
#define WN_OUT_OF_MEMORY ERROR_NOT_ENOUGH_MEMORY
#define WN_NO_NETWORK ERROR_NO_NETWORK
#define WN_EXTENDED_ERROR ERROR_EXTENDED_ERROR
#define WN_BAD_LEVEL ERROR_INVALID_LEVEL
#define WN_BAD_HANDLE ERROR_INVALID_HANDLE
#define WN_NOT_INITIALIZING ERROR_ALREADY_INITIALIZED
#define WN_NO_MORE_DEVICES ERROR_NO_MORE_DEVICES
#define WN_NOT_CONNECTED ERROR_NOT_CONNECTED
#define WN_OPEN_FILES ERROR_OPEN_FILES
#define WN_DEVICE_IN_USE ERROR_DEVICE_IN_USE
#define WN_BAD_NETNAME ERROR_BAD_NET_NAME
#define WN_BAD_LOCALNAME ERROR_BAD_DEVICE
#define WN_ALREADY_CONNECTED ERROR_ALREADY_ASSIGNED
#define WN_DEVICE_ERROR ERROR_GEN_FAILURE
#define WN_CONNECTION_CLOSED ERROR_CONNECTION_UNAVAIL
#define WN_NO_NET_OR_BAD_PATH ERROR_NO_NET_OR_BAD_PATH
#define WN_BAD_PROVIDER ERROR_BAD_PROVIDER
#define WN_CANNOT_OPEN_PROFILE ERROR_CANNOT_OPEN_PROFILE
#define WN_BAD_PROFILE ERROR_BAD_PROFILE
#define WN_BAD_DEV_TYPE ERROR_BAD_DEV_TYPE
#define WN_DEVICE_ALREADY_REMEMBERED ERROR_DEVICE_ALREADY_REMEMBERED
#define WN_CONNECTED_OTHER_PASSWORD ERROR_CONNECTED_OTHER_PASSWORD
#define WN_CONNECTED_OTHER_PASSWORD_DEFAULT ERROR_CONNECTED_OTHER_PASSWORD_DEFAULT
#define WN_NO_MORE_ENTRIES ERROR_NO_MORE_ITEMS
#define WN_NOT_CONTAINER ERROR_NOT_CONTAINER
#define WN_NOT_AUTHENTICATED ERROR_NOT_AUTHENTICATED
#define WN_NOT_LOGGED_ON ERROR_NOT_LOGGED_ON
#define WN_NOT_VALIDATED ERROR_NO_LOGON_SERVERS

type _NETCONNECTINFOSTRUCT
	cbStructure as DWORD
	dwFlags as DWORD
	dwSpeed as DWORD
	dwDelay as DWORD
	dwOptDataSize as DWORD
end type

type NETCONNECTINFOSTRUCT as _NETCONNECTINFOSTRUCT
type LPNETCONNECTINFOSTRUCT as _NETCONNECTINFOSTRUCT ptr
#define WNCON_FORNETCARD &h00000001
#define WNCON_NOTROUTED &h00000002
#define WNCON_SLOWLINK &h00000004
#define WNCON_DYNAMIC &h00000008

#ifdef UNICODE
	#define MultinetGetConnectionPerformance MultinetGetConnectionPerformanceW
#else
	#define MultinetGetConnectionPerformance MultinetGetConnectionPerformanceA
#endif

declare function MultinetGetConnectionPerformanceA(byval lpNetResource as LPNETRESOURCEA, byval lpNetConnectInfoStruct as LPNETCONNECTINFOSTRUCT) as DWORD
declare function MultinetGetConnectionPerformanceW(byval lpNetResource as LPNETRESOURCEW, byval lpNetConnectInfoStruct as LPNETCONNECTINFOSTRUCT) as DWORD

end extern
