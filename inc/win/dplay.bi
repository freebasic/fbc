''
''
'' dplay -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dplay_bi__
#define __win_dplay_bi__

#inclib "dplayx"
#inclib "dxguid"

#include once "win/ole2.bi"

type LPRGLPVOID as LPVOID ptr ptr
type PRGPVOID as LPRGLPVOID
type LPRGPVOID as LPRGLPVOID
type PRGLPVOID as LPRGLPVOID
type PAPVOID as LPRGLPVOID
type LPAPVOID as LPRGLPVOID
type PALPVOID as LPRGLPVOID
type LPALPVOID as LPRGLPVOID
type LPVOIDV as any ptr

#define _FACDP &h877
#define MAKE_DPHRESULT( code )  MAKE_HRESULT( 1, _FACDP, code )

extern IID_IDirectPlay2 alias "IID_IDirectPlay2" as GUID
extern IID_IDirectPlay2A alias "IID_IDirectPlay2A" as GUID
extern IID_IDirectPlay3 alias "IID_IDirectPlay3" as GUID
extern IID_IDirectPlay3A alias "IID_IDirectPlay3A" as GUID
extern IID_IDirectPlay4 alias "IID_IDirectPlay4" as GUID
extern IID_IDirectPlay4A alias "IID_IDirectPlay4A" as GUID
extern CLSID_DirectPlay alias "CLSID_DirectPlay" as GUID
extern DPSPGUID_IPX alias "DPSPGUID_IPX" as GUID
extern DPSPGUID_TCPIP alias "DPSPGUID_TCPIP" as GUID
extern DPSPGUID_SERIAL alias "DPSPGUID_SERIAL" as GUID
extern DPSPGUID_MODEM alias "DPSPGUID_MODEM" as GUID

type LPDIRECTPLAY as IDirectPlay ptr
type LPDIRECTPLAY2 as IDirectPlay2 ptr
type LPDIRECTPLAY2A as IDirectPlay2 ptr
type IDirectPlay2A as IDirectPlay2
type LPDIRECTPLAY3 as IDirectPlay3 ptr
type LPDIRECTPLAY3A as IDirectPlay3 ptr
type IDirectPlay3A as IDirectPlay3
type LPDIRECTPLAY4 as IDirectPlay4 ptr
type LPDIRECTPLAY4A as IDirectPlay4 ptr
type IDirectPlay4A as IDirectPlay4
type DPID as DWORD
type LPDPID as DWORD ptr

#define DPID_SYSMSG 0
#define DPID_ALLPLAYERS 0
#define DPID_SERVERPLAYER 1
#define DPID_RESERVEDRANGE 100
#define DPID_UNKNOWN &hFFFFFFFF

type DPCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwMaxBufferSize as DWORD
	dwMaxQueueSize as DWORD
	dwMaxPlayers as DWORD
	dwHundredBaud as DWORD
	dwLatency as DWORD
	dwMaxLocalPlayers as DWORD
	dwHeaderLength as DWORD
	dwTimeout as DWORD
end type

type LPDPCAPS as DPCAPS ptr

#define DPCAPS_ISHOST &h00000002
#define DPCAPS_GROUPOPTIMIZED &h00000008
#define DPCAPS_KEEPALIVEOPTIMIZED &h00000010
#define DPCAPS_GUARANTEEDOPTIMIZED &h00000020
#define DPCAPS_GUARANTEEDSUPPORTED &h00000040
#define DPCAPS_SIGNINGSUPPORTED &h00000080
#define DPCAPS_ENCRYPTIONSUPPORTED &h00000100
#define DPPLAYERCAPS_LOCAL &h00000800
#define DPCAPS_ASYNCCANCELSUPPORTED &h00001000
#define DPCAPS_ASYNCCANCELALLSUPPORTED &h00002000
#define DPCAPS_SENDTIMEOUTSUPPORTED &h00004000
#define DPCAPS_SENDPRIORITYSUPPORTED &h00008000
#define DPCAPS_ASYNCSUPPORTED &h00010000

type DPSESSIONDESC2
	dwSize as DWORD
	dwFlags as DWORD
	guidInstance as GUID
	guidApplication as GUID
	dwMaxPlayers as DWORD
	dwCurrentPlayers as DWORD
    union
        as LPWSTR lpszSessionName
        as LPSTR lpszSessionNameA
    end union
    union
        as LPWSTR lpszPassword
        as LPSTR lpszPasswordA
	end union
	dwReserved1 as DWORD
	dwReserved2 as DWORD
	dwUser1 as DWORD
	dwUser2 as DWORD
	dwUser3 as DWORD
	dwUser4 as DWORD
end type

type LPDPSESSIONDESC2 as DPSESSIONDESC2 ptr
type LPDPSESSIONDESC2_V as DPSESSIONDESC2 ptr
type LPCDPSESSIONDESC2 as const DPSESSIONDESC2 ptr

#define DPSESSION_NEWPLAYERSDISABLED &h00000001
#define DPSESSION_MIGRATEHOST &h00000004
#define DPSESSION_NOMESSAGEID &h00000008
#define DPSESSION_JOINDISABLED &h00000020
#define DPSESSION_KEEPALIVE &h00000040
#define DPSESSION_NODATAMESSAGES &h00000080
#define DPSESSION_SECURESERVER &h00000100
#define DPSESSION_PRIVATE &h00000200
#define DPSESSION_PASSWORDREQUIRED &h00000400
#define DPSESSION_MULTICASTSERVER &h00000800
#define DPSESSION_CLIENTSERVER &h00001000
#define DPSESSION_DIRECTPLAYPROTOCOL &h00002000
#define DPSESSION_NOPRESERVEORDER &h00004000
#define DPSESSION_OPTIMIZELATENCY &h00008000
#define DPSESSION_ALLOWVOICERETRO &h00010000
#define DPSESSION_NOSESSIONDESCMESSAGES &h00020000

type DPNAME
	dwSize as DWORD
	dwFlags as DWORD
    union
        as LPWSTR lpszShortName
        as LPSTR lpszShortNameA
    end union
    union
        as LPWSTR lpszLongName
        as LPSTR lpszLongNameA
	end union
end type

type LPDPNAME as DPNAME ptr
type LPCDPNAME as const DPNAME ptr

type DPCREDENTIALS
	dwSize as DWORD
	dwFlags as DWORD
    union
        as LPWSTR lpszUsername
        as LPSTR lpszUsernameA
    end union
    union
        as LPWSTR lpszPassword
        as LPSTR lpszPasswordA
    end union
    union
        as LPWSTR lpszDomain
        as LPSTR lpszDomainA
    end union
end type

type LPDPCREDENTIALS as const DPCREDENTIALS ptr
type LPCDPCREDENTIALS as const DPCREDENTIALS ptr

type DPSECURITYDESC
	dwSize as DWORD
	dwFlags as DWORD
    union
        as LPWSTR lpszSSPIProvider
        as LPSTR lpszSSPIProviderA
    end union
    union
        as LPWSTR lpszCAPIProvider
        as LPSTR lpszCAPIProviderA
    end union
	dwCAPIProviderType as DWORD
	dwEncryptionAlgorithm as DWORD
end type

type LPDPSECURITYDESC as DPSECURITYDESC ptr
type LPCDPSECURITYDESC as const DPSECURITYDESC ptr

type DPACCOUNTDESC
	dwSize as DWORD
	dwFlags as DWORD
    union
        as LPWSTR lpszAccountID
        as LPSTR lpszAccountIDA
    end union
end type

type LPDPACCOUNTDESC as DPACCOUNTDESC ptr
type LPCDPACCOUNTDESC as const DPACCOUNTDESC ptr
type LPCGUID as const GUID ptr

type DPLCONNECTION
	dwSize as DWORD
	dwFlags as DWORD
	lpSessionDesc as LPDPSESSIONDESC2
	lpPlayerName as LPDPNAME
	guidSP as GUID
	lpAddress as LPVOID
	dwAddressSize as DWORD
end type

type LPDPLCONNECTION as DPLCONNECTION ptr
type LPCDPLCONNECTION as const DPLCONNECTION ptr

type DPCHAT
	dwSize as DWORD
	dwFlags as DWORD
    union
        as LPWSTR lpszMessage
        as LPSTR lpszMessageA
    end union
end type

type LPDPCHAT as DPCHAT ptr

type SGBUFFER
	len as UINT
	pData as PUCHAR
end type

type PSGBUFFER as SGBUFFER ptr
type LPSGBUFFER as SGBUFFER ptr
type LPDPENUMSESSIONSCALLBACK2 as function(byval as LPCDPSESSIONDESC2, byval as LPDWORD, byval as DWORD, byval as LPVOID) as BOOL

#define DPESC_TIMEDOUT &h00000001

type LPDPENUMPLAYERSCALLBACK2 as function(byval as DPID, byval as DWORD, byval as LPCDPNAME, byval as DWORD, byval as LPVOID) as BOOL
type LPDPENUMCONNECTIONSCALLBACK as function(byval as LPCGUID, byval as LPVOID, byval as DWORD, byval as LPCDPNAME, byval as DWORD, byval as LPVOID) as BOOL

#ifndef UNICODE
type LPDPENUMDPCALLBACK as function(byval as LPGUID, byval as LPSTR, byval as DWORD, byval as DWORD, byval as LPVOID) as BOOL
declare function DirectPlayEnumerate alias "DirectPlayEnumerateA" (byval as LPDPENUMDPCALLBACK, byval as LPVOID) as HRESULT
#else
type LPDPENUMDPCALLBACK as function(byval as LPGUID, byval as LPWSTR, byval as DWORD, byval as DWORD, byval as LPVOID) as BOOL
declare function DirectPlayEnumerate alias "DirectPlayEnumerateW" (byval as LPDPENUMDPCALLBACK, byval as LPVOID) as HRESULT
#endif

declare function DirectPlayCreate alias "DirectPlayCreate" (byval lpGUID as LPGUID, byval lplpDP as LPDIRECTPLAY ptr, byval pUnk as IUnknown ptr) as HRESULT

type IDirectPlay2Vtbl_ as IDirectPlay2Vtbl

type IDirectPlay2
	lpVtbl as IDirectPlay2Vtbl_ ptr
end type

type IDirectPlay2Vtbl
	QueryInterface as function(byval as IDirectPlay2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay2 ptr) as ULONG
	Release as function(byval as IDirectPlay2 ptr) as ULONG
	AddPlayerToGroup as function(byval as IDirectPlay2 ptr, byval as DPID, byval as DPID) as HRESULT
	Close as function(byval as IDirectPlay2 ptr) as HRESULT
	CreateGroup as function(byval as IDirectPlay2 ptr, byval as LPDPID, byval as LPDPNAME, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	CreatePlayer as function(byval as IDirectPlay2 ptr, byval as LPDPID, byval as LPDPNAME, byval as HANDLE, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	DeletePlayerFromGroup as function(byval as IDirectPlay2 ptr, byval as DPID, byval as DPID) as HRESULT
	DestroyGroup as function(byval as IDirectPlay2 ptr, byval as DPID) as HRESULT
	DestroyPlayer as function(byval as IDirectPlay2 ptr, byval as DPID) as HRESULT
	EnumGroupPlayers as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumGroups as function(byval as IDirectPlay2 ptr, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumPlayers as function(byval as IDirectPlay2 ptr, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumSessions as function(byval as IDirectPlay2 ptr, byval as LPDPSESSIONDESC2, byval as DWORD, byval as LPDPENUMSESSIONSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	GetCaps as function(byval as IDirectPlay2 ptr, byval as LPDPCAPS, byval as DWORD) as HRESULT
	GetGroupData as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD, byval as DWORD) as HRESULT
	GetGroupName as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetMessageCount as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPDWORD) as HRESULT
	GetPlayerAddress as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetPlayerCaps as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPDPCAPS, byval as DWORD) as HRESULT
	GetPlayerData as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD, byval as DWORD) as HRESULT
	GetPlayerName as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetSessionDesc as function(byval as IDirectPlay2 ptr, byval as LPVOID, byval as LPDWORD) as HRESULT
	Initialize as function(byval as IDirectPlay2 ptr, byval as LPGUID) as HRESULT
	Open as function(byval as IDirectPlay2 ptr, byval as LPDPSESSIONDESC2, byval as DWORD) as HRESULT
	Receive as function(byval as IDirectPlay2 ptr, byval as LPDPID, byval as LPDPID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	Send as function(byval as IDirectPlay2 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	SetGroupData as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	SetGroupName as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPDPNAME, byval as DWORD) as HRESULT
	SetPlayerData as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	SetPlayerName as function(byval as IDirectPlay2 ptr, byval as DPID, byval as LPDPNAME, byval as DWORD) as HRESULT
	SetSessionDesc as function(byval as IDirectPlay2 ptr, byval as LPDPSESSIONDESC2, byval as DWORD) as HRESULT
end type

#define IDirectPlay2_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay2_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay2_AddPlayerToGroup(p,a,b) (p)->lpVtbl->AddPlayerToGroup(p,a,b)
#define IDirectPlay2_Close(p) (p)->lpVtbl->Close(p)
#define IDirectPlay2_CreateGroup(p,a,b,c,d,e) (p)->lpVtbl->CreateGroup(p,a,b,c,d,e)
#define IDirectPlay2_CreatePlayer(p,a,b,c,d,e,f) (p)->lpVtbl->CreatePlayer(p,a,b,c,d,e,f)
#define IDirectPlay2_DeletePlayerFromGroup(p,a,b) (p)->lpVtbl->DeletePlayerFromGroup(p,a,b)
#define IDirectPlay2_DestroyGroup(p,a) (p)->lpVtbl->DestroyGroup(p,a)
#define IDirectPlay2_DestroyPlayer(p,a) (p)->lpVtbl->DestroyPlayer(p,a)
#define IDirectPlay2_EnumGroupPlayers(p,a,b,c,d,e) (p)->lpVtbl->EnumGroupPlayers(p,a,b,c,d,e)
#define IDirectPlay2_EnumGroups(p,a,b,c,d) (p)->lpVtbl->EnumGroups(p,a,b,c,d)
#define IDirectPlay2_EnumPlayers(p,a,b,c,d) (p)->lpVtbl->EnumPlayers(p,a,b,c,d)
#define IDirectPlay2_EnumSessions(p,a,b,c,d,e) (p)->lpVtbl->EnumSessions(p,a,b,c,d,e)
#define IDirectPlay2_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirectPlay2_GetMessageCount(p,a,b) (p)->lpVtbl->GetMessageCount(p,a,b)
#define IDirectPlay2_GetGroupData(p,a,b,c,d) (p)->lpVtbl->GetGroupData(p,a,b,c,d)
#define IDirectPlay2_GetGroupName(p,a,b,c) (p)->lpVtbl->GetGroupName(p,a,b,c)
#define IDirectPlay2_GetPlayerAddress(p,a,b,c) (p)->lpVtbl->GetPlayerAddress(p,a,b,c)
#define IDirectPlay2_GetPlayerCaps(p,a,b,c) (p)->lpVtbl->GetPlayerCaps(p,a,b,c)
#define IDirectPlay2_GetPlayerData(p,a,b,c,d) (p)->lpVtbl->GetPlayerData(p,a,b,c,d)
#define IDirectPlay2_GetPlayerName(p,a,b,c) (p)->lpVtbl->GetPlayerName(p,a,b,c)
#define IDirectPlay2_GetSessionDesc(p,a,b) (p)->lpVtbl->GetSessionDesc(p,a,b)
#define IDirectPlay2_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirectPlay2_Open(p,a,b) (p)->lpVtbl->Open(p,a,b)
#define IDirectPlay2_Receive(p,a,b,c,d,e) (p)->lpVtbl->Receive(p,a,b,c,d,e)
#define IDirectPlay2_Send(p,a,b,c,d,e) (p)->lpVtbl->Send(p,a,b,c,d,e)
#define IDirectPlay2_SetGroupData(p,a,b,c,d) (p)->lpVtbl->SetGroupData(p,a,b,c,d)
#define IDirectPlay2_SetGroupName(p,a,b,c) (p)->lpVtbl->SetGroupName(p,a,b,c)
#define IDirectPlay2_SetPlayerData(p,a,b,c,d) (p)->lpVtbl->SetPlayerData(p,a,b,c,d)
#define IDirectPlay2_SetPlayerName(p,a,b,c) (p)->lpVtbl->SetPlayerName(p,a,b,c)
#define IDirectPlay2_SetSessionDesc(p,a,b) (p)->lpVtbl->SetSessionDesc(p,a,b)

type IDirectPlay3Vtbl_ as IDirectPlay3Vtbl

type IDirectPlay3
	lpVtbl as IDirectPlay3Vtbl_ ptr
end type

type IDirectPlay3Vtbl
	QueryInterface as function(byval as IDirectPlay3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay3 ptr) as ULONG
	Release as function(byval as IDirectPlay3 ptr) as ULONG
	AddPlayerToGroup as function(byval as IDirectPlay3 ptr, byval as DPID, byval as DPID) as HRESULT
	Close as function(byval as IDirectPlay3 ptr) as HRESULT
	CreateGroup as function(byval as IDirectPlay3 ptr, byval as LPDPID, byval as LPDPNAME, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	CreatePlayer as function(byval as IDirectPlay3 ptr, byval as LPDPID, byval as LPDPNAME, byval as HANDLE, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	DeletePlayerFromGroup as function(byval as IDirectPlay3 ptr, byval as DPID, byval as DPID) as HRESULT
	DestroyGroup as function(byval as IDirectPlay3 ptr, byval as DPID) as HRESULT
	DestroyPlayer as function(byval as IDirectPlay3 ptr, byval as DPID) as HRESULT
	EnumGroupPlayers as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumGroups as function(byval as IDirectPlay3 ptr, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumPlayers as function(byval as IDirectPlay3 ptr, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumSessions as function(byval as IDirectPlay3 ptr, byval as LPDPSESSIONDESC2, byval as DWORD, byval as LPDPENUMSESSIONSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	GetCaps as function(byval as IDirectPlay3 ptr, byval as LPDPCAPS, byval as DWORD) as HRESULT
	GetGroupData as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD, byval as DWORD) as HRESULT
	GetGroupName as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetMessageCount as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPDWORD) as HRESULT
	GetPlayerAddress as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetPlayerCaps as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPDPCAPS, byval as DWORD) as HRESULT
	GetPlayerData as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD, byval as DWORD) as HRESULT
	GetPlayerName as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetSessionDesc as function(byval as IDirectPlay3 ptr, byval as LPVOID, byval as LPDWORD) as HRESULT
	Initialize as function(byval as IDirectPlay3 ptr, byval as LPGUID) as HRESULT
	Open as function(byval as IDirectPlay3 ptr, byval as LPDPSESSIONDESC2, byval as DWORD) as HRESULT
	Receive as function(byval as IDirectPlay3 ptr, byval as LPDPID, byval as LPDPID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	Send as function(byval as IDirectPlay3 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	SetGroupData as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	SetGroupName as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPDPNAME, byval as DWORD) as HRESULT
	SetPlayerData as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	SetPlayerName as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPDPNAME, byval as DWORD) as HRESULT
	SetSessionDesc as function(byval as IDirectPlay3 ptr, byval as LPDPSESSIONDESC2, byval as DWORD) as HRESULT
	AddGroupToGroup as function(byval as IDirectPlay3 ptr, byval as DPID, byval as DPID) as HRESULT
	CreateGroupInGroup as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPDPID, byval as LPDPNAME, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	DeleteGroupFromGroup as function(byval as IDirectPlay3 ptr, byval as DPID, byval as DPID) as HRESULT
	EnumConnections as function(byval as IDirectPlay3 ptr, byval as LPCGUID, byval as LPDPENUMCONNECTIONSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	EnumGroupsInGroup as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	GetGroupConnectionSettings as function(byval as IDirectPlay3 ptr, byval as DWORD, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	InitializeConnection as function(byval as IDirectPlay3 ptr, byval as LPVOID, byval as DWORD) as HRESULT
	SecureOpen as function(byval as IDirectPlay3 ptr, byval as LPCDPSESSIONDESC2, byval as DWORD, byval as LPCDPSECURITYDESC, byval as LPCDPCREDENTIALS) as HRESULT
	SendChatMessage as function(byval as IDirectPlay3 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPDPCHAT) as HRESULT
	SetGroupConnectionSettings as function(byval as IDirectPlay3 ptr, byval as DWORD, byval as DPID, byval as LPDPLCONNECTION) as HRESULT
	StartSession as function(byval as IDirectPlay3 ptr, byval as DWORD, byval as DPID) as HRESULT
	GetGroupFlags as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPDWORD) as HRESULT
	GetGroupParent as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPDPID) as HRESULT
	GetPlayerAccount as function(byval as IDirectPlay3 ptr, byval as DPID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetPlayerFlags as function(byval as IDirectPlay3 ptr, byval as DPID, byval as LPDWORD) as HRESULT
end type

#define IDirectPlay3_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay3_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay3_AddPlayerToGroup(p,a,b) (p)->lpVtbl->AddPlayerToGroup(p,a,b)
#define IDirectPlay3_Close(p) (p)->lpVtbl->Close(p)
#define IDirectPlay3_CreateGroup(p,a,b,c,d,e) (p)->lpVtbl->CreateGroup(p,a,b,c,d,e)
#define IDirectPlay3_CreatePlayer(p,a,b,c,d,e,f) (p)->lpVtbl->CreatePlayer(p,a,b,c,d,e,f)
#define IDirectPlay3_DeletePlayerFromGroup(p,a,b) (p)->lpVtbl->DeletePlayerFromGroup(p,a,b)
#define IDirectPlay3_DestroyGroup(p,a) (p)->lpVtbl->DestroyGroup(p,a)
#define IDirectPlay3_DestroyPlayer(p,a) (p)->lpVtbl->DestroyPlayer(p,a)
#define IDirectPlay3_EnumGroupPlayers(p,a,b,c,d,e) (p)->lpVtbl->EnumGroupPlayers(p,a,b,c,d,e)
#define IDirectPlay3_EnumGroups(p,a,b,c,d) (p)->lpVtbl->EnumGroups(p,a,b,c,d)
#define IDirectPlay3_EnumPlayers(p,a,b,c,d) (p)->lpVtbl->EnumPlayers(p,a,b,c,d)
#define IDirectPlay3_EnumSessions(p,a,b,c,d,e) (p)->lpVtbl->EnumSessions(p,a,b,c,d,e)
#define IDirectPlay3_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirectPlay3_GetMessageCount(p,a,b) (p)->lpVtbl->GetMessageCount(p,a,b)
#define IDirectPlay3_GetGroupData(p,a,b,c,d) (p)->lpVtbl->GetGroupData(p,a,b,c,d)
#define IDirectPlay3_GetGroupName(p,a,b,c) (p)->lpVtbl->GetGroupName(p,a,b,c)
#define IDirectPlay3_GetPlayerAddress(p,a,b,c) (p)->lpVtbl->GetPlayerAddress(p,a,b,c)
#define IDirectPlay3_GetPlayerCaps(p,a,b,c) (p)->lpVtbl->GetPlayerCaps(p,a,b,c)
#define IDirectPlay3_GetPlayerData(p,a,b,c,d) (p)->lpVtbl->GetPlayerData(p,a,b,c,d)
#define IDirectPlay3_GetPlayerName(p,a,b,c) (p)->lpVtbl->GetPlayerName(p,a,b,c)
#define IDirectPlay3_GetSessionDesc(p,a,b) (p)->lpVtbl->GetSessionDesc(p,a,b)
#define IDirectPlay3_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirectPlay3_Open(p,a,b) (p)->lpVtbl->Open(p,a,b)
#define IDirectPlay3_Receive(p,a,b,c,d,e) (p)->lpVtbl->Receive(p,a,b,c,d,e)
#define IDirectPlay3_Send(p,a,b,c,d,e) (p)->lpVtbl->Send(p,a,b,c,d,e)
#define IDirectPlay3_SetGroupData(p,a,b,c,d) (p)->lpVtbl->SetGroupData(p,a,b,c,d)
#define IDirectPlay3_SetGroupName(p,a,b,c) (p)->lpVtbl->SetGroupName(p,a,b,c)
#define IDirectPlay3_SetPlayerData(p,a,b,c,d) (p)->lpVtbl->SetPlayerData(p,a,b,c,d)
#define IDirectPlay3_SetPlayerName(p,a,b,c) (p)->lpVtbl->SetPlayerName(p,a,b,c)
#define IDirectPlay3_SetSessionDesc(p,a,b) (p)->lpVtbl->SetSessionDesc(p,a,b)
#define IDirectPlay3_AddGroupToGroup(p,a,b) (p)->lpVtbl->AddGroupToGroup(p,a,b)
#define IDirectPlay3_CreateGroupInGroup(p,a,b,c,d,e,f) (p)->lpVtbl->CreateGroupInGroup(p,a,b,c,d,e,f)
#define IDirectPlay3_DeleteGroupFromGroup(p,a,b) (p)->lpVtbl->DeleteGroupFromGroup(p,a,b)
#define IDirectPlay3_EnumConnections(p,a,b,c,d) (p)->lpVtbl->EnumConnections(p,a,b,c,d)
#define IDirectPlay3_EnumGroupsInGroup(p,a,b,c,d,e) (p)->lpVtbl->EnumGroupsInGroup(p,a,b,c,d,e)
#define IDirectPlay3_GetGroupConnectionSettings(p,a,b,c,d) (p)->lpVtbl->GetGroupConnectionSettings(p,a,b,c,d)
#define IDirectPlay3_InitializeConnection(p,a,b) (p)->lpVtbl->InitializeConnection(p,a,b)
#define IDirectPlay3_SecureOpen(p,a,b,c,d) (p)->lpVtbl->SecureOpen(p,a,b,c,d)
#define IDirectPlay3_SendChatMessage(p,a,b,c,d) (p)->lpVtbl->SendChatMessage(p,a,b,c,d)
#define IDirectPlay3_SetGroupConnectionSettings(p,a,b,c) (p)->lpVtbl->SetGroupConnectionSettings(p,a,b,c)
#define IDirectPlay3_StartSession(p,a,b) (p)->lpVtbl->StartSession(p,a,b)
#define IDirectPlay3_GetGroupFlags(p,a,b) (p)->lpVtbl->GetGroupFlags(p,a,b)
#define IDirectPlay3_GetGroupParent(p,a,b) (p)->lpVtbl->GetGroupParent(p,a,b)
#define IDirectPlay3_GetPlayerAccount(p,a,b,c,d) (p)->lpVtbl->GetPlayerAccount(p,a,b,c,d)
#define IDirectPlay3_GetPlayerFlags(p,a,b) (p)->lpVtbl->GetPlayerFlags(p,a,b)

type IDirectPlay4Vtbl_ as IDirectPlay4Vtbl

type IDirectPlay4
	lpVtbl as IDirectPlay4Vtbl_ ptr
end type

type IDirectPlay4Vtbl
	QueryInterface as function(byval as IDirectPlay4 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay4 ptr) as ULONG
	Release as function(byval as IDirectPlay4 ptr) as ULONG
	AddPlayerToGroup as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID) as HRESULT
	Close as function(byval as IDirectPlay4 ptr) as HRESULT
	CreateGroup as function(byval as IDirectPlay4 ptr, byval as LPDPID, byval as LPDPNAME, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	CreatePlayer as function(byval as IDirectPlay4 ptr, byval as LPDPID, byval as LPDPNAME, byval as HANDLE, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	DeletePlayerFromGroup as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID) as HRESULT
	DestroyGroup as function(byval as IDirectPlay4 ptr, byval as DPID) as HRESULT
	DestroyPlayer as function(byval as IDirectPlay4 ptr, byval as DPID) as HRESULT
	EnumGroupPlayers as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumGroups as function(byval as IDirectPlay4 ptr, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumPlayers as function(byval as IDirectPlay4 ptr, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	EnumSessions as function(byval as IDirectPlay4 ptr, byval as LPDPSESSIONDESC2, byval as DWORD, byval as LPDPENUMSESSIONSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	GetCaps as function(byval as IDirectPlay4 ptr, byval as LPDPCAPS, byval as DWORD) as HRESULT
	GetGroupData as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD, byval as DWORD) as HRESULT
	GetGroupName as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetMessageCount as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDWORD) as HRESULT
	GetPlayerAddress as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetPlayerCaps as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDPCAPS, byval as DWORD) as HRESULT
	GetPlayerData as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD, byval as DWORD) as HRESULT
	GetPlayerName as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetSessionDesc as function(byval as IDirectPlay4 ptr, byval as LPVOID, byval as LPDWORD) as HRESULT
	Initialize as function(byval as IDirectPlay4 ptr, byval as LPGUID) as HRESULT
	Open as function(byval as IDirectPlay4 ptr, byval as LPDPSESSIONDESC2, byval as DWORD) as HRESULT
	Receive as function(byval as IDirectPlay4 ptr, byval as LPDPID, byval as LPDPID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	Send as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	SetGroupData as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	SetGroupName as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDPNAME, byval as DWORD) as HRESULT
	SetPlayerData as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	SetPlayerName as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDPNAME, byval as DWORD) as HRESULT
	SetSessionDesc as function(byval as IDirectPlay4 ptr, byval as LPDPSESSIONDESC2, byval as DWORD) as HRESULT
	AddGroupToGroup as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID) as HRESULT
	CreateGroupInGroup as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDPID, byval as LPDPNAME, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	DeleteGroupFromGroup as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID) as HRESULT
	EnumConnections as function(byval as IDirectPlay4 ptr, byval as LPCGUID, byval as LPDPENUMCONNECTIONSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	EnumGroupsInGroup as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPGUID, byval as LPDPENUMPLAYERSCALLBACK2, byval as LPVOID, byval as DWORD) as HRESULT
	GetGroupConnectionSettings as function(byval as IDirectPlay4 ptr, byval as DWORD, byval as DPID, byval as LPVOID, byval as LPDWORD) as HRESULT
	InitializeConnection as function(byval as IDirectPlay4 ptr, byval as LPVOID, byval as DWORD) as HRESULT
	SecureOpen as function(byval as IDirectPlay4 ptr, byval as LPCDPSESSIONDESC2, byval as DWORD, byval as LPCDPSECURITYDESC, byval as LPCDPCREDENTIALS) as HRESULT
	SendChatMessage as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPDPCHAT) as HRESULT
	SetGroupConnectionSettings as function(byval as IDirectPlay4 ptr, byval as DWORD, byval as DPID, byval as LPDPLCONNECTION) as HRESULT
	StartSession as function(byval as IDirectPlay4 ptr, byval as DWORD, byval as DPID) as HRESULT
	GetGroupFlags as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDWORD) as HRESULT
	GetGroupParent as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDPID) as HRESULT
	GetPlayerAccount as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetPlayerFlags as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDWORD) as HRESULT
	GetGroupOwner as function(byval as IDirectPlay4 ptr, byval as DPID, byval as LPDPID) as HRESULT
	SetGroupOwner as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID) as HRESULT
	SendEx as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPVOID, byval as DWORD ptr) as HRESULT
	GetMessageQueue as function(byval as IDirectPlay4 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPDWORD, byval as LPDWORD) as HRESULT
	CancelMessage as function(byval as IDirectPlay4 ptr, byval as DWORD, byval as DWORD) as HRESULT
	CancelPriority as function(byval as IDirectPlay4 ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
end type

#define IDirectPlayX_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlayX_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlayX_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlayX_AddPlayerToGroup(p,a,b) (p)->lpVtbl->AddPlayerToGroup(p,a,b)
#define IDirectPlayX_CancelMessage(p,a,b) (p)->lpVtbl->CancelMessage(p,a,b)
#define IDirectPlayX_CancelPriority(p,a,b,c) (p)->lpVtbl->CancelPriority(p,a,b,c)
#define IDirectPlayX_Close(p) (p)->lpVtbl->Close(p)
#define IDirectPlayX_CreateGroup(p,a,b,c,d,e) (p)->lpVtbl->CreateGroup(p,a,b,c,d,e)
#define IDirectPlayX_CreatePlayer(p,a,b,c,d,e,f) (p)->lpVtbl->CreatePlayer(p,a,b,c,d,e,f)
#define IDirectPlayX_DeletePlayerFromGroup(p,a,b) (p)->lpVtbl->DeletePlayerFromGroup(p,a,b)
#define IDirectPlayX_DestroyGroup(p,a) (p)->lpVtbl->DestroyGroup(p,a)
#define IDirectPlayX_DestroyPlayer(p,a) (p)->lpVtbl->DestroyPlayer(p,a)
#define IDirectPlayX_EnumGroupPlayers(p,a,b,c,d,e) (p)->lpVtbl->EnumGroupPlayers(p,a,b,c,d,e)
#define IDirectPlayX_EnumGroups(p,a,b,c,d) (p)->lpVtbl->EnumGroups(p,a,b,c,d)
#define IDirectPlayX_EnumPlayers(p,a,b,c,d) (p)->lpVtbl->EnumPlayers(p,a,b,c,d)
#define IDirectPlayX_EnumSessions(p,a,b,c,d,e) (p)->lpVtbl->EnumSessions(p,a,b,c,d,e)
#define IDirectPlayX_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirectPlayX_GetMessageCount(p,a,b) (p)->lpVtbl->GetMessageCount(p,a,b)
#define IDirectPlayX_GetMessageQueue(p,a,b,c,d,e) (p)->lpVtbl->GetMessageQueue(p,a,b,c,d,e)
#define IDirectPlayX_GetGroupData(p,a,b,c,d) (p)->lpVtbl->GetGroupData(p,a,b,c,d)
#define IDirectPlayX_GetGroupName(p,a,b,c) (p)->lpVtbl->GetGroupName(p,a,b,c)
#define IDirectPlayX_GetPlayerAddress(p,a,b,c) (p)->lpVtbl->GetPlayerAddress(p,a,b,c)
#define IDirectPlayX_GetPlayerCaps(p,a,b,c) (p)->lpVtbl->GetPlayerCaps(p,a,b,c)
#define IDirectPlayX_GetPlayerData(p,a,b,c,d) (p)->lpVtbl->GetPlayerData(p,a,b,c,d)
#define IDirectPlayX_GetPlayerName(p,a,b,c) (p)->lpVtbl->GetPlayerName(p,a,b,c)
#define IDirectPlayX_GetSessionDesc(p,a,b) (p)->lpVtbl->GetSessionDesc(p,a,b)
#define IDirectPlayX_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirectPlayX_Open(p,a,b) (p)->lpVtbl->Open(p,a,b)
#define IDirectPlayX_Receive(p,a,b,c,d,e) (p)->lpVtbl->Receive(p,a,b,c,d,e)
#define IDirectPlayX_Send(p,a,b,c,d,e) (p)->lpVtbl->Send(p,a,b,c,d,e)
#define IDirectPlayX_SendEx(p,a,b,c,d,e,f,g,h,i) (p)->lpVtbl->SendEx(p,a,b,c,d,e,f,g,h,i)
#define IDirectPlayX_SetGroupData(p,a,b,c,d) (p)->lpVtbl->SetGroupData(p,a,b,c,d)
#define IDirectPlayX_SetGroupName(p,a,b,c) (p)->lpVtbl->SetGroupName(p,a,b,c)
#define IDirectPlayX_SetPlayerData(p,a,b,c,d) (p)->lpVtbl->SetPlayerData(p,a,b,c,d)
#define IDirectPlayX_SetPlayerName(p,a,b,c) (p)->lpVtbl->SetPlayerName(p,a,b,c)
#define IDirectPlayX_SetSessionDesc(p,a,b) (p)->lpVtbl->SetSessionDesc(p,a,b)
#define IDirectPlayX_AddGroupToGroup(p,a,b) (p)->lpVtbl->AddGroupToGroup(p,a,b)
#define IDirectPlayX_CreateGroupInGroup(p,a,b,c,d,e,f) (p)->lpVtbl->CreateGroupInGroup(p,a,b,c,d,e,f)
#define IDirectPlayX_DeleteGroupFromGroup(p,a,b) (p)->lpVtbl->DeleteGroupFromGroup(p,a,b)
#define IDirectPlayX_EnumConnections(p,a,b,c,d) (p)->lpVtbl->EnumConnections(p,a,b,c,d)
#define IDirectPlayX_EnumGroupsInGroup(p,a,b,c,d,e) (p)->lpVtbl->EnumGroupsInGroup(p,a,b,c,d,e)
#define IDirectPlayX_GetGroupConnectionSettings(p,a,b,c,d) (p)->lpVtbl->GetGroupConnectionSettings(p,a,b,c,d)
#define IDirectPlayX_InitializeConnection(p,a,b) (p)->lpVtbl->InitializeConnection(p,a,b)
#define IDirectPlayX_SecureOpen(p,a,b,c,d) (p)->lpVtbl->SecureOpen(p,a,b,c,d)
#define IDirectPlayX_SendChatMessage(p,a,b,c,d) (p)->lpVtbl->SendChatMessage(p,a,b,c,d)
#define IDirectPlayX_SetGroupConnectionSettings(p,a,b,c) (p)->lpVtbl->SetGroupConnectionSettings(p,a,b,c)
#define IDirectPlayX_StartSession(p,a,b) (p)->lpVtbl->StartSession(p,a,b)
#define IDirectPlayX_GetGroupFlags(p,a,b) (p)->lpVtbl->GetGroupFlags(p,a,b)
#define IDirectPlayX_GetGroupParent(p,a,b) (p)->lpVtbl->GetGroupParent(p,a,b)
#define IDirectPlayX_GetPlayerAccount(p,a,b,c,d) (p)->lpVtbl->GetPlayerAccount(p,a,b,c,d)
#define IDirectPlayX_GetPlayerFlags(p,a,b) (p)->lpVtbl->GetPlayerFlags(p,a,b)
#define IDirectPlayX_GetGroupOwner(p,a,b) (p)->lpVtbl->GetGroupOwner(p,a,b)
#define IDirectPlayX_SetGroupOwner(p,a,b) (p)->lpVtbl->SetGroupOwner(p,a,b)

#define DPCONNECTION_DIRECTPLAY &h00000001
#define DPCONNECTION_DIRECTPLAYLOBBY &h00000002
#define DPENUMPLAYERS_ALL &h00000000
#define DPENUMGROUPS_ALL &h00000000
#define DPENUMPLAYERS_LOCAL &h00000008
#define DPENUMGROUPS_LOCAL &h00000008
#define DPENUMPLAYERS_REMOTE &h00000010
#define DPENUMGROUPS_REMOTE &h00000010
#define DPENUMPLAYERS_GROUP &h00000020
#define DPENUMPLAYERS_SESSION &h00000080
#define DPENUMGROUPS_SESSION &h00000080
#define DPENUMPLAYERS_SERVERPLAYER &h00000100
#define DPENUMPLAYERS_SPECTATOR &h00000200
#define DPENUMGROUPS_SHORTCUT &h00000400
#define DPENUMGROUPS_STAGINGAREA &h00000800
#define DPENUMGROUPS_HIDDEN &h00001000
#define DPENUMPLAYERS_OWNER &h00002000
#define DPPLAYER_SERVERPLAYER &h00000100
#define DPPLAYER_SPECTATOR &h00000200
#define DPPLAYER_LOCAL &h00000008
#define DPPLAYER_OWNER &h00002000
#define DPGROUP_STAGINGAREA &h00000800
#define DPGROUP_LOCAL &h00000008
#define DPGROUP_HIDDEN &h00001000
#define DPENUMSESSIONS_AVAILABLE &h00000001
#define DPENUMSESSIONS_ALL &h00000002
#define DPENUMSESSIONS_ASYNC &h00000010
#define DPENUMSESSIONS_STOPASYNC &h00000020
#define DPENUMSESSIONS_PASSWORDREQUIRED &h00000040
#define DPENUMSESSIONS_RETURNSTATUS &h00000080
#define DPGETCAPS_GUARANTEED &h00000001
#define DPGET_REMOTE &h00000000
#define DPGET_LOCAL &h00000001
#define DPOPEN_JOIN &h00000001
#define DPOPEN_CREATE &h00000002
#define DPOPEN_RETURNSTATUS &h00000080
#define DPLCONNECTION_CREATESESSION &h00000002
#define DPLCONNECTION_JOINSESSION &h00000001
#define DPRECEIVE_ALL &h00000001
#define DPRECEIVE_TOPLAYER &h00000002
#define DPRECEIVE_FROMPLAYER &h00000004
#define DPRECEIVE_PEEK &h00000008
#define DPSEND_GUARANTEED &h00000001
#define DPSEND_HIGHPRIORITY &h00000002
#define DPSEND_OPENSTREAM &h00000008
#define DPSEND_CLOSESTREAM &h00000010
#define DPSEND_SIGNED &h00000020
#define DPSEND_ENCRYPTED &h00000040
#define DPSEND_LOBBYSYSTEMMESSAGE &h00000080
#define DPSEND_ASYNC &h00000200
#define DPSEND_NOSENDCOMPLETEMSG &h00000400
#define DPSEND_MAX_PRI &h0000FFFF
#define DPSEND_MAX_PRIORITY &h0000FFFF
#define DPSET_REMOTE &h00000000
#define DPSET_LOCAL &h00000001
#define DPSET_GUARANTEED &h00000002
#define DPMESSAGEQUEUE_SEND &h00000001
#define DPMESSAGEQUEUE_RECEIVE &h00000002
#define DPCONNECT_RETURNSTATUS (&h00000080)
#define DPSYS_CREATEPLAYERORGROUP &h0003
#define DPSYS_DESTROYPLAYERORGROUP &h0005
#define DPSYS_ADDPLAYERTOGROUP &h0007
#define DPSYS_DELETEPLAYERFROMGROUP &h0021
#define DPSYS_SESSIONLOST &h0031
#define DPSYS_HOST &h0101
#define DPSYS_SETPLAYERORGROUPDATA &h0102
#define DPSYS_SETPLAYERORGROUPNAME &h0103
#define DPSYS_SETSESSIONDESC &h0104
#define DPSYS_ADDGROUPTOGROUP &h0105
#define DPSYS_DELETEGROUPFROMGROUP &h0106
#define DPSYS_SECUREMESSAGE &h0107
#define DPSYS_STARTSESSION &h0108
#define DPSYS_CHAT &h0109
#define DPSYS_SETGROUPOWNER &h010A
#define DPSYS_SENDCOMPLETE &h010d
#define DPPLAYERTYPE_GROUP &h00000000
#define DPPLAYERTYPE_PLAYER &h00000001

type DPMSG_GENERIC
	dwType as DWORD
end type

type LPDPMSG_GENERIC as DPMSG_GENERIC ptr

type DPMSG_CREATEPLAYERORGROUP
	dwType as DWORD
	dwPlayerType as DWORD
	dpId as DPID
	dwCurrentPlayers as DWORD
	lpData as LPVOID
	dwDataSize as DWORD
	dpnName as DPNAME
	dpIdParent as DPID
	dwFlags as DWORD
end type

type LPDPMSG_CREATEPLAYERORGROUP as DPMSG_CREATEPLAYERORGROUP ptr

type DPMSG_DESTROYPLAYERORGROUP
	dwType as DWORD
	dwPlayerType as DWORD
	dpId as DPID
	lpLocalData as LPVOID
	dwLocalDataSize as DWORD
	lpRemoteData as LPVOID
	dwRemoteDataSize as DWORD
	dpnName as DPNAME
	dpIdParent as DPID
	dwFlags as DWORD
end type

type LPDPMSG_DESTROYPLAYERORGROUP as DPMSG_DESTROYPLAYERORGROUP ptr

type DPMSG_ADDPLAYERTOGROUP
	dwType as DWORD
	dpIdGroup as DPID
	dpIdPlayer as DPID
end type

type LPDPMSG_ADDPLAYERTOGROUP as DPMSG_ADDPLAYERTOGROUP ptr
type DPMSG_DELETEPLAYERFROMGROUP as DPMSG_ADDPLAYERTOGROUP
type LPDPMSG_DELETEPLAYERFROMGROUP as DPMSG_DELETEPLAYERFROMGROUP ptr

type DPMSG_ADDGROUPTOGROUP
	dwType as DWORD
	dpIdParentGroup as DPID
	dpIdGroup as DPID
end type

type LPDPMSG_ADDGROUPTOGROUP as DPMSG_ADDGROUPTOGROUP ptr
type DPMSG_DELETEGROUPFROMGROUP as DPMSG_ADDGROUPTOGROUP
type LPDPMSG_DELETEGROUPFROMGROUP as DPMSG_DELETEGROUPFROMGROUP ptr

type DPMSG_SETPLAYERORGROUPDATA
	dwType as DWORD
	dwPlayerType as DWORD
	dpId as DPID
	lpData as LPVOID
	dwDataSize as DWORD
end type

type LPDPMSG_SETPLAYERORGROUPDATA as DPMSG_SETPLAYERORGROUPDATA ptr

type DPMSG_SETPLAYERORGROUPNAME
	dwType as DWORD
	dwPlayerType as DWORD
	dpId as DPID
	dpnName as DPNAME
end type

type LPDPMSG_SETPLAYERORGROUPNAME as DPMSG_SETPLAYERORGROUPNAME ptr

type DPMSG_SETSESSIONDESC
	dwType as DWORD
	dpDesc as DPSESSIONDESC2
end type

type LPDPMSG_SETSESSIONDESC as DPMSG_SETSESSIONDESC ptr
type DPMSG_HOST as DPMSG_GENERIC
type LPDPMSG_HOST as DPMSG_HOST ptr
type DPMSG_SESSIONLOST as DPMSG_GENERIC
type LPDPMSG_SESSIONLOST as DPMSG_SESSIONLOST ptr

type DPMSG_SECUREMESSAGE
	dwType as DWORD
	dwFlags as DWORD
	dpIdFrom as DPID
	lpData as LPVOID
	dwDataSize as DWORD
end type

type LPDPMSG_SECUREMESSAGE as DPMSG_SECUREMESSAGE ptr

type DPMSG_STARTSESSION
	dwType as DWORD
	lpConn as LPDPLCONNECTION
end type

type LPDPMSG_STARTSESSION as DPMSG_STARTSESSION ptr

type DPMSG_CHAT
	dwType as DWORD
	dwFlags as DWORD
	idFromPlayer as DPID
	idToPlayer as DPID
	idToGroup as DPID
	lpChat as LPDPCHAT
end type

type LPDPMSG_CHAT as DPMSG_CHAT ptr

type DPMSG_SETGROUPOWNER
	dwType as DWORD
	idGroup as DPID
	idNewOwner as DPID
	idOldOwner as DPID
end type

type LPDPMSG_SETGROUPOWNER as DPMSG_SETGROUPOWNER ptr

type DPMSG_SENDCOMPLETE
	dwType as DWORD
	idFrom as DPID
	idTo as DPID
	dwFlags as DWORD
	dwPriority as DWORD
	dwTimeout as DWORD
	lpvContext as LPVOID
	dwMsgID as DWORD
	hr as HRESULT
	dwSendTime as DWORD
end type

type LPDPMSG_SENDCOMPLETE as DPMSG_SENDCOMPLETE ptr

#define DP_OK S_OK
#define DPERR_ALREADYINITIALIZED MAKE_DPHRESULT( 5 )
#define DPERR_ACCESSDENIED MAKE_DPHRESULT( 10 )
#define DPERR_ACTIVEPLAYERS MAKE_DPHRESULT( 20 )
#define DPERR_BUFFERTOOSMALL MAKE_DPHRESULT( 30 )
#define DPERR_CANTADDPLAYER MAKE_DPHRESULT( 40 )
#define DPERR_CANTCREATEGROUP MAKE_DPHRESULT( 50 )
#define DPERR_CANTCREATEPLAYER MAKE_DPHRESULT( 60 )
#define DPERR_CANTCREATESESSION MAKE_DPHRESULT( 70 )
#define DPERR_CAPSNOTAVAILABLEYET MAKE_DPHRESULT( 80 )
#define DPERR_EXCEPTION MAKE_DPHRESULT( 90 )
#define DPERR_GENERIC E_FAIL
#define DPERR_INVALIDFLAGS MAKE_DPHRESULT( 120 )
#define DPERR_INVALIDOBJECT MAKE_DPHRESULT( 130 )
#define DPERR_INVALIDPARAM E_INVALIDARG
#define DPERR_INVALIDPARAMS DPERR_INVALIDPARAM
#define DPERR_INVALIDPLAYER MAKE_DPHRESULT( 150 )
#define DPERR_INVALIDGROUP MAKE_DPHRESULT( 155 )
#define DPERR_NOCAPS MAKE_DPHRESULT( 160 )
#define DPERR_NOCONNECTION MAKE_DPHRESULT( 170 )
#define DPERR_NOMEMORY E_OUTOFMEMORY
#define DPERR_OUTOFMEMORY DPERR_NOMEMORY
#define DPERR_NOMESSAGES MAKE_DPHRESULT( 190 )
#define DPERR_NONAMESERVERFOUND MAKE_DPHRESULT( 200 )
#define DPERR_NOPLAYERS MAKE_DPHRESULT( 210 )
#define DPERR_NOSESSIONS MAKE_DPHRESULT( 220 )
#define DPERR_PENDING E_PENDING
#define DPERR_SENDTOOBIG MAKE_DPHRESULT( 230 )
#define DPERR_TIMEOUT MAKE_DPHRESULT( 240 )
#define DPERR_UNAVAILABLE MAKE_DPHRESULT( 250 )
#define DPERR_UNSUPPORTED E_NOTIMPL
#define DPERR_BUSY MAKE_DPHRESULT( 270 )
#define DPERR_USERCANCEL MAKE_DPHRESULT( 280 ) 
#define DPERR_NOINTERFACE E_NOINTERFACE
#define DPERR_CANNOTCREATESERVER MAKE_DPHRESULT( 290 )
#define DPERR_PLAYERLOST MAKE_DPHRESULT( 300 )
#define DPERR_SESSIONLOST MAKE_DPHRESULT( 310 )
#define DPERR_UNINITIALIZED MAKE_DPHRESULT( 320 )
#define DPERR_NONEWPLAYERS MAKE_DPHRESULT( 330 )
#define DPERR_INVALIDPASSWORD MAKE_DPHRESULT( 340 )
#define DPERR_CONNECTING MAKE_DPHRESULT( 350 )
#define DPERR_CONNECTIONLOST MAKE_DPHRESULT( 360 )
#define DPERR_UNKNOWNMESSAGE MAKE_DPHRESULT( 370 )
#define DPERR_CANCELFAILED MAKE_DPHRESULT( 380 )
#define DPERR_INVALIDPRIORITY MAKE_DPHRESULT( 390 )
#define DPERR_NOTHANDLED MAKE_DPHRESULT( 400 )
#define DPERR_CANCELLED MAKE_DPHRESULT( 410 )
#define DPERR_ABORTED MAKE_DPHRESULT( 420 )
#define DPERR_BUFFERTOOLARGE MAKE_DPHRESULT( 1000 )
#define DPERR_CANTCREATEPROCESS MAKE_DPHRESULT( 1010 )
#define DPERR_APPNOTSTARTED MAKE_DPHRESULT( 1020 )
#define DPERR_INVALIDINTERFACE MAKE_DPHRESULT( 1030 )
#define DPERR_NOSERVICEPROVIDER MAKE_DPHRESULT( 1040 )
#define DPERR_UNKNOWNAPPLICATION MAKE_DPHRESULT( 1050 )
#define DPERR_NOTLOBBIED MAKE_DPHRESULT( 1070 )
#define DPERR_SERVICEPROVIDERLOADED MAKE_DPHRESULT( 1080 )
#define DPERR_ALREADYREGISTERED MAKE_DPHRESULT( 1090 )
#define DPERR_NOTREGISTERED MAKE_DPHRESULT( 1100 )
#define DPERR_AUTHENTICATIONFAILED MAKE_DPHRESULT( 2000 )
#define DPERR_CANTLOADSSPI MAKE_DPHRESULT( 2010 )
#define DPERR_ENCRYPTIONFAILED MAKE_DPHRESULT( 2020 )
#define DPERR_SIGNFAILED MAKE_DPHRESULT( 2030 )
#define DPERR_CANTLOADSECURITYPACKAGE MAKE_DPHRESULT( 2040 )
#define DPERR_ENCRYPTIONNOTSUPPORTED MAKE_DPHRESULT( 2050 )
#define DPERR_CANTLOADCAPI MAKE_DPHRESULT( 2060 )
#define DPERR_NOTLOGGEDIN MAKE_DPHRESULT( 2070 )
#define DPERR_LOGONDENIED MAKE_DPHRESULT( 2080 )

#define DPOPEN_OPENSESSION &h00000001
#define DPOPEN_CREATESESSION &h00000002
#define DPENUMSESSIONS_PREVIOUS &h00000004
#define DPENUMPLAYERS_PREVIOUS &h00000004
#define DPSEND_GUARANTEE &h00000001
#define DPSEND_TRYONCE &h00000004
#define DPCAPS_NAMESERVICE &h00000001
#define DPCAPS_NAMESERVER &h00000002
#define DPCAPS_GUARANTEED &h00000004
#define DPLONGNAMELEN 52
#define DPSHORTNAMELEN 20
#define DPSESSIONNAMELEN 32
#define DPPASSWORDLEN 16
#define DPUSERRESERVED 16
#define DPSYS_ADDPLAYER &h0003
#define DPSYS_DELETEPLAYER &h0005
#define DPSYS_DELETEGROUP &h0020
#define DPSYS_DELETEPLAYERFROMGRP &h0021
#define DPSYS_CONNECT &h484b

type DPMSG_ADDPLAYER
	dwType as DWORD
	dwPlayerType as DWORD
	dpId as DPID
	szLongName as zstring * 52
	szShortName as zstring * 20
	dwCurrentPlayers as DWORD
end type

type DPMSG_ADDGROUP as DPMSG_ADDPLAYER

type DPMSG_GROUPADD
	dwType as DWORD
	dpIdGroup as DPID
	dpIdPlayer as DPID
end type

type DPMSG_GROUPDELETE as DPMSG_GROUPADD

type DPMSG_DELETEPLAYER
	dwType as DWORD
	dpId as DPID
end type

type LPDPENUMPLAYERSCALLBACK as function(byval as DPID, byval as LPSTR, byval as LPSTR, byval as DWORD, byval as LPVOID) as BOOL

type DPSESSIONDESC
	dwSize as DWORD
	guidSession as GUID
	dwSession as DWORD
	dwMaxPlayers as DWORD
	dwCurrentPlayers as DWORD
	dwFlags as DWORD
	szSessionName as zstring * 32
	szUserField as zstring * 16
	dwReserved1 as DWORD
	szPassword as zstring * 16
	dwReserved2 as DWORD
	dwUser1 as DWORD
	dwUser2 as DWORD
	dwUser3 as DWORD
	dwUser4 as DWORD
end type

type LPDPSESSIONDESC as DPSESSIONDESC ptr
type LPDPENUMSESSIONSCALLBACK as function(byval as LPDPSESSIONDESC, byval as LPVOID, byval as LPDWORD, byval as DWORD) as BOOL

type IDirectPlayVtbl_ as IDirectPlayVtbl

type IDirectPlay
	lpVtbl as IDirectPlayVtbl_ ptr
end type

type IDirectPlayVtbl
	QueryInterface as function(byval as IDirectPlay ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay ptr) as ULONG
	Release as function(byval as IDirectPlay ptr) as ULONG
	AddPlayerToGroup as function(byval as IDirectPlay ptr, byval as DPID, byval as DPID) as HRESULT
	Close as function(byval as IDirectPlay ptr) as HRESULT
	CreatePlayer as function(byval as IDirectPlay ptr, byval as LPDPID, byval as LPSTR, byval as LPSTR, byval as LPHANDLE) as HRESULT
	CreateGroup as function(byval as IDirectPlay ptr, byval as LPDPID, byval as LPSTR, byval as LPSTR) as HRESULT
	DeletePlayerFromGroup as function(byval as IDirectPlay ptr, byval as DPID, byval as DPID) as HRESULT
	DestroyPlayer as function(byval as IDirectPlay ptr, byval as DPID) as HRESULT
	DestroyGroup as function(byval as IDirectPlay ptr, byval as DPID) as HRESULT
	EnableNewPlayers as function(byval as IDirectPlay ptr, byval as BOOL) as HRESULT
	EnumGroupPlayers as function(byval as IDirectPlay ptr, byval as DPID, byval as LPDPENUMPLAYERSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	EnumGroups as function(byval as IDirectPlay ptr, byval as DWORD, byval as LPDPENUMPLAYERSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	EnumPlayers as function(byval as IDirectPlay ptr, byval as DWORD, byval as LPDPENUMPLAYERSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	EnumSessions as function(byval as IDirectPlay ptr, byval as LPDPSESSIONDESC, byval as DWORD, byval as LPDPENUMSESSIONSCALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	GetCaps as function(byval as IDirectPlay ptr, byval as LPDPCAPS) as HRESULT
	GetMessageCount as function(byval as IDirectPlay ptr, byval as DPID, byval as LPDWORD) as HRESULT
	GetPlayerCaps as function(byval as IDirectPlay ptr, byval as DPID, byval as LPDPCAPS) as HRESULT
	GetPlayerName as function(byval as IDirectPlay ptr, byval as DPID, byval as LPSTR, byval as LPDWORD, byval as LPSTR, byval as LPDWORD) as HRESULT
	Initialize as function(byval as IDirectPlay ptr, byval as LPGUID) as HRESULT
	Open as function(byval as IDirectPlay ptr, byval as LPDPSESSIONDESC) as HRESULT
	Receive as function(byval as IDirectPlay ptr, byval as LPDPID, byval as LPDPID, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	SaveSession as function(byval as IDirectPlay ptr, byval as LPSTR) as HRESULT
	Send as function(byval as IDirectPlay ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	SetPlayerName as function(byval as IDirectPlay ptr, byval as DPID, byval as LPSTR, byval as LPSTR) as HRESULT
end type

#define IDirectPlay_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay_AddPlayerToGroup(p,a,b) (p)->lpVtbl->AddPlayerToGroup(p,a,b)
#define IDirectPlay_Close(p) (p)->lpVtbl->Close(p)
#define IDirectPlay_CreateGroup(p,a,b,c) (p)->lpVtbl->CreateGroup(p,a,b,c)
#define IDirectPlay_CreatePlayer(p,a,b,c,d) (p)->lpVtbl->CreatePlayer(p,a,b,c,d)
#define IDirectPlay_DeletePlayerFromGroup(p,a,b) (p)->lpVtbl->DeletePlayerFromGroup(p,a,b)
#define IDirectPlay_DestroyGroup(p,a) (p)->lpVtbl->DestroyGroup(p,a)
#define IDirectPlay_DestroyPlayer(p,a) (p)->lpVtbl->DestroyPlayer(p,a)
#define IDirectPlay_EnableNewPlayers(p,a) (p)->lpVtbl->EnableNewPlayers(p,a)
#define IDirectPlay_EnumGroupPlayers(p,a,b,c,d) (p)->lpVtbl->EnumGroupPlayers(p,a,b,c,d)
#define IDirectPlay_EnumGroups(p,a,b,c,d) (p)->lpVtbl->EnumGroups(p,a,b,c,d)
#define IDirectPlay_EnumPlayers(p,a,b,c,d) (p)->lpVtbl->EnumPlayers(p,a,b,c,d)
#define IDirectPlay_EnumSessions(p,a,b,c,d,e) (p)->lpVtbl->EnumSessions(p,a,b,c,d,e)
#define IDirectPlay_GetCaps(p,a) (p)->lpVtbl->GetCaps(p,a)
#define IDirectPlay_GetMessageCount(p,a,b) (p)->lpVtbl->GetMessageCount(p,a,b)
#define IDirectPlay_GetPlayerCaps(p,a,b) (p)->lpVtbl->GetPlayerCaps(p,a,b)
#define IDirectPlay_GetPlayerName(p,a,b,c,d,e) (p)->lpVtbl->GetPlayerName(p,a,b,c,d,e)
#define IDirectPlay_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirectPlay_Open(p,a) (p)->lpVtbl->Open(p,a)
#define IDirectPlay_Receive(p,a,b,c,d,e) (p)->lpVtbl->Receive(p,a,b,c,d,e)
#define IDirectPlay_SaveSession(p,a) (p)->lpVtbl->SaveSession(p,a)
#define IDirectPlay_Send(p,a,b,c,d,e) (p)->lpVtbl->Send(p,a,b,c,d,e)
#define IDirectPlay_SetPlayerName(p,a,b,c) (p)->lpVtbl->SetPlayerName(p,a,b,c)

extern IID_IDirectPlay alias "IID_IDirectPlay" as GUID

#endif
