#pragma once

#include once "ws2def.bi"
#include once "ws2ipdef.bi"
#include once "iprtrmib.bi"
#include once "ifdef.bi"
#include once "ntddndis.bi"

extern "Windows"

#define _INC_NETIOAPI
#define NETIO_STATUS DWORD

#ifdef UNICODE
	#define ConvertInterfaceLuidToName ConvertInterfaceLuidToNameW
	#define ConvertInterfaceNameToLuid ConvertInterfaceNameToLuidW
#else
	#define ConvertInterfaceLuidToName ConvertInterfaceLuidToNameA
	#define ConvertInterfaceNameToLuid ConvertInterfaceNameToLuidA
#endif

type _MIB_NOTIFICATION_TYPE as long
enum
	MibParameterNotification = 0
	MibAddInstance = 1
	MibDeleteInstance = 2
	MibInitialNotification = 3
end enum

type MIB_NOTIFICATION_TYPE as _MIB_NOTIFICATION_TYPE
type PMIB_NOTIFICATION_TYPE as _MIB_NOTIFICATION_TYPE ptr

type _MIB_ANYCASTIPADDRESS_ROW
	Address as SOCKADDR_INET
	InterfaceLuid as NET_LUID
	InterfaceIndex as NET_IFINDEX
	ScopeId as SCOPE_ID
end type

type MIB_ANYCASTIPADDRESS_ROW as _MIB_ANYCASTIPADDRESS_ROW
type PMIB_ANYCASTIPADDRESS_ROW as _MIB_ANYCASTIPADDRESS_ROW ptr

type _MIB_ANYCASTIPADDRESS_TABLE
	NumEntries as ULONG
	Table(0 to 0) as MIB_ANYCASTIPADDRESS_ROW
end type

type MIB_ANYCASTIPADDRESS_TABLE as _MIB_ANYCASTIPADDRESS_TABLE
type PMIB_ANYCASTIPADDRESS_TABLE as _MIB_ANYCASTIPADDRESS_TABLE ptr

type _IP_ADDRESS_PREFIX
	Prefix as SOCKADDR_INET
	PrefixLength as UINT8
end type

type IP_ADDRESS_PREFIX as _IP_ADDRESS_PREFIX
type PIP_ADDRESS_PREFIX as _IP_ADDRESS_PREFIX ptr

type _MIB_IPFORWARD_ROW2
	InterfaceLuid as NET_LUID
	InterfaceIndex as NET_IFINDEX
	DestinationPrefix as IP_ADDRESS_PREFIX
	NextHop as SOCKADDR_INET
	SitePrefixLength as UCHAR
	ValidLifetime as ULONG
	PreferredLifetime as ULONG
	Metric as ULONG
	Protocol as NL_ROUTE_PROTOCOL
	Loopback as BOOLEAN
	AutoconfigureAddress as BOOLEAN
	Publish as BOOLEAN
	Immortal as BOOLEAN
	Age as ULONG
	Origin as NL_ROUTE_ORIGIN
end type

type MIB_IPFORWARD_ROW2 as _MIB_IPFORWARD_ROW2
type PMIB_IPFORWARD_ROW2 as _MIB_IPFORWARD_ROW2 ptr

union _MIB_IPNET_ROW2_ReachabilityTime
	LastReachable as ULONG
	LastUnreachable as ULONG
end union

type _MIB_IPNET_ROW2
	Address as SOCKADDR_INET
	InterfaceIndex as NET_IFINDEX
	InterfaceLuid as NET_LUID
	PhysicalAddress(0 to 31) as UCHAR
	PhysicalAddressLength as ULONG
	State as NL_NEIGHBOR_STATE

	union
		type
			IsRouter : 1 as BOOLEAN
			IsUnreachable : 1 as BOOLEAN
		end type

		Flags as UCHAR
	end union

	ReachabilityTime as _MIB_IPNET_ROW2_ReachabilityTime
end type

type MIB_IPNET_ROW2 as _MIB_IPNET_ROW2
type PMIB_IPNET_ROW2 as _MIB_IPNET_ROW2 ptr

type _MIB_IPNET_TABLE2
	NumEntries as ULONG
	Table(0 to 0) as MIB_IPNET_ROW2
end type

type MIB_IPNET_TABLE2 as _MIB_IPNET_TABLE2
type PMIB_IPNET_TABLE2 as _MIB_IPNET_TABLE2 ptr

type _MIB_IPFORWARD_TABLE2
	NumEntries as ULONG
	Table(0 to 0) as MIB_IPFORWARD_ROW2
end type

type MIB_IPFORWARD_TABLE2 as _MIB_IPFORWARD_TABLE2
type PMIB_IPFORWARD_TABLE2 as _MIB_IPFORWARD_TABLE2 ptr

type _MIB_IPINTERFACE_ROW
	Family as ADDRESS_FAMILY
	InterfaceLuid as NET_LUID
	InterfaceIndex as NET_IFINDEX
	MaxReassemblySize as ULONG
	InterfaceIdentifier as ULONG64
	MinRouterAdvertisementInterval as ULONG
	MaxRouterAdvertisementInterval as ULONG
	AdvertisingEnabled as BOOLEAN
	ForwardingEnabled as BOOLEAN
	WeakHostSend as BOOLEAN
	WeakHostReceive as BOOLEAN
	UseAutomaticMetric as BOOLEAN
	UseNeighborUnreachabilityDetection as BOOLEAN
	ManagedAddressConfigurationSupported as BOOLEAN
	OtherStatefulConfigurationSupported as BOOLEAN
	AdvertiseDefaultRoute as BOOLEAN
	RouterDiscoveryBehavior as NL_ROUTER_DISCOVERY_BEHAVIOR
	DadTransmits as ULONG
	BaseReachableTime as ULONG
	RetransmitTime as ULONG
	PathMtuDiscoveryTimeout as ULONG
	LinkLocalAddressBehavior as NL_LINK_LOCAL_ADDRESS_BEHAVIOR
	LinkLocalAddressTimeout as ULONG
	ZoneIndices(0 to ScopeLevelCount - 1) as ULONG
	SitePrefixLength as ULONG
	Metric as ULONG
	NlMtu as ULONG
	Connected as BOOLEAN
	SupportsWakeUpPatterns as BOOLEAN
	SupportsNeighborDiscovery as BOOLEAN
	SupportsRouterDiscovery as BOOLEAN
	ReachableTime as ULONG
	TransmitOffload as NL_INTERFACE_OFFLOAD_ROD
	ReceiveOffload as NL_INTERFACE_OFFLOAD_ROD
	DisableDefaultRoutes as BOOLEAN
end type

type MIB_IPINTERFACE_ROW as _MIB_IPINTERFACE_ROW
type PMIB_IPINTERFACE_ROW as _MIB_IPINTERFACE_ROW ptr

type _MIB_IPINTERFACE_TABLE
	NumEntries as ULONG
	Table(0 to 0) as MIB_IPINTERFACE_ROW
end type

type MIB_IPINTERFACE_TABLE as _MIB_IPINTERFACE_TABLE
type PMIB_IPINTERFACE_TABLE as _MIB_IPINTERFACE_TABLE ptr

type _MIB_UNICASTIPADDRESS_ROW
	Address as SOCKADDR_INET
	InterfaceLuid as NET_LUID
	InterfaceIndex as NET_IFINDEX
	PrefixOrigin as NL_PREFIX_ORIGIN
	SuffixOrigin as NL_SUFFIX_ORIGIN
	ValidLifetime as ULONG
	PreferredLifetime as ULONG
	OnLinkPrefixLength as UINT8
	SkipAsSource as BOOLEAN
	DadState as NL_DAD_STATE
	ScopeId as SCOPE_ID
	CreationTimeStamp as LARGE_INTEGER
end type

type MIB_UNICASTIPADDRESS_ROW as _MIB_UNICASTIPADDRESS_ROW
type PMIB_UNICASTIPADDRESS_ROW as _MIB_UNICASTIPADDRESS_ROW ptr

type _MIB_UNICASTIPADDRESS_TABLE
	NumEntries as ULONG
	Table(0 to 0) as MIB_UNICASTIPADDRESS_ROW
end type

type MIB_UNICASTIPADDRESS_TABLE as _MIB_UNICASTIPADDRESS_TABLE
type PMIB_UNICASTIPADDRESS_TABLE as _MIB_UNICASTIPADDRESS_TABLE ptr

type _MIB_IF_ROW2_InterfaceAndOperStatusFlags
	HardwareInterface : 1 as BOOLEAN
	FilterInterface : 1 as BOOLEAN
	ConnectorPresent : 1 as BOOLEAN
	NotAuthenticated : 1 as BOOLEAN
	NotMediaConnected : 1 as BOOLEAN
	Paused : 1 as BOOLEAN
	LowPower : 1 as BOOLEAN
	EndPointInterface : 1 as BOOLEAN
end type

type _MIB_IF_ROW2
	InterfaceLuid as NET_LUID
	InterfaceIndex as NET_IFINDEX
	InterfaceGuid as GUID
	Alias as wstring * 256 + 1
	Description as wstring * 256 + 1
	PhysicalAddressLength as ULONG
	PhysicalAddress(0 to 31) as UCHAR
	PermanentPhysicalAddress(0 to 31) as UCHAR
	Mtu as ULONG
	as IFTYPE Type
	TunnelType as TUNNEL_TYPE
	MediaType as NDIS_MEDIUM
	PhysicalMediumType as NDIS_PHYSICAL_MEDIUM
	AccessType as NET_IF_ACCESS_TYPE
	DirectionType as NET_IF_DIRECTION_TYPE
	InterfaceAndOperStatusFlags as _MIB_IF_ROW2_InterfaceAndOperStatusFlags
	OperStatus as IF_OPER_STATUS
	AdminStatus as NET_IF_ADMIN_STATUS
	MediaConnectState as NET_IF_MEDIA_CONNECT_STATE
	NetworkGuid as NET_IF_NETWORK_GUID
	ConnectionType as NET_IF_CONNECTION_TYPE
	TransmitLinkSpeed as ULONG64
	ReceiveLinkSpeed as ULONG64
	InOctets as ULONG64
	InUcastPkts as ULONG64
	InNUcastPkts as ULONG64
	InDiscards as ULONG64
	InErrors as ULONG64
	InUnknownProtos as ULONG64
	InUcastOctets as ULONG64
	InMulticastOctets as ULONG64
	InBroadcastOctets as ULONG64
	OutOctets as ULONG64
	OutUcastPkts as ULONG64
	OutNUcastPkts as ULONG64
	OutDiscards as ULONG64
	OutErrors as ULONG64
	OutUcastOctets as ULONG64
	OutMulticastOctets as ULONG64
	OutBroadcastOctets as ULONG64
	OutQLen as ULONG64
end type

type MIB_IF_ROW2 as _MIB_IF_ROW2
type PMIB_IF_ROW2 as _MIB_IF_ROW2 ptr

type _MIB_IF_TABLE2
	NumEntries as ULONG
	Table(0 to 0) as MIB_IF_ROW2
end type

type MIB_IF_TABLE2 as _MIB_IF_TABLE2
type PMIB_IF_TABLE2 as _MIB_IF_TABLE2 ptr

type _MIB_IFSTACK_ROW
	HigherLayerInterfaceIndex as NET_IFINDEX
	LowerLayerInterfaceIndex as NET_IFINDEX
end type

type MIB_IFSTACK_ROW as _MIB_IFSTACK_ROW
type PMIB_IFSTACK_ROW as _MIB_IFSTACK_ROW ptr

type _MIB_IFSTACK_TABLE
	NumEntries as ULONG
	Table(0 to 0) as MIB_IFSTACK_ROW
end type

type MIB_IFSTACK_TABLE as _MIB_IFSTACK_TABLE
type PMIB_IFSTACK_TABLE as _MIB_IFSTACK_TABLE ptr

type _MIB_INVERTEDIFSTACK_ROW
	LowerLayerInterfaceIndex as NET_IFINDEX
	HigherLayerInterfaceIndex as NET_IFINDEX
end type

type MIB_INVERTEDIFSTACK_ROW as _MIB_INVERTEDIFSTACK_ROW
type PMIB_INVERTEDIFSTACK_ROW as _MIB_INVERTEDIFSTACK_ROW ptr

type _MIB_INVERTEDIFSTACK_TABLE
	NumEntries as ULONG
	Table(0 to 0) as MIB_INVERTEDIFSTACK_ROW
end type

type MIB_INVERTEDIFSTACK_TABLE as _MIB_INVERTEDIFSTACK_TABLE
type PMIB_INVERTEDIFSTACK_TABLE as _MIB_INVERTEDIFSTACK_TABLE ptr

type _MIB_IPPATH_ROW
	Source as SOCKADDR_INET
	Destination as SOCKADDR_INET
	InterfaceLuid as NET_LUID
	InterfaceIndex as NET_IFINDEX
	CurrentNextHop as SOCKADDR_INET
	PathMtu as ULONG
	RttMean as ULONG
	RttDeviation as ULONG

	union
		LastReachable as ULONG
		LastUnreachable as ULONG
	end union

	IsReachable as BOOLEAN
	LinkTransmitSpeed as ULONG64
	LinkReceiveSpeed as ULONG64
end type

type MIB_IPPATH_ROW as _MIB_IPPATH_ROW
type PMIB_IPPATH_ROW as _MIB_IPPATH_ROW ptr

type _MIB_IPPATH_TABLE
	NumEntries as ULONG
	Table(0 to 0) as MIB_IPPATH_ROW
end type

type MIB_IPPATH_TABLE as _MIB_IPPATH_TABLE
type PMIB_IPPATH_TABLE as _MIB_IPPATH_TABLE ptr

type _MIB_MULTICASTIPADDRESS_ROW
	Address as SOCKADDR_INET
	InterfaceIndex as NET_IFINDEX
	InterfaceLuid as NET_LUID
	ScopeId as SCOPE_ID
end type

type MIB_MULTICASTIPADDRESS_ROW as _MIB_MULTICASTIPADDRESS_ROW
type PMIB_MULTICASTIPADDRESS_ROW as _MIB_MULTICASTIPADDRESS_ROW ptr

type _MIB_MULTICASTIPADDRESS_TABLE
	NumEntries as ULONG
	Table(0 to 0) as MIB_MULTICASTIPADDRESS_ROW
end type

type MIB_MULTICASTIPADDRESS_TABLE as _MIB_MULTICASTIPADDRESS_TABLE
type PMIB_MULTICASTIPADDRESS_TABLE as _MIB_MULTICASTIPADDRESS_TABLE ptr
declare function CancelMibChangeNotify2(byval NotificationHandle as HANDLE) as DWORD
declare function ConvertInterfaceAliasToLuid(byval InterfaceAlias as const wstring ptr, byval InterfaceLuid as PNET_LUID) as DWORD
declare function ConvertInterfaceLuidToNameA(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceName as PSTR, byval Length as SIZE_T_) as DWORD
declare function ConvertInterfaceLuidToNameW(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceName as PWSTR, byval Length as SIZE_T_) as DWORD
declare function ConvertInterfaceNameToLuidA(byval InterfaceName as const zstring ptr, byval InterfaceLuid as PNET_LUID) as DWORD
declare function ConvertInterfaceNameToLuidW(byval InterfaceName as const wstring ptr, byval InterfaceLuid as PNET_LUID) as DWORD
declare function if_indextoname(byval InterfaceIndex as NET_IFINDEX, byval InterfaceName as PCHAR) as PCHAR
declare function if_nametoindex(byval InterfaceName as PCSTR) as NET_IFINDEX
declare function ConvertInterfaceGuidToLuid(byval InterfaceGuid as const GUID ptr, byval InterfaceLuid as PNET_LUID) as DWORD
declare function ConvertInterfaceIndexToLuid(byval InterfaceIndex as NET_IFINDEX, byval InterfaceLuid as PNET_LUID) as DWORD
declare function ConvertInterfaceLuidToAlias(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceAlias as PWSTR, byval Length as SIZE_T_) as DWORD
declare function ConvertInterfaceLuidToGuid(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceGuid as GUID ptr) as DWORD
declare function ConvertInterfaceLuidToIndex(byval InterfaceLuid as const NET_LUID ptr, byval InterfaceIndex as PNET_IFINDEX) as DWORD
declare function ConvertIpv4MaskToLength(byval Mask as ULONG, byval MaskLength as PUINT8) as DWORD
declare function ConvertLengthToIpv4Mask(byval MaskLength as ULONG, byval Mask as PULONG) as DWORD
declare function CreateAnycastIpAddressEntry(byval Row as const MIB_ANYCASTIPADDRESS_ROW ptr) as DWORD
declare function CreateIpForwardEntry2(byval Row as const MIB_IPFORWARD_ROW2 ptr) as DWORD
declare function GetIpNetTable2(byval Family as ADDRESS_FAMILY, byval Table as PMIB_IPNET_TABLE2 ptr) as DWORD
declare function GetIpNetEntry2(byval Row as PMIB_IPNET_ROW2) as DWORD
declare function CreateIpNetEntry2(byval Row as const MIB_IPNET_ROW2 ptr) as DWORD
declare function CreateSortedAddressPairs(byval SourceAddressList as const PSOCKADDR_IN6, byval SourceAddressCount as ULONG, byval DestinationAddressList as const PSOCKADDR_IN6, byval DestinationAddressCount as ULONG, byval AddressSortOptions as ULONG, byval SortedAddressPairList as PSOCKADDR_IN6_PAIR ptr, byval SortedAddressPairCount as ULONG ptr) as DWORD
declare function CreateUnicastIpAddressEntry(byval Row as const MIB_UNICASTIPADDRESS_ROW ptr) as DWORD
declare function DeleteIpForwardEntry2(byval Row as const MIB_IPFORWARD_ROW2 ptr) as DWORD
declare function GetIpForwardTable2(byval Family as ADDRESS_FAMILY, byval Table as PMIB_IPFORWARD_TABLE2 ptr) as DWORD
declare sub FreeMibTable(byval Memory as PVOID)
declare function DeleteIpNetEntry2(byval Row as const MIB_IPNET_ROW2 ptr) as DWORD
declare function DeleteUnicastIpAddressEntry(byval Row as const MIB_UNICASTIPADDRESS_ROW ptr) as DWORD
declare function GetUnicastIpAddressEntry(byval Row as PMIB_UNICASTIPADDRESS_ROW) as DWORD
declare function DeleteAnycastIpAddressEntry(byval Row as const MIB_ANYCASTIPADDRESS_ROW ptr) as DWORD
declare function FlushIpNetTable2(byval Family as ADDRESS_FAMILY, byval InterfaceIndex as NET_IFINDEX) as DWORD
declare function FlushIpPathTable(byval Family as ADDRESS_FAMILY) as DWORD
declare function GetAnycastIpAddressEntry(byval Row as PMIB_ANYCASTIPADDRESS_ROW) as DWORD
declare function GetAnycastIpAddressTable(byval Family as ADDRESS_FAMILY, byval Table as PMIB_ANYCASTIPADDRESS_TABLE ptr) as DWORD
declare function GetBestRoute2(byval InterfaceLuid as NET_LUID ptr, byval InterfaceIndex as NET_IFINDEX, byval SourceAddress as const SOCKADDR_INET ptr, byval DestinationAddress as const SOCKADDR_INET ptr, byval AddressSortOptions as ULONG, byval BestRoute as PMIB_IPFORWARD_ROW2, byval BestSourceAddress as SOCKADDR_INET ptr) as DWORD
declare function GetIfEntry2(byval Row as PMIB_IF_ROW2) as DWORD
declare function GetIfTable2(byval Table as PMIB_IF_TABLE2 ptr) as DWORD
declare function GetIfStackTable(byval Table as PMIB_IFSTACK_TABLE ptr) as DWORD

type _MIB_IF_TABLE_LEVEL as long
enum
	MibIfTableNormal = 0
	MibIfTableRaw = 1
end enum

type MIB_IF_TABLE_LEVEL as _MIB_IF_TABLE_LEVEL
type PMIB_IF_TABLE_LEVEL as _MIB_IF_TABLE_LEVEL ptr
declare function GetIfTable2Ex(byval Level as MIB_IF_TABLE_LEVEL, byval Table as PMIB_IF_TABLE2 ptr) as DWORD
declare function GetInvertedIfStackTable(byval Table as PMIB_INVERTEDIFSTACK_TABLE ptr) as DWORD
declare function GetIpForwardEntry2(byval Row as PMIB_IPFORWARD_ROW2) as DWORD
declare function GetIpInterfaceEntry(byval Row as PMIB_IPINTERFACE_ROW) as DWORD
declare function GetIpInterfaceTable(byval Family as ADDRESS_FAMILY, byval Table as PMIB_IPINTERFACE_TABLE ptr) as DWORD
declare function GetIpPathEntry(byval Row as PMIB_IPPATH_ROW) as DWORD
declare function GetIpPathTable(byval Family as ADDRESS_FAMILY, byval Table as PMIB_IPPATH_TABLE ptr) as DWORD
declare function GetMulticastIpAddressEntry(byval Row as PMIB_MULTICASTIPADDRESS_ROW) as DWORD
declare function GetMulticastIpAddressTable(byval Family as ADDRESS_FAMILY, byval Table as PMIB_MULTICASTIPADDRESS_TABLE ptr) as DWORD
declare function GetTeredoPort(byval Port as USHORT ptr) as DWORD
type PTEREDO_PORT_CHANGE_CALLBACK as sub(byval callerContext as any ptr, byval Port as USHORT, byval type as MIB_NOTIFICATION_TYPE)
declare function NotifyTeredoPortChange(byval Callback as PTEREDO_PORT_CHANGE_CALLBACK, byval CallerContext as PVOID, byval InitialNotification as BOOLEAN, byval NotificationHandle as HANDLE ptr) as DWORD
type PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK as sub(byval callerContext as any ptr, byval AddressTable as MIB_UNICASTIPADDRESS_TABLE ptr)
declare function NotifyStableUnicastIpAddressTable(byval Family as ADDRESS_FAMILY, byval Table as PMIB_UNICASTIPADDRESS_TABLE ptr, byval CallerCallback as PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK, byval CallerContext as PVOID, byval NotificationHandle as HANDLE ptr) as DWORD
type PUNICAST_IPADDRESS_CHANGE_CALLBACK as sub(byval callerContext as any ptr, byval row as PMIB_UNICASTIPADDRESS_ROW, byval type as MIB_NOTIFICATION_TYPE)
declare function NotifyUnicastIpAddressChange(byval Family as ADDRESS_FAMILY, byval Callback as PUNICAST_IPADDRESS_CHANGE_CALLBACK, byval CallerContext as PVOID, byval InitialNotification as BOOLEAN, byval NotificationHandle as HANDLE ptr) as DWORD
declare function GetUnicastIpAddressTable(byval Family as ADDRESS_FAMILY, byval Table as PMIB_UNICASTIPADDRESS_TABLE ptr) as DWORD
type PIPINTERFACE_CHANGE_CALLBACK as sub(byval CallerContext as PVOID, byval Row as PMIB_IPINTERFACE_ROW, byval NotificationType as MIB_NOTIFICATION_TYPE)
declare function NotifyIpInterfaceChange(byval Family as ADDRESS_FAMILY, byval Callback as PIPINTERFACE_CHANGE_CALLBACK, byval CallerContext as PVOID, byval InitialNotification as BOOLEAN, byval NotificationHandle as HANDLE ptr) as DWORD
type PIPFORWARD_CHANGE_CALLBACK as LPVOID
declare function NotifyRouteChange2(byval Family as ADDRESS_FAMILY, byval Callback as PIPFORWARD_CHANGE_CALLBACK, byval CallerContext as PVOID, byval InitialNotification as BOOLEAN, byval NotificationHandle as HANDLE ptr) as DWORD
declare function ResolveIpNetEntry2(byval Row as PMIB_IPNET_ROW2, byval SourceAddress as const SOCKADDR_INET ptr) as DWORD
declare function SetIpForwardEntry2(byval Route as const MIB_IPFORWARD_ROW2 ptr) as DWORD
declare function SetIpInterfaceEntry(byval Row as PMIB_IPINTERFACE_ROW) as DWORD
declare function SetIpNetEntry2(byval Row as PMIB_IPNET_ROW2) as DWORD
declare function SetUnicastIpAddressEntry(byval Row as const MIB_UNICASTIPADDRESS_ROW ptr) as DWORD

end extern
