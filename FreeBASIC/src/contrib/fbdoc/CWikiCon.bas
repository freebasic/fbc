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


'' CWikiCon
''
'' chng: apr/2006 written [v1ctor]
'' chng: sep/2006 updated [coderJeff]
''

#include once "CHttp.bi"
#include once "CHttpForm.bi"
#include once "CHttpStream.bi"
#include once "CWikiCon.bi"

type CWikiCon_
	as CHttp ptr		http
	as zstring ptr		url
	as zstring ptr		pagename
	as integer			pageid
end type

const wakka_prefix = "?wakka="
const wakka_loginpage = "UserSettings"
const wakka_raw = "/raw"
const wakka_edit = "/edit"
const wakka_getid = "/getid"
const wakka_error = "wiki-error"
const wakka_response = "wiki-response"

'':::::
private function build_url _
	( _
		byval _this as CWikiCon ptr, _
		byval page as zstring ptr = NULL, _
		byval method as zstring ptr = NULL _
	) as string

	dim as string url
	
	url = *_this->url + wakka_prefix
	
	if( page = NULL ) then
		page = _this->pagename 
	end if
	
	url += *page
	
	if( method <> NULL ) then
		url += *method
	end if
	
	function = url

end function

'':::::
function CWikiCon_New _
	( _
		byval url as zstring ptr, _
		byval _this as CWikiCon ptr _
	) as CWikiCon ptr

	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CWikiCon ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if
  
  	_this->http = CHttp_New( )
  	if( _this->http = NULL ) then
  		if( isstatic = FALSE ) then
  			deallocate( _this )
  		end if
  		return NULL
  	end if
  	
  	_this->url = allocate( len( *url ) + 1 )
  	*_this->url = *url
  	
  	_this->pagename = NULL
  	_this->pageid = 0
  	
  	function = _this
	
end function

'':::::
sub CWikiCon_Delete _
	( _
		byval _this as CWikiCon ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if
	
    if( _this->pagename <> NULL ) then
    	deallocate( _this->pagename )
    	_this->pagename = NULL
    end if

    if( _this->url <> NULL ) then
    	deallocate( _this->url )
    	_this->url = NULL
    end if
	
	if( _this->http <> NULL ) then
		CHttp_Delete( _this->http )
		_this->http = NULL
	end if		
	
	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
private function check_iserror _
	( _
		byval body as zstring ptr _
	) as integer
	
	if( len( *body ) = 0 ) then
		return TRUE
	end if
	
	function = ( instr( 1, *body, "<" + wakka_error + ">" ) > 0 )
	
end function

'':::::
function CWikiCon_Login _
	( _
		byval _this as CWikiCon ptr, _
		byval username as zstring ptr, _
		byval password as zstring ptr _
	) as integer
	
	if( _this = NULL ) then
		return FALSE
	end if
	
	dim as CHttpForm ptr form
	
	form = CHttpForm_New( )
	if( form = NULL ) then
		return FALSE
	end if
	
	CHttpForm_Add4( form, "action", "login" )
	CHttpForm_Add4( form, "wakka", "UserSettings" )
	CHttpForm_Add4( form, "name", username )
	CHttpForm_Add4( form, "password", password )
	
	dim as string response = CHttp_Post( _this->http, build_url( _this, wakka_loginpage ), form )
	
	function = ( check_iserror( response ) = FALSE )
	
	CHttpForm_Delete( form )

end function

'':::::
private function get_response _
	( _
		byval body as zstring ptr _
	) as string
	
	dim as string res
	dim as integer ps, pe, lgt, i
	
	function = ""
	
	if( len( *body ) = 0 ) then
		exit function
	end if
	
	ps = instr( 1, *body, "<" + wakka_response + ">" )
	if( ps = 0 ) then
		exit function
	end if

	pe = instr( ps, *body, "</" + wakka_response + ">" )
	if( pe = 0 ) then
		exit function
	end if
	
	ps -= 1
	pe -= 1
	
	ps += 1 + len( wakka_response ) + 1
	lgt = ((pe - 1) - ps) + 1
	res = space( lgt )
	i = 0
	do while( i < lgt )
		res[i] = body[ps+i]
		i += 1
	loop
	
	function = res
	
end function

'':::::
private sub remove_http_headers( byref body as string )

	dim as integer i = 1, n = len(body)
	const whitespace = chr(9,10,13,32)
	const crlfcrlf = chr(13,10,13,10)

	while( i <= n )
		if instr(whitespace,mid(body, i, 1)) = 0 then
			exit while
		end if
		i += 1
	wend

	if ( i < n ) then
		if( mid(body, i, 5) = "HTTP/" ) then
			i = instr( i, body, crlfcrlf )
			if( i > 0 ) then
				body = mid( body, i + 4 )
			end if

		end if
	end if

end sub

'':::::
private function get_pageid _
	( _
		byval _this as CWikiCon ptr _
	) as integer
	
	dim as CHttpStream ptr stream
	
	function = -1
	
	stream = CHttpStream_New( _this->http )
	if( stream = NULL ) then
		exit function
	end if
		
	dim as string body, URL
	URL = build_url( _this, NULL, wakka_getid )
	
	if( CHttpStream_Receive( stream, URL, TRUE ) ) then
		body = CHttpStream_Read( stream )
	end if

	CHttpStream_Delete( stream )
	
	if( check_iserror( body ) = FALSE ) then
		remove_http_headers( body )
		function = valint( get_response( body ) )
	end if
	
end function

'':::::
function CWikiCon_LoadPage _
	( _
		byval _this as CWikiCon ptr, _
		byval page as zstring ptr, _
		byval israw as integer, _
		byval getid as integer, _
		byref body as string _
	) as integer

	function = FALSE
	body = ""
	
	if( _this = NULL ) then
		exit function
	end if

	_this->pageid = -1
	_this->pagename = reallocate( _this->pagename, len( *page ) + 1 )
	*_this->pagename = *page
	
	dim as CHttpStream ptr stream
	
	stream = CHttpStream_New( _this->http )
	if( stream = NULL ) then
		exit function
	end if
		
	dim as zstring ptr rawmethod = iif( israw, @wakka_raw, NULL )
	
	dim URL as string
	URL = build_url( _this, NULL, rawmethod )

	if( CHttpStream_Receive( stream, URL, TRUE ) ) then
		body = CHttpStream_Read( stream )
		remove_http_headers( body )
	end if
	
	CHttpStream_Delete( stream )
	
	if( getid ) then
		'if( len( body ) > 0 ) then
			_this->pageid = get_pageid( _this )
		'else
		'	_this->pageid = -1
		'end if
	else
			_this->pageid = -1
	end if	

	''body += chr( 13, 10 )
	
	function = TRUE
	
end function

'':::::
function CWikiCon_StorePage _
	( _
		byval _this as CWikiCon ptr, _
		byval body as zstring ptr, _
		byval note as zstring ptr _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	if( _this->pageid <= 0 ) then
		return FALSE
	end if
	
	dim as CHttpForm ptr form
	
	form = CHttpForm_New( )
	if( form = NULL ) then
		return FALSE
	end if

	CHttpForm_Add4( form, "wakka", *_this->pagename + wakka_edit )

	CHttpForm_Add3( form, "previous",  _this->pageid )
	CHttpForm_Add4( form, "body", body, "text/html" )
	if( note ) then
		CHttpForm_Add4( form, "note", *note )
	else
		CHttpForm_Add4( form, "note", "new format" )
	end if

	CHttpForm_Add4( form, "submit", "Store" )

	dim url as string 
	URL = build_url( _this, NULL, wakka_edit )

	dim as string response = CHttp_Post( _this->http, url, form )

	dim as integer res = ( check_iserror( response ) = FALSE )

	if( res ) then 
		_this->pageid = get_pageid( _this )
	end if
	
	CHttpForm_Delete( form )
	
	function = res
	
end function

'':::::
function CWikiCon_StoreNewPage _
	( _
		byval _this as CWikiCon ptr, _
		byval body as zstring ptr, _
		byval pagename as zstring ptr _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	dim as CHttpForm ptr form
	
	form = CHttpForm_New( )
	if( form = NULL ) then
		return FALSE
	end if

	CHttpForm_Add4( form, "wakka", *pagename + wakka_edit )

	CHttpForm_Add4( form, "previous",  " " )
	CHttpForm_Add4( form, "body", body, "text/html" )
	CHttpForm_Add4( form, "note", "new page" )
	CHttpForm_Add4( form, "submit", "Store" )
	
	dim URL as string
	URL = build_url( _this, pagename, wakka_edit )
	
	dim as string response = CHttp_Post( _this->http, URL, form )
	
	dim as integer res = ( check_iserror( response ) = FALSE )

	if( res ) then 
		_this->pageid = get_pageid( _this )
	end if
	
	CHttpForm_Delete( form )
	
	function = res
	
end function

'':::::
function CWikiCon_GetPageID _
	( _
		byval _this as CWikiCon ptr _
	) as integer

	if( _this = NULL ) then
		return 0
	end if

	return _this->pageid

end function