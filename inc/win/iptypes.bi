#pragma once

#include once "crt/time.bi"
#include once "ifdef.bi"
#include once "nldef.bi"

#define IP_TYPES_INCLUDED
#define MAX_ADAPTER_DESCRIPTION_LENGTH 128
#define MAX_ADAPTER_NAME_LENGTH 256
#define MAX_ADAPTER_ADDRESS_LENGTH 8
#define DEFAULT_MINIMUM_ENTITIES 32
#define MAX_HOSTNAME_LEN 128
#define MAX_DOMAIN_NAME_LEN 128
#define MAX_SCOPE_ID_LEN 256
#define MAX_DHCPV6_DUID_LENGTH 130
#define MAX_DNS_SUFFIX_STRING_LENGTH 256
#define BROADCAST_NODETYPE 1
#define PEER_TO_PEER_NODETYPE 2
#define MIXED_NODETYPE 4
#define HYBRID_NODETYPE 8

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

type ip_interface_name_info
	Index as ULONG
	MediaType as ULONG
	ConnectionType as UCHAR
	AccessType as UCHAR
	DeviceGuid as GUID
	InterfaceGuid as GUID
end type

type PIP_INTERFACE_NAME_INFO as ip_interface_name_info ptr
