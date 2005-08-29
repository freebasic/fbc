option explicit

#include once "wshelper.bi"
#include once "myprotocol.bi"

declare function serverIni( ) as integer	
declare function serverRun( ) as integer
declare function serverEnd( ) as integer	

declare sub serverAdd( byval s as SOCKET, byval sa as sockaddr_in ptr )

declare sub serverAccept( byval unused as integer )
declare sub serverReceive( byval client as CLIENT ptr )
declare sub serverSend( byval client as CLIENT ptr )

	
	dim shared ctx as SERVER
	
	if( not serverIni( ) ) then
		serverEnd( )
		end 
	end if

	serverRun( )
	
	serverEnd( )
	
	end
	
	
'':::::
function serverIni( ) as integer

	'' start winsock
	if( not hStart( ) ) then
		hPrintError( hStart )
		return FALSE
	end if
	
	'' create a socket for listening
	ctx.socket = hOpen( )
	if( ctx.socket = NULL ) then
		hPrintError( hOpen )
		return FALSE
	end if
	
	'' bind it to the server port
	if( not hBind( ctx.socket, SERVER_PORT ) ) then
		hPrintError( hBind )
		return FALSE
	end if	
	
	function = TRUE
	
end function

'':::::
sub serverDel( byval client as CLIENT ptr )
			
	if( client->socket <> NULL ) then
		hClose( client->socket )
		client->socket = NULL
		
		condsignal( client->recvbuffer.cond )
		condsignal( client->sendbuffer.cond )
		
		print "Closing connection for: " & *hIp2Addr( client->ip )

		conddestroy( client->sendbuffer.cond )
		conddestroy( client->recvbuffer.cond )
		
	end if

end sub

'':::::
function serverEnd( ) as integer

	'' close the listening socket
	if( ctx.socket <> 0 ) then
		hClose( ctx.socket )
		ctx.socket = 0
	end if
	
	'' remove all clients yet running
	dim i as integer
	
	for i = 0 to ctx.clients-1
		serverDel( @ctx.clientTb(i) )
	next 
	
	'' shutdown winsock
	function = hShutdown( )

end function


'':::::
function serverProcess( byval client as CLIENT ptr, byval buffer as zstring ptr ) as integer
	dim answer as integer
	
	print "Received from " & *hIp2Addr( client->ip ) & ": "; *buffer
	
	'' check message by ID
	select case SERVER_ID( buffer )
	case SERVER_MSG_HELLO
		answer = SERVER_MSG_SUP
		
	case SERVER_MSG_BYE
		answer = SERVER_MSG_CYA

	case else
		answer = 0

	end select

	''
	if( answer <> 0 ) then
		client->sendbuffer.ptr = @client->sendbuffer.buff
		SERVER_ID( client->sendbuffer.ptr ) = answer
		client->sendbuffer.buff[len( integer )] = 0
		client->sendbuffer.len = len( integer )
		
		condsignal( client->sendbuffer.cond )

		function = TRUE

	''
	else
		function = FALSE
	
	end if
		
end function

'':::::
sub serverReceive( byval client as CLIENT ptr )
	dim bytes as integer
	
	'' keep running while server is on and the client too
	do while( ctx.isrunning and (client->socket <> NULL) )
		
		'' block until some data
		bytes = hReceive( client->socket, @client->recvbuffer.buff, SERVER_BUFFSIZE )
		
		'' connection closed?
		if( bytes <= 0 ) then
			exit do
		end if
		
		'' add the null-terminator
		client->recvbuffer.buff[bytes] = 0
		
		'' process the incoming msg
		if( serverProcess( client, @client->recvbuffer.buff ) ) then
			'' wait until it's okay to receive
			condwait( client->recvbuffer.cond )
		end if
	loop
	
	'' remove client
	serverDel( client )
	
end sub

'':::::
sub serverSend( byval client as CLIENT ptr )
	dim bytes as integer
	
	'' keep running while server is on and the client too
	do while( ctx.isrunning and (client->socket <> NULL) )
		
		'' any data to send?
		if( client->sendbuffer.len > 0 ) then
			
			print "Sending to " & *hIp2Addr( client->ip ) & ": "; client->sendbuffer.buff
		
			'' keep trying until the whole buffer is sent
			bytes = hSend( client->socket, client->sendbuffer.ptr, client->sendbuffer.len )
			
			'' connection closed?
			if( bytes <= 0 ) then
				exit do
			end if
		
			client->sendbuffer.ptr += bytes
			client->sendbuffer.len -= bytes
			
			if( client->sendbuffer.len <= 0 ) then
				'' signal that it's okay to receive
				condsignal( client->recvbuffer.cond )
			end if
		
		else
			'' wait until there's some data to send
			condwait( client->sendbuffer.cond )
		end if
		
	loop
	
	'' remove client
	serverDel( client )
	
end sub

'':::::
sub serverAdd( byval s as SOCKET, byval sa as sockaddr_in ptr )
	dim client as CLIENT ptr
	
	'' too many?
	if( ctx.clients >= SERVER_MAXCLIENTS ) then
		print "Error: too many clients"
		exit sub
	end if
	
	'' access global data, lock it
	mutexlock( ctx.globmutex )
	
	'' add
	client = @ctx.clientTb(ctx.clients)
	ctx.clients += 1
	
	mutexunlock( ctx.globmutex )
	
	'' setup the client
	client->socket 				= s
	client->ip					= sa->sin_addr.S_addr
	client->port				= sa->sin_port
	'' create the conditions
	client->recvbuffer.cond 	= condcreate( )
	client->sendbuffer.cond 	= condcreate( )
	'' start new recv and send threads
	client->recvthread 			= threadcreate( @serverReceive, cint( client ) )
	client->sendthread 			= threadcreate( @serverSend, cint( client ) )
	
	print "New connection from: " & *hIp2Addr( client->ip )

end sub

'':::::
sub serverAccept( byval unused as integer )
	dim sa as sockaddr_in
	dim s as SOCKET
	
	do while( ctx.isrunning )
		
		s = hAccept( ctx.socket, @sa )
		if( s = INVALID_SOCKET ) then
			if( ctx.isrunning ) then
				hPrintError( hAccept )
			end if
			exit do
		end if
		
		serverAdd( s, @sa )
		
	loop
	
	ctx.isrunning = FALSE

end sub

'':::::
sub showStatus( )
	dim xy as integer = locate( )
	print chr$( 33 + ((screen((xy shr 8) and &hff, xy and &hff) + 1) and 31) );
	locate (xy shr 8) and &hff, xy and &hff
end sub

'':::::
function serverRun( ) as integer
	
	if( not hListen( ctx.socket ) ) then
		return FALSE
	end if
	
	ctx.clients = 0
	ctx.isrunning = TRUE
	
	ctx.globmutex = mutexcreate( )

	ctx.acceptthread = threadcreate( @serverAccept )
	
	print "Press ESC to exit"
	print
	
	do while( ctx.isrunning )
		if( inkey( ) = chr( 27 ) ) then
			exit do
		end if
		showStatus( )
		sleep( 25 )
	loop
	
	ctx.isrunning = FALSE
	
	function = TRUE
	
end function