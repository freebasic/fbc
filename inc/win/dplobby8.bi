'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2003-2005 Raphael Junqueira
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

#include once "ole2.bi"

extern "Windows"

#define __WINE_DPLOBBY8_H
const DPL_MSGID_LOBBY = &h8000
const DPL_MSGID_RECEIVE = &h0001 or DPL_MSGID_LOBBY
const DPL_MSGID_CONNECT = &h0002 or DPL_MSGID_LOBBY
const DPL_MSGID_DISCONNECT = &h0003 or DPL_MSGID_LOBBY
const DPL_MSGID_SESSION_STATUS = &h0004 or DPL_MSGID_LOBBY
const DPL_MSGID_CONNECTION_SETTINGS = &h0005 or DPL_MSGID_LOBBY
const DPLHANDLE_ALLCONNECTIONS = &hFFFFFFFF
const DPLSESSION_CONNECTED = &h0001
const DPLSESSION_COULDNOTCONNECT = &h0002
const DPLSESSION_DISCONNECTED = &h0003
const DPLSESSION_TERMINATED = &h0004
const DPLSESSION_HOSTMIGRATED = &h0005
const DPLSESSION_HOSTMIGRATEDHERE = &h0006
const DPLAVAILABLE_ALLOWMULTIPLECONNECT = &h0001
const DPLCONNECT_LAUNCHNEW = &h0001
const DPLCONNECT_LAUNCHNOTFOUND = &h0002
const DPLCONNECTSETTINGS_HOST = &h0001
const DPLINITIALIZE_DISABLEPARAMVAL = &h0001

type _DPL_APPLICATION_INFO
	guidApplication as GUID
	pwszApplicationName as PWSTR
	dwNumRunning as DWORD
	dwNumWaiting as DWORD
	dwFlags as DWORD
end type

type DPL_APPLICATION_INFO as _DPL_APPLICATION_INFO
type PDPL_APPLICATION_INFO as _DPL_APPLICATION_INFO ptr

type _DPL_CONNECTION_SETTINGS
	dwSize as DWORD
	dwFlags as DWORD
	dpnAppDesc as DPN_APPLICATION_DESC
	pdp8HostAddress as IDirectPlay8Address ptr
	ppdp8DeviceAddresses as IDirectPlay8Address ptr ptr
	cNumDeviceAddresses as DWORD
	pwszPlayerName as PWSTR
end type

type DPL_CONNECTION_SETTINGS as _DPL_CONNECTION_SETTINGS
type PDPL_CONNECTION_SETTINGS as _DPL_CONNECTION_SETTINGS ptr

type _DPL_CONNECT_INFO
	dwSize as DWORD
	dwFlags as DWORD
	guidApplication as GUID
	pdplConnectionSettings as PDPL_CONNECTION_SETTINGS
	pvLobbyConnectData as PVOID
	dwLobbyConnectDataSize as DWORD
end type

type DPL_CONNECT_INFO as _DPL_CONNECT_INFO
type PDPL_CONNECT_INFO as _DPL_CONNECT_INFO ptr

type _DPL_PROGRAM_DESC
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

type DPL_PROGRAM_DESC as _DPL_PROGRAM_DESC
type PDPL_PROGRAM_DESC as _DPL_PROGRAM_DESC ptr

type _DPL_MESSAGE_CONNECT
	dwSize as DWORD
	hConnectId as DPNHANDLE
	pdplConnectionSettings as PDPL_CONNECTION_SETTINGS
	pvLobbyConnectData as PVOID
	dwLobbyConnectDataSize as DWORD
	pvConnectionContext as PVOID
end type

type DPL_MESSAGE_CONNECT as _DPL_MESSAGE_CONNECT
type PDPL_MESSAGE_CONNECT as _DPL_MESSAGE_CONNECT ptr

type _DPL_MESSAGE_CONNECTION_SETTINGS
	dwSize as DWORD
	hSender as DPNHANDLE
	pdplConnectionSettings as PDPL_CONNECTION_SETTINGS
	pvConnectionContext as PVOID
end type

type DPL_MESSAGE_CONNECTION_SETTINGS as _DPL_MESSAGE_CONNECTION_SETTINGS
type PDPL_MESSAGE_CONNECTION_SETTINGS as _DPL_MESSAGE_CONNECTION_SETTINGS ptr

type _DPL_MESSAGE_DISCONNECT
	dwSize as DWORD
	hDisconnectId as DPNHANDLE
	hrReason as HRESULT
	pvConnectionContext as PVOID
end type

type DPL_MESSAGE_DISCONNECT as _DPL_MESSAGE_DISCONNECT
type PDPL_MESSAGE_DISCONNECT as _DPL_MESSAGE_DISCONNECT ptr

type _DPL_MESSAGE_RECEIVE
	dwSize as DWORD
	hSender as DPNHANDLE
	pBuffer as UBYTE ptr
	dwBufferSize as DWORD
	pvConnectionContext as PVOID
end type

type DPL_MESSAGE_RECEIVE as _DPL_MESSAGE_RECEIVE
type PDPL_MESSAGE_RECEIVE as _DPL_MESSAGE_RECEIVE ptr

type _DPL_MESSAGE_SESSION_STATUS
	dwSize as DWORD
	hSender as DPNHANDLE
	dwStatus as DWORD
	pvConnectionContext as PVOID
end type

type DPL_MESSAGE_SESSION_STATUS as _DPL_MESSAGE_SESSION_STATUS
type PDPL_MESSAGE_SESSION_STATUS as _DPL_MESSAGE_SESSION_STATUS ptr
extern CLSID_DirectPlay8LobbiedApplication as const GUID
extern CLSID_DirectPlay8LobbyClient as const GUID
extern IID_IDirectPlay8LobbiedApplication as const GUID
type PDIRECTPLAY8LOBBIEDAPPLICATION as IDirectPlay8LobbiedApplication ptr
extern IID_IDirectPlay8LobbyClient as const GUID
type PDIRECTPLAY8LOBBYCLIENT as IDirectPlay8LobbyClient ptr
type IDirectPlay8LobbiedApplicationVtbl as IDirectPlay8LobbiedApplicationVtbl_

type IDirectPlay8LobbiedApplication_
	lpVtbl as IDirectPlay8LobbiedApplicationVtbl ptr
end type

type IDirectPlay8LobbiedApplicationVtbl_
	QueryInterface as function(byval This as IDirectPlay8LobbiedApplication ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8LobbiedApplication ptr) as ULONG
	Release as function(byval This as IDirectPlay8LobbiedApplication ptr) as ULONG
	Initialize as function(byval This as IDirectPlay8LobbiedApplication ptr, byval pvUserContext as PVOID, byval pfn as PFNDPNMESSAGEHANDLER, byval pdpnhConnection as DPNHANDLE ptr, byval dwFlags as DWORD) as HRESULT
	RegisterProgram as function(byval This as IDirectPlay8LobbiedApplication ptr, byval pdplProgramDesc as PDPL_PROGRAM_DESC, byval dwFlags as DWORD) as HRESULT
	UnRegisterProgram as function(byval This as IDirectPlay8LobbiedApplication ptr, byval pguidApplication as GUID ptr, byval dwFlags as DWORD) as HRESULT
	Send as function(byval This as IDirectPlay8LobbiedApplication ptr, byval hConnection as DPNHANDLE, byval pBuffer as UBYTE ptr, byval pBufferSize as DWORD, byval dwFlags as DWORD) as HRESULT
	SetAppAvailable as function(byval This as IDirectPlay8LobbiedApplication ptr, byval fAvailable as WINBOOL, byval dwFlags as DWORD) as HRESULT
	UpdateStatus as function(byval This as IDirectPlay8LobbiedApplication ptr, byval hConnection as DPNHANDLE, byval dwStatus as DWORD, byval dwFlags as DWORD) as HRESULT
	Close as function(byval This as IDirectPlay8LobbiedApplication ptr, byval dwFlags as DWORD) as HRESULT
	GetConnectionSettings as function(byval This as IDirectPlay8LobbiedApplication ptr, byval hConnection as DPNHANDLE, byval pdplSessionInfo as DPL_CONNECTION_SETTINGS ptr, byval pdwInfoSize as DWORD ptr, byval dwFlags as DWORD) as HRESULT
	SetConnectionSettings as function(byval This as IDirectPlay8LobbiedApplication ptr, byval hConnection as DPNHANDLE, byval pdplSessionInfo as const DPL_CONNECTION_SETTINGS ptr, byval dwFlags as DWORD) as HRESULT
end type

#define IDirectPlay8LobbiedApplication_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay8LobbiedApplication_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8LobbiedApplication_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8LobbiedApplication_Initialize(p, a, b, c, d) (p)->lpVtbl->Initialize(p, a, b, c, d)
#define IDirectPlay8LobbiedApplication_RegisterProgram(p, a, b) (p)->lpVtbl->RegisterProgram(p, a, b)
#define IDirectPlay8LobbiedApplication_UnRegisterProgram(p, a, b) (p)->lpVtbl->UnRegisterProgram(p, a, b)
#define IDirectPlay8LobbiedApplication_Send(p, a, b, c, d) (p)->lpVtbl->Send(p, a, b, c, d)
#define IDirectPlay8LobbiedApplication_SetAppAvailable(p, a, b) (p)->lpVtbl->SetAppAvailable(p, a, b)
#define IDirectPlay8LobbiedApplication_UpdateStatus(p, a, b, c) (p)->lpVtbl->UpdateStatus(p, a, b, c)
#define IDirectPlay8LobbiedApplication_Close(p, a) (p)->lpVtbl->Close(p, a)
#define IDirectPlay8LobbiedApplication_GetConnectionSettings(p, a, b, c, d) (p)->lpVtbl->GetConnectionSettings(p, a, b, c, d)
#define IDirectPlay8LobbiedApplication_SetConnectionSettings(p, a, b, c) (p)->lpVtbl->SetConnectionSettings(p, a, b, c)
type IDirectPlay8LobbyClientVtbl as IDirectPlay8LobbyClientVtbl_

type IDirectPlay8LobbyClient
	lpVtbl as IDirectPlay8LobbyClientVtbl ptr
end type

type IDirectPlay8LobbyClientVtbl_
	QueryInterface as function(byval This as IDirectPlay8LobbyClient ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8LobbyClient ptr) as ULONG
	Release as function(byval This as IDirectPlay8LobbyClient ptr) as ULONG
	Initialize as function(byval This as IDirectPlay8LobbyClient ptr, byval pvUserContext as PVOID, byval pfn as PFNDPNMESSAGEHANDLER, byval dwFlags as DWORD) as HRESULT
	EnumLocalPrograms as function(byval This as IDirectPlay8LobbyClient ptr, byval pGuidApplication as GUID ptr, byval pEnumData as UBYTE ptr, byval pdwEnumData as DWORD ptr, byval pdwItems as DWORD ptr, byval dwFlags as DWORD) as HRESULT
	ConnectApplication as function(byval This as IDirectPlay8LobbyClient ptr, byval pdplConnectionInfo as DPL_CONNECT_INFO ptr, byval pvConnectionContext as PVOID, byval hApplication as DPNHANDLE ptr, byval dwTimeOut as DWORD, byval dwFlags as DWORD) as HRESULT
	Send as function(byval This as IDirectPlay8LobbyClient ptr, byval hConnection as DPNHANDLE, byval pBuffer as UBYTE ptr, byval pBufferSize as DWORD, byval dwFlags as DWORD) as HRESULT
	ReleaseApplication as function(byval This as IDirectPlay8LobbyClient ptr, byval hConnection as DPNHANDLE, byval dwFlags as DWORD) as HRESULT
	Close as function(byval This as IDirectPlay8LobbyClient ptr, byval dwFlags as DWORD) as HRESULT
	GetConnectionSettings as function(byval This as IDirectPlay8LobbyClient ptr, byval hConnection as DPNHANDLE, byval pdplSessionInfo as DPL_CONNECTION_SETTINGS ptr, byval pdwInfoSize as DWORD ptr, byval dwFlags as DWORD) as HRESULT
	SetConnectionSettings as function(byval This as IDirectPlay8LobbyClient ptr, byval hConnection as DPNHANDLE, byval pdplSessionInfo as const DPL_CONNECTION_SETTINGS ptr, byval dwFlags as DWORD) as HRESULT
end type

#define IDirectPlay8LobbyClient_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay8LobbyClient_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8LobbyClient_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8LobbyClient_Initialize(p, a, b, c) (p)->lpVtbl->Initialize(p, a, b, c)
#define IDirectPlay8LobbyClient_EnumLocalPrograms(p, a, b, c, d, e) (p)->lpVtbl->EnumLocalPrograms(p, a, b, c, d, e)
#define IDirectPlay8LobbyClient_ConnectApplication(p, a, b, c, d, e) (p)->lpVtbl->ConnectApplication(p, a, b, c, d, e)
#define IDirectPlay8LobbyClient_Send(p, a, b, c, d) (p)->lpVtbl->Send(p, a, b, c, d)
#define IDirectPlay8LobbyClient_ReleaseApplication(p, a, b) (p)->lpVtbl->ReleaseApplication(p, a, b)
#define IDirectPlay8LobbyClient_Close(p, a) (p)->lpVtbl->Close(p, a)
#define IDirectPlay8LobbyClient_GetConnectionSettings(p, a, b, c, d) (p)->lpVtbl->GetConnectionSettings(p, a, b, c, d)
#define IDirectPlay8LobbyClient_SetConnectionSettings(p, a, b, c) (p)->lpVtbl->SetConnectionSettings(p, a, b, c)
declare function DirectPlay8LobbyCreate(byval pcIID as const GUID ptr, byval ppvInterface as LPVOID ptr, byval pUnknown as IUnknown ptr) as HRESULT

end extern
