''
''
'' netinet\in -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_netinet_in_bi__
#define __crt_netinet_in_bi__

#include once "crt/stdint.bi"
#include once "crt/sys/socket.bi"
#include once "crt/sys/types.bi"

enum 
	IPPROTO_IP = 0
	IPPROTO_HOPOPTS = 0
	IPPROTO_ICMP = 1
	IPPROTO_IGMP = 2
	IPPROTO_IPIP = 4
	IPPROTO_TCP = 6
	IPPROTO_EGP = 8
	IPPROTO_PUP = 12
	IPPROTO_UDP = 17
	IPPROTO_IDP = 22
	IPPROTO_TP = 29
	IPPROTO_IPV6 = 41
	IPPROTO_ROUTING = 43
	IPPROTO_FRAGMENT = 44
	IPPROTO_RSVP = 46
	IPPROTO_GRE = 47
	IPPROTO_ESP = 50
	IPPROTO_AH = 51
	IPPROTO_ICMPV6 = 58
	IPPROTO_NONE = 59
	IPPROTO_DSTOPTS = 60
	IPPROTO_MTP = 92
	IPPROTO_ENCAP = 98
	IPPROTO_PIM = 103
	IPPROTO_COMP = 108
	IPPROTO_SCTP = 132
	IPPROTO_RAW = 255
	IPPROTO_MAX
end enum

type in_port_t as uint16_t

enum 
	IPPORT_ECHO = 7
	IPPORT_DISCARD = 9
	IPPORT_SYSTAT = 11
	IPPORT_DAYTIME = 13
	IPPORT_NETSTAT = 15
	IPPORT_FTP = 21
	IPPORT_TELNET = 23
	IPPORT_SMTP = 25
	IPPORT_TIMESERVER = 37
	IPPORT_NAMESERVER = 42
	IPPORT_WHOIS = 43
	IPPORT_MTP = 57
	IPPORT_TFTP = 69
	IPPORT_RJE = 77
	IPPORT_FINGER = 79
	IPPORT_TTYLINK = 87
	IPPORT_SUPDUP = 95
	IPPORT_EXECSERVER = 512
	IPPORT_LOGINSERVER = 513
	IPPORT_CMDSERVER = 514
	IPPORT_EFSSERVER = 520
	IPPORT_BIFFUDP = 512
	IPPORT_WHOSERVER = 513
	IPPORT_ROUTESERVER = 520
	IPPORT_RESERVED = 1024
	IPPORT_USERRESERVED = 5000
end enum

type in_addr_t as uint32_t

type in_addr
	s_addr as in_addr_t
end type

#define	IN_CLASSA(a) ((cast(in_addr_t,a) and &h80000000) = 0)
#define IN_CLASSA_NET &hff000000
#define IN_CLASSA_NSHIFT 24
#define IN_CLASSA_HOST (&hffffffff and not &hff000000)
#define IN_CLASSA_MAX 128

#define	IN_CLASSB(a) ((cast(in_addr_t,a) and &hc0000000) = &h80000000)
#define IN_CLASSB_NET &hffff0000
#define IN_CLASSB_NSHIFT 16
#define IN_CLASSB_HOST (&hffffffff and not &hffff0000)
#define IN_CLASSB_MAX 65536

#define	IN_CLASSC(a) ((cast(in_addr_t,a) and &he0000000) = &hc0000000)
#define IN_CLASSC_NET &hffffff00
#define IN_CLASSC_NSHIFT 8
#define IN_CLASSC_HOST (&hffffffff and not &hffffff00)

#define	IN_CLASSD(a) ((cast(in_addr_t,a) and &hf0000000) = &he0000000)
#define	IN_MULTICAST(a) IN_CLASSD(a)

#define	IN_EXPERIMENTAL(a) ((cast(in_addr_t,a) and &he0000000) = &he0000000)
#define	IN_BADCLASS(a) ((cast(in_addr_t,a) & &hf0000000) = &hf0000000)

#define	INADDR_ANY cast(in_addr_t, &h00000000)
#define	INADDR_BROADCAST cast(in_addr_t, &hffffffff)
#define	INADDR_NONE	cast(in_addr_t, &hffffffff)

#define	IN_LOOPBACKNET 127
#ifndef INADDR_LOOPBACK
# define INADDR_LOOPBACK cast(in_addr_t, &h7f000001)
#endif

#define INADDR_UNSPEC_GROUP	cast(in_addr_t, &he0000000)
#define INADDR_ALLHOSTS_GROUP cast(in_addr_t, &he0000001)
#define INADDR_ALLRTRS_GROUP cast(in_addr_t, &he0000002)
#define INADDR_MAX_LOCAL_GROUP cast(in_addr_t, &he00000ff)

union in6_addr__in6_u
	u6_addr8(0 to 16-1) as uint8_t
	u6_addr16(0 to 8-1) as uint16_t
	u6_addr32(0 to 4-1) as uint32_t
end union

type in6_addr
	in6_u as in6_addr__in6_u
end type

#define s6_addr	in6_u.u6_addr8
#define s6_addr16 in6_u.u6_addr16
#define s6_addr32 in6_u.u6_addr32

extern in6addr_any alias "in6addr_any" as in6_addr
extern in6addr_loopback alias "in6addr_loopback" as in6_addr

#define IN6ADDR_ANY_INIT ( ( { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } ) )
#define IN6ADDR_LOOPBACK_INIT ( ( { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } ) )

#define INET_ADDRSTRLEN 16
#define INET6_ADDRSTRLEN 46

#include once "crt/sys/socket.bi"

type sockaddr_in
	sin_family as sa_family_t
	sin_port as in_port_t
	sin_addr as in_addr
	sin_zero(0 to len(sockaddr)-(len(ushort)) -len(in_port_t)-len(in_addr)-1) as ubyte
end type

type sockaddr_in6
	sin6_family as sa_family_t
	sin6_port as in_port_t
	sin6_flowinfo as uint32_t
	sin6_addr as in6_addr
	sin6_scope_id as uint32_t
end type

type ip_mreq
	imr_multiaddr as in_addr
	imr_interface as in_addr
end type

type ip_mreq_source
	imr_multiaddr as in_addr
	imr_interface as in_addr
	imr_sourceaddr as in_addr
end type

type ipv6_mreq
	ipv6mr_multiaddr as in6_addr
	ipv6mr_interface as ulong
end type

type group_req
	gr_interface as uint32_t
	gr_group as sockaddr_storage
end type

type group_source_req
	gsr_interface as uint32_t
	gsr_group as sockaddr_storage
	gsr_source as sockaddr_storage
end type

type ip_msfilter
	imsf_multiaddr as in_addr
	imsf_interface as in_addr
	imsf_fmode as uint32_t
	imsf_numsrc as uint32_t
	imsf_slist(0 to 1-1) as in_addr
end type

type group_filter
	gf_interface as uint32_t
	gf_group as sockaddr_storage
	gf_fmode as uint32_t
	gf_numsrc as uint32_t
	gf_slist(0 to 1-1) as sockaddr_storage
end type

#if defined(__FB_LINUX__)
#include once "crt/netinet/linux/in.bi"
#else
#error Platform unsupported
#endif

extern "C"
declare function ntohl (byval __netlong as uint32_t) as uint32_t
declare function ntohs (byval __netshort as uint16_t) as uint16_t
declare function htonl (byval __hostlong as uint32_t) as uint32_t
declare function htons (byval __hostshort as uint16_t) as uint16_t
declare function bindresvport (byval __sockfd as integer, byval __sock_in as sockaddr_in ptr) as long
declare function bindresvport6 (byval __sockfd as integer, byval __sock_in as sockaddr_in6 ptr) as long
end extern

type in6_pktinfo
	ipi6_addr as in6_addr
	ipi6_ifindex as ulong
end type

#endif
