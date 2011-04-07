''
'' to compile: fbc client.bas
'' 			   (note: build the wshelper library first)
''



#include once "wshelper.bi"
#include once "myprotocol.bi"

declare function clientSend( byval s as SOCKET, byval id as integer, byval buffer as zstring ptr ) as integer


	if( hStart( ) = FALSE ) then
		hPrintError( hStart )
		end
	end if

	dim s as SOCKET
	s = hOpen( )
	if( s = NULL ) then
		hPrintError( hOpen )
		end
	end if
	
	print "Connecting to "; SERVER_ADDR
	if( hConnect( s, hResolve( SERVER_ADDR ), SERVER_PORT ) = FALSE ) then
		hPrintError( hConnect )
		end
	end if
	
    dim buffer as zstring * SERVER_BUFFSIZE+1
    
    print "Sending HELLO to server"
    if( clientSend( s, SERVER_MSG_HELLO, @buffer ) = FALSE ) then
    	end
	end if
    
    '' receive
    dim bytes as integer
    
    do 
    	bytes = hReceive( s, @buffer, SERVER_BUFFSIZE )
    	if( bytes <= 0 ) then
    		exit do
    	end if
    	
    	buffer[bytes] = 0
    	
		print "Received from server: "; buffer
		
		select case SERVER_ID( @buffer )
		case SERVER_MSG_SUP
    		
    		if( clientSend( s, SERVER_MSG_BYE, @buffer ) = FALSE ) then
			
			end if
    		
    	case SERVER_MSG_CYA
    		exit do
    	end select
    	
    loop
	
	print "Closing connection"
	hClose( s )
	
	hShutdown( )

'':::::
function clientSend( byval s as SOCKET, byval id as integer, byval buffer as zstring ptr ) as integer
    
    SERVER_ID( buffer ) = id

    if( hSend( s, buffer, len( integer ) ) = FALSE ) then
		hPrintError( hSend )
		return FALSE
	end if
	
	function = TRUE
	
end function
	