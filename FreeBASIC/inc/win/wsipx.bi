''
''
'' wsipx -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_wsipx_bi__
#define __win_wsipx_bi__

#define NSPROTO_IPX 1000
#define NSPROTO_SPX 1256
#define NSPROTO_SPXII 1257

type SOCKADDR_IPX
	sa_family as short
	sa_netnum as zstring * 4
	sa_nodenum as zstring * 6
	sa_socket as ushort
end type

type PSOCKADDR_IPX as SOCKADDR_IPX ptr
type LPSOCKADDR_IPX as SOCKADDR_IPX ptr

#endif
