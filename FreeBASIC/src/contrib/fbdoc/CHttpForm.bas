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


'' CHttpForm
''
'' chng: apr/2006 written [v1ctor]
''

option explicit

#include once "CHttpForm.bi"
#include once "curl.bi"

type CHttpForm_
	as curl_httppost ptr 	formpost
	as curl_httppost ptr 	lastptr
end type

'':::::
function CHttpForm_New _
	( _
		byval _this as CHttpForm ptr _
	) as CHttpForm ptr
	
	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CHttpForm ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if
  
  	_this->formpost = NULL
  	_this->lastptr = NULL
  	
  	function = _this
  	
end function

'':::::
sub CHttpForm_Delete _
	( _
		byval _this as CHttpForm ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if
	
	if( _this->formpost <> NULL ) then
    	curl_formfree( _this->formpost )
		_this->formpost = NULL
	end if		

	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub


'':::::
function CHttpForm_Add4 _
	( _
		byval _this as CHttpForm ptr, _
		byval name_ as zstring ptr, _
		byval value as zstring ptr, _
		byval type_ as zstring ptr _
	) as integer
  
	if( _this = NULL ) then
		return FALSE
	end if
  
	if( type_ = NULL ) then
		function = curl_formadd( @_this->formpost, _
        	          			 @_this->lastptr, _
            	      			 CURLFORM_COPYNAME, name_, _
                	  			 CURLFORM_COPYCONTENTS, value, _
                  	  			 CURLFORM_END ) = 0
	
	else
		function = curl_formadd( @_this->formpost, _
        	          			 @_this->lastptr, _
            	      			 CURLFORM_COPYNAME, name_, _
                	  			 CURLFORM_COPYCONTENTS, value, _
                	  			 CURLFORM_CONTENTTYPE, type_, _
                  	  			 CURLFORM_END ) = 0
	
	end if
                  	
end function

'':::::
function CHttpForm_Add3 _
	( _
		byval _this as CHttpForm ptr, _
		byval name_ as zstring ptr, _
		byval value as integer _
	) as integer
	
	function = CHttpForm_Add4( _this, name_, str( value ) )
	
end function

'':::::
function CHttpForm_GetHandle _
	( _
		byval _this as CHttpForm ptr _
	) as any ptr
	
	if( _this = NULL ) then
		return NULL
	end if
	
	function = _this->formpost
	
end function
