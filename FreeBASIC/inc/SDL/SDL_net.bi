''
'' SDL_net header, to be included only with the FreeBASIC distribution
''
'' translated: jan/2005 by v1ctor (av1ctor[at]yahoo.com.br)
'' 

#ifndef SDLnet_h_
#define SDLnet_h_

#inclib "SDL"
#inclib "SDL_net"

#include once "SDL/SDL.bi"
#include once "SDL/SDL_endian.bi"
#include "SDL/begin_code.bi"

declare function SDLNet_Init SDLCALL alias "SDLNet_Init" () as integer
declare sub SDLNet_Quit SDLCALL alias "SDLNet_Quit" ()

''/***********************************************************************/
''/* IPv4 hostname resolution API                                        */
''/***********************************************************************/

type IPaddress
	host  as Uint32 
	port  as Uint16
end type

#ifndef INADDR_ANY
#define INADDR_ANY		&h00000000
#endif
#ifndef INADDR_NONE
#define INADDR_NONE		&hFFFFFFFF
#endif
#ifndef INADDR_BROADCAST
#define INADDR_BROADCAST	&hFFFFFFFF
#endif

declare function SDLNet_ResolveHost SDLCALL alias "SDLNet_ResolveHost" _
	(byval address as IPaddress ptr, byval host as string, byval port as Uint16) as integer

declare function SDLNet_ResolveIP SDLCALL alias "SDLNet_ResolveIP" (byval ip as IPaddress ptr) as byte ptr


''/***********************************************************************/
''/* TCP network API                                                     */
''/***********************************************************************/

type TCPsocket as any ptr

declare function SDLNet_TCP_Open SDLCALL alias "SDLNet_TCP_Open" (byval ip as IPaddress ptr) as TCPsocket

declare function SDLNet_TCP_Accept SDLCALL alias "SDLNet_TCP_Accept" (byval server as TCPsocket) as TCPsocket

declare function SDLNet_TCP_GetPeerAddress SDLCALL alias "SDLNet_TCP_GetPeerAddress" (byval sock as TCPsocket) as IPaddress ptr

declare function SDLNet_TCP_Send SDLCALL alias "SDLNet_TCP_Send" (byval sock as TCPsocket, byval data as any ptr, byval len as integer) as integer

declare function SDLNet_TCP_Recv SDLCALL alias "SDLNet_TCP_Recv" (byval sock as TCPsocket, byval data as any ptr, byval maxlen as integer) as integer

declare sub SDLNet_TCP_Close SDLCALL alias "SDLNet_TCP_Close" (byval sock as TCPsocket)


''/***********************************************************************/
''/* UDP network API                                                     */
''/***********************************************************************/

#define SDLNET_MAX_UDPCHANNELS	32
#define SDLNET_MAX_UDPADDRESSES	4

type UDPsocket as any ptr

type UDPpacket
	channel	as integer
	data 	as Uint8 ptr
	len 	as integer
	maxlen 	as integer
	status 	as integer
	address	as IPaddress
end type

declare function SDLNet_AllocPacket SDLCALL alias "SDLNet_AllocPacket" (byval size as integer) as UDPsocket
declare function SDLNet_ResizePacket SDLCALL alias "SDLNet_ResizePacket" (byval packet as UDPsocket, byval newsize as integer) as integer
declare sub SDLNet_FreePacket SDLCALL alias "SDLNet_FreePacket" (byval packet as UDPsocket)

declare function SDLNet_AllocPacketV SDLCALL alias "SDLNet_AllocPacketV" (byval howmany as integer, byval size as integer) as UDPpacket ptr ptr
declare sub SDLNet_FreePacketV SDLCALL alias "SDLNet_FreePacketV" (byval packetV as UDPsocket ptr ptr)

declare function SDLNet_UDP_Open SDLCALL alias "SDLNet_UDP_Open" (byval port as Uint16) as UDPsocket

declare function SDLNet_UDP_Bind SDLCALL alias "SDLNet_UDP_Bind" (byval sock as UDPsocket, byval channel as integer, byval address as IPaddress ptr) as integer

declare sub SDLNet_UDP_Unbind SDLCALL alias "SDLNet_UDP_Unbind" (byval sock as UDPsocket, byval channel as integer)

declare function SDLNet_UDP_GetPeerAddress SDLCALL alias "SDLNet_UDP_GetPeerAddress" (byval sock as UDPsocket, byval channel as integer) as IPaddress ptr

declare function SDLNet_UDP_SendV SDLCALL alias "SDLNet_UDP_SendV" (byval sock as UDPsocket, byval packets as UDPpacket ptr ptr, byval npackets as integer) as integer

declare function SDLNet_UDP_Send SDLCALL alias "SDLNet_UDP_Send" (byval sock as UDPsocket, byval channel as integer, byval packet as UDPsocket) as integer

declare function SDLNet_UDP_RecvV SDLCALL alias "SDLNet_UDP_RecvV" (byval sock as UDPsocket, byval packets as UDPpacket ptr ptr) as integer

declare function SDLNet_UDP_Recv SDLCALL alias "SDLNet_UDP_Recv" (byval sock as UDPsocket, byval packet as UDPsocket) as integer

declare sub SDLNet_UDP_Close SDLCALL alias "SDLNet_UDP_Close" (byval sock as UDPsocket)


''/***********************************************************************/
''/* Hooks for checking sockets for available data                       */
''/***********************************************************************/

type SDLNet_SocketSet as any ptr

type SDLNet_TGenericSocket
	ready		as integer
end type

type SDLNet_GenericSocket as SDLNet_TGenericSocket ptr

declare function SDLNet_AllocSocketSet SDLCALL alias "SDLNet_AllocSocketSet" (byval maxsockets as integer) as SDLNet_SocketSet

declare function SDLNet_AddSocket SDLCALL alias "SDLNet_AddSocket" (byval set as SDLNet_SocketSet, byval sock as SDLNet_GenericSocket) as integer

#define SDLNet_TCP_AddSocket(set,sock) SDLNet_AddSocket(set, sock)

#define SDLNet_UDP_AddSocket(set,sock) SDLNet_AddSocket(set, sock)

declare function SDLNet_DelSocket SDLCALL alias "SDLNet_DelSocket" (byval set as SDLNet_SocketSet, byval sock as SDLNet_GenericSocket) as integer

#define SDLNet_TCP_DelSocket(set,sock) SDLNet_DelSocket(set, sock)

#define SDLNet_UDP_DelSocket(set,sock) SDLNet_DelSocket(set, sock)

declare function SDLNet_CheckSockets SDLCALL alias "SDLNet_CheckSockets" (byval set as SDLNet_SocketSet, byval timeout as Uint32) as integer

#define SDLNet_SocketReady(sock) ((sock <> NULL) and (sock->ready = 1))

declare sub SDLNet_FreeSocketSet SDLCALL alias "SDLNet_FreeSocketSet" (byval set as SDLNet_SocketSet)


''/***********************************************************************/
''/* Platform-independent data conversion functions                      */
''/***********************************************************************/

declare sub SDLNet_Write16 SDLCALL alias "SDLNet_Write16" (byval value as Uint16, byval area as any ptr)
declare sub SDLNet_Write32 SDLCALL alias "SDLNet_Write32" (byval value as Uint32, byval area as any ptr)

declare function SDLNet_Read16 SDLCALL alias "SDLNet_Read16" (byval area as any ptr) as Uint16
declare function SDLNet_Read32 SDLCALL alias "SDLNet_Read32" (byval area as any ptr) as Uint32


''/***********************************************************************/
''/* Error reporting functions                                           */
''/***********************************************************************/

#define SDLNet_SetError	SDL_SetError
#define SDLNet_GetError	SDL_GetError


''/***********************************************************************/
''/* Inline macro functions to read/write network data                   */
''/***********************************************************************/

''private sub SDLNet_Write16(byval value as Uint16, byval areap as Uint16 ptr)
''	*areap = SDL_SwapBE16(value)
''end sub	

''private sub SDLNet_Write32(byval value as Uint32, byval areap as Uint32 ptr)
''	*areap = SDL_SwapBE32(value)
''end sub

''private function SDLNet_Read16(byval areap as Uint16 ptr) as Uint16
''	SDLNet_Read16 = SDL_SwapBE16(areap)
''end function

''private function SDLNet_Read32(byval areap as Uint32 ptr) as Uint32
''	SDLNet_Read32 = SDL_SwapBE32(areap)
''end function


#include "SDL/close_code.bi"

#endif '' SDLnet_h_