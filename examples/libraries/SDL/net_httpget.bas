''
'' simple http get example using the SDL_net library
''

#include once "SDL/SDL_net.bi"

const RECVBUFFLEN = 8192
const NEWLINE = !"\r\n"
const DEFAULT_HOST = "www.freebasic.net"

declare sub gethostandpath( byref src as string, byref hostname as string, byref path as string )
	
	
	'' globals
	dim hostname as string
	dim path as string
	
	gethostandpath command, hostname, path
	
	if( len( hostname ) = 0 ) then
		hostname = DEFAULT_HOST
	end if
	
	'' init
	if( SDLNet_Init <> 0 ) then
		print "Error: SDLNet_Init failed"
		end 1
	end if
                         
	'' resolve
	dim ip as IPAddress
    dim socket as TCPSocket
    
    if( SDLNet_ResolveHost( @ip, hostname, 80 ) <> 0 ) then
		print "Error: SDLNet_ResolveHost failed"
		end 1
	end if
    
    '' open
    socket = SDLNet_TCP_Open( @ip )
    if( socket = 0 ) then
		print "Error: SDLNet_TCP_Open failed"
		end 1
	end if
    
    '' send HTTP request
    dim sendbuffer as string
    
	sendBuffer = "GET /" + path + " HTTP/1.0" + NEWLINE + _
				 "Host: " + hostname + NEWLINE + _
				 "Connection: close" + NEWLINE + _
				 "User-Agent: GetHTTP 0.0" + NEWLINE + _
				 NEWLINE
				 
    if( SDLNet_TCP_Send( socket, strptr( sendbuffer ), len( sendbuffer ) ) < len( sendbuffer ) ) then
		print "Error: SDLNet_TCP_Send failed"
		end 1
	end if
    
    '' receive til connection is closed
    dim recvbuffer as zstring * RECVBUFFLEN+1
    dim bytes as integer
    
    do 
    	bytes = SDLNet_TCP_Recv( socket, strptr( recvbuffer ), RECVBUFFLEN )
    	if( bytes <= 0 ) then
    		exit do
    	end if
    	
    	'' add the null-terminator
    	recvbuffer[bytes] = 0
    	
    	'' print it as string
    	print recvbuffer;
    loop
    print
                         
	'' close socket
	SDLNet_TCP_Close( socket )
	
	'' quit
	SDLNet_Quit

'':::::
sub gethostandpath( byref src as string, byref hostname as string, byref path as string )
	dim p as integer
	
	p = instr( src, " " )
	if( p = 0 or p = len( src ) ) then
		hostname = trim( src )
		path = ""
	else
		hostname = trim( left( src, p-1 ) )
		path = trim( mid( src, p+1 ) )
	end if
		
end sub
