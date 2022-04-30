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


'' COptions - class for options storage 
''            and in-string expansion
''
'' chng: jun/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "list.bi"
#include once "COptions.bi"

namespace fb.fbdoc

	type ListItem
		as COption itmdata
	end type

	type COptionsCtx_
		as Clist ptr lst
	end type

	'':::::
	constructor COptions _
		( _
			byval sFileName as zstring ptr _
		)

		ctx = new COptionsCtx

		ctx->lst = new CList( 16, len( ListItem ) )

		if( sFileName <> NULL ) then
			if( len(*sFileName) > 0 ) then
				this.ReadFromFile( sFileName )
			end if
		end if

	end constructor

	'':::::
	private sub _ClearList _
		( _
			byval ctx as COptionsCtx ptr _
		)
		
		dim as ListItem ptr itm, nxt

		itm = ctx->lst->GetHead()
		do while( itm <> NULL )
			nxt = ctx->lst->GetNext( itm )

			ZFree @itm->itmData.sKey
			ZFree @itm->itmData.sValue
			ctx->lst->Remove( itm )
			
			itm = nxt
		loop
		
	end sub

	'':::::
	destructor COptions _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if

		_ClearList( ctx )
		delete ctx->lst
		delete ctx

	end destructor

	'':::::
	sub COptions.Clear _
		( _
		)
		
		if( ctx = NULL ) then
			exit sub
		end if

		_ClearList( ctx )

	end sub

	':::::
	function COptions.ReadFromFile _
		( _
			byval sFileName as zstring ptr _
		) as integer

		if( ctx = NULL ) then
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
							this.Set( k, StripQuotes(w) )
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
	function COptions.Set _
		( _
			byval sKey as zstring ptr, _
			byval sValue as zstring ptr _
		) as COption ptr

		dim opt as COption ptr = this.Find( sKey )

		if( opt = NULL ) then
			dim as ListItem ptr itm = ctx->lst->Insert()
			
			if(itm = NULL) then
				return NULL
			end if

			opt = @itm->itmdata
		end if

		ZSet @opt->sKey, sKey
		ZSet @opt->sValue, sValue

		return opt

	end function

	function COptions.Get _
		( _
			byval sKey as zstring ptr, _
			byval sDefault as zstring ptr _
		) as string

		dim opt as COption ptr = this.Find( sKey )

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
	function COptions.NextEnum _
		( _
			byval _iter as any ptr ptr _
		) as COption ptr

		if( ctx = NULL ) then
			return NULL
		end if

		if( ctx->lst = NULL ) then
			return NULL
		end if

		if( _iter = NULL ) then
			return NULL
		end if

		*_iter = ctx->lst->GetNext(*_iter)

		if( *_iter ) then
			return cast(COption ptr, *_iter)
		end if

		return NULL

	end function

	'':::::
	function COptions.NewEnum _
		( _
			byval _iter as any ptr ptr _
		) as COption ptr

		if( ctx = NULL ) then
			return NULL
		end if

		if( _iter = NULL ) then
			return NULL
		end if

		if( ctx->lst = NULL ) then
			return NULL
		end if

		*_iter = ctx->lst->GetHead()

		if( *_iter ) then
			return cast(COption ptr, *_iter)
		end if

		return NULL

	end function

	'':::::
	function COptions.Find _
		( _
			byval sKey as zstring ptr _
		) as COption ptr

		if( ctx = NULL ) then
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

		opt = this.NewEnum( @opt_i )
		while( opt )
			if lcase( *sKey ) = lcase( *opt->sKey ) then
				return opt
			end if
			opt = this.NextEnum( @opt_i )
		wend

		return NULL

	end function

	'':::::
	function COptions.ExpandString _
		( _
			byval sText as zstring ptr _
		) as string

		dim as integer i
		dim as string ret

		ret = *sText

		dim as COption ptr opt
		dim as any ptr opt_i

		opt = this.NewEnum( @opt_i )
		while( opt )
			ret = ReplaceSubStr( ret, "{#" + *opt->sKey + "}", *opt->sValue )
			opt = this.NextEnum( @opt_i )
		wend

		return ret

	end function

end namespace
