
#include once "wshelper.bi"

const SERVER_ADDR 		= "localhost"
const SERVER_PORT 		= 6666
const SERVER_MAXCLIENTS = 100
const SERVER_BUFFSIZE	= 256

#define MAKEMSG(a0,a1,a2,a3) asc(a0) + asc(a1) shl 8 + asc(a2) shl 16 + asc(a3) shl 24

const SERVER_MSG_HELLO	= MAKEMSG( "H", "E", "L", "O" )
const SERVER_MSG_SUP	= MAKEMSG( "S", "U", "P", "!" )
const SERVER_MSG_BYE	= MAKEMSG( "B", "Y", "E", "!" )
const SERVER_MSG_CYA	= MAKEMSG( "C", "Y", "A", "!" )

#define SERVER_ID(buff) *cptr( integer ptr, buff )

type BUFFER
	buff			as zstring * SERVER_BUFFSIZE+1
	ptr				as zstring ptr
	len				as integer
	cond			as integer
end type

type CLIENT
	socket			as SOCKET
	ip				as integer
	port			as integer
	recvthread		as integer	
	sendthread		as integer
	recvbuffer 		as BUFFER
	sendbuffer 		as BUFFER
end type

type SERVER
	socket			as SOCKET
	acceptthread	as integer
	isrunning		as integer
	globmutex		as integer
	
	clients			as integer
	clientTb(0 to SERVER_MAXCLIENTS-1) as CLIENT
end type

