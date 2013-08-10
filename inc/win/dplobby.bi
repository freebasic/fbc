''
''
'' dplobby -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dplobby_bi__
#define __win_dplobby_bi__

#include once "win/dplay.bi"

extern IID_IDirectPlayLobby alias "IID_IDirectPlayLobby" as GUID
extern IID_IDirectPlayLobbyA alias "IID_IDirectPlayLobbyA" as GUID
extern IID_IDirectPlayLobby2 alias "IID_IDirectPlayLobby2" as GUID
extern IID_IDirectPlayLobby2A alias "IID_IDirectPlayLobby2A" as GUID
extern IID_IDirectPlayLobby3 alias "IID_IDirectPlayLobby3" as GUID
extern IID_IDirectPlayLobby3A alias "IID_IDirectPlayLobby3A" as GUID
extern CLSID_DirectPlayLobby alias "CLSID_DirectPlayLobby" as GUID

type LPDIRECTPLAYLOBBY as IDirectPlayLobby ptr
type LPDIRECTPLAYLOBBYA as IDirectPlayLobby ptr
type IDirectPlayLobbyA as IDirectPlayLobby
type LPDIRECTPLAYLOBBY2 as IDirectPlayLobby2 ptr
type LPDIRECTPLAYLOBBY2A as IDirectPlayLobby2 ptr
type IDirectPlayLobby2A as IDirectPlayLobby2
type LPDIRECTPLAYLOBBY3 as IDirectPlayLobby3 ptr
type LPDIRECTPLAYLOBBY3A as IDirectPlayLobby3 ptr
type IDirectPlayLobby3A as IDirectPlayLobby3

type DPLAPPINFO
	dwSize as DWORD
	guidApplication as GUID
    union
        as LPSTR lpszAppNameA
        as LPWSTR lpszAppName
	end union
end type

type LPDPLAPPINFO as DPLAPPINFO ptr
type LPCDPLAPPINFO as const DPLAPPINFO ptr

type DPCOMPOUNDADDRESSELEMENT
	guidDataType as GUID
	dwDataSize as DWORD
	lpData as LPVOID
end type

type LPDPCOMPOUNDADDRESSELEMENT as DPCOMPOUNDADDRESSELEMENT ptr
type LPCDPCOMPOUNDADDRESSELEMENT as const DPCOMPOUNDADDRESSELEMENT ptr

type DPAPPLICATIONDESC
	dwSize as DWORD
	dwFlags as DWORD
    union
        as LPSTR lpszApplicationNameA
        as LPWSTR lpszApplicationName
    end union
	guidApplication as GUID
    union
        as LPSTR lpszFilenameA
        as LPWSTR lpszFilename
    end union
    union
        as LPSTR lpszCommandLineA
        as LPWSTR lpszCommandLine
    end union
    union
        as LPSTR lpszPathA
        as LPWSTR lpszPath
    end union
    union
        as LPSTR lpszCurrentDirectoryA
        as LPWSTR lpszCurrentDirectory
    end union
	lpszDescriptionA as LPSTR
	lpszDescriptionW as LPWSTR
end type

type LPDPAPPLICATIONDESC as DPAPPLICATIONDESC ptr

type DPAPPLICATIONDESC2
	dwSize as DWORD
	dwFlags as DWORD
    union
        as LPSTR lpszApplicationNameA
        as LPWSTR lpszApplicationName
    end union
	guidApplication as GUID
    union
        as LPSTR lpszFilenameA
        as LPWSTR lpszFilename
    end union
    union
        as LPSTR lpszCommandLineA
        as LPWSTR lpszCommandLine
    end union
    union
        as LPSTR lpszPathA
        as LPWSTR lpszPath
    end union
    union
        as LPSTR lpszCurrentDirectoryA
        as LPWSTR lpszCurrentDirectory
    end union
	lpszDescriptionA as LPSTR
	lpszDescriptionW as LPWSTR
    union
    	as LPSTR lpszAppLauncherNameA
    	as LPWSTR lpszAppLauncherName
    end union
end type

type LPDPAPPLICATIONDESC2 as DPAPPLICATIONDESC2 ptr
type LPDPENUMADDRESSCALLBACK as function(byval as GUID ptr, byval as DWORD, byval as LPCVOID, byval as LPVOID) as BOOL
type LPDPLENUMADDRESSTYPESCALLBACK as function(byval as GUID ptr, byval as LPVOID, byval as DWORD) as BOOL
type LPDPLENUMLOCALAPPLICATIONSCALLBACK as function(byval as LPCDPLAPPINFO, byval as LPVOID, byval as DWORD) as BOOL

#ifdef UNICODE
declare function DirectPlayLobbyCreate alias "DirectPlayLobbyCreateW" (byval as LPGUID, byval as LPDIRECTPLAYLOBBY ptr, byval as IUnknown ptr, byval as LPVOID, byval as DWORD) as HRESULT
#else
declare function DirectPlayLobbyCreate alias "DirectPlayLobbyCreateA" (byval as LPGUID, byval as LPDIRECTPLAYLOBBYA ptr, byval as IUnknown ptr, byval as LPVOID, byval as DWORD) as HRESULT
#endif

type IDirectPlayLobbyVtbl_ as IDirectPlayLobbyVtbl

type IDirectPlayLobby
	lpVtbl as IDirectPlayLobbyVtbl_ ptr
end type

type IDirectPlayLobbyVtbl
	QueryInterface as function(byval as IDirectPlayLobby ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlayLobby ptr) as ULONG
	Release as function(byval as IDirectPlayLobby ptr) as ULONG
	Connect as function(byval as IDirectPlayLobby ptr, byval as DWORD, byval as LPDIRECTPLAY2 ptr, byval as IUnknown ptr) as HRESULT
	CreateAddress as function(byval as IDirectPlayLobby ptr, byval as GUID ptr, byval as GUID ptr, byval as LPCVOID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	EnumAddress as function(byval as IDirectPlayLobby ptr, byval as LPDPENUMADDRESSCALLBACK, byval as LPCVOID, byval as DWORD, byval as LPVOID) as HRESULT
	EnumAddressTypes as function(byval as IDirectPlayLobby ptr, byval as LPDPLENUMADDRESSTYPESCALLBACK, byval as GUID ptr, byval as LPVOID, byval as DWORD) as HRESULT
	EnumLocalApplications as function(byval as IDirectPlayLobby ptr, byval as LPDPLENUMLOCALAPPLICATIONSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	GetConnectionSettings as function(byval as IDirectPlayLobby ptr, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	ReceiveLobbyMessage as function(byval as IDirectPlayLobby ptr, byval as DWORD, byval as DWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	RunApplication as function(byval as IDirectPlayLobby ptr, byval as DWORD, byval as LPDWORD, byval as LPDPLCONNECTION, byval as HANDLE) as HRESULT
	SendLobbyMessage as function(byval as IDirectPlayLobby ptr, byval as DWORD, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	SetConnectionSettings as function(byval as IDirectPlayLobby ptr, byval as DWORD, byval as DWORD, byval as LPDPLCONNECTION) as HRESULT
	SetLobbyMessageEvent as function(byval as IDirectPlayLobby ptr, byval as DWORD, byval as DWORD, byval as HANDLE) as HRESULT
end type

type IDirectPlayLobby2Vtbl_ as IDirectPlayLobby2Vtbl

type IDirectPlayLobby2
	lpVtbl as IDirectPlayLobby2Vtbl_ ptr
end type

type IDirectPlayLobby2Vtbl
	QueryInterface as function(byval as IDirectPlayLobby2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlayLobby2 ptr) as ULONG
	Release as function(byval as IDirectPlayLobby2 ptr) as ULONG
	Connect as function(byval as IDirectPlayLobby2 ptr, byval as DWORD, byval as LPDIRECTPLAY2 ptr, byval as IUnknown ptr) as HRESULT
	CreateAddress as function(byval as IDirectPlayLobby2 ptr, byval as GUID ptr, byval as GUID ptr, byval as LPCVOID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	EnumAddress as function(byval as IDirectPlayLobby2 ptr, byval as LPDPENUMADDRESSCALLBACK, byval as LPCVOID, byval as DWORD, byval as LPVOID) as HRESULT
	EnumAddressTypes as function(byval as IDirectPlayLobby2 ptr, byval as LPDPLENUMADDRESSTYPESCALLBACK, byval as GUID ptr, byval as LPVOID, byval as DWORD) as HRESULT
	EnumLocalApplications as function(byval as IDirectPlayLobby2 ptr, byval as LPDPLENUMLOCALAPPLICATIONSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	GetConnectionSettings as function(byval as IDirectPlayLobby2 ptr, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	ReceiveLobbyMessage as function(byval as IDirectPlayLobby2 ptr, byval as DWORD, byval as DWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	RunApplication as function(byval as IDirectPlayLobby2 ptr, byval as DWORD, byval as LPDWORD, byval as LPDPLCONNECTION, byval as HANDLE) as HRESULT
	SendLobbyMessage as function(byval as IDirectPlayLobby2 ptr, byval as DWORD, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	SetConnectionSettings as function(byval as IDirectPlayLobby2 ptr, byval as DWORD, byval as DWORD, byval as LPDPLCONNECTION) as HRESULT
	SetLobbyMessageEvent as function(byval as IDirectPlayLobby2 ptr, byval as DWORD, byval as DWORD, byval as HANDLE) as HRESULT
	CreateCompoundAddress as function(byval as IDirectPlayLobby2 ptr, byval as LPCDPCOMPOUNDADDRESSELEMENT, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
end type

type IDirectPlayLobby3Vtbl_ as IDirectPlayLobby3Vtbl

type IDirectPlayLobby3
	lpVtbl as IDirectPlayLobby3Vtbl_ ptr
end type

type IDirectPlayLobby3Vtbl
	QueryInterface as function(byval as IDirectPlayLobby3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlayLobby3 ptr) as ULONG
	Release as function(byval as IDirectPlayLobby3 ptr) as ULONG
	Connect as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as LPDIRECTPLAY2 ptr, byval as IUnknown ptr) as HRESULT
	CreateAddress as function(byval as IDirectPlayLobby3 ptr, byval as GUID ptr, byval as GUID ptr, byval as LPCVOID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	EnumAddress as function(byval as IDirectPlayLobby3 ptr, byval as LPDPENUMADDRESSCALLBACK, byval as LPCVOID, byval as DWORD, byval as LPVOID) as HRESULT
	EnumAddressTypes as function(byval as IDirectPlayLobby3 ptr, byval as LPDPLENUMADDRESSTYPESCALLBACK, byval as GUID ptr, byval as LPVOID, byval as DWORD) as HRESULT
	EnumLocalApplications as function(byval as IDirectPlayLobby3 ptr, byval as LPDPLENUMLOCALAPPLICATIONSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	GetConnectionSettings as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	ReceiveLobbyMessage as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as DWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	RunApplication as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as LPDWORD, byval as LPDPLCONNECTION, byval as HANDLE) as HRESULT
	SendLobbyMessage as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	SetConnectionSettings as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as DWORD, byval as LPDPLCONNECTION) as HRESULT
	SetLobbyMessageEvent as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as DWORD, byval as HANDLE) as HRESULT
	CreateCompoundAddress as function(byval as IDirectPlayLobby3 ptr, byval as LPCDPCOMPOUNDADDRESSELEMENT, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	ConnectEx as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as IID ptr, byval as LPVOID ptr, byval as IUnknown ptr) as HRESULT
	RegisterApplication as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as LPVOID) as HRESULT
	UnregisterApplication as function(byval as IDirectPlayLobby3 ptr, byval as DWORD, byval as GUID ptr) as HRESULT
	WaitForConnectionSettings as function(byval as IDirectPlayLobby3 ptr, byval as DWORD) as HRESULT
end type

#define IDirectPlayLobby_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlayLobby_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlayLobby_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlayLobby_Connect(p,a,b,c) (p)->lpVtbl->Connect(p,a,b,c)
#define IDirectPlayLobby_ConnectEx(p,a,b,c,d) (p)->lpVtbl->ConnectEx(p,a,b,c,d)
#define IDirectPlayLobby_CreateAddress(p,a,b,c,d,e,f) (p)->lpVtbl->CreateAddress(p,a,b,c,d,e,f)
#define IDirectPlayLobby_CreateCompoundAddress(p,a,b,c,d) (p)->lpVtbl->CreateCompoundAddress(p,a,b,c,d)
#define IDirectPlayLobby_EnumAddress(p,a,b,c,d) (p)->lpVtbl->EnumAddress(p,a,b,c,d)
#define IDirectPlayLobby_EnumAddressTypes(p,a,b,c,d) (p)->lpVtbl->EnumAddressTypes(p,a,b,c,d)
#define IDirectPlayLobby_EnumLocalApplications(p,a,b,c) (p)->lpVtbl->EnumLocalApplications(p,a,b,c)
#define IDirectPlayLobby_GetConnectionSettings(p,a,b,c) (p)->lpVtbl->GetConnectionSettings(p,a,b,c)
#define IDirectPlayLobby_ReceiveLobbyMessage(p,a,b,c,d,e) (p)->lpVtbl->ReceiveLobbyMessage(p,a,b,c,d,e)
#define IDirectPlayLobby_RegisterApplication(p,a,b) (p)->lpVtbl->RegisterApplication(p,a,b)
#define IDirectPlayLobby_RunApplication(p,a,b,c,d) (p)->lpVtbl->RunApplication(p,a,b,c,d)
#define IDirectPlayLobby_SendLobbyMessage(p,a,b,c,d) (p)->lpVtbl->SendLobbyMessage(p,a,b,c,d)
#define IDirectPlayLobby_SetConnectionSettings(p,a,b,c) (p)->lpVtbl->SetConnectionSettings(p,a,b,c)
#define IDirectPlayLobby_SetLobbyMessageEvent(p,a,b,c) (p)->lpVtbl->SetLobbyMessageEvent(p,a,b,c)
#define IDirectPlayLobby_UnregisterApplication(p,a,b) (p)->lpVtbl->UnregisterApplication(p,a,b)
#define IDirectPlayLobby_WaitForConnectionSettings(p,a) (p)->lpVtbl->WaitForConnectionSettings(p,a)

#define DPLWAIT_CANCEL &h00000001
#define DPLMSG_SYSTEM &h00000001
#define DPLMSG_STANDARD &h00000002
#define DPLAPP_NOENUM &h80000000
#define DPLAPP_AUTOVOICE &h00000001
#define DPLAPP_SELFVOICE &h00000002

type DPLMSG_GENERIC
	dwType as DWORD
end type

type LPDPLMSG_GENERIC as DPLMSG_GENERIC ptr

type DPLMSG_SYSTEMMESSAGE
	dwType as DWORD
	guidInstance as GUID
end type

type LPDPLMSG_SYSTEMMESSAGE as DPLMSG_SYSTEMMESSAGE ptr

type DPLMSG_SETPROPERTY
	dwType as DWORD
	dwRequestID as DWORD
	guidPlayer as GUID
	guidPropertyTag as GUID
	dwDataSize as DWORD
	dwPropertyData(0 to 1-1) as DWORD
end type

type LPDPLMSG_SETPROPERTY as DPLMSG_SETPROPERTY ptr

#define DPL_NOCONFIRMATION 0

type DPLMSG_SETPROPERTYRESPONSE
	dwType as DWORD
	dwRequestID as DWORD
	guidPlayer as GUID
	guidPropertyTag as GUID
	hr as HRESULT
end type

type LPDPLMSG_SETPROPERTYRESPONSE as DPLMSG_SETPROPERTYRESPONSE ptr

type DPLMSG_GETPROPERTY
	dwType as DWORD
	dwRequestID as DWORD
	guidPlayer as GUID
	guidPropertyTag as GUID
end type

type LPDPLMSG_GETPROPERTY as DPLMSG_GETPROPERTY ptr

type DPLMSG_GETPROPERTYRESPONSE
	dwType as DWORD
	dwRequestID as DWORD
	guidPlayer as GUID
	guidPropertyTag as GUID
	hr as HRESULT
	dwDataSize as DWORD
	dwPropertyData(0 to 1-1) as DWORD
end type

type LPDPLMSG_GETPROPERTYRESPONSE as DPLMSG_GETPROPERTYRESPONSE ptr

type DPLMSG_NEWSESSIONHOST
	dwType as DWORD
	guidInstance as GUID
end type

type LPDPLMSG_NEWSESSIONHOST as DPLMSG_NEWSESSIONHOST ptr

#define DPLSYS_CONNECTIONSETTINGSREAD &h00000001
#define DPLSYS_DPLAYCONNECTFAILED &h00000002
#define DPLSYS_DPLAYCONNECTSUCCEEDED &h00000003
#define DPLSYS_APPTERMINATED &h00000004
#define DPLSYS_SETPROPERTY &h00000005
#define DPLSYS_SETPROPERTYRESPONSE &h00000006
#define DPLSYS_GETPROPERTY &h00000007
#define DPLSYS_GETPROPERTYRESPONSE &h00000008
#define DPLSYS_NEWSESSIONHOST &h00000009
#define DPLSYS_NEWCONNECTIONSETTINGS &h0000000A
#define DPLSYS_LOBBYCLIENTRELEASE &h0000000B
extern DPLPROPERTY_MessagesSupported alias "DPLPROPERTY_MessagesSupported" as GUID
extern DPLPROPERTY_LobbyGuid alias "DPLPROPERTY_LobbyGuid" as GUID
extern DPLPROPERTY_PlayerGuid alias "DPLPROPERTY_PlayerGuid" as GUID

type DPLDATA_PLAYERGUID
	guidPlayer as GUID
	dwPlayerFlags as DWORD
end type

type LPDPLDATA_PLAYERGUID as DPLDATA_PLAYERGUID ptr
extern DPLPROPERTY_PlayerScore alias "DPLPROPERTY_PlayerScore" as GUID

type DPLDATA_PLAYERSCORE
	dwScoreCount as DWORD
	Score(0 to 1-1) as LONG
end type

type LPDPLDATA_PLAYERSCORE as DPLDATA_PLAYERSCORE ptr

type DPADDRESS
	guidDataType as GUID
	dwDataSize as DWORD
end type

type LPDPADDRESS as DPADDRESS ptr

extern DPAID_TotalSize alias "DPAID_TotalSize" as GUID
extern DPAID_ServiceProvider alias "DPAID_ServiceProvider" as GUID
extern DPAID_LobbyProvider alias "DPAID_LobbyProvider" as GUID
extern DPAID_Phone alias "DPAID_Phone" as GUID
extern DPAID_PhoneW alias "DPAID_PhoneW" as GUID
extern DPAID_Modem alias "DPAID_Modem" as GUID
extern DPAID_ModemW alias "DPAID_ModemW" as GUID
extern DPAID_INet alias "DPAID_INet" as GUID
extern DPAID_INetW alias "DPAID_INetW" as GUID
extern DPAID_INetPort alias "DPAID_INetPort" as GUID

#define DPCPA_NOFLOW 0
#define DPCPA_XONXOFFFLOW 1
#define DPCPA_RTSFLOW 2
#define DPCPA_DTRFLOW 3
#define DPCPA_RTSDTRFLOW 4

type DPCOMPORTADDRESS
	dwComPort as DWORD
	dwBaudRate as DWORD
	dwStopBits as DWORD
	dwParity as DWORD
	dwFlowControl as DWORD
end type

type LPDPCOMPORTADDRESS as DPCOMPORTADDRESS ptr
extern DPAID_ComPort alias "DPAID_ComPort" as GUID

#define DPLAD_SYSTEM &h00000001

#endif
