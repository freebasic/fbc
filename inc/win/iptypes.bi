'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/time.bi"
#include once "ifdef.bi"
#include once "nldef.bi"
#include once "winsock2.bi"

#define IP_TYPES_INCLUDED
const MAX_ADAPTER_DESCRIPTION_LENGTH = 128
const MAX_ADAPTER_NAME_LENGTH = 256
const MAX_ADAPTER_ADDRESS_LENGTH = 8
const DEFAULT_MINIMUM_ENTITIES = 32
const MAX_HOSTNAME_LEN = 128
const MAX_DOMAIN_NAME_LEN = 128
const MAX_SCOPE_ID_LEN = 256
const MAX_DHCPV6_DUID_LENGTH = 130
const MAX_DNS_SUFFIX_STRING_LENGTH = 256
const BROADCAST_NODETYPE = 1
const PEER_TO_PEER_NODETYPE = 2
const MIXED_NODETYPE = 4
const HYBRID_NODETYPE = 8

type IP_ADDRESS_STRING
	String as zstring * 4 * 4
end type

type PIP_ADDRESS_STRING as IP_ADDRESS_STRING ptr
type IP_MASK_STRING as IP_ADDRESS_STRING
type PIP_MASK_STRING as IP_ADDRESS_STRING ptr

type _IP_ADDR_STRING
	Next as _IP_ADDR_STRING ptr
	IpAddress as IP_ADDRESS_STRING
	IpMask as IP_MASK_STRING
	Context as DWORD
end type

type IP_ADDR_STRING as _IP_ADDR_STRING
type PIP_ADDR_STRING as _IP_ADDR_STRING ptr

type _IP_ADAPTER_INFO
	Next as _IP_ADAPTER_INFO ptr
	ComboIndex as DWORD
	AdapterName as zstring * 256 + 4
	Description as zstring * 128 + 4
	AddressLength as UINT
	Address(0 to 7) as UBYTE
	Index as DWORD
	as UINT Type
	DhcpEnabled as UINT
	CurrentIpAddress as PIP_ADDR_STRING
	IpAddressList as IP_ADDR_STRING
	GatewayList as IP_ADDR_STRING
	DhcpServer as IP_ADDR_STRING
	HaveWins as WINBOOL
	PrimaryWinsServer as IP_ADDR_STRING
	SecondaryWinsServer as IP_ADDR_STRING
	LeaseObtained as time_t
	LeaseExpires as time_t
end type

type IP_ADAPTER_INFO as _IP_ADAPTER_INFO
type PIP_ADAPTER_INFO as _IP_ADAPTER_INFO ptr
type IP_PREFIX_ORIGIN as NL_PREFIX_ORIGIN
type IP_SUFFIX_ORIGIN as NL_SUFFIX_ORIGIN
type IP_DAD_STATE as NL_DAD_STATE

type _IP_ADAPTER_UNICAST_ADDRESS_XP
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			Flags as DWORD
		end type
	end union

	Next as _IP_ADAPTER_UNICAST_ADDRESS_XP ptr
	Address as SOCKET_ADDRESS
	PrefixOrigin as IP_PREFIX_ORIGIN
	SuffixOrigin as IP_SUFFIX_ORIGIN
	DadState as IP_DAD_STATE
	ValidLifetime as ULONG
	PreferredLifetime as ULONG
	LeaseLifetime as ULONG
end type

type IP_ADAPTER_UNICAST_ADDRESS_XP as _IP_ADAPTER_UNICAST_ADDRESS_XP
type PIP_ADAPTER_UNICAST_ADDRESS_XP as _IP_ADAPTER_UNICAST_ADDRESS_XP ptr

type _IP_ADAPTER_UNICAST_ADDRESS_LH
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			Flags as DWORD
		end type
	end union

	Next as _IP_ADAPTER_UNICAST_ADDRESS_LH ptr
	Address as SOCKET_ADDRESS
	PrefixOrigin as IP_PREFIX_ORIGIN
	SuffixOrigin as IP_SUFFIX_ORIGIN
	DadState as IP_DAD_STATE
	ValidLifetime as ULONG
	PreferredLifetime as ULONG
	LeaseLifetime as ULONG
	OnLinkPrefixLength as UINT8
end type

type IP_ADAPTER_UNICAST_ADDRESS_LH as _IP_ADAPTER_UNICAST_ADDRESS_LH
type PIP_ADAPTER_UNICAST_ADDRESS_LH as _IP_ADAPTER_UNICAST_ADDRESS_LH ptr

#if _WIN32_WINNT <= &h0502
	type IP_ADAPTER_UNICAST_ADDRESS as IP_ADAPTER_UNICAST_ADDRESS_XP
	type PIP_ADAPTER_UNICAST_ADDRESS as IP_ADAPTER_UNICAST_ADDRESS_XP ptr
#else
	type IP_ADAPTER_UNICAST_ADDRESS as IP_ADAPTER_UNICAST_ADDRESS_LH
	type PIP_ADAPTER_UNICAST_ADDRESS as IP_ADAPTER_UNICAST_ADDRESS_LH ptr
#endif

type _IP_ADAPTER_ANYCAST_ADDRESS_XP
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			Flags as DWORD
		end type
	end union

	Next as _IP_ADAPTER_ANYCAST_ADDRESS_XP ptr
	Address as SOCKET_ADDRESS
end type

type IP_ADAPTER_ANYCAST_ADDRESS_XP as _IP_ADAPTER_ANYCAST_ADDRESS_XP
type PIP_ADAPTER_ANYCAST_ADDRESS_XP as _IP_ADAPTER_ANYCAST_ADDRESS_XP ptr
type IP_ADAPTER_ANYCAST_ADDRESS as IP_ADAPTER_ANYCAST_ADDRESS_XP
type PIP_ADAPTER_ANYCAST_ADDRESS as IP_ADAPTER_ANYCAST_ADDRESS_XP ptr

type _IP_ADAPTER_MULTICAST_ADDRESS_XP
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			Flags as DWORD
		end type
	end union

	Next as _IP_ADAPTER_MULTICAST_ADDRESS_XP ptr
	Address as SOCKET_ADDRESS
end type

type IP_ADAPTER_MULTICAST_ADDRESS_XP as _IP_ADAPTER_MULTICAST_ADDRESS_XP
type PIP_ADAPTER_MULTICAST_ADDRESS_XP as _IP_ADAPTER_MULTICAST_ADDRESS_XP ptr
type IP_ADAPTER_MULTICAST_ADDRESS as IP_ADAPTER_MULTICAST_ADDRESS_XP
type PIP_ADAPTER_MULTICAST_ADDRESS as IP_ADAPTER_MULTICAST_ADDRESS_XP ptr

const IP_ADAPTER_ADDRESS_DNS_ELIGIBLE = &h01
const IP_ADAPTER_ADDRESS_TRANSIENT = &h02
const IP_ADAPTER_ADDRESS_PRIMARY = &h04

type _IP_ADAPTER_DNS_SERVER_ADDRESS_XP
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			Reserved as DWORD
		end type
	end union

	Next as _IP_ADAPTER_DNS_SERVER_ADDRESS_XP ptr
	Address as SOCKET_ADDRESS
end type

type IP_ADAPTER_DNS_SERVER_ADDRESS_XP as _IP_ADAPTER_DNS_SERVER_ADDRESS_XP
type PIP_ADAPTER_DNS_SERVER_ADDRESS_XP as _IP_ADAPTER_DNS_SERVER_ADDRESS_XP ptr
type IP_ADAPTER_DNS_SERVER_ADDRESS as IP_ADAPTER_DNS_SERVER_ADDRESS_XP
type PIP_ADAPTER_DNS_SERVER_ADDRESS as IP_ADAPTER_DNS_SERVER_ADDRESS_XP ptr

type _IP_ADAPTER_PREFIX_XP
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			Flags as DWORD
		end type
	end union

	Next as _IP_ADAPTER_PREFIX_XP ptr
	Address as SOCKET_ADDRESS
	PrefixLength as ULONG
end type

type IP_ADAPTER_PREFIX_XP as _IP_ADAPTER_PREFIX_XP
type PIP_ADAPTER_PREFIX_XP as _IP_ADAPTER_PREFIX_XP ptr
type IP_ADAPTER_PREFIX as IP_ADAPTER_PREFIX_XP
type PIP_ADAPTER_PREFIX as IP_ADAPTER_PREFIX_XP ptr

type _IP_ADAPTER_WINS_SERVER_ADDRESS_LH
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			Reserved as DWORD
		end type
	end union

	Next as _IP_ADAPTER_WINS_SERVER_ADDRESS_LH ptr
	Address as SOCKET_ADDRESS
end type

type IP_ADAPTER_WINS_SERVER_ADDRESS_LH as _IP_ADAPTER_WINS_SERVER_ADDRESS_LH
type PIP_ADAPTER_WINS_SERVER_ADDRESS_LH as _IP_ADAPTER_WINS_SERVER_ADDRESS_LH ptr

#if _WIN32_WINNT >= &h0600
	type IP_ADAPTER_WINS_SERVER_ADDRESS as IP_ADAPTER_WINS_SERVER_ADDRESS_LH
	type PIP_ADAPTER_WINS_SERVER_ADDRESS as IP_ADAPTER_WINS_SERVER_ADDRESS_LH ptr
#endif

type _IP_ADAPTER_GATEWAY_ADDRESS_LH
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			Reserved as DWORD
		end type
	end union

	Next as _IP_ADAPTER_GATEWAY_ADDRESS_LH ptr
	Address as SOCKET_ADDRESS
end type

type IP_ADAPTER_GATEWAY_ADDRESS_LH as _IP_ADAPTER_GATEWAY_ADDRESS_LH
type PIP_ADAPTER_GATEWAY_ADDRESS_LH as _IP_ADAPTER_GATEWAY_ADDRESS_LH ptr

#if _WIN32_WINNT >= &h0600
	type IP_ADAPTER_GATEWAY_ADDRESS as IP_ADAPTER_GATEWAY_ADDRESS_LH
	type PIP_ADAPTER_GATEWAY_ADDRESS as IP_ADAPTER_GATEWAY_ADDRESS_LH ptr
#endif

type _IP_ADAPTER_DNS_SUFFIX
	Next as _IP_ADAPTER_DNS_SUFFIX ptr
	String as wstring * 256
end type

type IP_ADAPTER_DNS_SUFFIX as _IP_ADAPTER_DNS_SUFFIX
type PIP_ADAPTER_DNS_SUFFIX as _IP_ADAPTER_DNS_SUFFIX ptr
const IP_ADAPTER_DDNS_ENABLED = &h01
const IP_ADAPTER_REGISTER_ADAPTER_SUFFIX = &h02
const IP_ADAPTER_DHCP_ENABLED = &h04
const IP_ADAPTER_RECEIVE_ONLY = &h08
const IP_ADAPTER_NO_MULTICAST = &h10
const IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG = &h20
const IP_ADAPTER_NETBIOS_OVER_TCPIP_ENABLED = &h40
const IP_ADAPTER_IPV4_ENABLED = &h80
const IP_ADAPTER_IPV6_ENABLED = &h100
const IP_ADAPTER_IPV6_MANAGE_ADDRESS_CONFIG = &h200

type _IP_ADAPTER_ADDRESSES_LH
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			IfIndex as IF_INDEX
		end type
	end union

	Next as _IP_ADAPTER_ADDRESSES_LH ptr
	AdapterName as PCHAR
	FirstUnicastAddress as PIP_ADAPTER_UNICAST_ADDRESS_LH
	FirstAnycastAddress as PIP_ADAPTER_ANYCAST_ADDRESS_XP
	FirstMulticastAddress as PIP_ADAPTER_MULTICAST_ADDRESS_XP
	FirstDnsServerAddress as PIP_ADAPTER_DNS_SERVER_ADDRESS_XP
	DnsSuffix as PWCHAR
	Description as PWCHAR
	FriendlyName as PWCHAR
	PhysicalAddress(0 to 7) as UBYTE
	PhysicalAddressLength as ULONG

	union
		Flags as ULONG

		type
			DdnsEnabled : 1 as ULONG
			RegisterAdapterSuffix : 1 as ULONG
			Dhcpv4Enabled : 1 as ULONG
			ReceiveOnly : 1 as ULONG
			NoMulticast : 1 as ULONG
			Ipv6OtherStatefulConfig : 1 as ULONG
			NetbiosOverTcpipEnabled : 1 as ULONG
			Ipv4Enabled : 1 as ULONG
			Ipv6Enabled : 1 as ULONG
			Ipv6ManagedAddressConfigurationSupported : 1 as ULONG
		end type
	end union

	Mtu as ULONG
	IfType as IFTYPE
	OperStatus as IF_OPER_STATUS
	Ipv6IfIndex as IF_INDEX
	ZoneIndices(0 to 15) as ULONG
	FirstPrefix as PIP_ADAPTER_PREFIX_XP
	TransmitLinkSpeed as ULONG64
	ReceiveLinkSpeed as ULONG64
	FirstWinsServerAddress as PIP_ADAPTER_WINS_SERVER_ADDRESS_LH
	FirstGatewayAddress as PIP_ADAPTER_GATEWAY_ADDRESS_LH
	Ipv4Metric as ULONG
	Ipv6Metric as ULONG
	Luid as IF_LUID
	Dhcpv4Server as SOCKET_ADDRESS
	CompartmentId as NET_IF_COMPARTMENT_ID
	NetworkGuid as NET_IF_NETWORK_GUID
	ConnectionType as NET_IF_CONNECTION_TYPE
	TunnelType as TUNNEL_TYPE
	Dhcpv6Server as SOCKET_ADDRESS
	Dhcpv6ClientDuid(0 to 129) as UBYTE
	Dhcpv6ClientDuidLength as ULONG
	Dhcpv6Iaid as ULONG

	#if _WIN32_WINNT >= &h0601
		FirstDnsSuffix as PIP_ADAPTER_DNS_SUFFIX
	#endif
end type

type IP_ADAPTER_ADDRESSES_LH as _IP_ADAPTER_ADDRESSES_LH
type PIP_ADAPTER_ADDRESSES_LH as _IP_ADAPTER_ADDRESSES_LH ptr

type _IP_ADAPTER_ADDRESSES_XP
	union
		Alignment as ULONGLONG

		type
			Length as ULONG
			IfIndex as DWORD
		end type
	end union

	Next as _IP_ADAPTER_ADDRESSES_XP ptr
	AdapterName as PCHAR
	FirstUnicastAddress as PIP_ADAPTER_UNICAST_ADDRESS_XP
	FirstAnycastAddress as PIP_ADAPTER_ANYCAST_ADDRESS_XP
	FirstMulticastAddress as PIP_ADAPTER_MULTICAST_ADDRESS_XP
	FirstDnsServerAddress as PIP_ADAPTER_DNS_SERVER_ADDRESS_XP
	DnsSuffix as PWCHAR
	Description as PWCHAR
	FriendlyName as PWCHAR
	PhysicalAddress(0 to 7) as UBYTE
	PhysicalAddressLength as DWORD
	Flags as DWORD
	Mtu as DWORD
	IfType as DWORD
	OperStatus as IF_OPER_STATUS
	Ipv6IfIndex as DWORD
	ZoneIndices(0 to 15) as DWORD
	FirstPrefix as PIP_ADAPTER_PREFIX_XP
end type

type IP_ADAPTER_ADDRESSES_XP as _IP_ADAPTER_ADDRESSES_XP
type PIP_ADAPTER_ADDRESSES_XP as _IP_ADAPTER_ADDRESSES_XP ptr

#if _WIN32_WINNT <= &h0502
	type IP_ADAPTER_ADDRESSES as IP_ADAPTER_ADDRESSES_XP
	type PIP_ADAPTER_ADDRESSES as IP_ADAPTER_ADDRESSES_XP ptr
#else
	type IP_ADAPTER_ADDRESSES as IP_ADAPTER_ADDRESSES_LH
	type PIP_ADAPTER_ADDRESSES as IP_ADAPTER_ADDRESSES_LH ptr
#endif

const GAA_FLAG_SKIP_UNICAST = &h0001
const GAA_FLAG_SKIP_ANYCAST = &h0002
const GAA_FLAG_SKIP_MULTICAST = &h0004
const GAA_FLAG_SKIP_DNS_SERVER = &h0008
const GAA_FLAG_INCLUDE_PREFIX = &h0010
const GAA_FLAG_SKIP_FRIENDLY_NAME = &h0020
const GAA_FLAG_INCLUDE_WINS_INFO = &h0040
const GAA_FLAG_INCLUDE_GATEWAYS = &h0080
const GAA_FLAG_INCLUDE_ALL_INTERFACES = &h0100
const GAA_FLAG_INCLUDE_ALL_COMPARTMENTS = &h0200
const GAA_FLAG_INCLUDE_TUNNEL_BINDINGORDER = &h0400

type _IP_PER_ADAPTER_INFO
	AutoconfigEnabled as UINT
	AutoconfigActive as UINT
	CurrentDnsServer as PIP_ADDR_STRING
	DnsServerList as IP_ADDR_STRING
end type

type IP_PER_ADAPTER_INFO as _IP_PER_ADAPTER_INFO
type PIP_PER_ADAPTER_INFO as _IP_PER_ADAPTER_INFO ptr

type FIXED_INFO
	HostName as zstring * 128 + 4
	DomainName as zstring * 128 + 4
	CurrentDnsServer as PIP_ADDR_STRING
	DnsServerList as IP_ADDR_STRING
	NodeType as UINT
	ScopeId as zstring * 256 + 4
	EnableRouting as UINT
	EnableProxy as UINT
	EnableDns as UINT
end type

type PFIXED_INFO as FIXED_INFO ptr
#define IP_INTERFACE_NAME_INFO_DEFINED

type IP_INTERFACE_NAME_INFO
	Index as ULONG
	MediaType as ULONG
	ConnectionType as UCHAR
	AccessType as UCHAR
	DeviceGuid as GUID
	InterfaceGuid as GUID
end type

type PIP_INTERFACE_NAME_INFO as IP_INTERFACE_NAME_INFO ptr
