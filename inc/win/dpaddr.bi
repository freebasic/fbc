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
#include once "dplay8.bi"

extern "Windows"

#define __WINE_DPLAY8_DPADDR_H
type DPNAREFIID as const IID const ptr
const DPNA_DATATYPE_STRING = &h00000001
const DPNA_DATATYPE_DWORD = &h00000002
const DPNA_DATATYPE_GUID = &h00000003
const DPNA_DATATYPE_BINARY = &h00000004
const DPNA_DATATYPE_STRING_ANSI = &h00000005
const DPNA_DPNSVR_PORT = 6073
const DPNA_INDEX_INVALID = &hFFFFFFFF
#define DPNA_SEPARATOR_KEYVALUE asc(wstr("="))
#define DPNA_SEPARATOR_KEYVALUE_A asc("=")
#define DPNA_SEPARATOR_USERDATA asc(wstr("#"))
#define DPNA_SEPARATOR_USERDATA_A asc("#")
#define DPNA_SEPARATOR_COMPONENT asc(wstr(";"))
#define DPNA_SEPARATOR_COMPONENT_A asc(";")
#define DPNA_ESCAPECHAR asc(wstr("%"))
#define DPNA_ESCAPECHAR_A asc("%")
#define DPNA_HEADER_A "x-directplay:/"
#define DPNA_KEY_APPLICATION_INSTANCE_A "applicationinstance"
#define DPNA_KEY_BAUD_A "baud"
#define DPNA_KEY_DEVICE_A "device"
#define DPNA_KEY_FLOWCONTROL_A "flowcontrol"
#define DPNA_KEY_HOSTNAME_A "hostname"
#define DPNA_KEY_NAMEINFO_A "nameinfo"
#define DPNA_KEY_PARITY_A "parity"
#define DPNA_KEY_PHONENUMBER_A "phonenumber"
#define DPNA_KEY_PORT_A "port"
#define DPNA_KEY_PROCESSOR_A "processor"
#define DPNA_KEY_PROGRAM_A "program"
#define DPNA_KEY_PROVIDER_A "provider"
#define DPNA_KEY_SCOPE_A "scope"
#define DPNA_KEY_STOPBITS_A "stopbits"
#define DPNA_KEY_TRAVERSALMODE_A "traversalmode"
#define DPNA_STOP_BITS_ONE_A "1"
#define DPNA_STOP_BITS_ONE_FIVE_A "1.5"
#define DPNA_STOP_BITS_TWO_A "2"
#define DPNA_PARITY_NONE_A "NONE"
#define DPNA_PARITY_EVEN_A "EVEN"
#define DPNA_PARITY_ODD_A "ODD"
#define DPNA_PARITY_MARK_A "MARK"
#define DPNA_PARITY_SPACE_A "SPACE"
#define DPNA_FLOW_CONTROL_NONE_A "NONE"
#define DPNA_FLOW_CONTROL_XONXOFF_A "XONXOFF"
#define DPNA_FLOW_CONTROL_RTS_A "RTS"
#define DPNA_FLOW_CONTROL_DTR_A "DTR"
#define DPNA_FLOW_CONTROL_RTSDTR_A "RTSDTR"
#define DPNA_VALUE_TCPIPPROVIDER_A "IP"
#define DPNA_VALUE_IPXPROVIDER_A "IPX"
#define DPNA_VALUE_MODEMPROVIDER_A "MODEM"
#define DPNA_VALUE_SERIALPROVIDER_A "SERIAL"
#define DPNA_HEADER wstr("x-directplay:/")
#define DPNA_KEY_APPLICATION_INSTANCE wstr("applicationinstance")
#define DPNA_KEY_BAUD wstr("baud")
#define DPNA_KEY_DEVICE wstr("device")
#define DPNA_KEY_FLOWCONTROL wstr("flowcontrol")
#define DPNA_KEY_HOSTNAME wstr("hostname")
#define DPNA_KEY_NAMEINFO wstr("nameinfo")
#define DPNA_KEY_PARITY wstr("parity")
#define DPNA_KEY_PHONENUMBER wstr("phonenumber")
#define DPNA_KEY_PORT wstr("port")
#define DPNA_KEY_PROCESSOR wstr("processor")
#define DPNA_KEY_PROGRAM wstr("program")
#define DPNA_KEY_PROVIDER wstr("provider")
#define DPNA_KEY_SCOPE wstr("scope")
#define DPNA_KEY_STOPBITS wstr("stopbits")
#define DPNA_KEY_TRAVERSALMODE wstr("traversalmode")
#define DPNA_STOP_BITS_ONE wstr("1")
#define DPNA_STOP_BITS_ONE_FIVE wstr("1.5")
#define DPNA_STOP_BITS_TWO wstr("2")
#define DPNA_PARITY_NONE wstr("NONE")
#define DPNA_PARITY_EVEN wstr("EVEN")
#define DPNA_PARITY_ODD wstr("ODD")
#define DPNA_PARITY_MARK wstr("MARK")
#define DPNA_PARITY_SPACE wstr("SPACE")
#define DPNA_FLOW_CONTROL_NONE wstr("NONE")
#define DPNA_FLOW_CONTROL_XONXOFF wstr("XONXOFF")
#define DPNA_FLOW_CONTROL_RTS wstr("RTS")
#define DPNA_FLOW_CONTROL_DTR wstr("DTR")
#define DPNA_FLOW_CONTROL_RTSDTR wstr("RTSDTR")
#define DPNA_VALUE_TCPIPPROVIDER wstr("IP")
#define DPNA_VALUE_IPXPROVIDER wstr("IPX")
#define DPNA_VALUE_MODEMPROVIDER wstr("MODEM")
#define DPNA_VALUE_SERIALPROVIDER wstr("SERIAL")
const DPNA_BAUD_RATE_9600 = 9600
const DPNA_BAUD_RATE_14400 = 14400
const DPNA_BAUD_RATE_19200 = 19200
const DPNA_BAUD_RATE_38400 = 38400
const DPNA_BAUD_RATE_56000 = 56000
const DPNA_BAUD_RATE_57600 = 57600
const DPNA_BAUD_RATE_115200 = 115200
extern CLSID_DirectPlay8Address as const GUID
extern IID_IDirectPlay8Address as const GUID
type PDIRECTPLAY8ADDRESS as IDirectPlay8Address ptr
type LPDIRECTPLAY8ADDRESS as IDirectPlay8Address ptr
extern IID_IDirectPlay8AddressIP as const GUID

type PDIRECTPLAY8ADDRESSIP as IDirectPlay8AddressIP ptr
type LPDIRECTPLAY8ADDRESSIP as IDirectPlay8AddressIP ptr
type IDirectPlay8AddressVtbl as IDirectPlay8AddressVtbl_

type IDirectPlay8Address_
	lpVtbl as IDirectPlay8AddressVtbl ptr
end type

type IDirectPlay8AddressVtbl_
	QueryInterface as function(byval This as IDirectPlay8Address ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8Address ptr) as ULONG
	Release as function(byval This as IDirectPlay8Address ptr) as ULONG
	BuildFromURLW as function(byval This as IDirectPlay8Address ptr, byval pwszSourceURL as wstring ptr) as HRESULT
	BuildFromURLA as function(byval This as IDirectPlay8Address ptr, byval pszSourceURL as zstring ptr) as HRESULT
	Duplicate as function(byval This as IDirectPlay8Address ptr, byval ppdpaNewAddress as PDIRECTPLAY8ADDRESS ptr) as HRESULT
	SetEqual as function(byval This as IDirectPlay8Address ptr, byval pdpaAddress as PDIRECTPLAY8ADDRESS) as HRESULT
	IsEqual as function(byval This as IDirectPlay8Address ptr, byval pdpaAddress as PDIRECTPLAY8ADDRESS) as HRESULT
	Clear as function(byval This as IDirectPlay8Address ptr) as HRESULT
	GetURLW as function(byval This as IDirectPlay8Address ptr, byval pwszURL as wstring ptr, byval pdwNumChars as PDWORD) as HRESULT
	GetURLA as function(byval This as IDirectPlay8Address ptr, byval pszURL as zstring ptr, byval pdwNumChars as PDWORD) as HRESULT
	GetSP as function(byval This as IDirectPlay8Address ptr, byval pguidSP as GUID ptr) as HRESULT
	GetUserData as function(byval This as IDirectPlay8Address ptr, byval pvUserData as LPVOID, byval pdwBufferSize as PDWORD) as HRESULT
	SetSP as function(byval This as IDirectPlay8Address ptr, byval pguidSP as const GUID ptr) as HRESULT
	SetUserData as function(byval This as IDirectPlay8Address ptr, byval pvUserData as const any ptr, byval dwDataSize as DWORD) as HRESULT
	GetNumComponents as function(byval This as IDirectPlay8Address ptr, byval pdwNumComponents as PDWORD) as HRESULT
	GetComponentByName as function(byval This as IDirectPlay8Address ptr, byval pwszName as const wstring ptr, byval pvBuffer as LPVOID, byval pdwBufferSize as PDWORD, byval pdwDataType as PDWORD) as HRESULT
	GetComponentByIndex as function(byval This as IDirectPlay8Address ptr, byval dwComponentID as DWORD, byval pwszName as wstring ptr, byval pdwNameLen as PDWORD, byval pvBuffer as any ptr, byval pdwBufferSize as PDWORD, byval pdwDataType as PDWORD) as HRESULT
	AddComponent as function(byval This as IDirectPlay8Address ptr, byval pwszName as const wstring ptr, byval lpvData as const any ptr, byval dwDataSize as DWORD, byval dwDataType as DWORD) as HRESULT
	GetDevice as function(byval This as IDirectPlay8Address ptr, byval pDevGuid as GUID ptr) as HRESULT
	SetDevice as function(byval This as IDirectPlay8Address ptr, byval devGuid as const GUID ptr) as HRESULT
	BuildFromDirectPlay4Address as function(byval This as IDirectPlay8Address ptr, byval pvAddress as LPVOID, byval dwDataSize as DWORD) as HRESULT
end type

#define IDirectPlay8Address_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay8Address_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8Address_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8Address_BuildFromURLW(p, a) (p)->lpVtbl->BuildFromURLW(p, a)
#define IDirectPlay8Address_BuildFromURLA(p, a) (p)->lpVtbl->BuildFromURLA(p, a)
#define IDirectPlay8Address_Duplicate(p, a) (p)->lpVtbl->Duplicate(p, a)
#define IDirectPlay8Address_SetEqual(p, a) (p)->lpVtbl->SetEqual(p, a)
#define IDirectPlay8Address_IsEqual(p, a) (p)->lpVtbl->IsEqual(p, a)
#define IDirectPlay8Address_Clear(p) (p)->lpVtbl->Clear(p)
#define IDirectPlay8Address_GetURLW(p, a, b) (p)->lpVtbl->GetURLW(p, a, b)
#define IDirectPlay8Address_GetURLA(p, a, b) (p)->lpVtbl->GetURLA(p, a, b)
#define IDirectPlay8Address_GetSP(p, a) (p)->lpVtbl->GetSP(p, a)
#define IDirectPlay8Address_GetUserData(p, a, b) (p)->lpVtbl->GetUserData(p, a, b)
#define IDirectPlay8Address_SetSP(p, a) (p)->lpVtbl->SetSP(p, a)
#define IDirectPlay8Address_SetUserData(p, a, b) (p)->lpVtbl->SetUserData(p, a, b)
#define IDirectPlay8Address_GetNumComponents(p, a) (p)->lpVtbl->GetNumComponents(p, a)
#define IDirectPlay8Address_GetComponentByName(p, a, b, c, d) (p)->lpVtbl->GetComponentByName(p, a, b, c, d)
#define IDirectPlay8Address_GetComponentByIndex(p, a, b, c, d, e, f) (p)->lpVtbl->GetComponentByIndex(p, a, b, c, d, e, f)
#define IDirectPlay8Address_AddComponent(p, a, b, c, d) (p)->lpVtbl->AddComponent(p, a, b, c, d)
#define IDirectPlay8Address_SetDevice(p, a) (p)->lpVtbl->SetDevice(p, a)
#define IDirectPlay8Address_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirectPlay8Address_BuildFromDirectPlay4Address(p, a, b) (p)->lpVtbl->BuildFromDirectPlay4Address(p, a, b)
type IDirectPlay8AddressIPVtbl as IDirectPlay8AddressIPVtbl_

type IDirectPlay8AddressIP
	lpVtbl as IDirectPlay8AddressIPVtbl ptr
end type

type IDirectPlay8AddressIPVtbl_
	QueryInterface as function(byval This as IDirectPlay8AddressIP ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8AddressIP ptr) as ULONG
	Release as function(byval This as IDirectPlay8AddressIP ptr) as ULONG
	BuildFromSockAddr as function(byval This as IDirectPlay8AddressIP ptr, byval pSockAddr as const SOCKADDR ptr) as HRESULT
	BuildAddress as function(byval This as IDirectPlay8AddressIP ptr, byval wszAddress as const wstring ptr, byval usPort as USHORT) as HRESULT
	BuildLocalAddress as function(byval This as IDirectPlay8AddressIP ptr, byval pguidAdapter as const GUID ptr, byval usPort as USHORT) as HRESULT
	GetSockAddress as function(byval This as IDirectPlay8AddressIP ptr, byval pSockAddr as SOCKADDR ptr, byval as PDWORD) as HRESULT
	GetLocalAddress as function(byval This as IDirectPlay8AddressIP ptr, byval pguidAdapter as GUID ptr, byval pusPort as USHORT ptr) as HRESULT
	GetAddress as function(byval This as IDirectPlay8AddressIP ptr, byval wszAddress as wstring ptr, byval pdwAddressLength as PDWORD, byval psPort as USHORT ptr) as HRESULT
end type

#define IDirectPlay8AddressIP_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(a, b)
#define IDirectPlay8AddressIP_AddRef(p) (p)->lpVtbl->AddRef()
#define IDirectPlay8AddressIP_Release(p) (p)->lpVtbl->Release()
#define IDirectPlay8AddressIP_BuildFromSockAddr(p, a) (p)->lpVtbl->BuildFromSockAddr(a)
#define IDirectPlay8AddressIP_BuildAddress(p, a, b) (p)->lpVtbl->BuildAddress(a, b)
#define IDirectPlay8AddressIP_BuildLocalAddress(p, a, b) (p)->lpVtbl->BuildLocalAddress(a, b)
#define IDirectPlay8AddressIP_GetSockAddress(p, a, b) (p)->lpVtbl->GetSockAddress(a, b)
#define IDirectPlay8AddressIP_GetLocalAddress(p, a, b) (p)->lpVtbl->GetLocalAddress(a, b)
#define IDirectPlay8AddressIP_GetAddress(p, a, b, c) (p)->lpVtbl->GetAddress(a, b, c)
declare function DirectPlay8AddressCreate(byval pcIID as const GUID ptr, byval ppvInterface as LPVOID ptr, byval pUnknown as IUnknown ptr) as HRESULT

end extern
