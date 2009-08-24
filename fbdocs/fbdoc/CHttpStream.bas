''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2008 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' CHttpStream
''
'' chng: apr/2006 written [v1ctor]
'' chng: sep/2006 updated [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "CHttp.bi"
#include once "CHttpStream.bi"
#include once "curl.bi"
#include once "crt/string.bi"

namespace fb

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
		
		ctx = new CHttpStreamCtx
		
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
		)
		
 		if( ctx->stream.buffer <> NULL ) then
 			deallocate( ctx->stream.buffer )
 			ctx->stream.buffer = NULL
 		end if

 		if( ctx->http <> NULL ) then
 			if( ctx->delcon ) then
 				delete( ctx->http )	
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

		dim as CStream ptr ctx = userdata
		dim as integer bytes = size * nitems
		
		if( ctx->pos + bytes >= ctx->size ) then
			ctx->size += iif( bytes < CSTREAM_MINALLOC, CSTREAM_MINALLOC, bytes )
			ctx->buffer = reallocate( ctx->buffer, ctx->size + 1 )
		end if
		
		memcpy( ctx->buffer + ctx->pos, buffer, bytes )
		ctx->pos += bytes
		
		function = bytes

	end function

	'':::::
	function CHttpStream.Receive _
		( _
			byval url as zstring ptr, _
			byval doreset as integer _
		) as integer

		dim as CURL ptr curl
		dim as CURLcode ret
		
		if( ctx = NULL ) then
			return FALSE
		end if

		if( ctx->http = NULL ) then
			return FALSE
		end if

		curl = ctx->http->GetHandle()
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

		'' curl_easy_setopt( curl, CURLOPT_VERBOSE, TRUE )
		curl_easy_setopt( curl, CURLOPT_URL, url )
		curl_easy_setopt( curl, CURLOPT_WRITEFUNCTION, @recv_cb )
		curl_easy_setopt( curl, CURLOPT_WRITEDATA, @ctx->stream )

		'' This option should not be needed.  It wasn't in earlier version
		'' but some where between libcurl 7.16.0 and 7.16.2, there seems to
		'' be a problem getting pages consistently from www.freebasic.net/wiki
		'' could be a bug in libcurl.  It wasn't a problem before.  This is the
		'' work-around for now.
		'' curl_easy_setopt( curl, CURLOPT_FRESH_CONNECT, TRUE )

		'' This shouldn't be needed either, as it wasn't in previous versions
		'' But now, we might get CURLE_COULDNT_RESOLVE_HOST on the first try
		'' But not on the second, weird.  Problem with time-out values?
		ret = curl_easy_perform( curl )
		if( ret = CURLE_COULDNT_RESOLVE_HOST ) then
			'' Retry
			ret = curl_easy_perform( curl )
		end if

		if( ret <> 0 ) then
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
	function CHttpStream.Read _
		( _
		) as string
		
		function = ""
		
		if( ctx = NULL ) then
			exit function
		end if

		if( ctx->stream.buffer <> NULL ) then
			function = *ctx->stream.buffer
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

		dim as CStream ptr ctx = userdata
		dim as integer bytes = size * nitems
		
		bytes = iif( bytes < ctx->size, bytes, ctx->size )
		
		if( bytes = 0 ) then
			return 0
		end if

		memcpy( buffer, ctx->buffer + ctx->pos, bytes )
		ctx->pos += bytes
		ctx->size -= bytes
		
		function = bytes

	end function

	'':::::
	function CHttpStream.Send _
		( _
			byval url as zstring ptr, _
			byval data_ as any ptr, _
			byval bytes as integer, _
			byval doreset as integer _
		) as integer

		dim as CURL ptr curl
		
		if( ctx = NULL ) then
			return FALSE
		end if

		if( ctx->http = NULL ) then
			return FALSE
		end if

		if( bytes <= 0 ) then
			return TRUE
		end if

		curl = ctx->http->GetHandle()
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
		curl_easy_setopt( curl, CURLOPT_READFUNCTION, @send_cb )
		curl_easy_setopt( curl, CURLOPT_READDATA, @ctx->stream )

 		if( curl_easy_perform( curl ) <> 0 ) then
 			return FALSE
 		end if
 		
		function = TRUE

	end function

end namespace
