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


'' CWikiCache - Save/Load raw wiki pages to/from a local dir
''
'' chng: may/2006 written [coderJeff]
''

#include once "CWikiCache.bi"

type CWikiCache_
	as zstring ptr localdir
	as integer RefreshMode
end type

const cache_ext = ".wakka"

'':::::
function CWikiCache_New _
	( _
		byval localdir as zstring ptr, _
		byval RefreshMode as integer, _
		byval _this as CWikiCache ptr _
	) as CWikiCache ptr

	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CWikiCache ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

  ZSet @_this->localdir, localdir
	_this->RefreshMode = RefreshMode

	function = _this

end function

'':::::
sub CWikiCache_Delete _
	( _
		byval _this as CWikiCache ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	ZFree @_this->localdir
	
	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub


'':::::
function CWikiCache_LoadPage _
	( _
		byval _this as CWikiCache ptr, _
		byval sPage as zstring ptr, _
		byref sBody as string _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	if( sPage = NULL ) then
		return FALSE
	end if

	if( len(*sPage) = 0) then
		return FALSE
	endif

	dim as integer h
	dim as string sLocalFile

	function = FALSE
	sBody = ""

	sLocalFile = *_this->localdir + *sPage + cache_ext

	if( dir( sLocalFile ) > "" ) then
		h = freefile
		if( open( sLocalFile for binary as #h) = 0 ) then
			if( lof(h) > 0 ) then
				sBody = space( lof(	h ) )
				get #h,,sBody
			end if
			close #h
			function = TRUE
		end if
	end if

end function

'':::::
function CWikiCache_SavePage _
	( _
		byval _this as CWikiCache ptr, _
		byval sPage as zstring ptr, _
		byval sBody as zstring ptr _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	if( sPage = NULL ) then
		return FALSE
	end if

	if( len(*sPage) = 0) then
		return FALSE
	endif

	dim as integer h
	dim as string sLocalFile

	function = FALSE

	sLocalFile = *_this->localdir + *sPage + cache_ext

	if dir( sLocalFile ) > "" then
		kill sLocalFile
	end if

	h = freefile
	if( open(sLocalFile for binary as #h) = 0 ) then
		put #h,,*sBody, len(*sBody)
		close #h
		function = TRUE
	end if

end function

function CWikiCache_GetRefreshMode _
	( _
		byval _this as CWikiCache ptr _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	function = _this->RefreshMode

end function

function CWikiCache_SetRefreshMode _
	( _
		byval _this as CWikiCache ptr, _
		byval RefreshMode as integer _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	_this->RefreshMode = RefreshMode
	
end function
