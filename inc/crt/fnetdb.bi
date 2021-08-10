











	ai_addr as sockaddr ptr
	ai_addrlen as socklen_t
	ai_canonname as zstring ptr
	ai_family as long
	ai_flags as long
	ai_next as addrinfo ptr
	ai_protocol as long
	ai_socktype as long
	h_addr_list as zstring ptr ptr
	h_addrtype as long
	h_aliases as zstring ptr ptr
	h_length as long
	h_name as zstring ptr
	n_addrtype as long
	n_aliases as zstring ptr ptr
	n_name as zstring ptr
	n_net as ulong
	p_aliases as zstring ptr ptr
	p_name as zstring ptr
	p_proto as long
	s_aliases as zstring ptr ptr
	s_name as zstring ptr
	s_port as long
	s_proto as zstring ptr
#define AI_MASK ((((((AI_PASSIVE or AI_CANONNAME) or AI_NUMERICHOST) or AI_NUMERICSERV) or AI_ADDRCONFIG) or AI_ALL) or AI_V4MAPPED)
#define SCOPE_DELIMITER asc("%")
#define _NETDB_H_
#define _PATH_HEQUIV "/etc/hosts.equiv"
#define _PATH_HOSTS "/etc/hosts"
#define _PATH_NETWORKS "/etc/networks"
#define _PATH_PROTOCOLS "/etc/protocols"
#define _PATH_SERVICES "/etc/services"
#define _PATH_SERVICES_DB "/var/db/services.db"
#define h_addr h_addr_list[0]
#define h_errno (*__h_errno())
#include once "sys/_types.bi"
#include once "sys/cdefs.bi"
#pragma once
AI_ADDRCONFIG = &h00000400
AI_ALL = &h00000100
AI_CANONNAME = &h00000002
AI_DEFAULT = AI_V4MAPPED_CFG or AI_ADDRCONFIG
AI_NUMERICHOST = &h00000004
AI_NUMERICSERV = &h00000008
AI_PASSIVE = &h00000001
AI_V4MAPPED = &h00000800
AI_V4MAPPED_CFG = &h00000200
EAI_AGAIN = 2
EAI_BADFLAGS = 3
EAI_BADHINTS = 12
EAI_FAIL = 4
EAI_FAMILY = 5
EAI_MAX = 15
EAI_MEMORY = 6
EAI_NONAME = 8
EAI_OVERFLOW = 14
EAI_PROTOCOL = 13
EAI_SERVICE = 9
EAI_SOCKTYPE = 10
EAI_SYSTEM = 11
HOST_NOT_FOUND = 1
IPPORT_RESERVED = 1024
NETDB_INTERNAL = -1
NETDB_SUCCESS = 0
NI_DGRAM = &h00000010
NI_MAXHOST = 1025
NI_MAXSERV = 32
NI_NAMEREQD = &h00000004
NI_NOFQDN = &h00000001
NI_NUMERICHOST = &h00000002
NI_NUMERICSERV = &h00000008
NO_ADDRESS = NO_DATA
NO_DATA = 4
NO_RECOVERY = 3
TRY_AGAIN = 2
declare function __h_errno() as long ptr
declare function gai_strerror(byval as long) as zstring ptr
declare function getaddrinfo(byval as zstring ptr, byval as zstring ptr, byval as addrinfo ptr, byval as addrinfo ptr ptr) as long
declare function gethostbyaddr(byval as any ptr, byval as socklen_t, byval as long) as hostent ptr
declare function gethostbyaddr_r(byval as any ptr, byval as socklen_t, byval as long, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostbyname(byval as zstring ptr) as hostent ptr
declare function gethostbyname2(byval as zstring ptr, byval as long) as hostent ptr
declare function gethostbyname2_r(byval as zstring ptr, byval as long, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostbyname_r(byval as zstring ptr, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostent() as hostent ptr
declare function gethostent_r(byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function getipnodebyaddr(byval as any ptr, byval as uinteger, byval as long, byval as long ptr) as hostent ptr
declare function getipnodebyname(byval as zstring ptr, byval as long, byval as long, byval as long ptr) as hostent ptr
declare function getnameinfo(byval as sockaddr ptr, byval as socklen_t, byval as zstring ptr, byval as uinteger, byval as zstring ptr, byval as uinteger, byval as long) as long
declare function getnetbyaddr(byval as ulong, byval as long) as netent ptr
declare function getnetbyaddr_r(byval as ulong, byval as long, byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetbyname(byval as zstring ptr) as netent ptr
declare function getnetbyname_r(byval as zstring ptr, byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetent() as netent ptr
declare function getnetent_r(byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetgrent(byval as zstring ptr ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as long
declare function getnetgrent_r(byval as zstring ptr ptr, byval as zstring ptr ptr, byval as zstring ptr ptr, byval as zstring ptr, byval as uinteger) as long
declare function getprotobyname(byval as zstring ptr) as protoent ptr
declare function getprotobyname_r(byval as zstring ptr, byval as protoent ptr, byval as zstring ptr, byval as uinteger, byval as protoent ptr ptr) as long
declare function getprotobynumber(byval as long) as protoent ptr
declare function getprotobynumber_r(byval as long, byval as protoent ptr, byval as zstring ptr, byval as uinteger, byval as protoent ptr ptr) as long
declare function getprotoent() as protoent ptr
declare function getprotoent_r(byval as protoent ptr, byval as zstring ptr, byval as uinteger, byval as protoent ptr ptr) as long
declare function getservbyname(byval as zstring ptr, byval as zstring ptr) as servent ptr
declare function getservbyname_r(byval as zstring ptr, byval as zstring ptr, byval as servent ptr, byval as zstring ptr, byval as uinteger, byval as servent ptr ptr) as long
declare function getservbyport(byval as long, byval as zstring ptr) as servent ptr
declare function getservbyport_r(byval as long, byval as zstring ptr, byval as servent ptr, byval as zstring ptr, byval as uinteger, byval as servent ptr ptr) as long
declare function getservent() as servent ptr
declare function getservent_r(byval as servent ptr, byval as zstring ptr, byval as uinteger, byval as servent ptr ptr) as long
declare function hstrerror(byval as long) as zstring ptr
declare function innetgr(byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as long
declare sub endhostent()
declare sub endnetent()
declare sub endnetgrent()
declare sub endprotoent()
declare sub endservent()
declare sub freeaddrinfo(byval as addrinfo ptr)
declare sub freehostent(byval as hostent ptr)
declare sub herror(byval as zstring ptr)
declare sub sethostent(byval as long)
declare sub setnetent(byval as long)
declare sub setnetgrent(byval as zstring ptr)
declare sub setprotoent(byval as long)
declare sub setservent(byval as long)
end extern
end type
end type
end type
end type
end type
extern "C"
type addrinfo
type hostent
type netent
type protoent
type servent
type socklen_t as __socklen_t
