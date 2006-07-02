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


'' CRegex - a pseudo-class wrapper for PCRE (based in the PCRE C++ wrapper)
''
'' chng: apr/2006 written [v1ctor]
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
