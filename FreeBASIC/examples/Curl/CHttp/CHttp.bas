''
'' CHttp - a pseudo-class wrapper for the CURL library
''
'' to build: fbc -lib CHtpp.bas CHttpStream.bas CHttpForm.bas
''



#include once "CHttp.bi"
#include once "curl.bi"

type CHttp_
	as CURL ptr 			curl
	as curl_slist ptr 		headerlist
end type

'':::::
function CHttp_New _
	( _
		byval _this as CHttp ptr _
	) as CHttp ptr
	
	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = allocate( len( CHttp ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if
  
  	curl_global_init( CURL_GLOBAL_ALL )

  	_this->curl = curl_easy_init()
  	if( _this->curl = NULL ) then
  		if( isstatic = FALSE ) then
  			deallocate( _this )
  		end if
  		return NULL
  	end if

  	curl_easy_setopt( _this->curl, CURLOPT_VERBOSE, TRUE )
	curl_easy_setopt( _this->curl, CURLOPT_COOKIEFILE, "" )
	
	_this->headerlist = curl_slist_append( NULL, "Expect:" )
  	if( _this->headerlist = NULL ) then
  		if( isstatic = FALSE ) then
  			deallocate( _this )
  		end if
  		return NULL
  	end if
  	
  	function = _this
  	
end function

'':::::
sub CHttp_Delete _
	( _
		byval _this as CHttp ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if
	
    if( _this->headerlist <> NULL ) then
    	curl_slist_free_all( _this->headerlist )
    	_this->headerlist = NULL
    end if
	
	if( _this->curl <> NULL ) then
		curl_easy_cleanup( _this->curl )
		_this->curl = NULL
	end if		
	
	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
function CHttp_Post _
	( _
		byval _this as CHttp ptr, _
		byval url as zstring ptr, _
		byval form as CHTtpForm ptr _
	) as string

	function = ""
	
	if( _this = NULL ) then
		exit function
	end if

	if( _this->curl = NULL ) then
		exit function
	end if
	
	dim as CHttpStream ptr stream = CHttpStream_New( _this )

    curl_easy_reset( _this->curl )
    curl_easy_setopt( _this->curl, CURLOPT_HTTPHEADER, _this->headerlist )
    curl_easy_setopt( _this->curl, CURLOPT_HTTPPOST, CHttpForm_GetHandle( form ) )

    if( CHttpStream_Receive( stream, url, FALSE ) ) then
    	function = CHttpStream_Read( stream )
    end if
    
    CHttpStream_Delete( stream )
    
end function

'':::::
function CHttp_GetHandle _
	( _
		byval _this as CHttp ptr _
	) as any ptr
	
	if( _this = NULL ) then
		return NULL
	end if

	function = _this->curl
	
end function
