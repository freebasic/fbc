#pragma once

#include once "winapifamily.bi"
#include once "in6addr.bi"
#include once "winsock2.bi"

#define _INC_WS2IPDEF

type ipv6_mreq
	ipv6mr_multiaddr as in6_addr
	ipv6mr_interface as ulong
end type

type sockaddr_in6_old
	sin6_family as short
	sin6_port as u_short
	sin6_flowinfo as u_long
	sin6_addr as in6_addr
end type

union sockaddr_gen
	Address as sockaddr
	AddressIn as sockaddr_in
	AddressIn6 as sockaddr_in6_old
end union

type sockaddr_in6
	sin6_family as short
	sin6_port as u_short
	sin6_flowinfo as u_long
	sin6_addr as in6_addr

	union
		sin6_scope_id as u_long
		sin6_scope_struct as SCOPE_ID
	end union
end type

type PSOCKADDR_IN6 as sockaddr_in6 ptr
type LPSOCKADDR_IN6 as sockaddr_in6 ptr

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
	Ipv4 as sockaddr_in
	Ipv6 as sockaddr_in6
	si_family as ADDRESS_FAMILY
end union

type SOCKADDR_INET as _SOCKADDR_INET
type PSOCKADDR_INET as _SOCKADDR_INET ptr

type group_filter
	gf_interface as ULONG
	gf_group as sockaddr_storage
	gf_fmode as MULTICAST_MODE_TYPE
	gf_numsrc as ULONG
	gf_slist(0 to 0) as sockaddr_storage
end type

type PGROUP_FILTER as group_filter ptr

type group_req
	gr_interface as ULONG
	gr_group as sockaddr_storage
end type

type PGROUP_REQ as group_req ptr

type group_source_req
	gsr_interface as ULONG
	gsr_group as sockaddr_storage
	gsr_source as sockaddr_storage
end type

type PGROUP_SOURCE_REQ as group_source_req ptr

#define IPV6_HOPOPTS 1
#define IPV6_HDRINCL 2
#define IPV6_UNICAST_HOPS 4
#define IPV6_MULTICAST_IF 9
#define IPV6_MULTICAST_HOPS 10
#define IPV6_MULTICAST_LOOP 11
#define IPV6_ADD_MEMBERSHIP 12
#define IPV6_JOIN_GROUP IPV6_ADD_MEMBERSHIP
#define IPV6_DROP_MEMBERSHIP 13
#define IPV6_LEAVE_GROUP IPV6_DROP_MEMBERSHIP
#define IPV6_DONTFRAG 14
#define IPV6_PKTINFO 19
#define IPV6_HOPLIMIT 21
#define IPV6_PROTECTION_LEVEL 23
#define IPV6_RECVIF 24
#define IPV6_RECVDSTADDR 25
#define IPV6_CHECKSUM 26
#define IPV6_V6ONLY 27
#define IPV6_IFLIST 28
#define IPV6_ADD_IFLIST 29
#define IPV6_DEL_IFLIST 30
#define IPV6_UNICAST_IF 31
#define IPV6_RTHDR 32
#define IPV6_RECVRTHDR 38
#define IPV6_TCLASS 39
#define IPV6_RECVTCLASS 40
