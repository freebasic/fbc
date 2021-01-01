'' FreeBASIC binding for SDL2_net-2.0.1
''
'' based on the C header files:
''   SDL_net:  An example cross-platform network library for use with SDL
''   Copyright (C) 1997-2016 Sam Lantinga <slouken@libsdl.org>
''   Copyright (C) 2012 Simeon Maxein <smaxein@googlemail.com>
''
''   This software is provided 'as-is', without any express or implied
''   warranty.  In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''   1. The origin of this software must not be misrepresented; you must not
''      claim that you wrote the original software. If you use this software
''      in a product, an acknowledgment in the product documentation would be
''      appreciated but is not required.
''   2. Altered source versions must be plainly marked as such, and must not be
''      misrepresented as being the original software.
''   3. This notice may not be removed or altered from any source distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "SDL2_net"

#include once "SDL.bi"

extern "C"

#define _SDL_NET_H
type SDLNet_version as SDL_version
const SDL_NET_MAJOR_VERSION = 2
const SDL_NET_MINOR_VERSION = 0
const SDL_NET_PATCHLEVEL = 1
#macro SDL_NET_VERSION(X)
	scope
		(X)->major = SDL_NET_MAJOR_VERSION
		(X)->minor = SDL_NET_MINOR_VERSION
		(X)->patch = SDL_NET_PATCHLEVEL
	end scope
#endmacro

declare function SDLNet_Linked_Version() as const SDLNet_version ptr
declare function SDLNet_Init() as long
declare sub SDLNet_Quit()

type IPaddress
	host as Uint32
	port as Uint16
end type

const INADDR_ANY = &h00000000
const INADDR_NONE = &hFFFFFFFF
const INADDR_LOOPBACK = &h7f000001
const INADDR_BROADCAST = &hFFFFFFFF

declare function SDLNet_ResolveHost(byval address as IPaddress ptr, byval host as const zstring ptr, byval port as Uint16) as long
declare function SDLNet_ResolveIP(byval ip as const IPaddress ptr) as const zstring ptr
declare function SDLNet_GetLocalAddresses(byval addresses as IPaddress ptr, byval maxcount as long) as long
type TCPsocket as _TCPsocket ptr
declare function SDLNet_TCP_Open(byval ip as IPaddress ptr) as TCPsocket
declare function SDLNet_TCP_Accept(byval server as TCPsocket) as TCPsocket
declare function SDLNet_TCP_GetPeerAddress(byval sock as TCPsocket) as IPaddress ptr
declare function SDLNet_TCP_Send(byval sock as TCPsocket, byval data as const any ptr, byval len as long) as long
declare function SDLNet_TCP_Recv(byval sock as TCPsocket, byval data as any ptr, byval maxlen as long) as long
declare sub SDLNet_TCP_Close(byval sock as TCPsocket)
const SDLNET_MAX_UDPCHANNELS = 32
const SDLNET_MAX_UDPADDRESSES = 4
type UDPsocket as _UDPsocket ptr

type UDPpacket
	channel as long
	data as Uint8 ptr
	len as long
	maxlen as long
	status as long
	address as IPaddress
end type

declare function SDLNet_AllocPacket(byval size as long) as UDPpacket ptr
declare function SDLNet_ResizePacket(byval packet as UDPpacket ptr, byval newsize as long) as long
declare sub SDLNet_FreePacket(byval packet as UDPpacket ptr)
declare function SDLNet_AllocPacketV(byval howmany as long, byval size as long) as UDPpacket ptr ptr
declare sub SDLNet_FreePacketV(byval packetV as UDPpacket ptr ptr)
declare function SDLNet_UDP_Open(byval port as Uint16) as UDPsocket
declare sub SDLNet_UDP_SetPacketLoss(byval sock as UDPsocket, byval percent as long)
declare function SDLNet_UDP_Bind(byval sock as UDPsocket, byval channel as long, byval address as const IPaddress ptr) as long
declare sub SDLNet_UDP_Unbind(byval sock as UDPsocket, byval channel as long)
declare function SDLNet_UDP_GetPeerAddress(byval sock as UDPsocket, byval channel as long) as IPaddress ptr
declare function SDLNet_UDP_SendV(byval sock as UDPsocket, byval packets as UDPpacket ptr ptr, byval npackets as long) as long
declare function SDLNet_UDP_Send(byval sock as UDPsocket, byval channel as long, byval packet as UDPpacket ptr) as long
declare function SDLNet_UDP_RecvV(byval sock as UDPsocket, byval packets as UDPpacket ptr ptr) as long
declare function SDLNet_UDP_Recv(byval sock as UDPsocket, byval packet as UDPpacket ptr) as long
declare sub SDLNet_UDP_Close(byval sock as UDPsocket)
type SDLNet_SocketSet as _SDLNet_SocketSet ptr

type _SDLNet_GenericSocket
	ready as long
end type

type SDLNet_GenericSocket as _SDLNet_GenericSocket ptr
declare function SDLNet_AllocSocketSet(byval maxsockets as long) as SDLNet_SocketSet
declare function SDLNet_AddSocket(byval set as SDLNet_SocketSet, byval sock as SDLNet_GenericSocket) as long
#define SDLNet_TCP_AddSocket(set, sock) clng(SDLNet_AddSocket((set), cast(SDLNet_GenericSocket, (sock))))
#define SDLNet_UDP_AddSocket(set, sock) clng(SDLNet_AddSocket((set), cast(SDLNet_GenericSocket, (sock))))
declare function SDLNet_DelSocket(byval set as SDLNet_SocketSet, byval sock as SDLNet_GenericSocket) as long
#define SDLNet_TCP_DelSocket(set, sock) clng(SDLNet_DelSocket((set), cast(SDLNet_GenericSocket, (sock))))
#define SDLNet_UDP_DelSocket(set, sock) clng(SDLNet_DelSocket((set), cast(SDLNet_GenericSocket, (sock))))
declare function SDLNet_CheckSockets(byval set as SDLNet_SocketSet, byval timeout as Uint32) as long
#define SDLNet_SocketReady(sock) _SDLNet_SocketReady(cast(SDLNet_GenericSocket, (sock)))

private function _SDLNet_SocketReady(byval sock as SDLNet_GenericSocket) as long
	return -((sock <> cptr(any ptr, 0)) andalso sock->ready)
end function

declare sub SDLNet_FreeSocketSet(byval set as SDLNet_SocketSet)
declare sub SDLNet_SetError(byval fmt as const zstring ptr, ...)
declare function SDLNet_GetError() as const zstring ptr

#if (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	const SDL_DATA_ALIGNED = 1
#else
	const SDL_DATA_ALIGNED = 0
#endif

#define SDLNet_Write16(value, areap) _SDLNet_Write16(value, areap)
#define SDLNet_Write32(value, areap) _SDLNet_Write32(value, areap)
#define SDLNet_Read16(areap) _SDLNet_Read16(areap)
#define SDLNet_Read32(areap) _SDLNet_Read32(areap)

#if (not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))
	private sub _SDLNet_Write16(byval value as Uint16, byval areap as any ptr)
		dim area as Uint8 ptr = cptr(Uint8 ptr, areap)
		area[0] = (value shr 8) and &hFF
		area[1] = value and &hFF
	end sub

	private sub _SDLNet_Write32(byval value as Uint32, byval areap as any ptr)
		dim area as Uint8 ptr = cptr(Uint8 ptr, areap)
		area[0] = (value shr 24) and &hFF
		area[1] = (value shr 16) and &hFF
		area[2] = (value shr 8) and &hFF
		area[3] = value and &hFF
	end sub

	private function _SDLNet_Read16(byval areap as any ptr) as Uint16
		dim area as Uint8 ptr = cptr(Uint8 ptr, areap)
		return (cast(Uint16, area[0]) shl 8) or cast(Uint16, area[1])
	end function

	private function _SDLNet_Read32(byval areap as const any ptr) as Uint32
		dim area as const Uint8 ptr = cptr(const Uint8 ptr, areap)
		return (((cast(Uint32, area[0]) shl 24) or (cast(Uint32, area[1]) shl 16)) or (cast(Uint32, area[2]) shl 8)) or cast(Uint32, area[3])
	end function
#else
	#define _SDLNet_Write16(value, areap) scope : *cptr(Uint16 ptr, areap) = SDL_Swap16(value) : end scope
	#define _SDLNet_Write32(value, areap) scope : *cptr(Uint32 ptr, areap) = SDL_Swap32(value) : end scope
	#define _SDLNet_Read16(areap) cast(Uint16, SDL_Swap16(*cptr(const Uint16 ptr, (areap))))
	#define _SDLNet_Read32(areap) cast(Uint32, SDL_Swap32(*cptr(const Uint32 ptr, (areap))))
#endif

end extern
