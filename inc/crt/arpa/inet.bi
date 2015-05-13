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

extern "C"

declare function inet_addr (byval __cp as zstring ptr) as in_addr_t
declare function inet_lnaof (byval __in as in_addr) as in_addr_t
declare function inet_makeaddr (byval __net as in_addr_t, byval __host as in_addr_t) as in_addr
declare function inet_netof (byval __in as in_addr) as in_addr_t
declare function inet_network (byval __cp as zstring ptr) as in_addr_t
declare function inet_ntoa (byval __in as in_addr) as zstring ptr
declare function inet_pton (byval __af as long, byval __cp as zstring ptr, byval __buf as any ptr) as long
declare function inet_ntop (byval __af as long, byval __cp as any ptr, byval __buf as zstring ptr, byval __len as socklen_t) as zstring ptr
declare function inet_aton (byval __cp as zstring ptr, byval __inp as in_addr ptr) as long
declare function inet_neta (byval __net as in_addr_t, byval __buf as zstring ptr, byval __len as size_t) as zstring ptr
declare function inet_net_ntop (byval __af as long, byval __cp as any ptr, byval __bits as long, byval __buf as zstring ptr, byval __len as size_t) as zstring ptr
declare function inet_net_pton (byval __af as long, byval __cp as zstring ptr, byval __buf as any ptr, byval __len as size_t) as long
declare function inet_nsap_addr (byval __cp as zstring ptr, byval __buf as ubyte ptr, byval __len as long) as ulong
declare function inet_nsap_ntoa (byval __len as long, byval __cp as ubyte ptr, byval __buf as zstring ptr) as zstring ptr

end extern

#endif
