''
''
'' dplobby8 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dplobby8_bi__
#define __win_dplobby8_bi__

#include once "win/ole2.bi"
#include once "win/dplay8.bi"

extern CLSID_DirectPlay8LobbiedApplication alias "CLSID_DirectPlay8LobbiedApplication" as GUID
extern CLSID_DirectPlay8LobbyClient alias "CLSID_DirectPlay8LobbyClient" as GUID
extern IID_IDirectPlay8LobbiedApplication alias "IID_IDirectPlay8LobbiedApplication" as GUID
extern IID_IDirectPlay8LobbyClient alias "IID_IDirectPlay8LobbyClient" as GUID

type PDIRECTPLAY8LOBBIEDAPPLICATION as IDirectPlay8LobbiedApplication ptr
type PDIRECTPLAY8LOBBYCLIENT as IDirectPlay8LobbyClient ptr

#define DPL_MSGID_LOBBY &h8000
#define DPL_MSGID_RECEIVE (&h0001 or &h8000)
#define DPL_MSGID_CONNECT (&h0002 or &h8000)
#define DPL_MSGID_DISCONNECT (&h0003 or &h8000)
#define DPL_MSGID_SESSION_STATUS (&h0004 or &h8000)
#define DPL_MSGID_CONNECTION_SETTINGS (&h0005 or &h8000)
#define DPLHANDLE_ALLCONNECTIONS &hFFFFFFFF
#define DPLSESSION_CONNECTED &h0001
#define DPLSESSION_COULDNOTCONNECT &h0002
#define DPLSESSION_DISCONNECTED &h0003
#define DPLSESSION_TERMINATED &h0004
#define DPLSESSION_HOSTMIGRATED &h0005
#define DPLSESSION_HOSTMIGRATEDHERE &h0006
#define DPLAVAILABLE_ALLOWMULTIPLECONNECT &h0001
#define DPLCONNECT_LAUNCHNEW &h0001
#define DPLCONNECT_LAUNCHNOTFOUND &h0002
#define DPLCONNECTSETTINGS_HOST &h0001
#define DPLINITIALIZE_DISABLEPARAMVAL &h0001

type DPL_APPLICATION_INFO
	guidApplication as GUID
	pwszApplicationName as PWSTR
	dwNumRunning as DWORD
	dwNumWaiting as DWORD
	dwFlags as DWORD
end type

type PDPL_APPLICATION_INFO as DPL_APPLICATION_INFO ptr

type DPL_CONNECTION_SETTINGS
	dwSize as DWORD
	dwFlags as DWORD
	dpnAppDesc as DPN_APPLICATION_DESC
	pdp8HostAddress as IDirectPlay8Address ptr
	ppdp8DeviceAddresses as IDirectPlay8Address ptr ptr
	cNumDeviceAddresses as DWORD
	pwszPlayerName as PWSTR
end type

type PDPL_CONNECTION_SETTINGS as DPL_CONNECTION_SETTINGS ptr

type DPL_CONNECT_INFO
	dwSize as DWORD
	dwFlags as DWORD
	guidApplication as GUID
	pdplConnectionSettings as PDPL_CONNECTION_SETTINGS
	pvLobbyConnectData as PVOID
	dwLobbyConnectDataSize as DWORD
end type

type PDPL_CONNECT_INFO as DPL_CONNECT_INFO ptr

type DPL_PROGRAM_DESC
	dwSize as DWORD
	dwFlags as DWORD
	guidApplication as GUID
	pwszApplicationName as PWSTR
	pwszCommandLine as PWSTR
	pwszCurrentDirectory as PWSTR
	pwszDescription as PWSTR
	pwszExecutableFilename as PWSTR
	pwszExecutablePath as PWSTR
	pwszLauncherFilename as PWSTR
	pwszLauncherPath as PWSTR
end type

type PDPL_PROGRAM_DESC as DPL_PROGRAM_DESC ptr

type DPL_MESSAGE_CONNECT
	dwSize as DWORD
	hConnectId as DPNHANDLE
	pdplConnectionSettings as PDPL_CONNECTION_SETTINGS
	pvLobbyConnectData as PVOID
	dwLobbyConnectDataSize as DWORD
	pvConnectionContext as PVOID
end type

type PDPL_MESSAGE_CONNECT as DPL_MESSAGE_CONNECT ptr

type DPL_MESSAGE_CONNECTION_SETTINGS
	dwSize as DWORD
	hSender as DPNHANDLE
	pdplConnectionSettings as PDPL_CONNECTION_SETTINGS
	pvConnectionContext as PVOID
end type

type PDPL_MESSAGE_CONNECTION_SETTINGS as DPL_MESSAGE_CONNECTION_SETTINGS ptr

type DPL_MESSAGE_DISCONNECT
	dwSize as DWORD
	hDisconnectId as DPNHANDLE
	hrReason as HRESULT
	pvConnectionContext as PVOID
end type

type PDPL_MESSAGE_DISCONNECT as DPL_MESSAGE_DISCONNECT ptr

type DPL_MESSAGE_RECEIVE
	dwSize as DWORD
	hSender as DPNHANDLE
	pBuffer as UBYTE ptr
	dwBufferSize as DWORD
	pvConnectionContext as PVOID
end type

type PDPL_MESSAGE_RECEIVE as DPL_MESSAGE_RECEIVE ptr

type DPL_MESSAGE_SESSION_STATUS
	dwSize as DWORD
	hSender as DPNHANDLE
	dwStatus as DWORD
	pvConnectionContext as PVOID
end type

type PDPL_MESSAGE_SESSION_STATUS as DPL_MESSAGE_SESSION_STATUS ptr

type IDirectPlay8LobbyClientVtbl_ as IDirectPlay8LobbyClientVtbl

type IDirectPlay8LobbyClient
	lpVtbl as IDirectPlay8LobbyClientVtbl_ ptr
end type

type IDirectPlay8LobbyClientVtbl
	QueryInterface as function(byval as IDirectPlay8LobbyClient ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay8LobbyClient ptr) as ULONG
	Release as function(byval as IDirectPlay8LobbyClient ptr) as ULONG
	Initialize as function(byval as IDirectPlay8LobbyClient ptr, byval as PVOID, byval as PFNDPNMESSAGEHANDLER, byval as DWORD) as HRESULT
	EnumLocalPrograms as function(byval as IDirectPlay8LobbyClient ptr, byval as GUID ptr, byval as UBYTE ptr, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	ConnectApplication as function(byval as IDirectPlay8LobbyClient ptr, byval as DPL_CONNECT_INFO ptr, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD, byval as DWORD) as HRESULT
	Send as function(byval as IDirectPlay8LobbyClient ptr, byval as DPNHANDLE, byval as UBYTE ptr, byval as DWORD, byval as DWORD) as HRESULT
	ReleaseApplication as function(byval as IDirectPlay8LobbyClient ptr, byval as DPNHANDLE, byval as DWORD) as HRESULT
	Close as function(byval as IDirectPlay8LobbyClient ptr, byval as DWORD) as HRESULT
	GetConnectionSettings as function(byval as IDirectPlay8LobbyClient ptr, byval as DPNHANDLE, byval as DPL_CONNECTION_SETTINGS ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	SetConnectionSettings as function(byval as IDirectPlay8LobbyClient ptr, byval as DPNHANDLE, byval as DPL_CONNECTION_SETTINGS ptr, byval as DWORD) as HRESULT
end type

type IDirectPlay8LobbiedApplicationVtbl_ as IDirectPlay8LobbiedApplicationVtbl

type IDirectPlay8LobbiedApplication
	lpVtbl as IDirectPlay8LobbiedApplicationVtbl_ ptr
end type

type IDirectPlay8LobbiedApplicationVtbl
	QueryInterface as function(byval as IDirectPlay8LobbiedApplication ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay8LobbiedApplication ptr) as ULONG
	Release as function(byval as IDirectPlay8LobbiedApplication ptr) as ULONG
	Initialize as function(byval as IDirectPlay8LobbiedApplication ptr, byval as PVOID, byval as PFNDPNMESSAGEHANDLER, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	RegisterProgram as function(byval as IDirectPlay8LobbiedApplication ptr, byval as PDPL_PROGRAM_DESC, byval as DWORD) as HRESULT
	UnRegisterProgram as function(byval as IDirectPlay8LobbiedApplication ptr, byval as GUID ptr, byval as DWORD) as HRESULT
	Send as function(byval as IDirectPlay8LobbiedApplication ptr, byval as DPNHANDLE, byval as UBYTE ptr, byval as DWORD, byval as DWORD) as HRESULT
	SetAppAvailable as function(byval as IDirectPlay8LobbiedApplication ptr, byval as BOOL, byval as DWORD) as HRESULT
	UpdateStatus as function(byval as IDirectPlay8LobbiedApplication ptr, byval as DPNHANDLE, byval as DWORD, byval as DWORD) as HRESULT
	Close as function(byval as IDirectPlay8LobbiedApplication ptr, byval as DWORD) as HRESULT
	GetConnectionSettings as function(byval as IDirectPlay8LobbiedApplication ptr, byval as DPNHANDLE, byval as DPL_CONNECTION_SETTINGS ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	SetConnectionSettings as function(byval as IDirectPlay8LobbiedApplication ptr, byval as DPNHANDLE, byval as DPL_CONNECTION_SETTINGS ptr, byval as DWORD) as HRESULT
end type

#define IDirectPlay8LobbyClient_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8LobbyClient_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8LobbyClient_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8LobbyClient_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectPlay8LobbyClient_EnumLocalPrograms(p,a,b,c,d,e) (p)->lpVtbl->EnumLocalPrograms(p,a,b,c,d,e)
#define IDirectPlay8LobbyClient_ConnectApplication(p,a,b,c,d,e) (p)->lpVtbl->ConnectApplication(p,a,b,c,d,e)
#define IDirectPlay8LobbyClient_Send(p,a,b,c,d) (p)->lpVtbl->Send(p,a,b,c,d)
#define IDirectPlay8LobbyClient_ReleaseApplication(p,a,b) (p)->lpVtbl->ReleaseApplication(p,a,b)
#define IDirectPlay8LobbyClient_Close(p,a) (p)->lpVtbl->Close(p,a)
#define IDirectPlay8LobbyClient_GetConnectionSettings(p,a,b,c,d) (p)->lpVtbl->GetConnectionSettings(p,a,b,c,d)
#define IDirectPlay8LobbyClient_SetConnectionSettings(p,a,b,c) (p)->lpVtbl->SetConnectionSettings(p,a,b,c)

#define IDirectPlay8LobbiedApplication_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8LobbiedApplication_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8LobbiedApplication_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8LobbiedApplication_Initialize(p,a,b,c,d) (p)->lpVtbl->Initialize(p,a,b,c,d)
#define IDirectPlay8LobbiedApplication_RegisterProgram(p,a,b) (p)->lpVtbl->RegisterProgram(p,a,b)
#define IDirectPlay8LobbiedApplication_UnRegisterProgram(p,a,b) (p)->lpVtbl->UnRegisterProgram(p,a,b)
#define IDirectPlay8LobbiedApplication_Send(p,a,b,c,d) (p)->lpVtbl->Send(p,a,b,c,d)
#define IDirectPlay8LobbiedApplication_SetAppAvailable(p,a,b) (p)->lpVtbl->SetAppAvailable(p,a,b)
#define IDirectPlay8LobbiedApplication_UpdateStatus(p,a,b,c) (p)->lpVtbl->UpdateStatus(p,a,b,c)
#define IDirectPlay8LobbiedApplication_Close(p,a) (p)->lpVtbl->Close(p,a)
#define IDirectPlay8LobbiedApplication_GetConnectionSettings(p,a,b,c,d) (p)->lpVtbl->GetConnectionSettings(p,a,b,c,d)
#define IDirectPlay8LobbiedApplication_SetConnectionSettings(p,a,b,c) (p)->lpVtbl->SetConnectionSettings(p,a,b,c)

#endif
