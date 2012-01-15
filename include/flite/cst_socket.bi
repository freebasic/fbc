''
''
'' cst_socket -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_socket_bi__
#define __cst_socket_bi__

declare function cst_socket_open cdecl alias "cst_socket_open" (byval host as zstring ptr, byval port as integer) as integer
declare function cst_socket_close cdecl alias "cst_socket_close" (byval socket as integer) as integer
declare function cst_socket_server cdecl alias "cst_socket_server" (byval name as zstring ptr, byval port as integer, byval as function cdecl(byval as process_client) as integer) as integer

#endif
