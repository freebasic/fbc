















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
	n_net as uint32_t
	p_aliases as zstring ptr ptr
	p_name as zstring ptr
	p_proto as long
	s_aliases as zstring ptr ptr
	s_name as zstring ptr
	s_port as long
	s_proto as zstring ptr
#define EAI_ADDRFAMILY -9
#define EAI_AGAIN -3
#define EAI_BADFLAGS -1
#define EAI_FAIL -4
#define EAI_FAMILY -6
#define EAI_MEMORY -10
#define EAI_NODATA -5
#define EAI_NONAME -2
#define EAI_OVERFLOW -12
#define EAI_SERVICE -8
#define EAI_SOCKTYPE -7
#define EAI_SYSTEM -11
#define HOST_NOT_FOUND 1
#define NETDB_INTERNAL -1
#define NETDB_SUCCESS 0
#define NI_DGRAM 16
#define NI_MAXHOST 1025
#define NI_MAXSERV 32
#define NI_NAMEREQD 8
#define NI_NOFQDN 4
#define NI_NUMERICHOST 1
#define NI_NUMERICSERV 2
#define NO_ADDRESS 4
#define NO_DATA 4
#define NO_RECOVERY 3
#define SCOPE_DELIMITER asc( "%" )
#define TRY_AGAIN 2
#define _PATH_HEQUIV "/etc/hosts.equiv"
#define _PATH_HOSTS "/etc/hosts"
#define _PATH_NETWORKS "/etc/networks"
#define _PATH_NSSWITCH_CONF "/etc/nsswitch.conf"
#define _PATH_PROTOCOLS "/etc/protocols"
#define _PATH_SERVICES "/etc/services"
#define __crt_linux_netdb_bi__
#define h_errno *__h_errno_location()
#endif
#ifndef __crt_linux_netdb_bi__
#include once "crt/netinet/in.bi"
#include once "crt/stdint.bi"
''
''
''
''
''
''         be included in other distributions without authorization.
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
'' bits\netdb -- header translated with help of SWIG FB wrapper
const AI_ADDRCONFIG = &h0020
const AI_ALL = &h0010
const AI_CANONNAME = &h0002
const AI_NUMERICHOST = &h0004
const AI_NUMERICSERV = &h0400
const AI_PASSIVE = &h0001
const AI_V4MAPPED = &h0008
declare function __h_errno_location() as long ptr
declare function gai_strerror(byval as long) as zstring ptr
declare function getaddrinfo(byval as zstring ptr, byval as zstring ptr, byval as addrinfo ptr, byval as addrinfo ptr ptr) as long
declare function gethostbyaddr(byval as any ptr, byval as __socklen_t, byval as long) as hostent ptr
declare function gethostbyaddr_r(byval as any ptr, byval as __socklen_t, byval as long, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostbyname(byval as zstring ptr) as hostent ptr
declare function gethostbyname2(byval as zstring ptr, byval as long) as hostent ptr
declare function gethostbyname2_r(byval as zstring ptr, byval as long, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostbyname_r(byval as zstring ptr, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostent() as hostent ptr
declare function gethostent_r(byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function getnameinfo(byval as sockaddr ptr, byval as socklen_t, byval as zstring ptr, byval as socklen_t, byval as zstring ptr, byval as socklen_t, byval as long) as long
declare function getnetbyaddr(byval as uint32_t, byval as long) as netent ptr
declare function getnetbyaddr_r(byval as uint32_t, byval as long, byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetbyname(byval as zstring ptr) as netent ptr
declare function getnetbyname_r(byval as zstring ptr, byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetent() as netent ptr
declare function getnetent_r(byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetgrent(byval as byte ptr ptr, byval as byte ptr ptr, byval as byte ptr ptr) as long
declare function getnetgrent_r(byval as byte ptr ptr, byval as byte ptr ptr, byval as byte ptr ptr, byval as zstring ptr, byval as uinteger) as long
declare function getprotobyname(byval as zstring ptr) as protoent ptr
declare function getprotobyname_r(byval as zstring ptr, byval as protoent ptr, byval as zstring ptr, byval as uinteger, byval as protoent ptr ptr) as long
declare function getprotobynumber(byval as integer) as protoent ptr
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
declare function rcmd(byval as byte ptr ptr, byval as ushort, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval2p as long ptr) as long
declare function rcmd_af(byval as byte ptr ptr, byval as ushort, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval2p as long ptr, byval as sa_family_t) as long
declare function rexec(byval as byte ptr ptr, byval as long, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval2p as long ptr) as long
declare function rexec_af(byval as byte ptr ptr, byval as long, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval2p as long ptr, byval as sa_family_t) as long
declare function rresvport(byval as long ptr) as long
declare function rresvport_af(byval as long ptr, byval as sa_family_t) as long
declare function ruserok(byval as zstring ptr, byval as long, byval as zstring ptr, byval as zstring ptr) as long
declare function ruserok_af(byval as zstring ptr, byval as long, byval as zstring ptr, byval as zstring ptr, byval as sa_family_t) as long
declare function setnetgrent(byval as zstring ptr) as long
declare sub endhostent()
declare sub endnetent()
declare sub endnetgrent()
declare sub endprotoent()
declare sub endservent()
declare sub freeaddrinfo(byval as addrinfo ptr)
declare sub herror(byval as zstring ptr)
declare sub sethostent(byval as long)
declare sub setnetent(byval as long)
declare sub setprotoent(byval as long)
declare sub setservent(byval as long)
end extern
end type
end type
end type
end type
end type
extern "c"
type addrinfo
type hostent
type netent
type protoent
type servent
