''
'' CHttp - a class wrapper for the CURL library
''

#include once "CHttp.bi"
#include once "curl.bi"

type CHttpFormCtx_
	dim as curl_httppost ptr formpost
	dim as curl_httppost ptr lastptr
end type

'':::::
constructor CHttpForm _
	( _
		_
	) 
	
	ctx = new CHttpFormCtx_
  
  	ctx->formpost = NULL
  	ctx->lastptr = NULL
  	
end constructor

'':::::
destructor CHttpForm _
	( _
		_
	)
	
	if( ctx->formpost <> NULL ) then
    	curl_formfree( ctx->formpost )
		ctx->formpost = NULL
	end if		

	delete ctx

end destructor

'':::::
function CHttpForm.add _
	( _
		byval name_ as zstring ptr, _
		byval value as zstring ptr, _
		byval type_ as zstring ptr _
	) as integer
  
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
function CHttpForm.add _
	( _
		byval name_ as zstring ptr, _
		byval value as integer _
	) as integer
	
	function = add( name_, str( value ) )
	
end function

'':::::
function CHttpForm.getHandle _
	( _
		_
	) as any ptr
	
	function = ctx->formpost
	
end function
