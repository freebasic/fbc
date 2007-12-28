''
''
'' ipexport -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ipexport_bi__
#define __win_ipexport_bi__

#ifndef ANY_SIZE
#define ANY_SIZE 1
#endif
#define MAX_ADAPTER_NAME 128
#define IP_STATUS_BASE 11000
#define IP_SUCCESS 0
#define IP_BUF_TOO_SMALL (11000+1)
#define IP_DEST_NET_UNREACHABLE (11000+2)
#define IP_DEST_HOST_UNREACHABLE (11000+3)
#define IP_DEST_PROT_UNREACHABLE (11000+4)
#define IP_DEST_PORT_UNREACHABLE (11000+5)
#define IP_NO_RESOURCES (11000+6)
#define IP_BAD_OPTION (11000+7)
#define IP_HW_ERROR (11000+8)
#define IP_PACKET_TOO_BIG (11000+9)
#define IP_REQ_TIMED_OUT (11000+10)
#define IP_BAD_REQ (11000+11)
#define IP_BAD_ROUTE (11000+12)
#define IP_TTL_EXPIRED_TRANSIT (11000+13)
#define IP_TTL_EXPIRED_REASSEM (11000+14)
#define IP_PARAM_PROBLEM (11000+15)
#define IP_SOURCE_QUENCH (11000+16)
#define IP_OPTION_TOO_BIG (11000+17)
#define IP_BAD_DESTINATION (11000+18)
#define IP_ADDR_DELETED (11000+19)
#define IP_SPEC_MTU_CHANGE (11000+20)
#define IP_MTU_CHANGE (11000+21)
#define IP_UNLOAD (11000+22)
#define IP_GENERAL_FAILURE (11000+50)
#define MAX_IP_STATUS (11000+50)
#define IP_PENDING (11000+255)
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

type IPAddr as uinteger
type IPMask as uinteger
type IP_STATUS as uinteger

type IP_OPTION_INFORMATION
	Ttl as ubyte
	Tos as ubyte
	Flags as ubyte
	OptionsSize as ubyte
	OptionsData as ubyte ptr
end type

type PIP_OPTION_INFORMATION as IP_OPTION_INFORMATION ptr

type ICMP_ECHO_REPLY
	Address as IPAddr
	Status as uinteger
	RoundTripTime as uinteger
	DataSize as ushort
	Reserved as ushort
	Data as any ptr
	Options as ip_option_information
end type

type PICMP_ECHO_REPLY as ICMP_ECHO_REPLY ptr

type IP_ADAPTER_INDEX_MAP
	Index as ULONG
	Name as wstring * 128
end type

type PIP_ADAPTER_INDEX_MAP as IP_ADAPTER_INDEX_MAP ptr

type IP_INTERFACE_INFO
	NumAdapters as LONG
	Adapter(0 to 1-1) as IP_ADAPTER_INDEX_MAP
end type

type PIP_INTERFACE_INFO as IP_INTERFACE_INFO ptr

type IP_UNIDIRECTIONAL_ADAPTER_ADDRESS
	NumAdapters as ULONG
	Address(0 to 1-1) as IPAddr
end type

type PIP_UNIDIRECTIONAL_ADAPTER_ADDRESS as IP_UNIDIRECTIONAL_ADAPTER_ADDRESS ptr

#endif
