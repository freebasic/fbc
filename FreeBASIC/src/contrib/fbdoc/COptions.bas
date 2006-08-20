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


'' COptions - pseudo class for options storage 
''            and in-string expansion
''
'' chng: jun/2006 written [coderJeff]
''

#include once "common.bi"
#include once "list.bi"
#include once "COptions.bi"

type ListItem
	as any ptr				ll_prev
	as any ptr				ll_next

	as COption itmdata
end type

type COptions_
	as TLIST lst
end type

'':::::
function COptions_New _
	( _
		byval sFileName as zstring ptr, _
		byval _this as COptions ptr _
	) as COptions ptr

	dim as integer isstatic = TRUE
	

	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( COptions ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	listNew( @_this->lst, 16, len( ListItem ), TRUE )

	if( sFileName <> NULL ) then
		if( len(*sFileName) > 0 ) then
			COptions_ReadFromFile( _this, sFileName )
		end if
	end if

	function = _this

end function

'':::::
private sub COptions_FreePageList _
	( _
		byval _this as COptions ptr _
	)
	
	dim as ListItem ptr itm, nxt

	itm = cast( ListItem ptr, listGetHead( @_this->lst ) )
	do while( itm <> NULL )
		nxt = cast( ListItem ptr, listGetNext( itm ) )

		ZFree @itm->itmData.sKey
		ZFree @itm->itmData.sValue
		listDelNode( @_this->lst, cast( any ptr, itm ) )
		
		itm = nxt
	loop
	
end sub

'':::::
sub COptions_Delete _
	( _
		byval _this as COptions ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	COptions_FreePageList _this

	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
sub COptions_Clear _
	( _
		byval _this as COptions ptr _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	COptions_FreePageList _this

end sub

':::::
function COptions_ReadFromFile _
	( _
		byval _this as COptions ptr, _
		byval sFileName as zstring ptr _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	if( sFileName = NULL ) then
		return FALSE
	end if

	if( len(*sFileName) = 0 ) then	
		return FALSE
	end if

	dim as integer h,i
	dim as string x,k,w

	h = freefile
	if( open( *sFileName for input as #h ) = 0 ) then
		while eof(h) = 0
			line input #h, x
			x = trim(x)
			if( len(x) > 0 ) then
				select case left(x, 1)
				case "'", ";"
				case else
					i = instr(x, "=" )
					if( i > 0 ) then
						k = trim(left(x, i - 1), any " " + chr(9) )
						w = trim(mid(x, i + 1), any " " + chr(9) )
						COptions_Set( _this, k, StripQuotes(w) )
					end if
				end select
			end if
		wend
		close #h
		return TRUE
	end if

	return FALSE

end function	

'':::::
function COptions_Set _
	( _
		byval _this as COptions ptr, _
		byval sKey as zstring ptr, _
		byval sValue as zstring ptr _
	) as COption ptr

	dim opt as COption ptr = COptions_Find( _this, sKey )

	if( opt = NULL ) then
		dim as ListItem ptr itm = listNewNode( @_this->lst )
		
		if(itm = NULL) then
			return NULL
		end if

		opt = @itm->itmdata
	end if

	ZSet @opt->sKey, sKey
	ZSet @opt->sValue, sValue

	return opt

end function

function COptions_Get _
	( _
		byval _this as COptions ptr, _
		byval sKey as zstring ptr, _
		byval sDefault as zstring ptr _
	) as string

	dim opt as COption ptr = COptions_Find( _this, sKey )

	if( opt ) then
		if( opt->sValue ) then
			return *opt->sValue
		end if
	end if

	if( sDefault )  then
		return *sDefault
	end if

	return ""

end function

'':::::
function COptions_NextEnum _
	( _
		byval _iter as any ptr ptr _
	) as COption ptr

	if( _iter = NULL ) then
		return NULL
	end if

	if( *_iter = NULL ) then
		return NULL
	end if

	dim as ListItem ptr itm

	itm = cast( ListItem ptr, *_iter )
	itm = listGetNext( itm )

	*_iter = itm

	if( *_iter = NULL ) then
		return NULL
	end if

	function = @itm->itmdata
	
end function

'':::::
function COptions_NewEnum _
	( _
		byval _this as COptions ptr, _
		byval _iter as any ptr ptr _
	) as COption ptr

	if( _this = NULL ) then
		return NULL
	end if

	if( _iter = NULL ) then
		return NULL
	end if

	dim as ListItem ptr itm = listGetHead( @_this->lst )

	if( itm = NULL ) then
		return NULL
	end if

	*_iter = itm

	function = @itm->itmdata

end function

'':::::
function COptions_Find _
	( _
		byval _this as COptions ptr, _
		byval sKey as zstring ptr _
	) as COption ptr

	if( _this = NULL ) then
		return NULL
	end if

	if( sKey = NULL ) then
		return NULL
	end if

	if( len( *sKey ) = 0 ) then
		return NULL
	end if

	dim as COption ptr opt
	dim as any ptr opt_i

	opt = COptions_NewEnum( _this, @opt_i )
	while( opt )
		if lcase( *sKey ) = lcase( *opt->sKey ) then
			return opt
		end if
		opt = COptions_NextEnum( @opt_i )
	wend

	return NULL

end function

'':::::
function COptions_ExpandString _
	( _
		byval _this as COptions ptr, _
		byval sText as zstring ptr _
	) as string

	dim as integer i
	dim as string ret

	ret = *sText

	dim as COption ptr opt
	dim as any ptr opt_i

	opt = COptions_NewEnum( _this, @opt_i )
	while( opt )
		ret = ReplaceSubStr( ret, "{#" + *opt->sKey + "}", *opt->sValue )
		opt = COptions_NextEnum( @opt_i )
	wend

	return ret

end function
