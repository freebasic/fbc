''
'' CRegex - a pseudo-class wrapper for PCRE (based on the PCRE C++ wrapper)
''
'' to build: fbc -lib CRegex.bi
''

option explicit

#include once "CRegex.bi"
#include once "pcre/pcre.bi" 

type CRegex_
	as pcre ptr 		reg
	as pcre_extra ptr 	extra
    as integer ptr 		vectb
    as zstring ptr 		subject
	as integer 			sublen
	as integer 			substrcnt
	as zstring ptr ptr	substrlist
end type

'':::::
function CRegex_New _
	( _
		byval pattern as zstring ptr, _
		byval options as REGEX_OPT, _
		byval _this as CRegex ptr _
	) as CRegex ptr
	
	dim as zstring ptr err_msg
	dim as integer err_ofs
	dim as integer isstatic = TRUE	
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = allocate( len( CRegex ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if
	
	_this->reg = pcre_compile( pattern, options, @err_msg, @err_ofs, NULL ) 
	if( _this->reg = NULL ) then
  		if( isstatic = FALSE ) then
  			deallocate( _this )
  		end if
		return NULL
	end if

	_this->extra = pcre_study( _this->reg, 0, @err_msg )
	pcre_fullinfo( _this->reg, _this->extra, PCRE_INFO_CAPTURECOUNT, @_this->substrcnt )
	_this->substrcnt += 1
	_this->vectb = allocate( len( integer ) * (3 * _this->substrcnt) )
    _this->substrlist = NULL
    
    function = _this
    
end function

'':::::
private sub CRegex_ClearSubstrlist _
	( _
		byval _this as CRegex ptr _
	)
	
	if( _this->substrlist <> NULL ) then
		pcre_free_substring_list( _this->substrlist )
		_this->substrlist = NULL
	end if

end sub

'':::::
sub CRegex_Delete _
	( _
		byval _this as CRegex ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if
	
	CRegex_ClearSubstrlist( _this )
	
	if( _this->vectb <> NULL ) then
		deallocate( _this->vectb )
		_this->vectb = NULL
	end if
	
	if( _this->extra <> NULL ) then
		pcre_free( _this->extra )
		_this->extra = NULL
	end if		
	
	if( _this->reg <> NULL ) then
		pcre_free( _this->reg )
		_this->reg = NULL
	end if		
	
	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
function CRegex_GetMaxMatches _
	( _
		byval _this as CRegex ptr _
	) as integer

	if( _this = NULL ) then
		return 0
	end if
	
	function = _this->substrcnt - 1
	
end function

'':::::
function CRegex_Search _
	( _
		byval _this as CRegex ptr, _
		byval subject as zstring ptr, _
		byval lgt as integer, _
		byval options as REGEX_OPT _
	) as integer
	
	if( _this = NULL ) then
		return FALSE
	end if

	CRegex_Clearsubstrlist( _this )
	
	_this->subject = subject
	_this->sublen = iif( lgt >= 0, lgt, len( *subject ) )
	
	function = ( pcre_exec( _this->reg, _this->extra, _
							subject, _this->sublen, _
							0, options, _
							_this->vectb, 3 * _this->substrcnt ) > 0 )
	
end function

'':::::
function CRegex_SearchNext _
	( _
		byval _this as CRegex ptr, _
		byval options as REGEX_OPT _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	CRegex_Clearsubstrlist( _this )
         
	function = ( pcre_exec( _this->reg, _this->extra, _
							_this->subject, _this->sublen, _
							_this->vectb[1], options, _
							_this->vectb, 3 * _this->substrcnt ) > 0 )

end function

'':::::
function CRegex_GetStr _
	( _
		byval _this as CRegex ptr, _
		byval i as integer _
	) as zstring ptr
         
	if( i < 0 ) then
		return _this->subject
	end if

	if( i >= _this->substrcnt ) then
		return NULL
	end if
         
	if( _this->substrlist = NULL ) then
		pcre_get_substring_list( _this->subject, _this->vectb, _this->substrcnt, @_this->substrlist )
	end if
    
    function = _this->substrlist[i]
    
end function

'':::::
function CRegex_GetOfs _
	( _
		byval _this as CRegex ptr, _
		byval i as integer _
	) as integer
         
	if( i < 0 ) then
		return 0
	end if

	if( i >= _this->substrcnt ) then
		return -1
	end if
	
	function = _this->vectb[i * 2 + 0]
	
end function

'':::::
function CRegex_GetLen _
	( _
		byval _this as CRegex ptr, _
		byval i as integer _
	) as integer
         
	if( i < 0 ) then
		return 0
	end if

	if( i >= _this->substrcnt ) then
		return -1
	end if
	
	function = _this->vectb[i * 2 + 1] - _this->vectb[i * 2 + 0]
	
end function
