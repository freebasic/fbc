''
'' simple http get example using the SDL_net library
''

option explicit
option escape
'$include: "SDL/SDL_net.bi"

const RECVBUFFLEN = 8192
const NEWLINE = "\n\r"

declare sub gethostandpath( src as string, hostname as string, path as string )
	
	
	'' globals
	dim hostname as string
	dim path as string
	
	gethostandpath command$, hostname, path
	
	if( len( hostname ) = 0 ) then
		print "usage: hostname [path]"
		end 1
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
				 "Connection: close" + NEWLINE + _
				 "User-Agent: GetHTTP 0.0" + NEWLINE + _
				 + NEWLINE
				 
    if( SDLNet_TCP_Send( socket, strptr( sendbuffer ), len( sendbuffer ) ) < len( sendbuffer ) ) then
		print "Error: SDLNet_TCP_Send failed"
		end 1
	end if
    
    '' receive til connection is closed
    dim recvbuffer as string * RECVBUFFLEN
    dim bytes as integer
    
    do 
    	recvbuffer = ""
    	bytes = SDLNet_TCP_Recv( socket, strptr( recvbuffer ), RECVBUFFLEN )
    	if( bytes <= 0 ) then
    		exit do
    	end if
    	print recvbuffer;
    loop
    print
                         
	'' close socket
	SDLNet_TCP_Close( socket )
	
	'' quit
	SDLNet_Quit

'':::::
sub gethostandpath( src as string, hostname as string, path as string )
	dim p as integer
	
	p = instr( src, " " )
	if( p = 0 or p = len( src ) ) then
		hostname = trim$( src )
		path = ""
	else
		hostname = trim$( left$( src, p-1 ) )
		path = trim$( mid$( src, p+1 ) )
	end if
		
end sub