''
'' simple http get example using the Winsock API
''

#include once "win/winsock.bi"

const RECVBUFFLEN = 8192
const NEWLINE = !"\r\n"
const DEFAULT_HOST = "www.freebasic.net"

declare sub 	 gethostandpath	( byref src as string, byref hostname as string, byref path as string )

declare function resolveHost	( byref hostname as string ) as integer
	
	
	'' globals
	dim hostname as string
	dim path as string
	
	'' check command-line
	gethostandpath command, hostname, path
	
	if( len( hostname ) = 0 ) then
		hostname = DEFAULT_HOST
	end if
	
	'' init winsock
	dim wsaData as WSAData
	
	if( WSAStartup( MAKEWORD( 1, 1 ), @wsaData ) <> 0 ) then
		print "Error: WSAStartup failed"
		end 1
	end if
                         
	'' resolve name
	dim ip as integer
    dim s as SOCKET
    
    ip = resolveHost( hostname )
    if( ip = 0 ) then
		print "Error: resolveHost failed"
		end 1
	end if
    
    '' open socket
    s = opensocket( AF_INET, SOCK_STREAM, IPPROTO_TCP )
    if( s = 0 ) then
		print "Error:"; WSAGetLastError; " Calling: socket()"
		end 1
	end if
    
	'' connect to host
	dim sa as sockaddr_in

	sa.sin_port			= htons( 80 )
	sa.sin_family		= AF_INET
	sa.sin_addr.S_addr	= ip
	
	if ( connect( s, cast( PSOCKADDR, @sa ), len( sa )) = SOCKET_ERROR ) then
		print "Error:"; WSAGetLastError; " Calling: connect()"
		closesocket( s )
		end 1
	end if
    
    '' send HTTP request
    dim sendbuffer as string
    
	sendBuffer = "GET /" + path + " HTTP/1.0" + NEWLINE + _
				 "Host: " + hostname + NEWLINE + _
				 "Connection: close" + NEWLINE + _
				 "User-Agent: GetHTTP 0.0" + NEWLINE + _
				 NEWLINE
				 
    if( send( s, sendBuffer, len( sendBuffer ), 0 ) = SOCKET_ERROR ) then
		print "Error:"; WSAGetLastError; " Calling: send()"
		closesocket( s )
		end 1
	end if
    
    '' receive until connection is closed
    dim recvbuffer as zstring * RECVBUFFLEN+1
    dim bytes as integer
    
    do 
    	bytes = recv( s, recvBuffer, RECVBUFFLEN, 0 )
    	if( bytes <= 0 ) then
    		exit do
    	end if
    	
    	'' add the null-terminator
    	recvbuffer[bytes] = 0
    	
    	'' print buffer as a string
    	print recvbuffer
    loop
    print
                         
	'' close socket
	shutdown( s, 2 )
	closesocket( s )
	
	'' quit winsock
	WSACleanup

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

'':::::
function resolveHost( byref hostname as string ) as integer
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

