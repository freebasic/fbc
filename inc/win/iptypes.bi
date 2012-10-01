''
''
'' iptypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_iptypes_bi__
#define __win_iptypes_bi__

#ifndef time_t
type time_t as integer
#endif

#define DEFAULT_MINIMUM_ENTITIES 32
#define MAX_ADAPTER_ADDRESS_LENGTH 8
#define MAX_ADAPTER_DESCRIPTION_LENGTH 128
#define MAX_ADAPTER_NAME_LENGTH 256
#define MAX_DOMAIN_NAME_LEN 128
#define MAX_HOSTNAME_LEN 128
#define MAX_SCOPE_ID_LEN 256
#define BROADCAST_NODETYPE 1
#define PEER_TO_PEER_NODETYPE 2
#define MIXED_NODETYPE 4
#define HYBRID_NODETYPE 8
#define IF_OTHER_ADAPTERTYPE 0
#define IF_ETHERNET_ADAPTERTYPE 1
#define IF_TOKEN_RING_ADAPTERTYPE 2
#define IF_FDDI_ADAPTERTYPE 3
#define IF_PPP_ADAPTERTYPE 4
#define IF_LOOPBACK_ADAPTERTYPE 5

type IP_ADDRESS_STRING
	String as zstring * 16
end type

type PIP_ADDRESS_STRING as IP_ADDRESS_STRING ptr
type IP_MASK_STRING as IP_ADDRESS_STRING
type PIP_MASK_STRING as IP_ADDRESS_STRING ptr

type IP_ADDR_STRING
	Next as IP_ADDR_STRING ptr
	IpAddress as IP_ADDRESS_STRING
	IpMask as IP_MASK_STRING
	Context as DWORD
end type

type PIP_ADDR_STRING as IP_ADDR_STRING ptr

type IP_ADAPTER_INFO
	Next as IP_ADAPTER_INFO ptr
	ComboIndex as DWORD
	AdapterName as zstring * 256+4
	Description as zstring * 128+4
	AddressLength as UINT
	Address(0 to 8-1) as UBYTE
	Index as DWORD
	Type as UINT
	DhcpEnabled as UINT
	CurrentIpAddress as PIP_ADDR_STRING
	IpAddressList as IP_ADDR_STRING
	GatewayList as IP_ADDR_STRING
	DhcpServer as IP_ADDR_STRING
	HaveWins as BOOL
	PrimaryWinsServer as IP_ADDR_STRING
	SecondaryWinsServer as IP_ADDR_STRING
	LeaseObtained as time_t
	LeaseExpires as time_t
end type

type PIP_ADAPTER_INFO as IP_ADAPTER_INFO ptr

type IP_PER_ADAPTER_INFO
	AutoconfigEnabled as UINT
	AutoconfigActive as UINT
	CurrentDnsServer as PIP_ADDR_STRING
	DnsServerList as IP_ADDR_STRING
end type

type PIP_PER_ADAPTER_INFO as IP_PER_ADAPTER_INFO ptr

type FIXED_INFO
	HostName as zstring * 128+4
	DomainName as zstring * 128+4
	CurrentDnsServer as PIP_ADDR_STRING
	DnsServerList as IP_ADDR_STRING
	NodeType as UINT
	ScopeId as zstring * 256+4
	EnableRouting as UINT
	EnableProxy as UINT
	EnableDns as UINT
end type

type PFIXED_INFO as FIXED_INFO ptr

#endif
