''
''
'' winnetwk -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winnetwk_bi__
#define __win_winnetwk_bi__

#define WNNC_NET_MSNET &h00010000
#define WNNC_NET_LANMAN &h00020000
#define WNNC_NET_NETWARE &h00030000
#define WNNC_NET_VINES &h00040000
#define WNNC_NET_10NET &h00050000
#define WNNC_NET_LOCUS &h00060000
#define WNNC_NET_SUN_PC_NFS &h00070000
#define WNNC_NET_LANSTEP &h00080000
#define WNNC_NET_9TILES &h00090000
#define WNNC_NET_LANTASTIC &h000A0000
#define WNNC_NET_AS400 &h000B0000
#define WNNC_NET_FTP_NFS &h000C0000
#define WNNC_NET_PATHWORKS &h000D0000
#define WNNC_NET_LIFENET &h000E0000
#define WNNC_NET_POWERLAN &h000F0000
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
#define WNNC_NET_AVID &h001A0000
#define WNNC_NET_DOCUSPACE &h001B0000
#define WNNC_NET_MANGOSOFT &h001C0000
#define WNNC_NET_SERNET &h001D0000
#define WNNC_NET_DECORB &h00200000
#define WNNC_NET_PROTSTOR &h00210000
#define WNNC_NET_FJ_REDIR &h00220000
#define WNNC_NET_DISTINCT &h00230000
#define WNNC_NET_TWINS &h00240000
#define WNNC_NET_RDR2SAMPLE &h00250000
#define WNNC_NET_CSC &h00260000
#define WNNC_NET_3IN1 &h00270000
#define WNNC_NET_EXTENDNET &h00290000
#define WNNC_NET_OBJECT_DIRE &h00300000
#define WNNC_NET_MASFAX &h00310000
#define WNNC_NET_HOB_NFS &h00320000
#define WNNC_NET_SHIVA &h00330000
#define WNNC_NET_IBMAL &h00340000
#define WNNC_CRED_MANAGER &hFFFF0000
#define RESOURCE_CONNECTED 1
#define RESOURCE_GLOBALNET 2
#define RESOURCE_REMEMBERED 3
#define RESOURCE_RECENT 4
#define RESOURCE_CONTEXT 5
#define RESOURCETYPE_ANY 0
#define RESOURCETYPE_DISK 1
#define RESOURCETYPE_PRINT 2
#define RESOURCETYPE_RESERVED 8
#define RESOURCETYPE_UNKNOWN &hFFFFFFFF
#define RESOURCEUSAGE_CONNECTABLE &h00000001
#define RESOURCEUSAGE_CONTAINER &h00000002
#define RESOURCEUSAGE_NOLOCALDEVICE &h00000004
#define RESOURCEUSAGE_SIBLING &h00000008
#define RESOURCEUSAGE_ATTACHED &h00000010
#define RESOURCEUSAGE_ALL (&h00000001 or &h00000002 or &h00000010)
#define RESOURCEUSAGE_RESERVED &h80000000
#define RESOURCEDISPLAYTYPE_GENERIC 0
#define RESOURCEDISPLAYTYPE_DOMAIN 1
#define RESOURCEDISPLAYTYPE_SERVER 2
#define RESOURCEDISPLAYTYPE_SHARE 3
#define RESOURCEDISPLAYTYPE_FILE 4
#define RESOURCEDISPLAYTYPE_GROUP 5
#define RESOURCEDISPLAYTYPE_NETWORK 6
#define RESOURCEDISPLAYTYPE_ROOT 7
#define RESOURCEDISPLAYTYPE_SHAREADMIN 8
#define RESOURCEDISPLAYTYPE_DIRECTORY 9
#define RESOURCEDISPLAYTYPE_TREE 10
#define NETPROPERTY_PERSISTENT 1
#define CONNECT_UPDATE_PROFILE 1
#define CONNECT_UPDATE_RECENT 2
#define CONNECT_TEMPORARY 4
#define CONNECT_INTERACTIVE 8
#define CONNECT_PROMPT 16
#define CONNECT_NEED_DRIVE 32
#define CONNECT_REFCOUNT 64
#define CONNECT_REDIRECT 128
#define CONNECT_LOCALDRIVE 256
#define CONNECT_CURRENT_MEDIA 512
#define CONNDLG_RO_PATH 1
#define CONNDLG_CONN_POINT 2
#define CONNDLG_USE_MRU 4
#define CONNDLG_HIDE_BOX 8
#define CONNDLG_PERSIST 16
#define CONNDLG_NOT_PERSIST 32
#define DISC_UPDATE_PROFILE 1
#define DISC_NO_FORCE 64
#define WNFMT_MULTILINE 1
#define WNFMT_ABBREVIATED 2
#define WNFMT_INENUM 16
#define WNFMT_CONNECTION 32
#define WN_SUCCESS 0L
#define WN_NO_ERROR 0L
#define WN_NOT_SUPPORTED 50L
#define WN_CANCEL 1223L
#define WN_RETRY 1237L
#define WN_NET_ERROR 59L
#define WN_MORE_DATA 234L
#define WN_BAD_POINTER 487L
#define WN_BAD_VALUE 87L
#define WN_BAD_USER 2202L
#define WN_BAD_PASSWORD 86L
#define WN_ACCESS_DENIED 5L
#define WN_FUNCTION_BUSY 170L
#define WN_WINDOWS_ERROR 59L
#define WN_OUT_OF_MEMORY 8L
#define WN_NO_NETWORK 1222L
#define WN_EXTENDED_ERROR 1208L
#define WN_BAD_LEVEL 124L
#define WN_BAD_HANDLE 6L
#define WN_NOT_INITIALIZING 1247L
#define WN_NO_MORE_DEVICES 1248L
#define WN_NOT_CONNECTED 2250L
#define WN_OPEN_FILES 2401L
#define WN_DEVICE_IN_USE 2404L
#define WN_BAD_NETNAME 67L
#define WN_BAD_LOCALNAME 1200L
#define WN_ALREADY_CONNECTED 85L
#define WN_DEVICE_ERROR 31L
#define WN_CONNECTION_CLOSED 1201L
#define WN_NO_NET_OR_BAD_PATH 1203L
#define WN_BAD_PROVIDER 1204L
#define WN_CANNOT_OPEN_PROFILE 1205L
#define WN_BAD_PROFILE 1206L
#define WN_BAD_DEV_TYPE 66L
#define WN_DEVICE_ALREADY_REMEMBERED 1202L
#define WN_NO_MORE_ENTRIES 259L
#define WN_NOT_CONTAINER 1207L
#define WN_NOT_AUTHENTICATED 1244L
#define WN_NOT_LOGGED_ON 1245L
#define WN_NOT_VALIDATED 1311L
#define UNIVERSAL_NAME_INFO_LEVEL 1
#define REMOTE_NAME_INFO_LEVEL 2
#define NETINFO_DLL16 1
#define NETINFO_DISKRED 4
#define NETINFO_PRINTERRED 8
#define RP_LOGON 1
#define RP_INIFILE 2
#define PP_DISPLAYERRORS 1
#define WNCON_FORNETCARD 1
#define WNCON_NOTROUTED 2
#define WNCON_SLOWLINK 4
#define WNCON_DYNAMIC 8

#ifndef UNICODE
type NETRESOURCEA
	dwScope as DWORD
	dwType as DWORD
	dwDisplayType as DWORD
	dwUsage as DWORD
	lpLocalName as LPSTR
	lpRemoteName as LPSTR
	lpComment as LPSTR
	lpProvider as LPSTR
end type

type LPNETRESOURCEA as NETRESOURCEA ptr

#else ''UNICODE
type NETRESOURCEW
	dwScope as DWORD
	dwType as DWORD
	dwDisplayType as DWORD
	dwUsage as DWORD
	lpLocalName as LPWSTR
	lpRemoteName as LPWSTR
	lpComment as LPWSTR
	lpProvider as LPWSTR
end type

type LPNETRESOURCEW as NETRESOURCEW ptr
#endif ''UNICODE

#ifndef UNICODE
type CONNECTDLGSTRUCTA
	cbStructure as DWORD
	hwndOwner as HWND
	lpConnRes as LPNETRESOURCEA
	dwFlags as DWORD
	dwDevNum as DWORD
end type

type LPCONNECTDLGSTRUCTA as CONNECTDLGSTRUCTA ptr

#else ''UNICODE
type CONNECTDLGSTRUCTW
	cbStructure as DWORD
	hwndOwner as HWND
	lpConnRes as LPNETRESOURCEW
	dwFlags as DWORD
	dwDevNum as DWORD
end type

type LPCONNECTDLGSTRUCTW as CONNECTDLGSTRUCTW ptr
#endif ''UNICODE

#ifndef UNICODE
type DISCDLGSTRUCTA
	cbStructure as DWORD
	hwndOwner as HWND
	lpLocalName as LPSTR
	lpRemoteName as LPSTR
	dwFlags as DWORD
end type

type LPDISCDLGSTRUCTA as DISCDLGSTRUCTA ptr

#else ''UNICODE
type DISCDLGSTRUCTW
	cbStructure as DWORD
	hwndOwner as HWND
	lpLocalName as LPWSTR
	lpRemoteName as LPWSTR
	dwFlags as DWORD
end type

type LPDISCDLGSTRUCTW as DISCDLGSTRUCTW ptr
#endif ''UNICODE

#ifndef UNICODE
type UNIVERSAL_NAME_INFOA
	lpUniversalName as LPSTR
end type

type LPUNIVERSAL_NAME_INFOA as UNIVERSAL_NAME_INFOA ptr

type REMOTE_NAME_INFOA
	lpUniversalName as LPSTR
	lpConnectionName as LPSTR
	lpRemainingPath as LPSTR
end type

type LPREMOTE_NAME_INFOA as REMOTE_NAME_INFOA ptr

type PFNGETPROFILEPATHA as function (byval as LPCSTR, byval as LPSTR, byval as UINT) as UINT
type PFNRECONCILEPROFILEA as function (byval as LPCSTR, byval as LPCSTR, byval as DWORD) as UINT
type PFNPROCESSPOLICIESA as function (byval as HWND, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as DWORD) as BOOL

#else ''UNICODE
type UNIVERSAL_NAME_INFOW
	lpUniversalName as LPWSTR
end type

type LPUNIVERSAL_NAME_INFOW as UNIVERSAL_NAME_INFOW ptr

type REMOTE_NAME_INFOW
	lpUniversalName as LPWSTR
	lpConnectionName as LPWSTR
	lpRemainingPath as LPWSTR
end type

type LPREMOTE_NAME_INFOW as REMOTE_NAME_INFOW ptr

type PFNGETPROFILEPATHW as function (byval as LPCWSTR, byval as LPWSTR, byval as UINT) as UINT
type PFNRECONCILEPROFILEW as function (byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as UINT
type PFNPROCESSPOLICIESW as function (byval as HWND, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as BOOL
#endif ''UNICODE

type NETINFOSTRUCT
	cbStructure as DWORD
	dwProviderVersion as DWORD
	dwStatus as DWORD
	dwCharacteristics as DWORD
	dwHandle as DWORD
	wNetType as WORD
	dwPrinters as DWORD
	dwDrives as DWORD
end type

type LPNETINFOSTRUCT as NETINFOSTRUCT ptr

type NETCONNECTINFOSTRUCT
	cbStructure as DWORD
	dwFlags as DWORD
	dwSpeed as DWORD
	dwDelay as DWORD
	dwOptDataSize as DWORD
end type

type LPNETCONNECTINFOSTRUCT as NETCONNECTINFOSTRUCT ptr

declare function WNetConnectionDialog alias "WNetConnectionDialog" (byval as HWND, byval as DWORD) as DWORD
declare function WNetDisconnectDialog alias "WNetDisconnectDialog" (byval as HWND, byval as DWORD) as DWORD
declare function WNetCloseEnum alias "WNetCloseEnum" (byval as HANDLE) as DWORD

#ifdef UNICODE
type NETRESOURCE as NETRESOURCEW
type LPNETRESOURCE as NETRESOURCEW ptr
type CONNECTDLGSTRUCT as CONNECTDLGSTRUCTW
type LPCONNECTDLGSTRUCT as CONNECTDLGSTRUCTW ptr
type DISCDLGSTRUCT as DISCDLGSTRUCTW
type LPDISCDLGSTRUCT as DISCDLGSTRUCTW ptr
type UNIVERSAL_NAME_INFO as UNIVERSAL_NAME_INFOW
type LPUNIVERSAL_NAME_INFO as UNIVERSAL_NAME_INFOW ptr
type REMOTE_NAME_INFO as REMOTE_NAME_INFOW
type LPREMOTE_NAME_INFO as REMOTE_NAME_INFOW ptr

#define PFNPROCESSPOLICIES PFNPROCESSPOLICIESW
#define PFNRECONCILEPROFILE PFNRECONCILEPROFILEW
#define PFNGETPROFILEPATH PFNGETPROFILEPATHW

declare function WNetAddConnection alias "WNetAddConnectionW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as DWORD
declare function WNetAddConnection2 alias "WNetAddConnection2W" (byval as LPNETRESOURCEW, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as DWORD
declare function WNetAddConnection3 alias "WNetAddConnection3W" (byval as HWND, byval as LPNETRESOURCEW, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as DWORD
declare function WNetCancelConnection alias "WNetCancelConnectionW" (byval as LPCWSTR, byval as BOOL) as DWORD
declare function WNetCancelConnection2 alias "WNetCancelConnection2W" (byval as LPCWSTR, byval as DWORD, byval as BOOL) as DWORD
declare function WNetGetConnection alias "WNetGetConnectionW" (byval as LPCWSTR, byval as LPWSTR, byval as PDWORD) as DWORD
declare function WNetUseConnection alias "WNetUseConnectionW" (byval as HWND, byval as LPNETRESOURCEW, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as LPWSTR, byval as PDWORD, byval as PDWORD) as DWORD
declare function WNetSetConnection alias "WNetSetConnectionW" (byval as LPCWSTR, byval as DWORD, byval as PVOID) as DWORD
declare function WNetConnectionDialog1 alias "WNetConnectionDialog1W" (byval as LPCONNECTDLGSTRUCTW) as DWORD
declare function WNetDisconnectDialog1 alias "WNetDisconnectDialog1W" (byval as LPDISCDLGSTRUCTW) as DWORD
declare function WNetOpenEnum alias "WNetOpenEnumW" (byval as DWORD, byval as DWORD, byval as DWORD, byval as LPNETRESOURCEW, byval as LPHANDLE) as DWORD
declare function WNetEnumResource alias "WNetEnumResourceW" (byval as HANDLE, byval as PDWORD, byval as PVOID, byval as PDWORD) as DWORD
declare function WNetGetUniversalName alias "WNetGetUniversalNameW" (byval as LPCWSTR, byval as DWORD, byval as PVOID, byval as PDWORD) as DWORD
declare function WNetGetUser alias "WNetGetUserW" (byval as LPCWSTR, byval as LPWSTR, byval as PDWORD) as DWORD
declare function WNetGetProviderName alias "WNetGetProviderNameW" (byval as DWORD, byval as LPWSTR, byval as PDWORD) as DWORD
declare function WNetGetNetworkInformation alias "WNetGetNetworkInformationW" (byval as LPCWSTR, byval as LPNETINFOSTRUCT) as DWORD
declare function WNetGetResourceInformation alias "WNetGetResourceInformationW" (byval as LPNETRESOURCEW, byval as LPVOID, byval as LPDWORD, byval as LPWSTR ptr) as DWORD
declare function WNetGetLastError alias "WNetGetLastErrorW" (byval as PDWORD, byval as LPWSTR, byval as DWORD, byval as LPWSTR, byval as DWORD) as DWORD
declare function MultinetGetConnectionPerformance alias "MultinetGetConnectionPerformanceW" (byval as LPNETRESOURCEW, byval as LPNETCONNECTINFOSTRUCT) as DWORD

#else ''UNICODE
type NETRESOURCE as NETRESOURCEA
type LPNETRESOURCE as NETRESOURCEA ptr
type CONNECTDLGSTRUCT as CONNECTDLGSTRUCTA
type LPCONNECTDLGSTRUCT as CONNECTDLGSTRUCTA ptr
type DISCDLGSTRUCT as DISCDLGSTRUCTA
type LPDISCDLGSTRUCT as DISCDLGSTRUCTA ptr
type UNIVERSAL_NAME_INFO as UNIVERSAL_NAME_INFOA
type LPUNIVERSAL_NAME_INFO as UNIVERSAL_NAME_INFOA ptr
type REMOTE_NAME_INFO as REMOTE_NAME_INFOA
type LPREMOTE_NAME_INFO as REMOTE_NAME_INFOA ptr

#define PFNGETPROFILEPATH PFNGETPROFILEPATHA
#define PFNRECONCILEPROFILE PFNRECONCILEPROFILEA
#define PFNPROCESSPOLICIES PFNPROCESSPOLICIESA

declare function WNetAddConnection alias "WNetAddConnectionA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as DWORD
declare function WNetAddConnection2 alias "WNetAddConnection2A" (byval as LPNETRESOURCEA, byval as LPCSTR, byval as LPCSTR, byval as DWORD) as DWORD
declare function WNetAddConnection3 alias "WNetAddConnection3A" (byval as HWND, byval as LPNETRESOURCEA, byval as LPCSTR, byval as LPCSTR, byval as DWORD) as DWORD
declare function WNetCancelConnection alias "WNetCancelConnectionA" (byval as LPCSTR, byval as BOOL) as DWORD
declare function WNetCancelConnection2 alias "WNetCancelConnection2A" (byval as LPCSTR, byval as DWORD, byval as BOOL) as DWORD
declare function WNetGetConnection alias "WNetGetConnectionA" (byval as LPCSTR, byval as LPSTR, byval as PDWORD) as DWORD
declare function WNetUseConnection alias "WNetUseConnectionA" (byval as HWND, byval as LPNETRESOURCEA, byval as LPCSTR, byval as LPCSTR, byval as DWORD, byval as LPSTR, byval as PDWORD, byval as PDWORD) as DWORD
declare function WNetSetConnection alias "WNetSetConnectionA" (byval as LPCSTR, byval as DWORD, byval as PVOID) as DWORD
declare function WNetConnectionDialog1 alias "WNetConnectionDialog1A" (byval as LPCONNECTDLGSTRUCTA) as DWORD
declare function WNetDisconnectDialog1 alias "WNetDisconnectDialog1A" (byval as LPDISCDLGSTRUCTA) as DWORD
declare function WNetOpenEnum alias "WNetOpenEnumA" (byval as DWORD, byval as DWORD, byval as DWORD, byval as LPNETRESOURCEA, byval as LPHANDLE) as DWORD
declare function WNetEnumResource alias "WNetEnumResourceA" (byval as HANDLE, byval as PDWORD, byval as PVOID, byval as PDWORD) as DWORD
declare function WNetGetUniversalName alias "WNetGetUniversalNameA" (byval as LPCSTR, byval as DWORD, byval as PVOID, byval as PDWORD) as DWORD
declare function WNetGetUser alias "WNetGetUserA" (byval as LPCSTR, byval as LPSTR, byval as PDWORD) as DWORD
declare function WNetGetProviderName alias "WNetGetProviderNameA" (byval as DWORD, byval as LPSTR, byval as PDWORD) as DWORD
declare function WNetGetNetworkInformation alias "WNetGetNetworkInformationA" (byval as LPCSTR, byval as LPNETINFOSTRUCT) as DWORD
declare function WNetGetResourceInformation alias "WNetGetResourceInformationA" (byval as LPNETRESOURCEA, byval as LPVOID, byval as LPDWORD, byval as LPSTR ptr) as DWORD
declare function WNetGetLastError alias "WNetGetLastErrorA" (byval as PDWORD, byval as LPSTR, byval as DWORD, byval as LPSTR, byval as DWORD) as DWORD
declare function MultinetGetConnectionPerformance alias "MultinetGetConnectionPerformanceA" (byval as LPNETRESOURCEA, byval as LPNETCONNECTINFOSTRUCT) as DWORD

#endif ''UNICODE

#endif
