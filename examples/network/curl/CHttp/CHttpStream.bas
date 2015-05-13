''
'' CHttp - a class wrapper for the CURL library
''

#include once "CHttp.bi"
#include once "curl.bi"
#include once "crt/string.bi"

const CSTREAM_MINALLOC = 1024

type CStream
	as byte ptr				buffer
	as integer				size	
	as integer				pos
end type

type CHttpStreamCtx_
	as CHttp ptr 			http
	as integer				delcon
	as CStream 				stream
end type

'':::::
constructor CHttpStream _
	( _
		byval http as CHttp ptr _
	)
	
	ctx = new CHttpStreamCtx_
	
	if( http = NULL ) then
		http = new CHttp
		ctx->delcon = TRUE
	else
		ctx->delcon = FALSE
	end if
	
	ctx->http = http
	ctx->stream.buffer = NULL

end constructor

'':::::
destructor CHttpStream _
	( _
		_
	)
	
 	if( ctx->stream.buffer <> NULL ) then
 		deallocate( ctx->stream.buffer )
 		ctx->stream.buffer = NULL
 	end if

 	if( ctx->http <> NULL ) then
 		if( ctx->delcon ) then
 			delete ctx->http
 		end if
 		ctx->http = NULL
	end if
	
	delete ctx

end destructor

'':::::
private function recv_cb cdecl _
	( _
		byval buffer as byte ptr, _
		byval size as integer, _
		byval nitems as integer, _
		byval userdata as any ptr _
	) as integer

	dim as CStream ptr stream = userdata
	dim as integer bytes = size * nitems
	
	if( stream->pos + bytes >= stream->size ) then
		stream->size += iif( bytes < CSTREAM_MINALLOC, CSTREAM_MINALLOC, bytes )
		stream->buffer = reallocate( stream->buffer, stream->size + 1 )
	end if
	
	memcpy( stream->buffer + stream->pos, buffer, bytes )
	stream->pos += bytes
	
	function = bytes

end function

'':::::
function CHttpStream.receive _
	( _
		byval url as zstring ptr, _
		byval referer as zstring ptr, _
		byval doreset as integer _
	) as integer

	dim as CURL ptr curl
	
	if( ctx->http = NULL ) then
		return FALSE
	end if

	curl = ctx->http->getHandle( )
	if( curl = NULL ) then
		return FALSE
	end if
	
 	''
 	if( ctx->stream.buffer <> NULL ) then
 		deallocate( ctx->stream.buffer )
 		ctx->stream.buffer = NULL
 	end if
 	
 	ctx->stream.size = 0
 	ctx->stream.pos = 0
 	
 	''
 	if( doreset ) then
 		curl_easy_reset( curl )
 	end if

	curl_easy_setopt( curl, CURLOPT_URL, url )
	
	curl_easy_setopt( curl, CURLOPT_FOLLOWLOCATION, 1 )
	curl_easy_setopt( curl, CURLOPT_MAXREDIRS, 16 )
	
	if( referer <> NULL ) then
		curl_easy_setopt( curl, CURLOPT_REFERER, referer )
	end if
	
	curl_easy_setopt( curl, CURLOPT_WRITEFUNCTION, @recv_cb )
	curl_easy_setopt( curl, CURLOPT_WRITEDATA, @ctx->stream )

 	if( curl_easy_perform( curl ) <> 0 ) then
 		if( ctx->stream.buffer <> NULL ) then
 			deallocate( ctx->stream.buffer )
 			ctx->stream.buffer = NULL
 		end if
 		return FALSE
 	end if
 	
	if( ctx->stream.buffer <> NULL ) then
		ctx->stream.buffer[ctx->stream.pos] = 0
	end if
	
	function = TRUE

end function

'':::::
function CHttpStream.read _
	( _
		byval is_binary as integer _
	) as string
	
	if( ctx->stream.buffer <> NULL ) then
		if( is_binary = FALSE ) then
			function = *cptr(zstring ptr, ctx->stream.buffer)
		else
			dim as string res = space( ctx->stream.pos + 1 )
			memcpy( strptr( res ), ctx->stream.buffer, ctx->stream.pos + 1 )
			function = res
		end if
	
	else
		function = ""
	end if
	
end function

'':::::
private function send_cb cdecl _
	( _
		byval buffer as byte ptr, _
		byval size as integer, _
		byval nitems as integer, _
		byval userdata as any ptr _
	) as integer

	dim as CStream ptr stream = userdata
	dim as integer bytes = size * nitems
	
	bytes = iif( bytes < stream->size, bytes, stream->size )
	
	if( bytes = 0 ) then
		return 0
	end if

	memcpy( buffer, stream->buffer + stream->pos, bytes )
	stream->pos += bytes
	stream->size -= bytes
	
	function = bytes

end function

'':::::
function CHttpStream.send _
	( _
		byval url as zstring ptr, _
		byval data_ as any ptr, _
		byval bytes as integer, _
		byval referer as zstring ptr, _
		byval doreset as integer _
	) as integer

	dim as CURL ptr curl
	
	if( ctx->http = NULL ) then
		return FALSE
	end if

	if( bytes <= 0 ) then
		return TRUE
	end if

	curl = ctx->http->getHandle( )
	if( curl = NULL ) then
		return FALSE
	end if
	
 	''
 	if( ctx->stream.buffer <> NULL ) then
 		deallocate( ctx->stream.buffer )
 		ctx->stream.buffer = NULL
 	end if
 	
 	ctx->stream.buffer = data_
 	ctx->stream.size = bytes
 	ctx->stream.pos = 0
 	
 	''
 	if( doreset ) then
 		curl_easy_reset( curl )
 	end if

	curl_easy_setopt( curl, CURLOPT_URL, url )

	curl_easy_setopt( curl, CURLOPT_FOLLOWLOCATION, 1 )
	curl_easy_setopt( curl, CURLOPT_MAXREDIRS, 16 )
	
	if( referer <> NULL ) then
		curl_easy_setopt( curl, CURLOPT_REFERER, referer )
	end if

	curl_easy_setopt( curl, CURLOPT_READFUNCTION, @send_cb )
	curl_easy_setopt( curl, CURLOPT_READDATA, @ctx->stream )
 	
 	if( curl_easy_perform( curl ) <> 0 ) then
 		return FALSE
 	end if
 	
	function = TRUE

end function
