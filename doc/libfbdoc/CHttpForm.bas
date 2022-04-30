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


'' CHttpForm
''
'' chng: apr/2006 written [v1ctor]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "CHttpForm.bi"
#include once "curl.bi"

namespace fb

	type CHttpFormCtx_
		as curl_httppost ptr 	formpost
		as curl_httppost ptr 	lastptr
	end type

	'':::::
	constructor CHttpForm _
		( _
		)
		
		ctx = new CHttpFormCtx

  		ctx->formpost = NULL
  		ctx->lastptr = NULL
  		
	end constructor

	'':::::
	destructor CHttpForm _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if
		
		if( ctx->formpost <> NULL ) then
    		curl_formfree( ctx->formpost )
			ctx->formpost = NULL
		end if		

		delete ctx

	end destructor

	'':::::
	function CHttpForm.Add _
		( _
			byval name_ as zstring ptr, _
			byval value as zstring ptr, _
			byval type_ as zstring ptr _
		) as integer
  
		if( ctx = NULL ) then
			return FALSE
		end if
  
		if( type_ = NULL ) then
			function = curl_formadd( @ctx->formpost, _
        	          				 @ctx->lastptr, _
            	      				 CURLFORM_COPYNAME, name_, _
                	  				 CURLFORM_COPYCONTENTS, value, _
                  	  				 CURLFORM_END ) = 0
		
		else
			function = curl_formadd( @ctx->formpost, _
        	          				 @ctx->lastptr, _
            	      				 CURLFORM_COPYNAME, name_, _
                	  				 CURLFORM_COPYCONTENTS, value, _
                	  				 CURLFORM_CONTENTTYPE, type_, _
                  	  				 CURLFORM_END ) = 0
		
		end if
                  		
	end function

	'':::::
	function CHttpForm.Add _
		( _
			byval name_ as zstring ptr, _
			byval value as integer _
		) as integer
		
		function = this.Add( name_, str( value ) )
		
	end function

	'':::::
	function CHttpForm.GetHandle _
		( _
		) as any ptr
		
		if( ctx = NULL ) then
			return NULL
		end if
		
		function = ctx->formpost
		
	end function

end namespace
