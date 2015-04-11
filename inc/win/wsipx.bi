'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#define _WSIPX_

type SOCKADDR_IPX
	sa_family as short
	sa_netnum as zstring * 4
	sa_nodenum as zstring * 6
	sa_socket as ushort
end type

type PSOCKADDR_IPX as SOCKADDR_IPX ptr
type LPSOCKADDR_IPX as SOCKADDR_IPX ptr
const NSPROTO_IPX = 1000
const NSPROTO_SPX = 1256
const NSPROTO_SPXII = 1257
