#pragma once

#define _WSIPX_

type sockaddr_ipx
	sa_family as short
	sa_netnum as zstring * 4
	sa_nodenum as zstring * 6
	sa_socket as ushort
end type

type PSOCKADDR_IPX as sockaddr_ipx ptr
type LPSOCKADDR_IPX as sockaddr_ipx ptr

#define NSPROTO_IPX 1000
#define NSPROTO_SPX 1256
#define NSPROTO_SPXII 1257
