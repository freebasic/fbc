'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#if _WIN32_WINNT = &h0602
	#include once "winapifamily.bi"

	extern "Windows"

	#define _NETIOAPI_H_
	#define NETIO_STATUS DWORD
	#define NETIO_SUCCESS(x) ((x) = NO_ERROR)
	#define _NETIOAPI_SUCCESS_
	#define IF_NAMESIZE NDIS_IF_MAX_STRING_SIZE

	type _MIB_NOTIFICATION_TYPE as long
	enum
		MibParameterNotification
		MibAddInstance
		MibDeleteInstance
		MibInitialNotification
	end enum

	type MIB_NOTIFICATION_TYPE as _MIB_NOTIFICATION_TYPE
	type PMIB_NOTIFICATION_TYPE as _MIB_NOTIFICATION_TYPE ptr
	declare function ConvertInterfaceNameToLuidA(byval InterfaceName as const zstring ptr, byval InterfaceLuid as NET_LUID ptr) as DWORD
	declare function ConvertInterfaceNameToLuidW(byval InterfaceName as const wstring ptr, byval InterfaceLuid as NET_LUID ptr) as DWORD
	declare function ConvertInterfaceLuidToNameA(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceName as PSTR, byval Length as SIZE_T_) as DWORD
	declare function ConvertInterfaceLuidToNameW(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceName as PWSTR, byval Length as SIZE_T_) as DWORD
	declare function ConvertInterfaceLuidToIndex(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceIndex as PNET_IFINDEX) as DWORD
	declare function ConvertInterfaceIndexToLuid(byval InterfaceIndex as NET_IFINDEX, byval InterfaceLuid as PNET_LUID) as DWORD
	declare function ConvertInterfaceLuidToAlias(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceAlias as PWSTR, byval Length as SIZE_T_) as DWORD
	declare function ConvertInterfaceAliasToLuid(byval InterfaceAlias as const wstring ptr, byval InterfaceLuid as PNET_LUID) as DWORD
	declare function ConvertInterfaceLuidToGuid(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceGuid as GUID ptr) as DWORD
	declare function ConvertInterfaceGuidToLuid(byval InterfaceGuid as const GUID ptr, byval InterfaceLuid as PNET_LUID) as DWORD
	declare function if_nametoindex(byval InterfaceName as PCSTR) as NET_IFINDEX
	declare function if_indextoname(byval InterfaceIndex as NET_IFINDEX, byval InterfaceName as PCHAR) as PCHAR
	declare function GetCurrentThreadCompartmentId() as NET_IF_COMPARTMENT_ID
	declare function SetCurrentThreadCompartmentId(byval CompartmentId as NET_IF_COMPARTMENT_ID) as DWORD
	declare function GetSessionCompartmentId(byval SessionId as ULONG) as NET_IF_COMPARTMENT_ID
	declare function SetSessionCompartmentId(byval SessionId as ULONG, byval CompartmentId as NET_IF_COMPARTMENT_ID) as DWORD
	declare function GetNetworkInformation(byval NetworkGuid as const NET_IF_NETWORK_GUID ptr, byval CompartmentId as PNET_IF_COMPARTMENT_ID, byval SiteId as PULONG, byval NetworkName as PWCHAR, byval Length as ULONG) as DWORD
	declare function SetNetworkInformation(byval NetworkGuid as const NET_IF_NETWORK_GUID ptr, byval CompartmentId as NET_IF_COMPARTMENT_ID, byval NetworkName as const wstring ptr) as DWORD
	declare function ConvertLengthToIpv4Mask(byval MaskLength as ULONG, byval Mask as PULONG) as DWORD
	declare function ConvertIpv4MaskToLength(byval Mask as ULONG, byval MaskLength as PUINT8) as DWORD

	end extern
#endif
