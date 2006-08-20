''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006 Jeffery R. Marshall (coder[at]execulink.com) and
''  the FreeBASIC development team.
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
''

#include once "CHttp.bi"
#include once "CHttpStream.bi"
#include once "curl.bi"
#include once "crt/string.bi"

#define CURLOPT_WRITEDATA CURLOPT_FILE
#define CURLOPT_READDATA CURLOPT_INFILE

const CSTREAM_MINALLOC = 1024

type CStream
	as byte ptr				buffer
	as integer				size	
	as integer				pos
end type

type CHttpStream_
	as CHttp ptr 			http
	as integer				delcon
	as CStream 				stream
end type

'':::::
function CHttpStream_New _
	( _
		byval http as CHttp ptr, _
		byval _this as CHttpStream ptr _
	) as CHttpStream ptr
	
	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CHttpStream ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if
	
	if( http = NULL ) then
		http = CHttp_New( )
		_this->delcon = TRUE
	else
		_this->delcon = FALSE
	end if
	
	_this->http = http
	_this->stream.buffer = NULL

  	function = _this
  	
end function

'':::::
sub CHttpStream_Delete _
	( _
		byval _this as CHttpStream ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

 	if( _this->stream.buffer <> NULL ) then
 		deallocate( _this->stream.buffer )
 		_this->stream.buffer = NULL
 	end if

 	if( _this->http <> NULL ) then
 		if( _this->delcon ) then
 			CHttp_Delete( _this->http )	
 		end if
 		_this->http = NULL
	end if
	
	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
private function recv_cb cdecl _
	( _
		byval buffer as byte ptr, _
		byval size as integer, _
		byval nitems as integer, _
		byval userdata as any ptr _
	) as integer

	dim as CStream ptr _this = userdata
	dim as integer bytes = size * nitems
	
	if( _this->pos + bytes >= _this->size ) then
		_this->size += iif( bytes < CSTREAM_MINALLOC, CSTREAM_MINALLOC, bytes )
		_this->buffer = reallocate( _this->buffer, _this->size + 1 )
	end if
	
	memcpy( _this->buffer + _this->pos, buffer, bytes )
	_this->pos += bytes
	
	function = bytes

end function

'':::::
function CHttpStream_Receive _
	( _
		byval _this as CHttpStream ptr, _
		byval url as zstring ptr, _
		byval doreset as integer _
	) as integer

	dim as CURL ptr curl
	
	if( _this = NULL ) then
		return FALSE
	end if

	if( _this->http = NULL ) then
		return FALSE
	end if

	curl = CHttp_GetHandle( _this->http )
	if( curl = NULL ) then
		return FALSE
	end if
	
 	''
 	if( _this->stream.buffer <> NULL ) then
 		deallocate( _this->stream.buffer )
 		_this->stream.buffer = NULL
 	end if
 	
 	_this->stream.size = 0
 	_this->stream.pos = 0
 	
 	''
 	if( doreset ) then
 		curl_easy_reset( curl )
 	end if
	curl_easy_setopt( curl, CURLOPT_URL, url )
	curl_easy_setopt( curl, CURLOPT_WRITEFUNCTION, @recv_cb )
	curl_easy_setopt( curl, CURLOPT_WRITEDATA, @_this->stream )

 	if( curl_easy_perform( curl ) <> 0 ) then
 		if( _this->stream.buffer <> NULL ) then
 			deallocate( _this->stream.buffer )
 			_this->stream.buffer = NULL
 		end if
 		return FALSE
 	end if
 	
	if( _this->stream.buffer <> NULL ) then
		_this->stream.buffer[_this->stream.pos] = 0
	end if
	
	function = TRUE

end function

'':::::
function CHttpStream_Read _
	( _
		byval _this as CHttpStream ptr _
	) as string
	
	function = ""
	
	if( _this = NULL ) then
		exit function
	end if

	if( _this->stream.buffer <> NULL ) then
		function = *_this->stream.buffer
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

	dim as CStream ptr _this = userdata
	dim as integer bytes = size * nitems
	
	bytes = iif( bytes < _this->size, bytes, _this->size )
	
	if( bytes = 0 ) then
		return 0
	end if

	memcpy( buffer, _this->buffer + _this->pos, bytes )
	_this->pos += bytes
	_this->size -= bytes
	
	function = bytes

end function

'':::::
function CHttpStream_Send _
	( _
		byval _this as CHttpStream ptr, _
		byval url as zstring ptr, _
		byval data_ as any ptr, _
		byval bytes as integer, _
		byval doreset as integer _
	) as integer

	dim as CURL ptr curl
	
	if( _this = NULL ) then
		return FALSE
	end if

	if( _this->http = NULL ) then
		return FALSE
	end if

	if( bytes <= 0 ) then
		return TRUE
	end if

	curl = CHttp_GetHandle( _this->http )
	if( curl = NULL ) then
		return FALSE
	end if
	
 	''
 	if( _this->stream.buffer <> NULL ) then
 		deallocate( _this->stream.buffer )
 		_this->stream.buffer = NULL
 	end if
 	
 	_this->stream.buffer = data_
 	_this->stream.size = bytes
 	_this->stream.pos = 0
 	
 	''
 	if( doreset ) then
 		curl_easy_reset( curl )
 	end if
	curl_easy_setopt( curl, CURLOPT_URL, url )
	curl_easy_setopt( curl, CURLOPT_READFUNCTION, @send_cb )
	curl_easy_setopt( curl, CURLOPT_READDATA, @_this->stream )

 	if( curl_easy_perform( curl ) <> 0 ) then
 		return FALSE
 	end if
 	
	function = TRUE

end function
