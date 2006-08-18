''
'' Curl HTTP example
''



#include once "curl.bi"
#include once "crt/string.bi"

'':::::
''
'' this callback will be called when any data is received
''
private function write_callback cdecl ( byval buffer as byte ptr, _
										byval size as integer, _
									    byval nitems as integer, _
									    byval outstream as any ptr _
									  ) as integer

	static as zstring ptr zstr = 0
	static as integer maxbytes = 0
	
	dim as integer bytes = size * nitems

	'' current zstring buffer too small?
	if( maxbytes < bytes ) then
		zstr = reallocate( zstr, bytes + 1 )
		maxbytes = bytes
	end if
	
	'' "buffer" is not null-terminated, so we must dup it and add the null-term
	memcpy( zstr, buffer, bytes )
	zstr[bytes] = 0
	
	'' just print it..
	print *zstr
	
	function = bytes

end function

'' main	
	dim as CURL ptr curl
 	dim as CURLcode res

	'' init
	curl = curl_easy_init( )
 	if( curl = 0 ) then
 		end 1
 	end if
	
	'' set url and callback
	curl_easy_setopt( curl, CURLOPT_URL, "freebasic.net" )
	curl_easy_setopt( curl, CURLOPT_WRITEFUNCTION, @write_callback )
 	
 	'' execute..
 	res = curl_easy_perform( curl )
	
	'' shutdown
	curl_easy_cleanup( curl )

