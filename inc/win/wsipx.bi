'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
