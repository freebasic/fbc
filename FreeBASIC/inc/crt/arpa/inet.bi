''
''
'' arpa\inet -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_arpa_inet_bi__
#define __crt_arpa_inet_bi__

#define _ARPA_INET_H 1

#include once "crt/netinet/in.bi"

#ifndef socklen_t
type socklen_t as __socklen_t
#endif

declare function inet_addr cdecl alias "inet_addr" (byval __cp as zstring ptr) as in_addr_t
declare function inet_lnaof cdecl alias "inet_lnaof" (byval __in as in_addr) as in_addr_t
declare function inet_makeaddr cdecl alias "inet_makeaddr" (byval __net as in_addr_t, byval __host as in_addr_t) as in_addr
declare function inet_netof cdecl alias "inet_netof" (byval __in as in_addr) as in_addr_t
declare function inet_network cdecl alias "inet_network" (byval __cp as zstring ptr) as in_addr_t
declare function inet_ntoa cdecl alias "inet_ntoa" (byval __in as in_addr) as zstring ptr
declare function inet_pton cdecl alias "inet_pton" (byval __af as integer, byval __cp as zstring ptr, byval __buf as any ptr) as integer
declare function inet_ntop cdecl alias "inet_ntop" (byval __af as integer, byval __cp as any ptr, byval __buf as zstring ptr, byval __len as socklen_t) as zstring ptr
declare function inet_aton cdecl alias "inet_aton" (byval __cp as zstring ptr, byval __inp as in_addr ptr) as integer
declare function inet_neta cdecl alias "inet_neta" (byval __net as in_addr_t, byval __buf as zstring ptr, byval __len as size_t) as zstring ptr
declare function inet_net_ntop cdecl alias "inet_net_ntop" (byval __af as integer, byval __cp as any ptr, byval __bits as integer, byval __buf as zstring ptr, byval __len as size_t) as zstring ptr
declare function inet_net_pton cdecl alias "inet_net_pton" (byval __af as integer, byval __cp as zstring ptr, byval __buf as any ptr, byval __len as size_t) as integer
declare function inet_nsap_addr cdecl alias "inet_nsap_addr" (byval __cp as zstring ptr, byval __buf as ubyte ptr, byval __len as integer) as uinteger
declare function inet_nsap_ntoa cdecl alias "inet_nsap_ntoa" (byval __len as integer, byval __cp as ubyte ptr, byval __buf as zstring ptr) as zstring ptr

#endif
