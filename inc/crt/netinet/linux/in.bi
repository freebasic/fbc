''
''
'' bits\in -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_netinet_linux_in_bi__
#define __crt_netinet_linux_in_bi__

#define IP_OPTIONS 4
#define IP_HDRINCL 3
#define IP_TOS 1
#define IP_TTL 2
#define IP_RECVOPTS 6
#define IP_RETOPTS 7
#define IP_MULTICAST_IF 32
#define IP_MULTICAST_TTL 33
#define IP_MULTICAST_LOOP 34
#define IP_ADD_MEMBERSHIP 35
#define IP_DROP_MEMBERSHIP 36
#define IP_UNBLOCK_SOURCE 37
#define IP_BLOCK_SOURCE 38
#define IP_ADD_SOURCE_MEMBERSHIP 39
#define IP_DROP_SOURCE_MEMBERSHIP 40
#define IP_MSFILTER_ 41
#define MCAST_JOIN_GROUP 42
#define MCAST_BLOCK_SOURCE 43
#define MCAST_UNBLOCK_SOURCE 44
#define MCAST_LEAVE_GROUP 45
#define MCAST_JOIN_SOURCE_GROUP 46
#define MCAST_LEAVE_SOURCE_GROUP 47
#define MCAST_MSFILTER 48
#define MCAST_EXCLUDE 0
#define MCAST_INCLUDE 1
#define IP_ROUTER_ALERT 5
#define IP_PKTINFO 8
#define IP_PKTOPTIONS 9
#define IP_PMTUDISC 10
#define IP_MTU_DISCOVER 10
#define IP_RECVERR 11
#define IP_RECVTTL 12
#define IP_RECVTOS 13
#define IP_PMTUDISC_DONT 0
#define IP_PMTUDISC_WANT 1
#define IP_PMTUDISC_DO 2
#define SOL_IP 0
#define IP_DEFAULT_MULTICAST_TTL 1
#define IP_DEFAULT_MULTICAST_LOOP 1
#define IP_MAX_MEMBERSHIPS 20

type ip_opts
	ip_dst as in_addr
	ip_opts as zstring * 40
end type

type ip_mreqn
	imr_multiaddr as in_addr
	imr_address as in_addr
	imr_ifindex as long
end type

type in_pktinfo
	ipi_ifindex as long
	ipi_spec_dst as in_addr
	ipi_addr as in_addr
end type

#define IPV6_ADDRFORM 1
#define IPV6_PKTINFO 2
#define IPV6_HOPOPTS 3
#define IPV6_DSTOPTS 4
#define IPV6_RTHDR 5
#define IPV6_PKTOPTIONS 6
#define IPV6_CHECKSUM 7
#define IPV6_HOPLIMIT 8
#define IPV6_NEXTHOP 9
#define IPV6_AUTHHDR 10
#define IPV6_UNICAST_HOPS 16
#define IPV6_MULTICAST_IF 17
#define IPV6_MULTICAST_HOPS 18
#define IPV6_MULTICAST_LOOP 19
#define IPV6_JOIN_GROUP 20
#define IPV6_LEAVE_GROUP 21
#define IPV6_ROUTER_ALERT 22
#define IPV6_MTU_DISCOVER 23
#define IPV6_MTU 24
#define IPV6_RECVERR 25
#define IPV6_V6ONLY 26
#define IPV6_JOIN_ANYCAST 27
#define IPV6_LEAVE_ANYCAST 28
#define IPV6_IPSEC_POLICY 34
#define IPV6_XFRM_POLICY 35
#define IPV6_ADD_MEMBERSHIP 20
#define IPV6_DROP_MEMBERSHIP 21
#define IPV6_RXHOPOPTS 3
#define IPV6_RXDSTOPTS 4
#define IPV6_PMTUDISC_DONT 0
#define IPV6_PMTUDISC_WANT 1
#define IPV6_PMTUDISC_DO 2
#define SOL_IPV6 41
#define SOL_ICMPV6 58
#define IPV6_RTHDR_LOOSE 0
#define IPV6_RTHDR_STRICT 1
#define IPV6_RTHDR_TYPE_0 0

#endif
