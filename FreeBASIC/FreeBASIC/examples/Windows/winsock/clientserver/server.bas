''
'' to compile: fbc server.bas
'' 			   (note: build the wshelper library first)
''



#include once "wshelper.bi"
#include once "myprotocol.bi"

type CLIENTLIST
	head			as CLIENT ptr	
	tail			as CLIENT ptr
end type

type SERVERCTX
	socket			as SOCKET
	acceptthread	as any ptr
	isrunning		as integer
	globmutex		as any ptr
	
	clientlist		as CLIENTLIST
end type

declare function serverIni( ) as integer	
declare function serverRun( ) as integer
declare function serverEnd( ) as integer	

declare sub serverAdd( byval s as SOCKET, byval sa as sockaddr_in ptr )

declare sub serverAccept( byval unused as integer )
declare sub serverReceive( byval client as CLIENT ptr )
declare sub serverSend( byval client as CLIENT ptr )

#define CLIENTADDR(c) *hIp2Addr( c->ip ) & "(" & c->port & ")"

	
	dim shared ctx as SERVERCTX
	
	if( serverIni( ) = FALSE ) then
		serverEnd( )
		end 
	end if

	serverRun( )
	
	serverEnd( )
	
	end
	
	
'':::::
function serverIni( ) as integer

	'' start winsock
	if( hStart( ) = FALSE ) then
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
	if( hBind( ctx.socket, SERVER_PORT ) = FALSE ) then
		hPrintError( hBind )
		return FALSE
	end if	
	
	function = TRUE
	
end function

'':::::
sub serverDel( byval client as CLIENT ptr )
	dim s as SOCKET
	
	'' not already removed?
	if( client->socket <> NULL ) then		
		s = NULL 
		swap s, client->socket						'' this should be atomic..
		
		'' close connection
		hClose( s )
		
		'' recv thread stills running?
		if( client->recvthread <> NULL ) then
			mutexlock( client->recvbuffer.cond_mutex )
				client->recvbuffer.cond_var = 0
				condsignal( client->recvbuffer.cond )
			mutexunlock( client->recvbuffer.cond_mutex )
			threadwait( client->recvthread )			
		end if
		
		conddestroy( client->recvbuffer.cond )
		mutexdestroy( client->recvbuffer.cond_mutex )
	
		'' send thread stills running?
		if( client->sendthread <> NULL ) then
			mutexlock( client->sendbuffer.cond_mutex )
				client->sendbuffer.cond_var = 0
				condsignal( client->sendbuffer.cond )
			mutexunlock( client->sendbuffer.cond_mutex )
			threadwait( client->sendthread )			
		end if
		
		conddestroy( client->sendbuffer.cond )
		mutexdestroy( client->sendbuffer.cond_mutex )
		
		print "Closing connection for: " & CLIENTADDR(client)
		
		'' remove from list
		if( client->next ) then
			client->next->prev = client->prev
		else
			ctx.clientlist.tail = client->prev
		end if
		if( client->prev ) then
			client->prev->next = client->next
		else
			ctx.clientlist.head = client->next
		end if
	end if

end sub

'':::::
function serverEnd( ) as integer
	dim client as CLIENT ptr
	
	'' close the listening socket
	if( ctx.socket <> 0 ) then
		hClose( ctx.socket )
		ctx.socket = 0
	end if
	
	'' remove all clients yet running
	dim i as integer
	
	do
		client = ctx.clientlist.head
		if( client = NULL ) then
			exit do
		end if
		serverDel( client )
	loop
	
	'' shutdown winsock
	function = hShutdown( )

end function


'':::::
function serverProcess( byval client as CLIENT ptr, byval buffer as zstring ptr ) as integer
	dim answer as integer
	
	print "Received from " & CLIENTADDR(client) & ": "; *buffer
	
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
		
		mutexlock( client->sendbuffer.cond_mutex )
			client->sendbuffer.cond_var = 0
			condsignal( client->sendbuffer.cond )
		mutexunlock( client->sendbuffer.cond_mutex )

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
			mutexlock( client->recvbuffer.cond_mutex )
				while( client->recvbuffer.cond_var )
					condwait( client->recvbuffer.cond, client->recvbuffer.cond_mutex )
				wend
				client->recvbuffer.cond_var = -1
			mutexunlock( client->recvbuffer.cond_mutex )
		end if
	loop
	
	'' remove client
	client->recvthread = NULL
	serverDel( client )
	
end sub

'':::::
sub serverSend( byval client as CLIENT ptr )
	dim bytes as integer
	
	'' keep running while server is on and the client too
	do while( ctx.isrunning and (client->socket <> NULL) )
		
		'' any data to send?
		if( client->sendbuffer.len > 0 ) then
			
			print "Sending to " & CLIENTADDR(client) & ": "; client->sendbuffer.buff
		
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
				mutexlock( client->recvbuffer.cond_mutex )
					client->recvbuffer.cond_var = 0
					condsignal( client->recvbuffer.cond )
				mutexunlock( client->recvbuffer.cond_mutex )
			end if
		
		else
			'' wait until there's some data to send
			mutexlock( client->sendbuffer.cond_mutex )
				while( client->sendbuffer.cond_var )
					condwait( client->sendbuffer.cond, client->sendbuffer.cond_mutex )
				wend
				client->sendbuffer.cond_var = -1
			mutexunlock( client->sendbuffer.cond_mutex )
		end if
		
	loop
	
	'' remove client
	client->sendthread = NULL
	serverDel( client )
	
end sub

'':::::
sub serverAdd( byval s as SOCKET, byval sa as sockaddr_in ptr )
	dim client as CLIENT ptr
	
	'' access global data, lock it
	mutexlock( ctx.globmutex )
	
	'' allocate node
	client = callocate( len( CLIENT ) )
	
	'' add to list
	if( ctx.clientlist.tail <> NULL ) then
		ctx.clientlist.tail->next = client
	else
		ctx.clientlist.head = client
	end if
	client->prev = ctx.clientlist.tail
	client->next = NULL
	ctx.clientlist.tail = client
	
	mutexunlock( ctx.globmutex )
	
	'' setup the client
	client->socket 				= s
	client->ip					= sa->sin_addr.S_addr
	client->port				= sa->sin_port
	'' create the conditions
	client->recvbuffer.cond 	= condcreate( )
	client->sendbuffer.cond 	= condcreate( )
	client->recvbuffer.cond_mutex = mutexcreate( )
	client->sendbuffer.cond_mutex = mutexcreate( )
	client->recvbuffer.cond_var = -1
	client->sendbuffer.cond_var = -1
	
	'' start new recv and send threads
	client->recvthread 			= threadcreate( cast(sub(byval as any ptr), @serverReceive), client )
	client->sendthread 			= threadcreate( cast(sub(byval as any ptr), @serverSend), client )
	
	print "New connection from: " & CLIENTADDR(client)

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
	print chr( 33 + ((screen((xy shr 8) and &hff, xy and &hff) + 1) and 31) );
	locate (xy shr 8) and &hff, xy and &hff
end sub

'':::::
function serverRun( ) as integer
	
	if( hListen( ctx.socket ) = FALSE ) then
		return FALSE
	end if
	
	ctx.clientlist.head = NULL
	ctx.clientlist.tail = NULL
	ctx.isrunning = TRUE
	
	ctx.globmutex = mutexcreate( )

	ctx.acceptthread = threadcreate( cast(sub(byval as any ptr), @serverAccept) )
	
	print "Press ESC to exit"
	print
	
	do while( ctx.isrunning )
		if( inkey( ) = chr( 27 ) ) then
			exit do
		end if
		''''''showStatus( )
		sleep( 25 )
	loop
	
	ctx.isrunning = FALSE
	
	function = TRUE
	
end function