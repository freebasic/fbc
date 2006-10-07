''
''
'' netdb -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_netdb_bi__
#define __crt_netdb_bi__

#include once "crt/netinet/in.bi"
#include once "crt/stdint.bi"

#if defined(__FB_LINUX__)
#include once "crt/linux/netdb.bi"
#else
#error Unsupported platform
#endif

#define _PATH_HEQUIV "/etc/hosts.equiv"
#define _PATH_HOSTS "/etc/hosts"
#define _PATH_NETWORKS "/etc/networks"
#define _PATH_NSSWITCH_CONF "/etc/nsswitch.conf"
#define _PATH_PROTOCOLS "/etc/protocols"
#define _PATH_SERVICES "/etc/services"

#define h_errno *__h_errno_location()
declare function __h_errno_location cdecl alias "__h_errno_location" () as integer ptr

#define NETDB_INTERNAL -1
#define NETDB_SUCCESS 0
#define HOST_NOT_FOUND 1
#define TRY_AGAIN 2
#define NO_RECOVERY 3
#define NO_DATA 4
#define NO_ADDRESS 4
#define SCOPE_DELIMITER asc( "%" )

declare sub herror cdecl alias "herror" (byval __str as zstring ptr)
declare function hstrerror cdecl alias "hstrerror" (byval __err_num as integer) as zstring ptr

type hostent
	h_name as zstring ptr
	h_aliases as zstring ptr ptr
	h_addrtype as integer
	h_length as integer
	h_addr_list as zstring ptr ptr
end type

declare sub sethostent cdecl alias "sethostent" (byval __stay_open as integer)
declare sub endhostent cdecl alias "endhostent" ()
declare function gethostent cdecl alias "gethostent" () as hostent ptr
declare function gethostbyaddr cdecl alias "gethostbyaddr" (byval __addr as any ptr, byval __len as __socklen_t, byval __type as integer) as hostent ptr
declare function gethostbyname cdecl alias "gethostbyname" (byval __name as zstring ptr) as hostent ptr
declare function gethostbyname2 cdecl alias "gethostbyname2" (byval __name as zstring ptr, byval __af as integer) as hostent ptr
declare function gethostent_r cdecl alias "gethostent_r" (byval __result_buf as hostent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as hostent ptr ptr, byval __h_errnop as integer ptr) as integer
declare function gethostbyaddr_r cdecl alias "gethostbyaddr_r" (byval __addr as any ptr, byval __len as __socklen_t, byval __type as integer, byval __result_buf as hostent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as hostent ptr ptr, byval __h_errnop as integer ptr) as integer
declare function gethostbyname_r cdecl alias "gethostbyname_r" (byval __name as zstring ptr, byval __result_buf as hostent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as hostent ptr ptr, byval __h_errnop as integer ptr) as integer
declare function gethostbyname2_r cdecl alias "gethostbyname2_r" (byval __name as zstring ptr, byval __af as integer, byval __result_buf as hostent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as hostent ptr ptr, byval __h_errnop as integer ptr) as integer
declare sub setnetent cdecl alias "setnetent" (byval __stay_open as integer)
declare sub endnetent cdecl alias "endnetent" ()
declare function getnetent cdecl alias "getnetent" () as netent ptr
declare function getnetbyaddr cdecl alias "getnetbyaddr" (byval __net as uint32_t, byval __type as integer) as netent ptr
declare function getnetbyname cdecl alias "getnetbyname" (byval __name as zstring ptr) as netent ptr
declare function getnetent_r cdecl alias "getnetent_r" (byval __result_buf as netent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as netent ptr ptr, byval __h_errnop as integer ptr) as integer
declare function getnetbyaddr_r cdecl alias "getnetbyaddr_r" (byval __net as uint32_t, byval __type as integer, byval __result_buf as netent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as netent ptr ptr, byval __h_errnop as integer ptr) as integer
declare function getnetbyname_r cdecl alias "getnetbyname_r" (byval __name as zstring ptr, byval __result_buf as netent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as netent ptr ptr, byval __h_errnop as integer ptr) as integer

type servent
	s_name as zstring ptr
	s_aliases as zstring ptr ptr
	s_port as integer
	s_proto as zstring ptr
end type

declare sub setservent cdecl alias "setservent" (byval __stay_open as integer)
declare sub endservent cdecl alias "endservent" ()
declare function getservent cdecl alias "getservent" () as servent ptr
declare function getservbyname cdecl alias "getservbyname" (byval __name as zstring ptr, byval __proto as zstring ptr) as servent ptr
declare function getservbyport cdecl alias "getservbyport" (byval __port as integer, byval __proto as zstring ptr) as servent ptr
declare function getservent_r cdecl alias "getservent_r" (byval __result_buf as servent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as servent ptr ptr) as integer
declare function getservbyname_r cdecl alias "getservbyname_r" (byval __name as zstring ptr, byval __proto as zstring ptr, byval __result_buf as servent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as servent ptr ptr) as integer
declare function getservbyport_r cdecl alias "getservbyport_r" (byval __port as integer, byval __proto as zstring ptr, byval __result_buf as servent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as servent ptr ptr) as integer

type protoent
	p_name as zstring ptr
	p_aliases as zstring ptr ptr
	p_proto as integer
end type

declare sub setprotoent cdecl alias "setprotoent" (byval __stay_open as integer)
declare sub endprotoent cdecl alias "endprotoent" ()
declare function getprotoent cdecl alias "getprotoent" () as protoent ptr
declare function getprotobyname cdecl alias "getprotobyname" (byval __name as zstring ptr) as protoent ptr
declare function getprotobynumber cdecl alias "getprotobynumber" (byval __proto as integer) as protoent ptr
declare function getprotoent_r cdecl alias "getprotoent_r" (byval __result_buf as protoent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as protoent ptr ptr) as integer
declare function getprotobyname_r cdecl alias "getprotobyname_r" (byval __name as zstring ptr, byval __result_buf as protoent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as protoent ptr ptr) as integer
declare function getprotobynumber_r cdecl alias "getprotobynumber_r" (byval __proto as integer, byval __result_buf as protoent ptr, byval __buf as zstring ptr, byval __buflen as size_t, byval __result as protoent ptr ptr) as integer
declare function setnetgrent cdecl alias "setnetgrent" (byval __netgroup as zstring ptr) as integer
declare sub endnetgrent cdecl alias "endnetgrent" ()
declare function getnetgrent cdecl alias "getnetgrent" (byval __hostp as byte ptr ptr, byval __userp as byte ptr ptr, byval __domainp as byte ptr ptr) as integer
declare function innetgr cdecl alias "innetgr" (byval __netgroup as zstring ptr, byval __host as zstring ptr, byval __user as zstring ptr, byval domain as zstring ptr) as integer
declare function getnetgrent_r cdecl alias "getnetgrent_r" (byval __hostp as byte ptr ptr, byval __userp as byte ptr ptr, byval __domainp as byte ptr ptr, byval __buffer as zstring ptr, byval __buflen as size_t) as integer
declare function rcmd cdecl alias "rcmd" (byval __ahost as byte ptr ptr, byval __rport as ushort, byval __locuser as zstring ptr, byval __remuser as zstring ptr, byval __cmd as zstring ptr, byval __fd2p as integer ptr) as integer
declare function rcmd_af cdecl alias "rcmd_af" (byval __ahost as byte ptr ptr, byval __rport as ushort, byval __locuser as zstring ptr, byval __remuser as zstring ptr, byval __cmd as zstring ptr, byval __fd2p as integer ptr, byval __af as sa_family_t) as integer
declare function rexec cdecl alias "rexec" (byval __ahost as byte ptr ptr, byval __rport as integer, byval __name as zstring ptr, byval __pass as zstring ptr, byval __cmd as zstring ptr, byval __fd2p as integer ptr) as integer
declare function rexec_af cdecl alias "rexec_af" (byval __ahost as byte ptr ptr, byval __rport as integer, byval __name as zstring ptr, byval __pass as zstring ptr, byval __cmd as zstring ptr, byval __fd2p as integer ptr, byval __af as sa_family_t) as integer
declare function ruserok cdecl alias "ruserok" (byval __rhost as zstring ptr, byval __suser as integer, byval __remuser as zstring ptr, byval __locuser as zstring ptr) as integer
declare function ruserok_af cdecl alias "ruserok_af" (byval __rhost as zstring ptr, byval __suser as integer, byval __remuser as zstring ptr, byval __locuser as zstring ptr, byval __af as sa_family_t) as integer
declare function rresvport cdecl alias "rresvport" (byval __alport as integer ptr) as integer
declare function rresvport_af cdecl alias "rresvport_af" (byval __alport as integer ptr, byval __af as sa_family_t) as integer

type addrinfo
	ai_flags as integer
	ai_family as integer
	ai_socktype as integer
	ai_protocol as integer
	ai_addrlen as socklen_t
	ai_addr as sockaddr ptr
	ai_canonname as zstring ptr
	ai_next as addrinfo ptr
end type

#define AI_PASSIVE &h0001
#define AI_CANONNAME &h0002
#define AI_NUMERICHOST &h0004
#define AI_V4MAPPED &h0008
#define AI_ALL &h0010
#define AI_ADDRCONFIG &h0020
#define AI_NUMERICSERV &h0400
#define EAI_BADFLAGS -1
#define EAI_NONAME -2
#define EAI_AGAIN -3
#define EAI_FAIL -4
#define EAI_NODATA -5
#define EAI_FAMILY -6
#define EAI_SOCKTYPE -7
#define EAI_SERVICE -8
#define EAI_ADDRFAMILY -9
#define EAI_MEMORY -10
#define EAI_SYSTEM -11
#define EAI_OVERFLOW -12
#define NI_MAXHOST 1025
#define NI_MAXSERV 32
#define NI_NUMERICHOST 1
#define NI_NUMERICSERV 2
#define NI_NOFQDN 4
#define NI_NAMEREQD 8
#define NI_DGRAM 16

declare function getaddrinfo cdecl alias "getaddrinfo" (byval __name as zstring ptr, byval __service as zstring ptr, byval __req as addrinfo ptr, byval __pai as addrinfo ptr ptr) as integer
declare sub freeaddrinfo cdecl alias "freeaddrinfo" (byval __ai as addrinfo ptr)
declare function gai_strerror cdecl alias "gai_strerror" (byval __ecode as integer) as zstring ptr
declare function getnameinfo cdecl alias "getnameinfo" (byval __sa as sockaddr ptr, byval __salen as socklen_t, byval __host as zstring ptr, byval __hostlen as socklen_t, byval __serv as zstring ptr, byval __servlen as socklen_t, byval __flags as uinteger) as integer

#endif
