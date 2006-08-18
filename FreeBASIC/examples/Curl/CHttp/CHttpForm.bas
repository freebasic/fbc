''
'' CHttp - a pseudo-class wrapper for the CURL library
''



#include once "CHttp.bi"
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
		_this = allocate( len( CHttpForm ) )
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
function CHttpForm_Add _
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
function CHttpForm_Add _
	( _
		byval _this as CHttpForm ptr, _
		byval name_ as zstring ptr, _
		byval value as integer _
	) as integer
	
	function = CHttpForm_Add( _this, name_, str( value ) )
	
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
