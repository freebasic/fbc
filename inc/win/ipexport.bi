#pragma once

#include once "in6addr.bi"
#include once "inaddr.bi"

#define IP_EXPORT_INCLUDED 1

type IPAddr as ULONG
type IPMask as ULONG
type IP_STATUS as ULONG
type IPv6Addr as in6_addr

type ip_option_information
	Ttl as UCHAR
	Tos as UCHAR
	Flags as UCHAR
	OptionsSize as UCHAR
	OptionsData as PUCHAR
end type

type PIP_OPTION_INFORMATION as ip_option_information ptr

#ifdef __FB_64BIT__
	type ip_option_information32
		Ttl as UCHAR
		Tos as UCHAR
		Flags as UCHAR
		OptionsSize as UCHAR
		OptionsData as UCHAR ptr
	end type

	type PIP_OPTION_INFORMATION32 as ip_option_information32 ptr
#endif

type icmp_echo_reply
	Address as IPAddr
	Status as ULONG
	RoundTripTime as ULONG
	DataSize as USHORT
	Reserved as USHORT
	Data as PVOID
	Options as ip_option_information
end type

type PICMP_ECHO_REPLY as icmp_echo_reply ptr

#ifdef __FB_64BIT__
	type icmp_echo_reply32
		Address as IPAddr
		Status as ULONG
		RoundTripTime as ULONG
		DataSize as USHORT
		Reserved as USHORT
		Data as any ptr
		Options as ip_option_information32
	end type

	type PICMP_ECHO_REPLY32 as icmp_echo_reply32 ptr
#endif

type arp_send_reply
	DestAddress as IPAddr
	SrcAddress as IPAddr
end type

type PARP_SEND_REPLY as arp_send_reply ptr

type tcp_reserve_port_range
	UpperRange as USHORT
	LowerRange as USHORT
end type

type PTCP_RESERVE_PORT_RANGE as tcp_reserve_port_range ptr

#define MAX_ADAPTER_NAME 128

type _IP_ADAPTER_INDEX_MAP
	Index as ULONG
	Name as wstring * 128
end type

type IP_ADAPTER_INDEX_MAP as _IP_ADAPTER_INDEX_MAP
type PIP_ADAPTER_INDEX_MAP as _IP_ADAPTER_INDEX_MAP ptr

type _IP_INTERFACE_INFO
	NumAdapters as LONG
	Adapter(0 to 0) as IP_ADAPTER_INDEX_MAP
end type

type IP_INTERFACE_INFO as _IP_INTERFACE_INFO
type PIP_INTERFACE_INFO as _IP_INTERFACE_INFO ptr

type _IP_UNIDIRECTIONAL_ADAPTER_ADDRESS
	NumAdapters as ULONG
	Address(0 to 0) as IPAddr
end type

type IP_UNIDIRECTIONAL_ADAPTER_ADDRESS as _IP_UNIDIRECTIONAL_ADAPTER_ADDRESS
type PIP_UNIDIRECTIONAL_ADAPTER_ADDRESS as _IP_UNIDIRECTIONAL_ADAPTER_ADDRESS ptr

type _IP_ADAPTER_ORDER_MAP
	NumAdapters as ULONG
	AdapterOrder(0 to 0) as ULONG
end type

type IP_ADAPTER_ORDER_MAP as _IP_ADAPTER_ORDER_MAP
type PIP_ADAPTER_ORDER_MAP as _IP_ADAPTER_ORDER_MAP ptr

type _IP_MCAST_COUNTER_INFO
	InMcastOctets as ULONG64
	OutMcastOctets as ULONG64
	InMcastPkts as ULONG64
	OutMcastPkts as ULONG64
end type

type IP_MCAST_COUNTER_INFO as _IP_MCAST_COUNTER_INFO
type PIP_MCAST_COUNTER_INFO as _IP_MCAST_COUNTER_INFO ptr

type _IPV6_ADDRESS_EX
	sin6_port as USHORT
	sin6_flowinfo as ULONG
	sin6_addr(0 to 7) as USHORT
	sin6_scope_id as ULONG
end type

type IPV6_ADDRESS_EX as _IPV6_ADDRESS_EX
type PIPV6_ADDRESS_EX as _IPV6_ADDRESS_EX ptr

#define IP_STATUS_BASE 11000
#define IP_SUCCESS 0
#define IP_BUF_TOO_SMALL (IP_STATUS_BASE + 1)
#define IP_DEST_NET_UNREACHABLE (IP_STATUS_BASE + 2)
#define IP_DEST_HOST_UNREACHABLE (IP_STATUS_BASE + 3)
#define IP_DEST_PROT_UNREACHABLE (IP_STATUS_BASE + 4)
#define IP_NO_RESOURCES (IP_STATUS_BASE + 6)
#define IP_BAD_OPTION (IP_STATUS_BASE + 7)
#define IP_HW_ERROR (IP_STATUS_BASE + 8)
#define IP_PACKET_TOO_BIG (IP_STATUS_BASE + 9)
#define IP_REQ_TIMED_OUT (IP_STATUS_BASE + 10)
#define IP_BAD_REQ (IP_STATUS_BASE + 11)
#define IP_BAD_ROUTE (IP_STATUS_BASE + 12)
#define IP_TTL_EXPIRED_TRANSIT (IP_STATUS_BASE + 13)
#define IP_TTL_EXPIRED_REASSEM (IP_STATUS_BASE + 14)
#define IP_PARAM_PROBLEM (IP_STATUS_BASE + 15)
#define IP_SOURCE_QUENCH (IP_STATUS_BASE + 16)
#define IP_OPTION_TOO_BIG (IP_STATUS_BASE + 17)
#define IP_BAD_DESTINATION (IP_STATUS_BASE + 18)
#define IP_DEST_NO_ROUTE (IP_STATUS_BASE + 2)
#define IP_DEST_ADDR_UNREACHABLE (IP_STATUS_BASE + 3)
#define IP_DEST_PROHIBITED (IP_STATUS_BASE + 4)
#define IP_DEST_PORT_UNREACHABLE (IP_STATUS_BASE + 5)
#define IP_HOP_LIMIT_EXCEEDED (IP_STATUS_BASE + 13)
#define IP_REASSEMBLY_TIME_EXCEEDED (IP_STATUS_BASE + 14)
#define IP_PARAMETER_PROBLEM (IP_STATUS_BASE + 15)
#define IP_DEST_UNREACHABLE (IP_STATUS_BASE + 40)
#define IP_TIME_EXCEEDED (IP_STATUS_BASE + 41)
#define IP_BAD_HEADER (IP_STATUS_BASE + 42)
#define IP_UNRECOGNIZED_NEXT_HEADER (IP_STATUS_BASE + 43)
#define IP_ICMP_ERROR (IP_STATUS_BASE + 44)
#define IP_DEST_SCOPE_MISMATCH (IP_STATUS_BASE + 45)
#define IP_ADDR_DELETED (IP_STATUS_BASE + 19)
#define IP_SPEC_MTU_CHANGE (IP_STATUS_BASE + 20)
#define IP_MTU_CHANGE (IP_STATUS_BASE + 21)
#define IP_UNLOAD (IP_STATUS_BASE + 22)
#define IP_ADDR_ADDED (IP_STATUS_BASE + 23)
#define IP_MEDIA_CONNECT (IP_STATUS_BASE + 24)
#define IP_MEDIA_DISCONNECT (IP_STATUS_BASE + 25)
#define IP_BIND_ADAPTER (IP_STATUS_BASE + 26)
#define IP_UNBIND_ADAPTER (IP_STATUS_BASE + 27)
#define IP_DEVICE_DOES_NOT_EXIST (IP_STATUS_BASE + 28)
#define IP_DUPLICATE_ADDRESS (IP_STATUS_BASE + 29)
#define IP_INTERFACE_METRIC_CHANGE (IP_STATUS_BASE + 30)
#define IP_RECONFIG_SECFLTR (IP_STATUS_BASE + 31)
#define IP_NEGOTIATING_IPSEC (IP_STATUS_BASE + 32)
#define IP_INTERFACE_WOL_CAPABILITY_CHANGE (IP_STATUS_BASE + 33)
#define IP_DUPLICATE_IPADD (IP_STATUS_BASE + 34)
#define IP_NO_FURTHER_SENDS (IP_STATUS_BASE + 35)
#define IP_GENERAL_FAILURE (IP_STATUS_BASE + 50)
#define MAX_IP_STATUS IP_GENERAL_FAILURE
#define IP_PENDING (IP_STATUS_BASE + 255)
#define IP_FLAG_DF &h2
#define IP_OPT_EOL 0
#define IP_OPT_NOP 1
#define IP_OPT_SECURITY &h82
#define IP_OPT_LSRR &h83
#define IP_OPT_SSRR &h89
#define IP_OPT_RR &h7
#define IP_OPT_TS &h44
#define IP_OPT_SID &h88
#define IP_OPT_ROUTER_ALERT &h94
#define MAX_OPT_SIZE 40
