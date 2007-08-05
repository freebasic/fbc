''
'' CHttp - a class wrapper for the CURL library
''
'' to build: fbc -lib CHttp.bas CHttpStream.bas CHttpForm.bas
''

#include once "CHttp.bi"
#include once "curl.bi"

type CHttpCtx_
	dim as CURL ptr curl
	dim as curl_slist ptr headerlist
end type

'':::::
constructor CHttp _
	( _
		_
	) 
	
	ctx = new CHttpCtx_
  
  	curl_global_init( CURL_GLOBAL_ALL )

  	ctx->curl = curl_easy_init()
  	if( ctx->curl = NULL ) then
  		delete ctx
  		return
  	end if

	curl_easy_setopt( ctx->curl, CURLOPT_COOKIEFILE, "" )
	
	ctx->headerlist = curl_slist_append( NULL, "Expect:" )
  	if( ctx->headerlist = NULL ) then
  		delete ctx
  		return
  	end if
  	
end constructor

'':::::
destructor CHttp _
	( _
		_
	)
	
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
function CHttp.post _
	( _
		byval url as zstring ptr, _
		byval form as CHTtpForm ptr, _
		byval is_binary as integer _
	) as string

	if( ctx->curl = NULL ) then
		return ""
	end if
	
	dim as CHttpStream ptr stream = new CHttpStream( @this )

    curl_easy_reset( ctx->curl )
    
    curl_easy_setopt( ctx->curl, CURLOPT_HTTPHEADER, ctx->headerlist )
    curl_easy_setopt( ctx->curl, CURLOPT_HTTPPOST, form->getHandle( ) )

    if( stream->receive( url, NULL, FALSE ) ) then
    	function = stream->read( is_binary )
    end if
    
    delete stream
    
end function

'':::::
function CHttp.getHandle _
	( _
		_
	) as any ptr
	
	function = ctx->curl
	
end function
