
#include once "win/winsock2.bi"

#inclib "wshelper"

declare function hStart		( byval verhigh as integer = 2, byval verlow as integer = 0 ) as integer
declare function hShutdown	( ) as integer
declare function hResolve	( byval hostname as string ) as integer
declare function hOpen		( byval proto as integer = IPPROTO_TCP ) as SOCKET
declare function hConnect	( byval s as SOCKET, byval ip as integer, byval port as integer ) as integer
declare function hBind		( byval s as SOCKET, byval port as integer ) as integer
declare function hListen	( byval s as SOCKET, byval timeout as integer = SOMAXCONN ) as integer
declare function hAccept	( byval s as SOCKET, byval sa as sockaddr_in ptr ) as SOCKET
declare function hClose		( byval s as SOCKET ) as integer
declare function hSend		( byval s as SOCKET, byval buffer as zstring ptr, byval bytes as integer ) as integer
declare function hReceive	( byval s as SOCKET, byval buffer as zstring ptr, byval bytes as integer ) as integer
declare function hIp2Addr	( byval ip as integer ) as zstring ptr

#define hPrintError(e) print "error calling "; #e; ": "; WSAGetLastError( )
