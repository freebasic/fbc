''
'' CRegex - a class wrapper for PCRE (based on the PCRE C++ wrapper)
''
'' to build: fbc -lib CRegex.bas
''

#include once "CRegex.bi"

constructor CRegex _
	( _
		byval pattern as zstring ptr, _
		byval opt as options _
	) 

	dim as zstring ptr err_msg = any
	dim as integer err_ofs = any
	
	reg = pcre_compile( pattern, opt, @err_msg, @err_ofs, NULL ) 
	if( reg = NULL ) then
		return
	end if

	extra = pcre_study( reg, 0, @err_msg )
	pcre_fullinfo( reg, extra, PCRE_INFO_CAPTURECOUNT, @substrcnt )
	substrcnt += 1
	vectb = allocate( len( integer ) * (3 * substrcnt) )
	substrlist = NULL
end constructor

sub CRegex.clearSubstrlist()
	if( substrlist <> NULL ) then
		pcre_free_substring_list( substrlist )
		substrlist = NULL
	end if
end sub

destructor CRegex()
	clearSubstrlist( )

	if( vectb <> NULL ) then
		deallocate( vectb )
		vectb = NULL
	end if

	if( extra <> NULL ) then
		pcre_free( extra )
		extra = NULL
	end if

	if( reg <> NULL ) then
		pcre_free( reg )
		reg = NULL
	end if
end destructor

function CRegex.getMaxMatches() as integer
	function = substrcnt - 1
end function

function CRegex.search _
	( _
		byval subject as zstring ptr, _
		byval lgt as integer, _
		byval opt as options _
	) as integer
	
	clearsubstrlist( )

	this.subject = subject
	sublen = iif( lgt >= 0, lgt, len( *subject ) )

	function = ( pcre_exec( reg, extra, subject, sublen, 0, opt, vectb, 3 * substrcnt ) > 0 )
end function

function CRegex.searchNext _
	( _
		byval opt as options _
	) as integer

	clearsubstrlist( )

	function = ( pcre_exec( reg, extra, subject, sublen, vectb[1], opt, vectb, 3 * substrcnt ) > 0 )
end function

function CRegex.getStr _
	( _
		byval i as integer _
	) as zstring ptr

	if( i < 0 ) then
		return subject
	end if

	if( i >= substrcnt ) then
		return NULL
	end if

	if( substrlist = NULL ) then
		pcre_get_substring_list( subject, vectb, substrcnt, @substrlist )
	end if

	function = substrlist[i]
end function

function CRegex.getOfs _
	( _
		byval i as integer _
	) as integer

	if( i < 0 ) then
		return 0
	end if

	if( i >= substrcnt ) then
		return -1
	end if

	function = vectb[i * 2 + 0]
end function

function CRegex.getLen _
	( _
		byval i as integer _
	) as integer

	if( i < 0 ) then
		return 0
	end if

	if( i >= substrcnt ) then
		return -1
	end if

	function = vectb[i * 2 + 1] - vectb[i * 2 + 0]
end function
