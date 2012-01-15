''
''
'' dpaddr -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dpaddr_bi__
#define __win_dpaddr_bi__

#include once "win/ole2.bi"
#include once "win/dplay8.bi"

extern CLSID_DirectPlay8Address alias "CLSID_DirectPlay8Address" as GUID

type DPNAREFIID as IID ptr

extern IID_IDirectPlay8Address alias "IID_IDirectPlay8Address" as GUID
extern IID_IDirectPlay8AddressIP alias "IID_IDirectPlay8AddressIP" as GUID

type PDIRECTPLAY8ADDRESS as IDirectPlay8Address ptr
type LPDIRECTPLAY8ADDRESS as IDirectPlay8Address ptr
type PDIRECTPLAY8ADDRESSIP as IDirectPlay8AddressIP ptr
type LPDIRECTPLAY8ADDRESSIP as IDirectPlay8AddressIP ptr
#ifndef SOCKADDR
type SOCKADDR as any
#endif

#define DPNA_DATATYPE_STRING &h00000001
#define DPNA_DATATYPE_DWORD &h00000002
#define DPNA_DATATYPE_GUID &h00000003
#define DPNA_DATATYPE_BINARY &h00000004
#define DPNA_DATATYPE_STRING_ANSI &h00000005
#define DPNA_DPNSVR_PORT 6073
#define DPNA_INDEX_INVALID &hFFFFFFFF
#define DPNA_BAUD_RATE_9600 9600
#define DPNA_BAUD_RATE_14400 14400
#define DPNA_BAUD_RATE_19200 19200
#define DPNA_BAUD_RATE_38400 38400
#define DPNA_BAUD_RATE_56000 56000
#define DPNA_BAUD_RATE_57600 57600
#define DPNA_BAUD_RATE_115200 115200
#define DPNA_TRAVERSALMODE_NONE 0
#define DPNA_TRAVERSALMODE_PORTREQUIRED 1
#define DPNA_TRAVERSALMODE_PORTRECOMMENDED 2
#define DPNA_HEADER_A "x-directplay:/"
#define DPNA_SEPARATOR_KEYVALUE_A asc("=")
#define DPNA_SEPARATOR_USERDATA_A asc("#")
#define DPNA_SEPARATOR_COMPONENT_A asc(";")
#define DPNA_ESCAPECHAR_A asc("%")
#define DPNA_KEY_NAT_RESOLVER_A "natresolver"
#define DPNA_KEY_NAT_RESOLVER_USER_STRING_A "natresolveruserstring"
#define DPNA_KEY_APPLICATION_INSTANCE_A "applicationinstance"
#define DPNA_KEY_DEVICE_A "device"
#define DPNA_KEY_HOSTNAME_A "hostname"
#define DPNA_KEY_PORT_A "port"
#define DPNA_KEY_NAMEINFO_A "nameinfo"
#define DPNA_KEY_PROCESSOR_A "processor"
#define DPNA_KEY_PROGRAM_A "program"
#define DPNA_KEY_PROVIDER_A "provider"
#define DPNA_KEY_SCOPE_A "scope"
#define DPNA_KEY_TRAVERSALMODE_A "traversalmode"
#define DPNA_KEY_BAUD_A "baud"
#define DPNA_KEY_FLOWCONTROL_A "flowcontrol"
#define DPNA_KEY_PARITY_A "parity"
#define DPNA_KEY_PHONENUMBER_A "phonenumber"
#define DPNA_KEY_STOPBITS_A "stopbits"
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

type IDirectPlay8AddressVtbl_ as IDirectPlay8AddressVtbl

type IDirectPlay8Address
	lpVtbl as IDirectPlay8AddressVtbl_ ptr
end type

type IDirectPlay8AddressVtbl
	QueryInterface as function stdcall(byval as IDirectPlay8Address ptr, byval as DPNAREFIID, byval as LPVOID ptr) as HRESULT
	AddRef as function stdcall(byval as IDirectPlay8Address ptr) as ULONG
	Release as function stdcall(byval as IDirectPlay8Address ptr) as ULONG
	BuildFromURLW as function stdcall(byval as IDirectPlay8Address ptr, byval as WCHAR ptr) as HRESULT
	BuildFromURLA as function stdcall(byval as IDirectPlay8Address ptr, byval as CHAR ptr) as HRESULT
	Duplicate as function stdcall(byval as IDirectPlay8Address ptr, byval as PDIRECTPLAY8ADDRESS ptr) as HRESULT
	SetEqual as function stdcall(byval as IDirectPlay8Address ptr, byval as PDIRECTPLAY8ADDRESS) as HRESULT
	IsEqual as function stdcall(byval as IDirectPlay8Address ptr, byval as PDIRECTPLAY8ADDRESS) as HRESULT
	Clear as function stdcall(byval as IDirectPlay8Address ptr) as HRESULT
	GetURLW as function stdcall(byval as IDirectPlay8Address ptr, byval as WCHAR ptr, byval as PDWORD) as HRESULT
	GetURLA as function stdcall(byval as IDirectPlay8Address ptr, byval as CHAR ptr, byval as PDWORD) as HRESULT
	GetSP as function stdcall(byval as IDirectPlay8Address ptr, byval as GUID ptr) as HRESULT
	GetUserData as function stdcall(byval as IDirectPlay8Address ptr, byval as any ptr, byval as PDWORD) as HRESULT
	SetSP as function stdcall(byval as IDirectPlay8Address ptr, byval as GUID ptr) as HRESULT
	SetUserData as function stdcall(byval as IDirectPlay8Address ptr, byval as any ptr, byval as DWORD) as HRESULT
	GetNumComponents as function stdcall(byval as IDirectPlay8Address ptr, byval as PDWORD) as HRESULT
	GetComponentByName as function stdcall(byval as IDirectPlay8Address ptr, byval as WCHAR ptr, byval as any ptr, byval as PDWORD, byval as PDWORD) as HRESULT
	GetComponentByIndex as function stdcall(byval as IDirectPlay8Address ptr, byval as DWORD, byval as WCHAR ptr, byval as PDWORD, byval as any ptr, byval as PDWORD, byval as PDWORD) as HRESULT
	AddComponent as function stdcall(byval as IDirectPlay8Address ptr, byval as WCHAR ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetDevice as function stdcall(byval as IDirectPlay8Address ptr, byval as GUID ptr) as HRESULT
	SetDevice as function stdcall(byval as IDirectPlay8Address ptr, byval as GUID ptr) as HRESULT
	BuildFromDPADDRESS as function stdcall(byval as IDirectPlay8Address ptr, byval as LPVOID, byval as DWORD) as HRESULT
end type

type IDirectPlay8AddressIPVtbl_ as IDirectPlay8AddressIPVtbl

type IDirectPlay8AddressIP
	lpVtbl as IDirectPlay8AddressIPVtbl_ ptr
end type

type IDirectPlay8AddressIPVtbl
	QueryInterface as function stdcall(byval as IDirectPlay8AddressIP ptr, byval as DPNAREFIID, byval as PVOID ptr) as HRESULT
	AddRef as function stdcall(byval as IDirectPlay8AddressIP ptr) as ULONG
	Release as function stdcall(byval as IDirectPlay8AddressIP ptr) as ULONG
	BuildFromSockAddr as function stdcall(byval as IDirectPlay8AddressIP ptr, byval as SOCKADDR ptr) as HRESULT
	BuildAddress as function stdcall(byval as IDirectPlay8AddressIP ptr, byval as WCHAR ptr, byval as USHORT) as HRESULT
	BuildLocalAddress as function stdcall(byval as IDirectPlay8AddressIP ptr, byval as GUID ptr, byval as USHORT) as HRESULT
	GetSockAddress as function stdcall(byval as IDirectPlay8AddressIP ptr, byval as SOCKADDR ptr, byval as PDWORD) as HRESULT
	GetLocalAddress as function stdcall(byval as IDirectPlay8AddressIP ptr, byval as GUID ptr, byval as USHORT ptr) as HRESULT
	GetAddress as function stdcall(byval as IDirectPlay8AddressIP ptr, byval as WCHAR ptr, byval as PDWORD, byval as USHORT ptr) as HRESULT
end type

#define IDirectPlay8Address_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8Address_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8Address_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8Address_BuildFromURLW(p,a) (p)->lpVtbl->BuildFromURLW(p,a)
#define IDirectPlay8Address_BuildFromURLA(p,a) (p)->lpVtbl->BuildFromURLA(p,a)
#define IDirectPlay8Address_Duplicate(p,a) (p)->lpVtbl->Duplicate(p,a)
#define IDirectPlay8Address_SetEqual(p,a) (p)->lpVtbl->SetEqual(p,a)
#define IDirectPlay8Address_IsEqual(p,a) (p)->lpVtbl->IsEqual(p,a)
#define IDirectPlay8Address_Clear(p) (p)->lpVtbl->Clear(p)
#define IDirectPlay8Address_GetURLW(p,a,b) (p)->lpVtbl->GetURLW(p,a,b)
#define IDirectPlay8Address_GetURLA(p,a,b) (p)->lpVtbl->GetURLA(p,a,b)
#define IDirectPlay8Address_GetSP(p,a) (p)->lpVtbl->GetSP(p,a)
#define IDirectPlay8Address_GetUserData(p,a,b) (p)->lpVtbl->GetUserData(p,a,b)
#define IDirectPlay8Address_SetSP(p,a) (p)->lpVtbl->SetSP(p,a)
#define IDirectPlay8Address_SetUserData(p,a,b) (p)->lpVtbl->SetUserData(p,a,b)
#define IDirectPlay8Address_GetNumComponents(p,a) (p)->lpVtbl->GetNumComponents(p,a)
#define IDirectPlay8Address_GetComponentByName(p,a,b,c,d) (p)->lpVtbl->GetComponentByName(p,a,b,c,d)
#define IDirectPlay8Address_GetComponentByIndex(p,a,b,c,d,e,f) (p)->lpVtbl->GetComponentByIndex(p,a,b,c,d,e,f)
#define IDirectPlay8Address_AddComponent(p,a,b,c,d) (p)->lpVtbl->AddComponent(p,a,b,c,d)
#define IDirectPlay8Address_SetDevice(p,a) (p)->lpVtbl->SetDevice(p,a)
#define IDirectPlay8Address_GetDevice(p,a) (p)->lpVtbl->GetDevice(p,a)
#define IDirectPlay8Address_BuildFromDirectPlay4Address(p,a,b) (p)->lpVtbl->BuildFromDirectPlay4Address(p,a,b)

#define IDirectPlay8AddressIP_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8AddressIP_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8AddressIP_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8AddressIP_BuildFromSockAddr(p,a) (p)->lpVtbl->BuildFromSockAddr(p,a)
#define IDirectPlay8AddressIP_BuildAddress(p,a,b) (p)->lpVtbl->BuildAddress(p,a,b)
#define IDirectPlay8AddressIP_BuildLocalAddress(p,a,b) (p)->lpVtbl->BuildLocalAddress(p,a,b)
#define IDirectPlay8AddressIP_GetSockAddress(p,a,b) (p)->lpVtbl->GetSockAddress(p,a,b)
#define IDirectPlay8AddressIP_GetLocalAddress(p,a,b) (p)->lpVtbl->GetLocalAddress(p,a,b)
#define IDirectPlay8AddressIP_GetAddress(p,a,b,c) (p)->lpVtbl->GetAddress(p,a,b,c)

#endif
