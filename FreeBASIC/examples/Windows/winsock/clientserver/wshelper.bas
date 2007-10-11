''
'' to compile: fbc wshelper.bas -lib
''

#include once "wshelper.bi"

'':::::
function hStart( byval verhigh as integer = 2, byval verlow as integer = 0 ) as integer
	dim wsaData as WSAData
	
	if( WSAStartup( MAKEWORD( verhigh, verlow ), @wsaData ) <> 0 ) then
		return FALSE
	end if
	
	if( wsaData.wVersion <> MAKEWORD( verhigh, verlow ) ) then
		WSACleanup( )	
		return FALSE
	end if
	
	function = TRUE

end function

'':::::
function hShutdown( ) as integer

	function = WSACleanup( )
	
end function

'':::::
function hResolve( byval hostname as string ) as integer
	dim ia as in_addr
	dim hostentry as hostent ptr

	'' check if it's an ip address
	ia.S_addr = inet_addr( hostname )
	if ( ia.S_addr = INADDR_NONE ) then
		
		'' if not, assume it's a name, resolve it
		hostentry = gethostbyname( hostname )
		if ( hostentry = 0 ) then
			exit function
		end if
		
		function = *cast( integer ptr, *hostentry->h_addr_list )
		
	else
	
		'' just return the address
		function = ia.S_addr
	
	end if
	
end function

'':::::
function hOpen( byval proto as integer = IPPROTO_TCP ) as SOCKET
	dim s as SOCKET
    
    s = opensocket( AF_INET, SOCK_STREAM, proto )
    if( s = NULL ) then
		return NULL
	end if
	
	function = s
	
end function

'':::::
function hConnect( byval s as SOCKET, byval ip as integer, byval port as integer ) as integer
	dim sa as sockaddr_in

	sa.sin_port			= htons( port )
	sa.sin_family		= AF_INET
	sa.sin_addr.S_addr	= ip
	
	function = connect( s, cast( PSOCKADDR, @sa ), len( sa ) ) <> SOCKET_ERROR
	
end function

'':::::
function hBind( byval s as SOCKET, byval port as integer ) as integer
	dim sa as sockaddr_in

	sa.sin_port			= htons( port )
	sa.sin_family		= AF_INET
	sa.sin_addr.S_addr	= INADDR_ANY 
	
	function = bind( s, cast( PSOCKADDR, @sa ), len( sa ) ) <> SOCKET_ERROR
	
end function

'':::::
function hListen( byval s as SOCKET, byval timeout as integer = SOMAXCONN ) as integer
	
	function = listen( s, timeout ) <> SOCKET_ERROR
	
end function

'':::::
function hAccept( byval s as SOCKET, byval sa as sockaddr_in ptr ) as SOCKET
	dim salen as integer 
	
	salen = len( sockaddr_in )
	function = accept( s, cast( PSOCKADDR, sa ), @salen )

end function	

'':::::
function hClose( byval s as SOCKET ) as integer

	shutdown( s, 2 )
	
	function = closesocket( s )
	
end function

'':::::
function hSend( byval s as SOCKET, byval buffer as zstring ptr, byval bytes as integer ) as integer

    function = send( s, buffer, bytes, 0 )
    
end function

'':::::
function hReceive( byval s as SOCKET, byval buffer as zstring ptr, byval bytes as integer ) as integer

    function = recv( s, buffer, bytes, 0 )
    
end function

'':::::
function hIp2Addr( byval ip as integer ) as zstring ptr
	dim ia as in_addr
	
	ia.S_addr = ip
	
	function = inet_ntoa( ia )

end function