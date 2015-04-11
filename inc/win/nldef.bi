'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#include once "winapifamily.bi"

#define _NLDEF_

type NL_DAD_STATE as long
enum
	NldsInvalid
	NldsTentative
	NldsDuplicate
	NldsDeprecated
	NldsPreferred
	IpDadStateInvalid = 0
	IpDadStateTentative
	IpDadStateDuplicate
	IpDadStateDeprecated
	IpDadStatePreferred
end enum

type NL_ROUTE_PROTOCOL as long
enum
	RouteProtocolOther = 1
	RouteProtocolLocal = 2
	RouteProtocolNetMgmt = 3
	RouteProtocolIcmp = 4
	RouteProtocolEgp = 5
	RouteProtocolGgp = 6
	RouteProtocolHello = 7
	RouteProtocolRip = 8
	RouteProtocolIsIs = 9
	RouteProtocolEsIs = 10
	RouteProtocolCisco = 11
	RouteProtocolBbn = 12
	RouteProtocolOspf = 13
	RouteProtocolBgp = 14
	MIB_IPPROTO_OTHER = 1
	PROTO_IP_OTHER = 1
	MIB_IPPROTO_LOCAL = 2
	PROTO_IP_LOCAL = 2
	MIB_IPPROTO_NETMGMT = 3
	PROTO_IP_NETMGMT = 3
	MIB_IPPROTO_ICMP = 4
	PROTO_IP_ICMP = 4
	MIB_IPPROTO_EGP = 5
	PROTO_IP_EGP = 5
	MIB_IPPROTO_GGP = 6
	PROTO_IP_GGP = 6
	MIB_IPPROTO_HELLO = 7
	PROTO_IP_HELLO = 7
	MIB_IPPROTO_RIP = 8
	PROTO_IP_RIP = 8
	MIB_IPPROTO_IS_IS = 9
	PROTO_IP_IS_IS = 9
	MIB_IPPROTO_ES_IS = 10
	PROTO_IP_ES_IS = 10
	MIB_IPPROTO_CISCO = 11
	PROTO_IP_CISCO = 11
	MIB_IPPROTO_BBN = 12
	PROTO_IP_BBN = 12
	MIB_IPPROTO_OSPF = 13
	PROTO_IP_OSPF = 13
	MIB_IPPROTO_BGP = 14
	PROTO_IP_BGP = 14
	MIB_IPPROTO_NT_AUTOSTATIC = 10002
	PROTO_IP_NT_AUTOSTATIC = 10002
	MIB_IPPROTO_NT_STATIC = 10006
	PROTO_IP_NT_STATIC = 10006
	MIB_IPPROTO_NT_STATIC_NON_DOD = 10007
	PROTO_IP_NT_STATIC_NON_DOD = 10007
end enum

type PNL_ROUTE_PROTOCOL as NL_ROUTE_PROTOCOL ptr

type NL_PREFIX_ORIGIN as long
enum
	IpPrefixOriginOther = 0
	IpPrefixOriginManual
	IpPrefixOriginWellKnown
	IpPrefixOriginDhcp
	IpPrefixOriginRouterAdvertisement
	IpPrefixOriginUnchanged = 16
end enum

type NL_SUFFIX_ORIGIN as long
enum
	NlsoOther = 0
	NlsoManual
	NlsoWellKnown
	NlsoDhcp
	NlsoLinkLayerAddress
	NlsoRandom
	IpSuffixOriginOther = 0
	IpSuffixOriginManual
	IpSuffixOriginWellKnown
	IpSuffixOriginDhcp
	IpSuffixOriginLinkLayerAddress
	IpSuffixOriginRandom
	IpSuffixOriginUnchanged = 16
end enum

type NL_ADDRESS_TYPE as long
enum
	NlatUnspecified
	NlatUnicast
	NlatAnycast
	NlatMulticast
	NlatBroadcast
	NlatInvalid
end enum

type PNL_ADDRESS_TYPE as NL_ADDRESS_TYPE ptr

type _NL_ROUTE_ORIGIN as long
enum
	NlroManual
	NlroWellKnown
	NlroDHCP
	NlroRouterAdvertisement
	Nlro6to4
end enum

type NL_ROUTE_ORIGIN as _NL_ROUTE_ORIGIN
type PNL_ROUTE_ORIGIN as _NL_ROUTE_ORIGIN ptr

type _NL_NEIGHBOR_STATE as long
enum
	NlnsUnreachable
	NlnsIncomplete
	NlnsProbe
	NlnsDelay
	NlnsStale
	NlnsReachable
	NlnsPermanent
	NlnsMaximum
end enum

type NL_NEIGHBOR_STATE as _NL_NEIGHBOR_STATE
type PNL_NEIGHBOR_STATE as _NL_NEIGHBOR_STATE ptr

type _NL_LINK_LOCAL_ADDRESS_BEHAVIOR as long
enum
	LinkLocalAlwaysOff = 0
	LinkLocalDelayed
	LinkLocalAlwaysOn
	LinkLocalUnchanged = -1
end enum

type NL_LINK_LOCAL_ADDRESS_BEHAVIOR as _NL_LINK_LOCAL_ADDRESS_BEHAVIOR

type _NL_ROUTER_DISCOVERY_BEHAVIOR as long
enum
	RouterDiscoveryDisabled = 0
	RouterDiscoveryEnabled
	RouterDiscoveryDhcp
	RouterDiscoveryUnchanged = -1
end enum

type NL_ROUTER_DISCOVERY_BEHAVIOR as _NL_ROUTER_DISCOVERY_BEHAVIOR

type _NL_BANDWIDTH_FLAG as long
enum
	NlbwDisabled = 0
	NlbwEnabled
	NlbwUnchanged = -1
end enum

type NL_BANDWIDTH_FLAG as _NL_BANDWIDTH_FLAG
type PNL_BANDWIDTH_FLAG as _NL_BANDWIDTH_FLAG ptr

type _NL_INTERFACE_NETWORK_CATEGORY_STATE as long
enum
	NlincCategoryUnknown = 0
	NlincPublic = 1
	NlincPrivate = 2
	NlincDomainAuthenticated = 3
	NlincCategoryStateMax
end enum

type NL_INTERFACE_NETWORK_CATEGORY_STATE as _NL_INTERFACE_NETWORK_CATEGORY_STATE
type PNL_INTERFACE_NETWORK_CATEGORY_STATE as _NL_INTERFACE_NETWORK_CATEGORY_STATE ptr

type _NL_INTERFACE_OFFLOAD_ROD
	NlChecksumSupported : 1 as BOOLEAN
	NlOptionsSupported : 1 as BOOLEAN
	TlDatagramChecksumSupported : 1 as BOOLEAN
	TlStreamChecksumSupported : 1 as BOOLEAN
	TlStreamOptionsSupported : 1 as BOOLEAN
	FastPathCompatible : 1 as BOOLEAN
	TlLargeSendOffloadSupported : 1 as BOOLEAN
	TlGiantSendOffloadSupported : 1 as BOOLEAN
end type

type NL_INTERFACE_OFFLOAD_ROD as _NL_INTERFACE_OFFLOAD_ROD
type PNL_INTERFACE_OFFLOAD_ROD as _NL_INTERFACE_OFFLOAD_ROD ptr

type _NL_PATH_BANDWIDTH_ROD
	Bandwidth as ULONG64
	Instability as ULONG64
	BandwidthPeaked as BOOLEAN
end type

type NL_PATH_BANDWIDTH_ROD as _NL_PATH_BANDWIDTH_ROD
type PNL_PATH_BANDWIDTH_ROD as _NL_PATH_BANDWIDTH_ROD ptr

type _NL_NETWORK_CATEGORY as long
enum
	NetworkCategoryPublic
	NetworkCategoryPrivate
	NetworkCategoryDomainAuthenticated
	NetworkCategoryUnchanged = -1
	NetworkCategoryUnknown = -1
end enum

type NL_NETWORK_CATEGORY as _NL_NETWORK_CATEGORY
type PNL_NETWORK_CATEGORY as _NL_NETWORK_CATEGORY ptr

type _NL_BANDWIDTH_INFORMATION
	Bandwidth as ULONG64
	Instability as ULONG64
	BandwidthPeaked as BOOLEAN
end type

type NL_BANDWIDTH_INFORMATION as _NL_BANDWIDTH_INFORMATION
type PNL_BANDWIDTH_INFORMATION as _NL_BANDWIDTH_INFORMATION ptr
#define NlpoOther IpPrefixOriginOther
#define NlpoManual IpPrefixOriginManual
#define NlpoWellKnown IpPrefixOriginWellKnown
#define NlpoDhcp IpPrefixOriginDhcp
#define NlpoRouterAdvertisement IpPrefixOriginRouterAdvertisement
#define NL_MAX_METRIC_COMPONENT ((cast(ULONG, 1) shl 31) - 1)
#define NET_IF_CURRENT_SESSION cast(ULONG, -1)
