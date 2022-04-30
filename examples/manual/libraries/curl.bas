'' examples/manual/libraries/curl.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'curl'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibcurl
'' --------

'' Curl HTTP Get example

#include Once "curl.bi"
#include Once "crt/string.bi"

'' this callback will be called when any data is received
Private Function write_callback cdecl _
	( _
		ByVal buffer As Byte Ptr, _
		ByVal size As Integer, _
		ByVal nitems As Integer, _
		ByVal outstream As Any Ptr _
	) As Integer

	Static As ZString Ptr zstr = 0
	Static As Integer maxbytes = 0

	Dim As Integer bytes = size * nitems

	'' current zstring buffer too small?
	If( maxbytes < bytes ) Then
		zstr = Reallocate( zstr, bytes + 1 )
		maxbytes = bytes
	End If

	'' "buffer" is not null-terminated, so we must dup it and add the null-term
	memcpy( zstr, buffer, bytes )
	zstr[bytes] = 0

	'' just print it..
	Print *zstr

	Return bytes
End Function

	'' init
	Dim As CURL Ptr curl = curl_easy_init( )
	If( curl = 0 ) Then
		End 1
	End If

	'' set url and callback
	curl_easy_setopt( curl, CURLOPT_URL, "freebasic.net" )
	curl_easy_setopt( curl, CURLOPT_WRITEFUNCTION, @write_callback )

	'' execute..
	curl_easy_perform( curl )

	'' shutdown
	curl_easy_cleanup( curl )
