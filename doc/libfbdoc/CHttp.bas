''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2022 The FreeBASIC development team.
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
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.


'' CHttp
''
'' chng: apr/2006 written [v1ctor]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "CHttp.bi"
#include once "CHttpForm.bi"
#include once "CHttpStream.bi"
#include once "curl.bi"
#include once "fbdoc_trace.bi"

namespace fb

	type CHttpCtx_
		as CURL ptr 			curl
		as curl_slist ptr 		headerlist
	end type

	'':::::
	static sub CHttp.GlobalInit()
		curl_global_init( CURL_GLOBAL_ALL )
	end sub

	'':::::
	constructor CHttp _
		( _
		)
		
		ctx = new CHttpCtx

		curl_global_init( CURL_GLOBAL_ALL )

		ctx->curl = curl_easy_init()

		if( fbdoc.get_trace() ) then
			curl_easy_setopt( ctx->curl, CURLOPT_VERBOSE, TRUE )
		end if

		curl_easy_setopt( ctx->curl, CURLOPT_COOKIEFILE, "" )

		'' TODO: Use option file or command line arguments
		'' curl_easy_setopt( ctx->curl, CURLOPT_PROXY, "http://proxyname:80" )
		'' curl_easy_setopt( ctx->curl, CURLOPT_PROXYUSERPWD, "domain\username:password" )
 		'' curl_easy_setopt( ctx->curl, CURLOPT_PROXYAUTH, CURLAUTH_NTLM )

		ctx->headerlist = curl_slist_append( NULL, "Expect:" )

	end constructor

	'':::::
	destructor CHttp _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if
		
		if( ctx->headerlist <> NULL ) then
    		curl_slist_free_all( ctx->headerlist )
    		ctx->headerlist = NULL
		end if
		
		if( ctx->curl <> NULL ) then
			curl_easy_cleanup( ctx->curl )
			ctx->curl = NULL
		end if		

		delete ctx

	end destructor

	'':::::
	function CHttp.Post _
		( _
			byval url as zstring ptr, _
			byval form as CHTtpForm ptr, _
			byval ca_file as zstring ptr _
		) as string

		function = ""
		
		if( ctx = NULL ) then
			exit function
		end if

		if( ctx->curl = NULL ) then
			exit function
		end if
		
		dim as CHttpStream ptr stream = new CHttpStream( @this )

		curl_easy_reset( ctx->curl )
		curl_easy_setopt( ctx->curl, CURLOPT_HTTPHEADER, ctx->headerlist )
		curl_easy_setopt( ctx->curl, CURLOPT_HTTPPOST, form->GetHandle() )

		if( stream->Receive( url, FALSE, ca_file ) ) then
    		function = stream->Read()
		end if
    
		delete stream
    
	end function

	'':::::
	function CHttp.GetHandle _
		( _
		) as any ptr
		
		if( ctx = NULL ) then
			return NULL
		end if

		function = ctx->curl
		
	end function

end namespace
