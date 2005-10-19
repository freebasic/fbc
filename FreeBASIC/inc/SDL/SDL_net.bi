''
''
'' SDL_net -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_net_bi__
#define __SDL_net_bi__

#inclib "SDL_net"

#include once "SDL/SDL.bi"
#include once "SDL/SDL_endian.bi"
#include once "SDL/begin_code.bi"

declare function SDLNet_Init cdecl alias "SDLNet_Init" () as integer
declare sub SDLNet_Quit cdecl alias "SDLNet_Quit" ()

type IPaddress
	host as Uint32
	port as Uint16
end type

#ifndef INADDR_ANY
# define INADDR_ANY	&h00000000
#endif
#ifndef INADDR_NONE
# define INADDR_NONE &hFFFFFFFF
#endif
#ifndef INADDR_BROADCAST
# define INADDR_BROADCAST &hFFFFFFFF
#endif

declare function SDLNet_ResolveHost cdecl alias "SDLNet_ResolveHost" (byval address as IPaddress ptr, byval host as zstring ptr, byval port as Uint16) as integer
declare function SDLNet_ResolveIP cdecl alias "SDLNet_ResolveIP" (byval ip as IPaddress ptr) as zstring ptr

type TCPsocket as _TCPsocket ptr

declare function SDLNet_TCP_Open cdecl alias "SDLNet_TCP_Open" (byval ip as IPaddress ptr) as TCPsocket
declare function SDLNet_TCP_Accept cdecl alias "SDLNet_TCP_Accept" (byval server as TCPsocket) as TCPsocket
declare function SDLNet_TCP_GetPeerAddress cdecl alias "SDLNet_TCP_GetPeerAddress" (byval sock as TCPsocket) as IPaddress ptr
declare function SDLNet_TCP_Send cdecl alias "SDLNet_TCP_Send" (byval sock as TCPsocket, byval data as any ptr, byval len as integer) as integer
declare function SDLNet_TCP_Recv cdecl alias "SDLNet_TCP_Recv" (byval sock as TCPsocket, byval data as any ptr, byval maxlen as integer) as integer
declare sub SDLNet_TCP_Close cdecl alias "SDLNet_TCP_Close" (byval sock as TCPsocket)

#define SDLNET_MAX_UDPCHANNELS 32
#define SDLNET_MAX_UDPADDRESSES 4

type UDPsocket as _UDPsocket ptr

type UDPpacket
	channel as integer
	data as Uint8 ptr
	len as integer
	maxlen as integer
	status as integer
	address as IPaddress
end type

declare function SDLNet_AllocPacket cdecl alias "SDLNet_AllocPacket" (byval size as integer) as UDPpacket ptr
declare function SDLNet_ResizePacket cdecl alias "SDLNet_ResizePacket" (byval packet as UDPpacket ptr, byval newsize as integer) as integer
declare sub SDLNet_FreePacket cdecl alias "SDLNet_FreePacket" (byval packet as UDPpacket ptr)
declare function SDLNet_AllocPacketV cdecl alias "SDLNet_AllocPacketV" (byval howmany as integer, byval size as integer) as UDPpacket ptr ptr
declare sub SDLNet_FreePacketV cdecl alias "SDLNet_FreePacketV" (byval packetV as UDPpacket ptr ptr)
declare function SDLNet_UDP_Open cdecl alias "SDLNet_UDP_Open" (byval port as Uint16) as UDPsocket
declare function SDLNet_UDP_Bind cdecl alias "SDLNet_UDP_Bind" (byval sock as UDPsocket, byval channel as integer, byval address as IPaddress ptr) as integer
declare sub SDLNet_UDP_Unbind cdecl alias "SDLNet_UDP_Unbind" (byval sock as UDPsocket, byval channel as integer)
declare function SDLNet_UDP_GetPeerAddress cdecl alias "SDLNet_UDP_GetPeerAddress" (byval sock as UDPsocket, byval channel as integer) as IPaddress ptr
declare function SDLNet_UDP_SendV cdecl alias "SDLNet_UDP_SendV" (byval sock as UDPsocket, byval packets as UDPpacket ptr ptr, byval npackets as integer) as integer
declare function SDLNet_UDP_Send cdecl alias "SDLNet_UDP_Send" (byval sock as UDPsocket, byval channel as integer, byval packet as UDPpacket ptr) as integer
declare function SDLNet_UDP_RecvV cdecl alias "SDLNet_UDP_RecvV" (byval sock as UDPsocket, byval packets as UDPpacket ptr ptr) as integer
declare function SDLNet_UDP_Recv cdecl alias "SDLNet_UDP_Recv" (byval sock as UDPsocket, byval packet as UDPpacket ptr) as integer
declare sub SDLNet_UDP_Close cdecl alias "SDLNet_UDP_Close" (byval sock as UDPsocket)

type SDLNet_SocketSet as _SDLNet_SocketSet ptr

type SDLNet_TGenericSocket
	ready as integer
end type

type SDLNet_GenericSocket as SDLNet_TGenericSocket ptr

declare function SDLNet_AllocSocketSet cdecl alias "SDLNet_AllocSocketSet" (byval maxsockets as integer) as SDLNet_SocketSet
declare function SDLNet_AddSocket cdecl alias "SDLNet_AddSocket" (byval set as SDLNet_SocketSet, byval sock as SDLNet_GenericSocket) as integer
declare function SDLNet_DelSocket cdecl alias "SDLNet_DelSocket" (byval set as SDLNet_SocketSet, byval sock as SDLNet_GenericSocket) as integer
declare function SDLNet_CheckSockets cdecl alias "SDLNet_CheckSockets" (byval set as SDLNet_SocketSet, byval timeout as Uint32) as integer
declare sub SDLNet_FreeSocketSet cdecl alias "SDLNet_FreeSocketSet" (byval set as SDLNet_SocketSet)
declare sub SDLNet_Write16 cdecl alias "SDLNet_Write16" (byval value as Uint16, byval area as any ptr)
declare sub SDLNet_Write32 cdecl alias "SDLNet_Write32" (byval value as Uint32, byval area as any ptr)
declare function SDLNet_Read16 cdecl alias "SDLNet_Read16" (byval area as any ptr) as Uint16
declare function SDLNet_Read32 cdecl alias "SDLNet_Read32" (byval area as any ptr) as Uint32

#define SDLNet_TCP_AddSocket(set, sock) SDLNet_AddSocket(set, cptr(SDLNet_GenericSocket,sock))
#define SDLNet_UDP_AddSocket(set, sock) SDLNet_AddSocket(set, cptr(SDLNet_GenericSocket,sock))
#define SDLNet_TCP_DelSocket(set, sock) SDLNet_DelSocket(set, cptr(SDLNet_GenericSocket,sock))
#define SDLNet_UDP_DelSocket(set, sock) SDLNet_DelSocket(set, cptr(SDLNet_GenericSocket,sock))
#define SDLNet_SocketReady(sock) iif( sock <> NULL, cptr(SDLNet_GenericSocket, sock)->ready = 1, 0 )

#define SDLNet_SetError	SDL_SetError
#define SDLNet_GetError	SDL_GetError

#define SDL_DATA_ALIGNED 0

#include once "SDL/close_code.bi"

#endif
