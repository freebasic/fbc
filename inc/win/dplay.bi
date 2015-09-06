'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) the Wine project
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "dplayx"
#inclib "dxguid"

#include once "ole2.bi"

extern "Windows"

#define __WINE_DPLAY_H
type LPRGLPVOID as LPVOID ptr
type PRGPVOID as LPRGLPVOID
type LPRGPVOID as LPRGLPVOID
type PRGLPVOID as LPRGLPVOID
type PAPVOID as LPRGLPVOID
type LPAPVOID as LPRGLPVOID
type PALPVOID as LPRGLPVOID
type LPALPVOID as LPRGLPVOID
type LPVOIDV as any ptr
extern CLSID_DirectPlay as const GUID
extern IID_IDirectPlay as const GUID
type LPDIRECTPLAY as IDirectPlay ptr
extern IID_IDirectPlay2 as const GUID
type LPDIRECTPLAY2 as IDirectPlay2 ptr
extern IID_IDirectPlay2A as const GUID
type IDirectPlay2A as IDirectPlay2
type LPDIRECTPLAY2A as IDirectPlay2 ptr
extern IID_IDirectPlay3 as const GUID
type LPDIRECTPLAY3 as IDirectPlay3 ptr
extern IID_IDirectPlay3A as const GUID
type IDirectPlay3A as IDirectPlay3
type LPDIRECTPLAY3A as IDirectPlay3 ptr
extern IID_IDirectPlay4 as const GUID
type LPDIRECTPLAY4 as IDirectPlay4 ptr
extern IID_IDirectPlay4A as const GUID
type IDirectPlay4A as IDirectPlay4
type LPDIRECTPLAY4A as IDirectPlay4 ptr

extern DPSPGUID_IPX as const GUID
extern DPSPGUID_TCPIP as const GUID
extern DPSPGUID_SERIAL as const GUID
extern DPSPGUID_MODEM as const GUID

const _FACDP = &h877
#define MAKE_DPHRESULT(code) MAKE_HRESULT(1, _FACDP, code)
const DP_OK = S_OK
#define DPERR_ALREADYINITIALIZED MAKE_DPHRESULT(5)
#define DPERR_ACCESSDENIED MAKE_DPHRESULT(10)
#define DPERR_ACTIVEPLAYERS MAKE_DPHRESULT(20)
#define DPERR_BUFFERTOOSMALL MAKE_DPHRESULT(30)
#define DPERR_CANTADDPLAYER MAKE_DPHRESULT(40)
#define DPERR_CANTCREATEGROUP MAKE_DPHRESULT(50)
#define DPERR_CANTCREATEPLAYER MAKE_DPHRESULT(60)
#define DPERR_CANTCREATESESSION MAKE_DPHRESULT(70)
#define DPERR_CAPSNOTAVAILABLEYET MAKE_DPHRESULT(80)
#define DPERR_EXCEPTION MAKE_DPHRESULT(90)
#define DPERR_GENERIC E_FAIL
#define DPERR_INVALIDFLAGS MAKE_DPHRESULT(120)
#define DPERR_INVALIDOBJECT MAKE_DPHRESULT(130)
#define DPERR_INVALIDPARAM E_INVALIDARG
#define DPERR_INVALIDPARAMS DPERR_INVALIDPARAM
#define DPERR_INVALIDPLAYER MAKE_DPHRESULT(150)
#define DPERR_INVALIDGROUP MAKE_DPHRESULT(155)
#define DPERR_NOCAPS MAKE_DPHRESULT(160)
#define DPERR_NOCONNECTION MAKE_DPHRESULT(170)
#define DPERR_NOMEMORY E_OUTOFMEMORY
#define DPERR_OUTOFMEMORY DPERR_NOMEMORY
#define DPERR_NOMESSAGES MAKE_DPHRESULT(190)
#define DPERR_NONAMESERVERFOUND MAKE_DPHRESULT(200)
#define DPERR_NOPLAYERS MAKE_DPHRESULT(210)
#define DPERR_NOSESSIONS MAKE_DPHRESULT(220)
#define DPERR_PENDING E_PENDING
#define DPERR_SENDTOOBIG MAKE_DPHRESULT(230)
#define DPERR_TIMEOUT MAKE_DPHRESULT(240)
#define DPERR_UNAVAILABLE MAKE_DPHRESULT(250)
#define DPERR_UNSUPPORTED E_NOTIMPL
#define DPERR_BUSY MAKE_DPHRESULT(270)
#define DPERR_USERCANCEL MAKE_DPHRESULT(280)
#define DPERR_NOINTERFACE E_NOINTERFACE
#define DPERR_CANNOTCREATESERVER MAKE_DPHRESULT(290)
#define DPERR_PLAYERLOST MAKE_DPHRESULT(300)
#define DPERR_SESSIONLOST MAKE_DPHRESULT(310)
#define DPERR_UNINITIALIZED MAKE_DPHRESULT(320)
#define DPERR_NONEWPLAYERS MAKE_DPHRESULT(330)
#define DPERR_INVALIDPASSWORD MAKE_DPHRESULT(340)
#define DPERR_CONNECTING MAKE_DPHRESULT(350)
#define DPERR_CONNECTIONLOST MAKE_DPHRESULT(360)
#define DPERR_UNKNOWNMESSAGE MAKE_DPHRESULT(370)
#define DPERR_CANCELFAILED MAKE_DPHRESULT(380)
#define DPERR_INVALIDPRIORITY MAKE_DPHRESULT(390)
#define DPERR_NOTHANDLED MAKE_DPHRESULT(400)
#define DPERR_CANCELLED MAKE_DPHRESULT(410)
#define DPERR_ABORTED MAKE_DPHRESULT(420)
#define DPERR_BUFFERTOOLARGE MAKE_DPHRESULT(1000)
#define DPERR_CANTCREATEPROCESS MAKE_DPHRESULT(1010)
#define DPERR_APPNOTSTARTED MAKE_DPHRESULT(1020)
#define DPERR_INVALIDINTERFACE MAKE_DPHRESULT(1030)
#define DPERR_NOSERVICEPROVIDER MAKE_DPHRESULT(1040)
#define DPERR_UNKNOWNAPPLICATION MAKE_DPHRESULT(1050)
#define DPERR_NOTLOBBIED MAKE_DPHRESULT(1070)
#define DPERR_SERVICEPROVIDERLOADED MAKE_DPHRESULT(1080)
#define DPERR_ALREADYREGISTERED MAKE_DPHRESULT(1090)
#define DPERR_NOTREGISTERED MAKE_DPHRESULT(1100)
#define DPERR_AUTHENTICATIONFAILED MAKE_DPHRESULT(2000)
#define DPERR_CANTLOADSSPI MAKE_DPHRESULT(2010)
#define DPERR_ENCRYPTIONFAILED MAKE_DPHRESULT(2020)
#define DPERR_SIGNFAILED MAKE_DPHRESULT(2030)
#define DPERR_CANTLOADSECURITYPACKAGE MAKE_DPHRESULT(2040)
#define DPERR_ENCRYPTIONNOTSUPPORTED MAKE_DPHRESULT(2050)
#define DPERR_CANTLOADCAPI MAKE_DPHRESULT(2060)
#define DPERR_NOTLOGGEDIN MAKE_DPHRESULT(2070)
#define DPERR_LOGONDENIED MAKE_DPHRESULT(2080)
type DPID as DWORD
type LPDPID as DWORD ptr
const DPID_SYSMSG = 0
const DPID_ALLPLAYERS = 0
const DPID_SERVERPLAYER = 1
const DPID_UNKNOWN = &hFFFFFFFF

type tagDPCAPS
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

type DPCAPS as tagDPCAPS
type LPDPCAPS as tagDPCAPS ptr

type tagDPNAME
	dwSize as DWORD
	dwFlags as DWORD

	union
		lpszShortName as LPWSTR
		lpszShortNameA as LPSTR
	end union

	union
		lpszLongName as LPWSTR
		lpszLongNameA as LPSTR
	end union
end type

type DPNAME as tagDPNAME
type LPDPNAME as tagDPNAME ptr
const DPLONGNAMELEN = 52
const DPSHORTNAMELEN = 20
const DPSESSIONNAMELEN = 32
const DPPASSWORDLEN = 16
const DPUSERRESERVED = 16

type tagDPSESSIONDESC
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

type DPSESSIONDESC as tagDPSESSIONDESC
type LPDPSESSIONDESC as tagDPSESSIONDESC ptr

type tagDPSESSIONDESC2
	dwSize as DWORD
	dwFlags as DWORD
	guidInstance as GUID
	guidApplication as GUID
	dwMaxPlayers as DWORD
	dwCurrentPlayers as DWORD

	union
		lpszSessionName as LPWSTR
		lpszSessionNameA as LPSTR
	end union

	union
		lpszPassword as LPWSTR
		lpszPasswordA as LPSTR
	end union

	dwReserved1 as DWORD
	dwReserved2 as DWORD
	dwUser1 as DWORD
	dwUser2 as DWORD
	dwUser3 as DWORD
	dwUser4 as DWORD
end type

type DPSESSIONDESC2 as tagDPSESSIONDESC2
type LPDPSESSIONDESC2 as tagDPSESSIONDESC2 ptr
type LPCDPSESSIONDESC2 as const DPSESSIONDESC2 ptr

const DPOPEN_JOIN = &h00000001
const DPOPEN_CREATE = &h00000002
const DPSESSION_NEWPLAYERSDISABLED = &h00000001
const DPSESSION_MIGRATEHOST = &h00000004
const DPSESSION_NOMESSAGEID = &h00000008
const DPSESSION_JOINDISABLED = &h00000020
const DPSESSION_KEEPALIVE = &h00000040
const DPSESSION_NODATAMESSAGES = &h00000080
const DPSESSION_SECURESERVER = &h00000100
const DPSESSION_PRIVATE = &h00000200
const DPSESSION_PASSWORDREQUIRED = &h00000400
const DPSESSION_MULTICASTSERVER = &h00000800
const DPSESSION_CLIENTSERVER = &h00001000
const DPSESSION_DIRECTPLAYPROTOCOL = &h00002000
const DPSESSION_NOPRESERVEORDER = &h00004000
const DPSESSION_OPTIMIZELATENCY = &h00008000

type tagDPLCONNECTION
	dwSize as DWORD
	dwFlags as DWORD
	lpSessionDesc as LPDPSESSIONDESC2
	lpPlayerName as LPDPNAME
	guidSP as GUID
	lpAddress as LPVOID
	dwAddressSize as DWORD
end type

type DPLCONNECTION as tagDPLCONNECTION
type LPDPLCONNECTION as tagDPLCONNECTION ptr
const DPLCONNECTION_CREATESESSION = DPOPEN_CREATE
const DPLCONNECTION_JOINSESSION = DPOPEN_JOIN

type tagDPCHAT
	dwSize as DWORD
	dwFlags as DWORD

	union
		lpszMessage as LPWSTR
		lpszMessageA as LPSTR
	end union
end type

type DPCHAT as tagDPCHAT
type LPDPCHAT as tagDPCHAT ptr

type SGBUFFER
	len as UINT
	pData as PUCHAR
end type

type PSGBUFFER as SGBUFFER ptr
type LPSGBUFFER as SGBUFFER ptr

type tagDPSECURITYDESC
	dwSize as DWORD
	dwFlags as DWORD

	union
		lpszSSPIProvider as LPWSTR
		lpszSSPIProviderA as LPSTR
	end union

	union
		lpszCAPIProvider as LPWSTR
		lpszCAPIProviderA as LPSTR
	end union

	dwCAPIProviderType as DWORD
	dwEncryptionAlgorithm as DWORD
end type

type DPSECURITYDESC as tagDPSECURITYDESC
type LPDPSECURITYDESC as tagDPSECURITYDESC ptr
type LPCDPSECURITYDESC as const DPSECURITYDESC ptr

type tagDPCREDENTIALS
	dwSize as DWORD
	dwFlags as DWORD

	union
		lpszUsername as LPWSTR
		lpszUsernameA as LPSTR
	end union

	union
		lpszPassword as LPWSTR
		lpszPasswordA as LPSTR
	end union

	union
		lpszDomain as LPWSTR
		lpszDomainA as LPSTR
	end union
end type

type DPCREDENTIALS as tagDPCREDENTIALS
type LPDPCREDENTIALS as tagDPCREDENTIALS ptr
type LPCDPCREDENTIALS as const DPCREDENTIALS ptr
type LPDPENUMDPCALLBACKW as function(byval lpguidSP as LPGUID, byval lpSPName as LPWSTR, byval dwMajorVersion as DWORD, byval dwMinorVersion as DWORD, byval lpContext as LPVOID) as WINBOOL
type LPDPENUMDPCALLBACKA as function(byval lpguidSP as LPGUID, byval lpSPName as LPSTR, byval dwMajorVersion as DWORD, byval dwMinorVersion as DWORD, byval lpContext as LPVOID) as WINBOOL
type LPCDPNAME as const DPNAME ptr
type LPDPENUMCONNECTIONSCALLBACK as function(byval lpguidSP as LPCGUID, byval lpConnection as LPVOID, byval dwConnectionSize as DWORD, byval lpName as LPCDPNAME, byval dwFlags as DWORD, byval lpContext as LPVOID) as WINBOOL
type LPDPENUMSESSIONSCALLBACK as function(byval lpDPSessionDesc as LPDPSESSIONDESC, byval lpContext as LPVOID, byval lpdwTimeOut as LPDWORD, byval dwFlags as DWORD) as WINBOOL

declare function DirectPlayEnumerateA(byval as LPDPENUMDPCALLBACKA, byval as LPVOID) as HRESULT
declare function DirectPlayEnumerateW(byval as LPDPENUMDPCALLBACKW, byval as LPVOID) as HRESULT
declare function DirectPlayCreate(byval lpGUID as LPGUID, byval lplpDP as LPDIRECTPLAY ptr, byval pUnk as IUnknown ptr) as HRESULT

type LPDPENUMPLAYERSCALLBACK as function(byval dpId as DPID, byval lpFriendlyName as LPSTR, byval lpFormalName as LPSTR, byval dwFlags as DWORD, byval lpContext as LPVOID) as WINBOOL
type LPDPENUMPLAYERSCALLBACK2 as function(byval dpId as DPID, byval dwPlayerType as DWORD, byval lpName as LPCDPNAME, byval dwFlags as DWORD, byval lpContext as LPVOID) as WINBOOL
type LPDPENUMSESSIONSCALLBACK2 as function(byval lpThisSD as LPCDPSESSIONDESC2, byval lpdwTimeOut as LPDWORD, byval dwFlags as DWORD, byval lpContext as LPVOID) as WINBOOL
const DPESC_TIMEDOUT = &h00000001
type IDirectPlayVtbl as IDirectPlayVtbl_

type IDirectPlay
	lpVtbl as IDirectPlayVtbl ptr
end type

type IDirectPlayVtbl_
	QueryInterface as function(byval This as IDirectPlay ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay ptr) as ULONG
	Release as function(byval This as IDirectPlay ptr) as ULONG
	AddPlayerToGroup as function(byval This as IDirectPlay ptr, byval idGroup as DPID, byval idPlayer as DPID) as HRESULT
	Close as function(byval This as IDirectPlay ptr) as HRESULT
	CreatePlayer as function(byval This as IDirectPlay ptr, byval lpidPlayer as LPDPID, byval lpPlayerName as LPSTR, byval as LPSTR, byval as LPHANDLE) as HRESULT
	CreateGroup as function(byval This as IDirectPlay ptr, byval lpidGroup as LPDPID, byval lpGroupName as LPSTR, byval as LPSTR) as HRESULT
	DeletePlayerFromGroup as function(byval This as IDirectPlay ptr, byval idGroup as DPID, byval idPlayer as DPID) as HRESULT
	DestroyPlayer as function(byval This as IDirectPlay ptr, byval idPlayer as DPID) as HRESULT
	DestroyGroup as function(byval This as IDirectPlay ptr, byval idGroup as DPID) as HRESULT
	EnableNewPlayers as function(byval This as IDirectPlay ptr, byval as WINBOOL) as HRESULT
	EnumGroupPlayers as function(byval This as IDirectPlay ptr, byval idGroup as DPID, byval lpEnumPlayersCallback as LPDPENUMPLAYERSCALLBACK, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumGroups as function(byval This as IDirectPlay ptr, byval as DWORD, byval lpEnumPlayersCallback as LPDPENUMPLAYERSCALLBACK, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumPlayers as function(byval This as IDirectPlay ptr, byval as DWORD, byval lpEnumPlayersCallback as LPDPENUMPLAYERSCALLBACK, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumSessions as function(byval This as IDirectPlay ptr, byval lpsd as LPDPSESSIONDESC, byval dwTimeout as DWORD, byval lpEnumSessionsCallback as LPDPENUMSESSIONSCALLBACK, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	GetCaps as function(byval This as IDirectPlay ptr, byval lpDPCaps as LPDPCAPS) as HRESULT
	GetMessageCount as function(byval This as IDirectPlay ptr, byval idPlayer as DPID, byval lpdwCount as LPDWORD) as HRESULT
	GetPlayerCaps as function(byval This as IDirectPlay ptr, byval idPlayer as DPID, byval lpPlayerCaps as LPDPCAPS) as HRESULT
	GetPlayerName as function(byval This as IDirectPlay ptr, byval idPlayer as DPID, byval as LPSTR, byval as LPDWORD, byval as LPSTR, byval as LPDWORD) as HRESULT
	Initialize as function(byval This as IDirectPlay ptr, byval lpGUID as LPGUID) as HRESULT
	Open as function(byval This as IDirectPlay ptr, byval lpsd as LPDPSESSIONDESC) as HRESULT
	Receive as function(byval This as IDirectPlay ptr, byval lpidFrom as LPDPID, byval lpidTo as LPDPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	SaveSession as function(byval This as IDirectPlay ptr, byval as LPSTR) as HRESULT
	Send as function(byval This as IDirectPlay ptr, byval idFrom as DPID, byval idTo as DPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval dwDataSize as DWORD) as HRESULT
	SetPlayerName as function(byval This as IDirectPlay ptr, byval idPlayer as DPID, byval lpPlayerName as LPSTR, byval as LPSTR) as HRESULT
end type

#define IDirectPlay_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay_AddPlayerToGroup(p, a, b) (p)->lpVtbl->AddPlayerToGroup(p, a, b)
#define IDirectPlay_Close(p) (p)->lpVtbl->Close(p)
#define IDirectPlay_CreatePlayer(p, a, b, c, d) (p)->lpVtbl->CreatePlayer(p, a, b, c, d)
#define IDirectPlay_CreateGroup(p, a, b, c) (p)->lpVtbl->CreateGroup(p, a, b, c)
#define IDirectPlay_DeletePlayerFromGroup(p, a, b) (p)->lpVtbl->DeletePlayerFromGroup(p, a, b)
#define IDirectPlay_DestroyPlayer(p, a) (p)->lpVtbl->DestroyPlayer(p, a)
#define IDirectPlay_DestroyGroup(p, a) (p)->lpVtbl->DestroyGroup(p, a)
#define IDirectPlay_EnableNewPlayers(p, a) (p)->lpVtbl->EnableNewPlayers(p, a)
#define IDirectPlay_EnumGroupPlayers(p, a, b, c, d) (p)->lpVtbl->EnumGroupPlayers(p, a, b, c, d)
#define IDirectPlay_EnumGroups(p, a, b, c, d) (p)->lpVtbl->EnumGroups(p, a, b, c, d)
#define IDirectPlay_EnumPlayers(p, a, b, c, d) (p)->lpVtbl->EnumPlayers(p, a, b, c, d)
#define IDirectPlay_EnumSessions(p, a, b, c, d, e) (p)->lpVtbl->EnumSessions(p, a, b, c, d, e)
#define IDirectPlay_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectPlay_GetMessageCount(p, a, b) (p)->lpVtbl->GetMessageCount(p, a, b)
#define IDirectPlay_GetPlayerCaps(p, a, b) (p)->lpVtbl->GetPlayerCaps(p, a, b)
#define IDirectPlay_GetPlayerName(p, a, b, c, d, e) (p)->lpVtbl->GetPlayerName(p, a, b, c, d, e)
#define IDirectPlay_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirectPlay_Open(p, a) (p)->lpVtbl->Open(p, a)
#define IDirectPlay_Receive(p, a, b, c, d, e) (p)->lpVtbl->Receive(p, a, b, c, d, e)
#define IDirectPlay_SaveSession(p, a) (p)->lpVtbl->SaveSession(p, a)
#define IDirectPlay_Send(p, a, b, c, d, e) (p)->lpVtbl->Send(p, a, b, c, d, e)
#define IDirectPlay_SetPlayerName(p, a, b, c) (p)->lpVtbl->SetPlayerName(p, a, b, c)
type IDirectPlay2Vtbl as IDirectPlay2Vtbl_

type IDirectPlay2
	lpVtbl as IDirectPlay2Vtbl ptr
end type

type IDirectPlay2Vtbl_
	QueryInterface as function(byval This as IDirectPlay2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay2 ptr) as ULONG
	Release as function(byval This as IDirectPlay2 ptr) as ULONG
	AddPlayerToGroup as function(byval This as IDirectPlay2 ptr, byval idGroup as DPID, byval idPlayer as DPID) as HRESULT
	Close as function(byval This as IDirectPlay2 ptr) as HRESULT
	CreateGroup as function(byval This as IDirectPlay2 ptr, byval lpidGroup as LPDPID, byval lpGroupName as LPDPNAME, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	CreatePlayer as function(byval This as IDirectPlay2 ptr, byval lpidPlayer as LPDPID, byval lpPlayerName as LPDPNAME, byval hEvent as HANDLE, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	DeletePlayerFromGroup as function(byval This as IDirectPlay2 ptr, byval idGroup as DPID, byval idPlayer as DPID) as HRESULT
	DestroyGroup as function(byval This as IDirectPlay2 ptr, byval idGroup as DPID) as HRESULT
	DestroyPlayer as function(byval This as IDirectPlay2 ptr, byval idPlayer as DPID) as HRESULT
	EnumGroupPlayers as function(byval This as IDirectPlay2 ptr, byval idGroup as DPID, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumGroups as function(byval This as IDirectPlay2 ptr, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumPlayers as function(byval This as IDirectPlay2 ptr, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumSessions as function(byval This as IDirectPlay2 ptr, byval lpsd as LPDPSESSIONDESC2, byval dwTimeout as DWORD, byval lpEnumSessionsCallback2 as LPDPENUMSESSIONSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	GetCaps as function(byval This as IDirectPlay2 ptr, byval lpDPCaps as LPDPCAPS, byval dwFlags as DWORD) as HRESULT
	GetGroupData as function(byval This as IDirectPlay2 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD, byval dwFlags as DWORD) as HRESULT
	GetGroupName as function(byval This as IDirectPlay2 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetMessageCount as function(byval This as IDirectPlay2 ptr, byval idPlayer as DPID, byval lpdwCount as LPDWORD) as HRESULT
	GetPlayerAddress as function(byval This as IDirectPlay2 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetPlayerCaps as function(byval This as IDirectPlay2 ptr, byval idPlayer as DPID, byval lpPlayerCaps as LPDPCAPS, byval dwFlags as DWORD) as HRESULT
	GetPlayerData as function(byval This as IDirectPlay2 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD, byval dwFlags as DWORD) as HRESULT
	GetPlayerName as function(byval This as IDirectPlay2 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetSessionDesc as function(byval This as IDirectPlay2 ptr, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	Initialize as function(byval This as IDirectPlay2 ptr, byval lpGUID as LPGUID) as HRESULT
	Open as function(byval This as IDirectPlay2 ptr, byval lpsd as LPDPSESSIONDESC2, byval dwFlags as DWORD) as HRESULT
	Receive as function(byval This as IDirectPlay2 ptr, byval lpidFrom as LPDPID, byval lpidTo as LPDPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	Send as function(byval This as IDirectPlay2 ptr, byval idFrom as DPID, byval idTo as DPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval dwDataSize as DWORD) as HRESULT
	SetGroupData as function(byval This as IDirectPlay2 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	SetGroupName as function(byval This as IDirectPlay2 ptr, byval idGroup as DPID, byval lpGroupName as LPDPNAME, byval dwFlags as DWORD) as HRESULT
	SetPlayerData as function(byval This as IDirectPlay2 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	SetPlayerName as function(byval This as IDirectPlay2 ptr, byval idPlayer as DPID, byval lpPlayerName as LPDPNAME, byval dwFlags as DWORD) as HRESULT
	SetSessionDesc as function(byval This as IDirectPlay2 ptr, byval lpSessDesc as LPDPSESSIONDESC2, byval dwFlags as DWORD) as HRESULT
end type

#define IDirectPlay2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay2_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay2_AddPlayerToGroup(p, a, b) (p)->lpVtbl->AddPlayerToGroup(p, a, b)
#define IDirectPlay2_Close(p) (p)->lpVtbl->Close(p)
#define IDirectPlay2_CreateGroup(p, a, b, c, d, e) (p)->lpVtbl->CreateGroup(p, a, b, c, d, e)
#define IDirectPlay2_CreatePlayer(p, a, b, c, d, e, f) (p)->lpVtbl->CreatePlayer(p, a, b, c, d, e, f)
#define IDirectPlay2_DeletePlayerFromGroup(p, a, b) (p)->lpVtbl->DeletePlayerFromGroup(p, a, b)
#define IDirectPlay2_DestroyGroup(p, a) (p)->lpVtbl->DestroyGroup(p, a)
#define IDirectPlay2_DestroyPlayer(p, a) (p)->lpVtbl->DestroyPlayer(p, a)
#define IDirectPlay2_EnumGroupPlayers(p, a, b, c, d, e) (p)->lpVtbl->EnumGroupPlayers(p, a, b, c, d, e)
#define IDirectPlay2_EnumGroups(p, a, b, c, d) (p)->lpVtbl->EnumGroups(p, a, b, c, d)
#define IDirectPlay2_EnumPlayers(p, a, b, c, d) (p)->lpVtbl->EnumPlayers(p, a, b, c, d)
#define IDirectPlay2_EnumSessions(p, a, b, c, d, e) (p)->lpVtbl->EnumSessions(p, a, b, c, d, e)
#define IDirectPlay2_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectPlay2_GetGroupData(p, a, b, c, d) (p)->lpVtbl->GetGroupData(p, a, b, c, d)
#define IDirectPlay2_GetGroupName(p, a, b, c) (p)->lpVtbl->GetGroupName(p, a, b, c)
#define IDirectPlay2_GetMessageCount(p, a, b) (p)->lpVtbl->GetMessageCount(p, a, b)
#define IDirectPlay2_GetPlayerAddress(p, a, b, c) (p)->lpVtbl->GetPlayerAddress(p, a, b, c)
#define IDirectPlay2_GetPlayerCaps(p, a, b, c) (p)->lpVtbl->GetPlayerCaps(p, a, b, c)
#define IDirectPlay2_GetPlayerData(p, a, b, c, d) (p)->lpVtbl->GetPlayerData(p, a, b, c, d)
#define IDirectPlay2_GetPlayerName(p, a, b, c) (p)->lpVtbl->GetPlayerName(p, a, b, c)
#define IDirectPlay2_GetSessionDesc(p, a, b) (p)->lpVtbl->GetSessionDesc(p, a, b)
#define IDirectPlay2_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirectPlay2_Open(p, a, b) (p)->lpVtbl->Open(p, a, b)
#define IDirectPlay2_Receive(p, a, b, c, d, e) (p)->lpVtbl->Receive(p, a, b, c, d, e)
#define IDirectPlay2_Send(p, a, b, c, d, e) (p)->lpVtbl->Send(p, a, b, c, d, e)
#define IDirectPlay2_SetGroupData(p, a, b, c, d) (p)->lpVtbl->SetGroupData(p, a, b, c, d)
#define IDirectPlay2_SetGroupName(p, a, b, c) (p)->lpVtbl->SetGroupName(p, a, b, c)
#define IDirectPlay2_SetPlayerData(p, a, b, c, d) (p)->lpVtbl->SetPlayerData(p, a, b, c, d)
#define IDirectPlay2_SetPlayerName(p, a, b, c) (p)->lpVtbl->SetPlayerName(p, a, b, c)
#define IDirectPlay2_SetSessionDesc(p, a, b) (p)->lpVtbl->SetSessionDesc(p, a, b)
type IDirectPlay3Vtbl as IDirectPlay3Vtbl_

type IDirectPlay3
	lpVtbl as IDirectPlay3Vtbl ptr
end type

type IDirectPlay3Vtbl_
	QueryInterface as function(byval This as IDirectPlay3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay3 ptr) as ULONG
	Release as function(byval This as IDirectPlay3 ptr) as ULONG
	AddPlayerToGroup as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval idPlayer as DPID) as HRESULT
	Close as function(byval This as IDirectPlay3 ptr) as HRESULT
	CreateGroup as function(byval This as IDirectPlay3 ptr, byval lpidGroup as LPDPID, byval lpGroupName as LPDPNAME, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	CreatePlayer as function(byval This as IDirectPlay3 ptr, byval lpidPlayer as LPDPID, byval lpPlayerName as LPDPNAME, byval hEvent as HANDLE, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	DeletePlayerFromGroup as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval idPlayer as DPID) as HRESULT
	DestroyGroup as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID) as HRESULT
	DestroyPlayer as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID) as HRESULT
	EnumGroupPlayers as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumGroups as function(byval This as IDirectPlay3 ptr, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumPlayers as function(byval This as IDirectPlay3 ptr, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumSessions as function(byval This as IDirectPlay3 ptr, byval lpsd as LPDPSESSIONDESC2, byval dwTimeout as DWORD, byval lpEnumSessionsCallback2 as LPDPENUMSESSIONSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	GetCaps as function(byval This as IDirectPlay3 ptr, byval lpDPCaps as LPDPCAPS, byval dwFlags as DWORD) as HRESULT
	GetGroupData as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD, byval dwFlags as DWORD) as HRESULT
	GetGroupName as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetMessageCount as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval lpdwCount as LPDWORD) as HRESULT
	GetPlayerAddress as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetPlayerCaps as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval lpPlayerCaps as LPDPCAPS, byval dwFlags as DWORD) as HRESULT
	GetPlayerData as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD, byval dwFlags as DWORD) as HRESULT
	GetPlayerName as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetSessionDesc as function(byval This as IDirectPlay3 ptr, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	Initialize as function(byval This as IDirectPlay3 ptr, byval lpGUID as LPGUID) as HRESULT
	Open as function(byval This as IDirectPlay3 ptr, byval lpsd as LPDPSESSIONDESC2, byval dwFlags as DWORD) as HRESULT
	Receive as function(byval This as IDirectPlay3 ptr, byval lpidFrom as LPDPID, byval lpidTo as LPDPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	Send as function(byval This as IDirectPlay3 ptr, byval idFrom as DPID, byval idTo as DPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval dwDataSize as DWORD) as HRESULT
	SetGroupData as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	SetGroupName as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval lpGroupName as LPDPNAME, byval dwFlags as DWORD) as HRESULT
	SetPlayerData as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	SetPlayerName as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval lpPlayerName as LPDPNAME, byval dwFlags as DWORD) as HRESULT
	SetSessionDesc as function(byval This as IDirectPlay3 ptr, byval lpSessDesc as LPDPSESSIONDESC2, byval dwFlags as DWORD) as HRESULT
	AddGroupToGroup as function(byval This as IDirectPlay3 ptr, byval idParentGroup as DPID, byval idGroup as DPID) as HRESULT
	CreateGroupInGroup as function(byval This as IDirectPlay3 ptr, byval idParentGroup as DPID, byval lpidGroup as LPDPID, byval lpGroupName as LPDPNAME, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	DeleteGroupFromGroup as function(byval This as IDirectPlay3 ptr, byval idParentGroup as DPID, byval idGroup as DPID) as HRESULT
	EnumConnections as function(byval This as IDirectPlay3 ptr, byval lpguidApplication as LPCGUID, byval lpEnumCallback as LPDPENUMCONNECTIONSCALLBACK, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumGroupsInGroup as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval lpguidInstance as LPGUID, byval lpEnumCallback as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	GetGroupConnectionSettings as function(byval This as IDirectPlay3 ptr, byval dwFlags as DWORD, byval idGroup as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	InitializeConnection as function(byval This as IDirectPlay3 ptr, byval lpConnection as LPVOID, byval dwFlags as DWORD) as HRESULT
	SecureOpen as function(byval This as IDirectPlay3 ptr, byval lpsd as LPCDPSESSIONDESC2, byval dwFlags as DWORD, byval lpSecurity as LPCDPSECURITYDESC, byval lpCredentials as LPCDPCREDENTIALS) as HRESULT
	SendChatMessage as function(byval This as IDirectPlay3 ptr, byval idFrom as DPID, byval idTo as DPID, byval dwFlags as DWORD, byval lpChatMessage as LPDPCHAT) as HRESULT
	SetGroupConnectionSettings as function(byval This as IDirectPlay3 ptr, byval dwFlags as DWORD, byval idGroup as DPID, byval lpConnection as LPDPLCONNECTION) as HRESULT
	StartSession as function(byval This as IDirectPlay3 ptr, byval dwFlags as DWORD, byval idGroup as DPID) as HRESULT
	GetGroupFlags as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval lpdwFlags as LPDWORD) as HRESULT
	GetGroupParent as function(byval This as IDirectPlay3 ptr, byval idGroup as DPID, byval lpidParent as LPDPID) as HRESULT
	GetPlayerAccount as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetPlayerFlags as function(byval This as IDirectPlay3 ptr, byval idPlayer as DPID, byval lpdwFlags as LPDWORD) as HRESULT
end type

#define IDirectPlay3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay3_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay3_AddPlayerToGroup(p, a, b) (p)->lpVtbl->AddPlayerToGroup(p, a, b)
#define IDirectPlay3_Close(p) (p)->lpVtbl->Close(p)
#define IDirectPlay3_CreateGroup(p, a, b, c, d, e) (p)->lpVtbl->CreateGroup(p, a, b, c, d, e)
#define IDirectPlay3_CreatePlayer(p, a, b, c, d, e, f) (p)->lpVtbl->CreatePlayer(p, a, b, c, d, e, f)
#define IDirectPlay3_DeletePlayerFromGroup(p, a, b) (p)->lpVtbl->DeletePlayerFromGroup(p, a, b)
#define IDirectPlay3_DestroyGroup(p, a) (p)->lpVtbl->DestroyGroup(p, a)
#define IDirectPlay3_DestroyPlayer(p, a) (p)->lpVtbl->DestroyPlayer(p, a)
#define IDirectPlay3_EnumGroupPlayers(p, a, b, c, d, e) (p)->lpVtbl->EnumGroupPlayers(p, a, b, c, d, e)
#define IDirectPlay3_EnumGroups(p, a, b, c, d) (p)->lpVtbl->EnumGroups(p, a, b, c, d)
#define IDirectPlay3_EnumPlayers(p, a, b, c, d) (p)->lpVtbl->EnumPlayers(p, a, b, c, d)
#define IDirectPlay3_EnumSessions(p, a, b, c, d, e) (p)->lpVtbl->EnumSessions(p, a, b, c, d, e)
#define IDirectPlay3_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectPlay3_GetGroupData(p, a, b, c, d) (p)->lpVtbl->GetGroupData(p, a, b, c, d)
#define IDirectPlay3_GetGroupName(p, a, b, c) (p)->lpVtbl->GetGroupName(p, a, b, c)
#define IDirectPlay3_GetMessageCount(p, a, b) (p)->lpVtbl->GetMessageCount(p, a, b)
#define IDirectPlay3_GetPlayerAddress(p, a, b, c) (p)->lpVtbl->GetPlayerAddress(p, a, b, c)
#define IDirectPlay3_GetPlayerCaps(p, a, b, c) (p)->lpVtbl->GetPlayerCaps(p, a, b, c)
#define IDirectPlay3_GetPlayerData(p, a, b, c, d) (p)->lpVtbl->GetPlayerData(p, a, b, c, d)
#define IDirectPlay3_GetPlayerName(p, a, b, c) (p)->lpVtbl->GetPlayerName(p, a, b, c)
#define IDirectPlay3_GetSessionDesc(p, a, b) (p)->lpVtbl->GetSessionDesc(p, a, b)
#define IDirectPlay3_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirectPlay3_Open(p, a, b) (p)->lpVtbl->Open(p, a, b)
#define IDirectPlay3_Receive(p, a, b, c, d, e) (p)->lpVtbl->Receive(p, a, b, c, d, e)
#define IDirectPlay3_Send(p, a, b, c, d, e) (p)->lpVtbl->Send(p, a, b, c, d, e)
#define IDirectPlay3_SetGroupData(p, a, b, c, d) (p)->lpVtbl->SetGroupData(p, a, b, c, d)
#define IDirectPlay3_SetGroupName(p, a, b, c) (p)->lpVtbl->SetGroupName(p, a, b, c)
#define IDirectPlay3_SetPlayerData(p, a, b, c, d) (p)->lpVtbl->SetPlayerData(p, a, b, c, d)
#define IDirectPlay3_SetPlayerName(p, a, b, c) (p)->lpVtbl->SetPlayerName(p, a, b, c)
#define IDirectPlay3_SetSessionDesc(p, a, b) (p)->lpVtbl->SetSessionDesc(p, a, b)
#define IDirectPlay3_AddGroupToGroup(p, a, b) (p)->lpVtbl->AddGroupToGroup(p, a, b)
#define IDirectPlay3_CreateGroupInGroup(p, a, b, c, d, e, f) (p)->lpVtbl->CreateGroupInGroup(p, a, b, c, d, e, f)
#define IDirectPlay3_DeleteGroupFromGroup(p, a, b) (p)->lpVtbl->DeleteGroupFromGroup(p, a, b)
#define IDirectPlay3_EnumConnections(p, a, b, c, d) (p)->lpVtbl->EnumConnections(p, a, b, c, d)
#define IDirectPlay3_EnumGroupsInGroup(p, a, b, c, d, e) (p)->lpVtbl->EnumGroupsInGroup(p, a, b, c, d, e)
#define IDirectPlay3_GetGroupConnectionSettings(p, a, b, c, d) (p)->lpVtbl->GetGroupConnectionSettings(p, a, b, c, d)
#define IDirectPlay3_InitializeConnection(p, a, b) (p)->lpVtbl->InitializeConnection(p, a, b)
#define IDirectPlay3_SecureOpen(p, a, b, c, d) (p)->lpVtbl->SecureOpen(p, a, b, c, d)
#define IDirectPlay3_SendChatMessage(p, a, b, c, d) (p)->lpVtbl->SendChatMessage(p, a, b, c, d)
#define IDirectPlay3_SetGroupConnectionSettings(p, a, b, c) (p)->lpVtbl->SetGroupConnectionSettings(p, a, b, c)
#define IDirectPlay3_StartSession(p, a, b) (p)->lpVtbl->StartSession(p, a, b)
#define IDirectPlay3_GetGroupFlags(p, a, b) (p)->lpVtbl->GetGroupFlags(p, a, b)
#define IDirectPlay3_GetGroupParent(p, a, b) (p)->lpVtbl->GetGroupParent(p, a, b)
#define IDirectPlay3_GetPlayerAccount(p, a, b, c, d) (p)->lpVtbl->GetPlayerAccount(p, a, b, c, d)
#define IDirectPlay3_GetPlayerFlags(p, a, b) (p)->lpVtbl->GetPlayerFlags(p, a, b)
type IDirectPlay4Vtbl as IDirectPlay4Vtbl_

type IDirectPlay4
	lpVtbl as IDirectPlay4Vtbl ptr
end type

type IDirectPlay4Vtbl_
	QueryInterface as function(byval This as IDirectPlay4 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay4 ptr) as ULONG
	Release as function(byval This as IDirectPlay4 ptr) as ULONG
	AddPlayerToGroup as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval idPlayer as DPID) as HRESULT
	Close as function(byval This as IDirectPlay4 ptr) as HRESULT
	CreateGroup as function(byval This as IDirectPlay4 ptr, byval lpidGroup as LPDPID, byval lpGroupName as LPDPNAME, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	CreatePlayer as function(byval This as IDirectPlay4 ptr, byval lpidPlayer as LPDPID, byval lpPlayerName as LPDPNAME, byval hEvent as HANDLE, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	DeletePlayerFromGroup as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval idPlayer as DPID) as HRESULT
	DestroyGroup as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID) as HRESULT
	DestroyPlayer as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID) as HRESULT
	EnumGroupPlayers as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumGroups as function(byval This as IDirectPlay4 ptr, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumPlayers as function(byval This as IDirectPlay4 ptr, byval lpguidInstance as LPGUID, byval lpEnumPlayersCallback2 as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumSessions as function(byval This as IDirectPlay4 ptr, byval lpsd as LPDPSESSIONDESC2, byval dwTimeout as DWORD, byval lpEnumSessionsCallback2 as LPDPENUMSESSIONSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	GetCaps as function(byval This as IDirectPlay4 ptr, byval lpDPCaps as LPDPCAPS, byval dwFlags as DWORD) as HRESULT
	GetGroupData as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD, byval dwFlags as DWORD) as HRESULT
	GetGroupName as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetMessageCount as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval lpdwCount as LPDWORD) as HRESULT
	GetPlayerAddress as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetPlayerCaps as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval lpPlayerCaps as LPDPCAPS, byval dwFlags as DWORD) as HRESULT
	GetPlayerData as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD, byval dwFlags as DWORD) as HRESULT
	GetPlayerName as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetSessionDesc as function(byval This as IDirectPlay4 ptr, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	Initialize as function(byval This as IDirectPlay4 ptr, byval lpGUID as LPGUID) as HRESULT
	Open as function(byval This as IDirectPlay4 ptr, byval lpsd as LPDPSESSIONDESC2, byval dwFlags as DWORD) as HRESULT
	Receive as function(byval This as IDirectPlay4 ptr, byval lpidFrom as LPDPID, byval lpidTo as LPDPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	Send as function(byval This as IDirectPlay4 ptr, byval idFrom as DPID, byval idTo as DPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval dwDataSize as DWORD) as HRESULT
	SetGroupData as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	SetGroupName as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval lpGroupName as LPDPNAME, byval dwFlags as DWORD) as HRESULT
	SetPlayerData as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	SetPlayerName as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval lpPlayerName as LPDPNAME, byval dwFlags as DWORD) as HRESULT
	SetSessionDesc as function(byval This as IDirectPlay4 ptr, byval lpSessDesc as LPDPSESSIONDESC2, byval dwFlags as DWORD) as HRESULT
	AddGroupToGroup as function(byval This as IDirectPlay4 ptr, byval idParentGroup as DPID, byval idGroup as DPID) as HRESULT
	CreateGroupInGroup as function(byval This as IDirectPlay4 ptr, byval idParentGroup as DPID, byval lpidGroup as LPDPID, byval lpGroupName as LPDPNAME, byval lpData as LPVOID, byval dwDataSize as DWORD, byval dwFlags as DWORD) as HRESULT
	DeleteGroupFromGroup as function(byval This as IDirectPlay4 ptr, byval idParentGroup as DPID, byval idGroup as DPID) as HRESULT
	EnumConnections as function(byval This as IDirectPlay4 ptr, byval lpguidApplication as LPCGUID, byval lpEnumCallback as LPDPENUMCONNECTIONSCALLBACK, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	EnumGroupsInGroup as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval lpguidInstance as LPGUID, byval lpEnumCallback as LPDPENUMPLAYERSCALLBACK2, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
	GetGroupConnectionSettings as function(byval This as IDirectPlay4 ptr, byval dwFlags as DWORD, byval idGroup as DPID, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	InitializeConnection as function(byval This as IDirectPlay4 ptr, byval lpConnection as LPVOID, byval dwFlags as DWORD) as HRESULT
	SecureOpen as function(byval This as IDirectPlay4 ptr, byval lpsd as LPCDPSESSIONDESC2, byval dwFlags as DWORD, byval lpSecurity as LPCDPSECURITYDESC, byval lpCredentials as LPCDPCREDENTIALS) as HRESULT
	SendChatMessage as function(byval This as IDirectPlay4 ptr, byval idFrom as DPID, byval idTo as DPID, byval dwFlags as DWORD, byval lpChatMessage as LPDPCHAT) as HRESULT
	SetGroupConnectionSettings as function(byval This as IDirectPlay4 ptr, byval dwFlags as DWORD, byval idGroup as DPID, byval lpConnection as LPDPLCONNECTION) as HRESULT
	StartSession as function(byval This as IDirectPlay4 ptr, byval dwFlags as DWORD, byval idGroup as DPID) as HRESULT
	GetGroupFlags as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval lpdwFlags as LPDWORD) as HRESULT
	GetGroupParent as function(byval This as IDirectPlay4 ptr, byval idGroup as DPID, byval lpidParent as LPDPID) as HRESULT
	GetPlayerAccount as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval dwFlags as DWORD, byval lpData as LPVOID, byval lpdwDataSize as LPDWORD) as HRESULT
	GetPlayerFlags as function(byval This as IDirectPlay4 ptr, byval idPlayer as DPID, byval lpdwFlags as LPDWORD) as HRESULT
	GetGroupOwner as function(byval This as IDirectPlay4 ptr, byval as DPID, byval as LPDPID) as HRESULT
	SetGroupOwner as function(byval This as IDirectPlay4 ptr, byval as DPID, byval as DPID) as HRESULT
	SendEx as function(byval This as IDirectPlay4 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPVOID, byval as LPDWORD) as HRESULT
	GetMessageQueue as function(byval This as IDirectPlay4 ptr, byval as DPID, byval as DPID, byval as DWORD, byval as LPDWORD, byval as LPDWORD) as HRESULT
	CancelMessage as function(byval This as IDirectPlay4 ptr, byval as DWORD, byval as DWORD) as HRESULT
	CancelPriority as function(byval This as IDirectPlay4 ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
end type

#define IDirectPlayX_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlayX_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlayX_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlayX_AddPlayerToGroup(p, a, b) (p)->lpVtbl->AddPlayerToGroup(p, a, b)
#define IDirectPlayX_Close(p) (p)->lpVtbl->Close(p)
#define IDirectPlayX_CreateGroup(p, a, b, c, d, e) (p)->lpVtbl->CreateGroup(p, a, b, c, d, e)
#define IDirectPlayX_CreatePlayer(p, a, b, c, d, e, f) (p)->lpVtbl->CreatePlayer(p, a, b, c, d, e, f)
#define IDirectPlayX_DeletePlayerFromGroup(p, a, b) (p)->lpVtbl->DeletePlayerFromGroup(p, a, b)
#define IDirectPlayX_DestroyGroup(p, a) (p)->lpVtbl->DestroyGroup(p, a)
#define IDirectPlayX_DestroyPlayer(p, a) (p)->lpVtbl->DestroyPlayer(p, a)
#define IDirectPlayX_EnumGroupPlayers(p, a, b, c, d, e) (p)->lpVtbl->EnumGroupPlayers(p, a, b, c, d, e)
#define IDirectPlayX_EnumGroups(p, a, b, c, d) (p)->lpVtbl->EnumGroups(p, a, b, c, d)
#define IDirectPlayX_EnumPlayers(p, a, b, c, d) (p)->lpVtbl->EnumPlayers(p, a, b, c, d)
#define IDirectPlayX_EnumSessions(p, a, b, c, d, e) (p)->lpVtbl->EnumSessions(p, a, b, c, d, e)
#define IDirectPlayX_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectPlayX_GetGroupData(p, a, b, c, d) (p)->lpVtbl->GetGroupData(p, a, b, c, d)
#define IDirectPlayX_GetGroupName(p, a, b, c) (p)->lpVtbl->GetGroupName(p, a, b, c)
#define IDirectPlayX_GetMessageCount(p, a, b) (p)->lpVtbl->GetMessageCount(p, a, b)
#define IDirectPlayX_GetPlayerAddress(p, a, b, c) (p)->lpVtbl->GetPlayerAddress(p, a, b, c)
#define IDirectPlayX_GetPlayerCaps(p, a, b, c) (p)->lpVtbl->GetPlayerCaps(p, a, b, c)
#define IDirectPlayX_GetPlayerData(p, a, b, c, d) (p)->lpVtbl->GetPlayerData(p, a, b, c, d)
#define IDirectPlayX_GetPlayerName(p, a, b, c) (p)->lpVtbl->GetPlayerName(p, a, b, c)
#define IDirectPlayX_GetSessionDesc(p, a, b) (p)->lpVtbl->GetSessionDesc(p, a, b)
#define IDirectPlayX_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirectPlayX_Open(p, a, b) (p)->lpVtbl->Open(p, a, b)
#define IDirectPlayX_Receive(p, a, b, c, d, e) (p)->lpVtbl->Receive(p, a, b, c, d, e)
#define IDirectPlayX_Send(p, a, b, c, d, e) (p)->lpVtbl->Send(p, a, b, c, d, e)
#define IDirectPlayX_SetGroupData(p, a, b, c, d) (p)->lpVtbl->SetGroupData(p, a, b, c, d)
#define IDirectPlayX_SetGroupName(p, a, b, c) (p)->lpVtbl->SetGroupName(p, a, b, c)
#define IDirectPlayX_SetPlayerData(p, a, b, c, d) (p)->lpVtbl->SetPlayerData(p, a, b, c, d)
#define IDirectPlayX_SetPlayerName(p, a, b, c) (p)->lpVtbl->SetPlayerName(p, a, b, c)
#define IDirectPlayX_SetSessionDesc(p, a, b) (p)->lpVtbl->SetSessionDesc(p, a, b)
#define IDirectPlayX_AddGroupToGroup(p, a, b) (p)->lpVtbl->AddGroupToGroup(p, a, b)
#define IDirectPlayX_CreateGroupInGroup(p, a, b, c, d, e, f) (p)->lpVtbl->CreateGroupInGroup(p, a, b, c, d, e, f)
#define IDirectPlayX_DeleteGroupFromGroup(p, a, b) (p)->lpVtbl->DeleteGroupFromGroup(p, a, b)
#define IDirectPlayX_EnumConnections(p, a, b, c, d) (p)->lpVtbl->EnumConnections(p, a, b, c, d)
#define IDirectPlayX_EnumGroupsInGroup(p, a, b, c, d, e) (p)->lpVtbl->EnumGroupsInGroup(p, a, b, c, d, e)
#define IDirectPlayX_GetGroupConnectionSettings(p, a, b, c, d) (p)->lpVtbl->GetGroupConnectionSettings(p, a, b, c, d)
#define IDirectPlayX_InitializeConnection(p, a, b) (p)->lpVtbl->InitializeConnection(p, a, b)
#define IDirectPlayX_SecureOpen(p, a, b, c, d) (p)->lpVtbl->SecureOpen(p, a, b, c, d)
#define IDirectPlayX_SendChatMessage(p, a, b, c, d) (p)->lpVtbl->SendChatMessage(p, a, b, c, d)
#define IDirectPlayX_SetGroupConnectionSettings(p, a, b, c) (p)->lpVtbl->SetGroupConnectionSettings(p, a, b, c)
#define IDirectPlayX_StartSession(p, a, b) (p)->lpVtbl->StartSession(p, a, b)
#define IDirectPlayX_GetGroupFlags(p, a, b) (p)->lpVtbl->GetGroupFlags(p, a, b)
#define IDirectPlayX_GetGroupParent(p, a, b) (p)->lpVtbl->GetGroupParent(p, a, b)
#define IDirectPlayX_GetPlayerAccount(p, a, b, c, d) (p)->lpVtbl->GetPlayerAccount(p, a, b, c, d)
#define IDirectPlayX_GetPlayerFlags(p, a, b) (p)->lpVtbl->GetPlayerFlags(p, a, b)
#define IDirectPlayX_GetGroupOwner(p, a, b) (p)->lpVtbl->GetGroupOwner(p, a, b)
#define IDirectPlayX_SetGroupOwner(p, a, b) (p)->lpVtbl->SetGroupOwner(p, a, b)
#define IDirectPlayX_SendEx(p, a, b, c, d, e, f, g, h, i) (p)->lpVtbl->SendEx(p, a, b, c, d, e, f, g, h, i)
#define IDirectPlayX_GetMessageQueue(p, a, b, c, d, e) (p)->lpVtbl->GetMessageQueue(p, a, b, c, d, e)
#define IDirectPlayX_CancelMessage(p, a, b) (p)->lpVtbl->CancelMessage(p, a, b)
#define IDirectPlayX_CancelPriority(p, a, b, c) (p)->lpVtbl->CancelPriority(p, a, b, c)
const DPCONNECTION_DIRECTPLAY = &h00000001
const DPCONNECTION_DIRECTPLAYLOBBY = &h00000002
const DPENUMPLAYERS_ALL = &h00000000
const DPENUMPLAYERS_LOCAL = &h00000008
const DPENUMPLAYERS_REMOTE = &h00000010
const DPENUMPLAYERS_GROUP = &h00000020
const DPENUMPLAYERS_SESSION = &h00000080
const DPENUMPLAYERS_SERVERPLAYER = &h00000100
const DPENUMPLAYERS_SPECTATOR = &h00000200
const DPENUMPLAYERS_OWNER = &h00002000
const DPENUMGROUPS_ALL = DPENUMPLAYERS_ALL
const DPENUMGROUPS_LOCAL = DPENUMPLAYERS_LOCAL
const DPENUMGROUPS_REMOTE = DPENUMPLAYERS_REMOTE
const DPENUMGROUPS_SESSION = DPENUMPLAYERS_SESSION
const DPENUMGROUPS_SHORTCUT = &h00000400
const DPENUMGROUPS_STAGINGAREA = &h00000800
const DPENUMGROUPS_HIDDEN = &h00001000
const DPPLAYER_SERVERPLAYER = DPENUMPLAYERS_SERVERPLAYER
const DPPLAYER_SPECTATOR = DPENUMPLAYERS_SPECTATOR
const DPPLAYER_LOCAL = DPENUMPLAYERS_LOCAL
const DPPLAYER_OWNER = DPENUMPLAYERS_OWNER
const DPGROUP_STAGINGAREA = DPENUMGROUPS_STAGINGAREA
const DPGROUP_LOCAL = DPENUMGROUPS_LOCAL
const DPGROUP_HIDDEN = DPENUMGROUPS_HIDDEN
const DPENUMSESSIONS_AVAILABLE = &h00000001
const DPENUMSESSIONS_ALL = &h00000002
const DPENUMSESSIONS_ASYNC = &h00000010
const DPENUMSESSIONS_STOPASYNC = &h00000020
const DPENUMSESSIONS_PASSWORDREQUIRED = &h00000040
const DPENUMSESSIONS_RETURNSTATUS = &h00000080
const DPOPEN_RETURNSTATUS = DPENUMSESSIONS_RETURNSTATUS
const DPGETCAPS_GUARANTEED = &h00000001
const DPGET_REMOTE = &h00000000
const DPGET_LOCAL = &h00000001
const DPRECEIVE_ALL = &h00000001
const DPRECEIVE_TOPLAYER = &h00000002
const DPRECEIVE_FROMPLAYER = &h00000004
const DPRECEIVE_PEEK = &h00000008
const DPSEND_NONGUARANTEED = &h00000000
const DPSEND_GUARANTEED = &h00000001
const DPSEND_HIGHPRIORITY = &h00000002
const DPSEND_OPENSTREAM = &h00000008
const DPSEND_CLOSESTREAM = &h00000010
const DPSEND_SIGNED = &h00000020
const DPSEND_ENCRYPTED = &h00000040
const DPSEND_LOBBYSYSTEMMESSAGE = &h00000080
const DPSEND_ASYNC = &h00000200
const DPSEND_NOSENDCOMPLETEMSG = &h00000400
const DPSEND_MAX_PRI = &h0000FFFF
const DPSEND_MAX_PRIORITY = DPSEND_MAX_PRI
const DPSET_REMOTE = &h00000000
const DPSET_LOCAL = &h00000001
const DPSET_GUARANTEED = &h00000002
const DPMESSAGEQUEUE_SEND = &h00000001
const DPMESSAGEQUEUE_RECEIVE = &h00000002
const DPCONNECT_RETURNSTATUS = DPENUMSESSIONS_RETURNSTATUS
const DPCAPS_ISHOST = &h00000002
const DPCAPS_GROUPOPTIMIZED = &h00000008
const DPCAPS_KEEPALIVEOPTIMIZED = &h00000010
const DPCAPS_GUARANTEEDOPTIMIZED = &h00000020
const DPCAPS_GUARANTEEDSUPPORTED = &h00000040
const DPCAPS_SIGNINGSUPPORTED = &h00000080
const DPCAPS_ENCRYPTIONSUPPORTED = &h00000100
const DPPLAYERCAPS_LOCAL = &h00000800
const DPCAPS_ASYNCCANCELSUPPORTED = &h00001000
const DPCAPS_ASYNCCANCELALLSUPPORTED = &h00002000
const DPCAPS_SENDTIMEOUTSUPPORTED = &h00004000
const DPCAPS_SENDPRIORITYSUPPORTED = &h00008000
const DPCAPS_ASYNCSUPPORTED = &h00010000
const DPSYS_CREATEPLAYERORGROUP = &h0003
const DPSYS_DESTROYPLAYERORGROUP = &h0005
const DPSYS_ADDPLAYERTOGROUP = &h0007
const DPSYS_DELETEPLAYERFROMGROUP = &h0021
const DPSYS_SESSIONLOST = &h0031
const DPSYS_HOST = &h0101
const DPSYS_SETPLAYERORGROUPDATA = &h0102
const DPSYS_SETPLAYERORGROUPNAME = &h0103
const DPSYS_SETSESSIONDESC = &h0104
const DPSYS_ADDGROUPTOGROUP = &h0105
const DPSYS_DELETEGROUPFROMGROUP = &h0106
const DPSYS_SECUREMESSAGE = &h0107
const DPSYS_STARTSESSION = &h0108
const DPSYS_CHAT = &h0109
const DPSYS_SETGROUPOWNER = &h010A
const DPSYS_SENDCOMPLETE = &h010d
const DPPLAYERTYPE_GROUP = &h00000000
const DPPLAYERTYPE_PLAYER = &h00000001

type tagDPMSG_GENERIC
	dwType as DWORD
end type

type DPMSG_GENERIC as tagDPMSG_GENERIC
type LPDPMSG_GENERIC as tagDPMSG_GENERIC ptr
type DPMSG_HOST as tagDPMSG_GENERIC
type LPDPMSG_HOST as tagDPMSG_GENERIC ptr
type DPMSG_SESSIONLOST as tagDPMSG_GENERIC
type LPDPMSG_SESSIONLOST as tagDPMSG_GENERIC ptr

type tagDPMSG_CREATEPLAYERORGROUP
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

type DPMSG_CREATEPLAYERORGROUP as tagDPMSG_CREATEPLAYERORGROUP
type LPDPMSG_CREATEPLAYERORGROUP as tagDPMSG_CREATEPLAYERORGROUP ptr

type tagDPMSG_DESTROYPLAYERORGROUP
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

type DPMSG_DESTROYPLAYERORGROUP as tagDPMSG_DESTROYPLAYERORGROUP
type LPDPMSG_DESTROYPLAYERORGROUP as tagDPMSG_DESTROYPLAYERORGROUP ptr

type tagDPMSG_ADDPLAYERTOGROUP
	dwType as DWORD
	dpIdGroup as DPID
	dpIdPlayer as DPID
end type

type DPMSG_ADDPLAYERTOGROUP as tagDPMSG_ADDPLAYERTOGROUP
type LPDPMSG_ADDPLAYERTOGROUP as tagDPMSG_ADDPLAYERTOGROUP ptr
type DPMSG_DELETEPLAYERFROMGROUP as tagDPMSG_ADDPLAYERTOGROUP
type LPDPMSG_DELETEPLAYERFROMGROUP as tagDPMSG_ADDPLAYERTOGROUP ptr

type tagDPMSG_ADDGROUPTOGROUP
	dwType as DWORD
	dpIdParentGroup as DPID
	dpIdGroup as DPID
end type

type DPMSG_ADDGROUPTOGROUP as tagDPMSG_ADDGROUPTOGROUP
type LPDPMSG_ADDGROUPTOGROUP as tagDPMSG_ADDGROUPTOGROUP ptr
type DPMSG_DELETEGROUPFROMGROUP as tagDPMSG_ADDGROUPTOGROUP
type LPDPMSG_DELETEGROUPFROMGROUP as tagDPMSG_ADDGROUPTOGROUP ptr

type tagDPMSG_SETPLAYERORGROUPDATA
	dwType as DWORD
	dwPlayerType as DWORD
	dpId as DPID
	lpData as LPVOID
	dwDataSize as DWORD
end type

type DPMSG_SETPLAYERORGROUPDATA as tagDPMSG_SETPLAYERORGROUPDATA
type LPDPMSG_SETPLAYERORGROUPDATA as tagDPMSG_SETPLAYERORGROUPDATA ptr

type tagDPMSG_SETPLAYERORGROUPNAME
	dwType as DWORD
	dwPlayerType as DWORD
	dpId as DPID
	dpnName as DPNAME
end type

type DPMSG_SETPLAYERORGROUPNAME as tagDPMSG_SETPLAYERORGROUPNAME
type LPDPMSG_SETPLAYERORGROUPNAME as tagDPMSG_SETPLAYERORGROUPNAME ptr

type tagDPMSG_SETSESSIONDESC
	dwType as DWORD
	dpDesc as DPSESSIONDESC2
end type

type DPMSG_SETSESSIONDESC as tagDPMSG_SETSESSIONDESC
type LPDPMSG_SETSESSIONDESC as tagDPMSG_SETSESSIONDESC ptr

type tagDPMSG_SECUREMESSAGE
	dwType as DWORD
	dwFlags as DWORD
	dpIdFrom as DPID
	lpData as LPVOID
	dwDataSize as DWORD
end type

type DPMSG_SECUREMESSAGE as tagDPMSG_SECUREMESSAGE
type LPDPMSG_SECUREMESSAGE as tagDPMSG_SECUREMESSAGE ptr

type tagDPMSG_STARTSESSION
	dwType as DWORD
	lpConn as LPDPLCONNECTION
end type

type DPMSG_STARTSESSION as tagDPMSG_STARTSESSION
type LPDPMSG_STARTSESSION as tagDPMSG_STARTSESSION ptr

type tagDPMSG_CHAT
	dwType as DWORD
	dwFlags as DWORD
	idFromPlayer as DPID
	idToPlayer as DPID
	idToGroup as DPID
	lpChat as LPDPCHAT
end type

type DPMSG_CHAT as tagDPMSG_CHAT
type LPDPMSG_CHAT as tagDPMSG_CHAT ptr

type tagDPMSG_SETGROUPOWNER
	dwType as DWORD
	idGroup as DPID
	idNewOwner as DPID
	idOldOwner as DPID
end type

type DPMSG_SETGROUPOWNER as tagDPMSG_SETGROUPOWNER
type LPDPMSG_SETGROUPOWNER as tagDPMSG_SETGROUPOWNER ptr

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

end extern
