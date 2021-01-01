'' FreeBASIC binding for SDL_net-1.2.8
''
'' based on the C header files:
''   SDL_net:  An example cross-platform network library for use with SDL
''   Copyright (C) 1997-2012 Sam Lantinga <slouken@libsdl.org>
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

#inclib "SDL_net"

#ifdef __FB_WIN32__
	#inclib "ws2_32"
	#inclib "iphlpapi"
#endif

#include once "SDL.bi"

'' The following symbols have been renamed:
''     procedure SDLNet_Write16 => SDLNet_Write16_
''     procedure SDLNet_Write32 => SDLNet_Write32_
''     procedure SDLNet_Read16 => SDLNet_Read16_
''     procedure SDLNet_Read32 => SDLNet_Read32_

extern "C"

#define _SDL_NET_H
const SDL_NET_MAJOR_VERSION = 1
const SDL_NET_MINOR_VERSION = 2
const SDL_NET_PATCHLEVEL = 8
#macro SDL_NET_VERSION(X)
	scope
		(X)->major = SDL_NET_MAJOR_VERSION
		(X)->minor = SDL_NET_MINOR_VERSION
		(X)->patch = SDL_NET_PATCHLEVEL
	end scope
#endmacro

declare function SDLNet_Linked_Version() as const SDL_version ptr
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
#define SDLNet_TCP_AddSocket(set, sock) SDLNet_AddSocket(set, SDL_reinterpret_cast(SDLNet_GenericSocket, sock))
#define SDLNet_UDP_AddSocket(set, sock) SDLNet_AddSocket(set, SDL_reinterpret_cast(SDLNet_GenericSocket, sock))
declare function SDLNet_AddSocket(byval set as SDLNet_SocketSet, byval sock as SDLNet_GenericSocket) as long
#define SDLNet_TCP_DelSocket(set, sock) SDLNet_DelSocket(set, SDL_reinterpret_cast(SDLNet_GenericSocket, sock))
#define SDLNet_UDP_DelSocket(set, sock) SDLNet_DelSocket(set, SDL_reinterpret_cast(SDLNet_GenericSocket, sock))
declare function SDLNet_DelSocket(byval set as SDLNet_SocketSet, byval sock as SDLNet_GenericSocket) as long
declare function SDLNet_CheckSockets(byval set as SDLNet_SocketSet, byval timeout as Uint32) as long
#define SDLNet_SocketReady(sock) ((sock <> NULL) andalso SDL_reinterpret_cast(SDLNet_GenericSocket, sock)->ready)
declare sub SDLNet_FreeSocketSet(byval set as SDLNet_SocketSet)
declare sub SDLNet_Write16_ alias "SDLNet_Write16"(byval value as Uint16, byval area as any ptr)
declare sub SDLNet_Write32_ alias "SDLNet_Write32"(byval value as Uint32, byval area as any ptr)
declare function SDLNet_Read16_ alias "SDLNet_Read16"(byval area as any ptr) as Uint16
declare function SDLNet_Read32_ alias "SDLNet_Read32"(byval area as any ptr) as Uint32
declare sub SDLNet_SetError alias "SDL_SetError"(byval fmt as const zstring ptr, ...)
declare function SDLNet_GetError alias "SDL_GetError"() as zstring ptr

const SDL_DATA_ALIGNED = 0
#define SDLNet_Write16(value, areap) scope : (*cptr(Uint16 ptr, areap)) = SDL_SwapBE16(value) : end scope
#define SDLNet_Write32(value, areap) scope : (*cptr(Uint32 ptr, areap)) = SDL_SwapBE32(value) : end scope
#define SDLNet_Read16(areap) SDL_SwapBE16(*cptr(Uint16 ptr, areap))
#define SDLNet_Read32(areap) SDL_SwapBE32(*cptr(Uint32 ptr, areap))

end extern
