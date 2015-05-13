#pragma once

#include once "winapifamily.bi"
#include once "in6addr.bi"
#include once "winsock2.bi"

#define _INC_WS2IPDEF

type IPV6_MREQ
	ipv6mr_multiaddr as IN6_ADDR
	ipv6mr_interface as ulong
end type

type sockaddr_in6_old
	sin6_family as short
	sin6_port as u_short
	sin6_flowinfo as u_long
	sin6_addr as IN6_ADDR
end type

union sockaddr_gen
	Address as SOCKADDR
	AddressIn as SOCKADDR_IN
	AddressIn6 as sockaddr_in6_old
end union

type SOCKADDR_IN6
	sin6_family as short
	sin6_port as u_short
	sin6_flowinfo as u_long
	sin6_addr as IN6_ADDR

	union
		sin6_scope_id as u_long
		sin6_scope_struct as SCOPE_ID
	end union
end type

type PSOCKADDR_IN6 as SOCKADDR_IN6 ptr
type LPSOCKADDR_IN6 as SOCKADDR_IN6 ptr

type _INTERFACE_INFO
	iiFlags as u_long
	iiAddress as sockaddr_gen
	iiBroadcastAddress as sockaddr_gen
	iiNetmask as sockaddr_gen
end type

type INTERFACE_INFO as _INTERFACE_INFO
type LPINTERFACE_INFO as _INTERFACE_INFO ptr

type _MULTICAST_MODE_TYPE as long
enum
	MCAST_INCLUDE = 0
	MCAST_EXCLUDE
end enum

type MULTICAST_MODE_TYPE as _MULTICAST_MODE_TYPE

type _sockaddr_in6_pair
	SourceAddress as PSOCKADDR_IN6
	DestinationAddress as PSOCKADDR_IN6
end type

type SOCKADDR_IN6_PAIR as _sockaddr_in6_pair
type PSOCKADDR_IN6_PAIR as _sockaddr_in6_pair ptr

union _SOCKADDR_INET
	Ipv4 as SOCKADDR_IN
	Ipv6 as SOCKADDR_IN6
	si_family as ADDRESS_FAMILY
end union

type SOCKADDR_INET as _SOCKADDR_INET
type PSOCKADDR_INET as _SOCKADDR_INET ptr

type GROUP_FILTER
	gf_interface as ULONG
	gf_group as SOCKADDR_STORAGE
	gf_fmode as MULTICAST_MODE_TYPE
	gf_numsrc as ULONG
	gf_slist(0 to 0) as SOCKADDR_STORAGE
end type

type PGROUP_FILTER as GROUP_FILTER ptr

type GROUP_REQ
	gr_interface as ULONG
	gr_group as SOCKADDR_STORAGE
end type

type PGROUP_REQ as GROUP_REQ ptr

type GROUP_SOURCE_REQ
	gsr_interface as ULONG
	gsr_group as SOCKADDR_STORAGE
	gsr_source as SOCKADDR_STORAGE
end type

type PGROUP_SOURCE_REQ as GROUP_SOURCE_REQ ptr
const IPV6_HOPOPTS = 1
const IPV6_HDRINCL = 2
const IPV6_UNICAST_HOPS = 4
const IPV6_MULTICAST_IF = 9
const IPV6_MULTICAST_HOPS = 10
const IPV6_MULTICAST_LOOP = 11
const IPV6_ADD_MEMBERSHIP = 12
#define IPV6_JOIN_GROUP IPV6_ADD_MEMBERSHIP
const IPV6_DROP_MEMBERSHIP = 13
#define IPV6_LEAVE_GROUP IPV6_DROP_MEMBERSHIP
const IPV6_DONTFRAG = 14
const IPV6_PKTINFO = 19
const IPV6_HOPLIMIT = 21
const IPV6_PROTECTION_LEVEL = 23
const IPV6_RECVIF = 24
const IPV6_RECVDSTADDR = 25
const IPV6_CHECKSUM = 26
const IPV6_V6ONLY = 27
const IPV6_IFLIST = 28
const IPV6_ADD_IFLIST = 29
const IPV6_DEL_IFLIST = 30
const IPV6_UNICAST_IF = 31
const IPV6_RTHDR = 32
const IPV6_RECVRTHDR = 38
const IPV6_TCLASS = 39
const IPV6_RECVTCLASS = 40
