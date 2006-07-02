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


'' CPage - pseudo class to manage a single document page 
''         and contained links
''
'' chng: may/2006 written [coderJeff]
''

option explicit

#include once "common.bi"
#include once "CPage.bi"

type CPage_
	as zstring ptr pagename
	as zstring ptr linktitle
	as zstring ptr pagetitle
	as integer level
	as integer emitted
	as integer scanned
	as TLIST   pagelinklist
end type

'':::::
function CPage_New _
	( _
		byval pagename as zstring ptr, _
		byval pagetitle as zstring ptr, _
		byval linktitle as zstring ptr, _
		byval level as integer, _
		byval _this as CPage ptr _
	) as CPage ptr

	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CPage ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

  ZSet @_this->pagename, pagename
  ZSet @_this->pagetitle, pagetitle
  ZSet @_this->linktitle, linktitle
	_this->level = level
	_this->emitted = FALSE
	_this->scanned = FALSE
	listNew( @_this->pagelinklist, 16, len( PageLinkItem ), TRUE )

	function = _this

end function

'':::::
sub CPage_FreePageLinks _
	( _
		byval _this as CPage ptr _
	)

	dim as PageLinkItem ptr pagelink, nxt

	pagelink = cast( PageLinkItem ptr, listGetHead( @_this->pagelinklist ) )
	do while( pagelink <> NULL )
		nxt = cast( PageLinkItem ptr, listGetNext( pagelink ) )
		
		pagelink->text = ""
		pagelink->url = ""
		
		listDelNode( @_this->pagelinklist, cast( any ptr, pagelink ) )
		
		pagelink = nxt
	loop
	
end sub

'':::::
sub CPage_Delete _
	( _
		byval _this as CPage ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	ZFree @_this->pagename
	ZFree @_this->pagetitle
	ZFree @_this->linktitle
	_this->level = 0
	_this->emitted = FALSE
	_this->scanned = FALSE
	
	CPage_FreePageLinks( _this )
	listFree( @_this->pagelinklist )

	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub


'':::::
function CPage_GetName _
	( _
		byval _this as CPage ptr _
	) as string

	if( _this = NULL ) then
		function = ""
	else
		function = *_this->pagename
	end if

end function

'':::::
function CPage_GetPageTitle _
	( _
		byval _this as CPage ptr _
	) as string

	if( _this = NULL ) then
		function = ""
	else
		function = *_this->pagetitle
	end if

end function

'':::::
function CPage_GetLinkTitle _
	( _
		byval _this as CPage ptr _
	) as string

	if( _this = NULL ) then
		function = ""
	else
		function = *_this->linktitle
	end if

end function

'':::::
function CPage_GetTitle _
	( _
		byval _this as CPage ptr _
	) as string

	if( _this = NULL ) then
		return ""
	end if

	if( len( *_this->linktitle) > 0 ) then
		function = *_this->linktitle
	elseif( len( *_this->pagetitle) > 0 ) then
		function = *_this->pagetitle
	elseif( len( *_this->pagename) > 0 ) then
		function = *_this->pagename
	else
		function = "No Title"
	end if

end function

'':::::
function CPage_GetFormattedTitle _
	( _
		byval _this as CPage ptr _
	) as string

	if( _this = NULL ) then
		return ""
	end if

	if( lcase(left( *_this->pagename, 5)) = "keypg" ) then
		return FormatPageTitle( CPage_GetTitle( _this ) )
	end if
	
	return CPage_GetTitle( _this )

end function

'':::::
sub CPage_SetPageTitle _
	( _
		byval _this as CPage ptr, _
		byval title as zstring ptr _
	)

	if( _this = NULL ) then
		exit sub
	end if

	if( len(*title) = 0 ) then
		exit sub
	end if

	ZSet @_this->pagetitle, title

end sub

'':::::
sub CPage_SetLinkTitle _
	( _
		byval _this as CPage ptr, _
		byval title as zstring ptr _
	)

	if( _this = NULL ) then
		exit sub
	end if

	if( len(*title) = 0 ) then
		exit sub
	end if

	ZSet @_this->linktitle, title

end sub

'':::::
function CPage_GetLevel _
	( _
		byval _this as CPage ptr _
	) as integer

	if( _this = NULL ) then
		function = 0
	else
		function = _this->level
	end if

end function

'':::::
function CPage_GetEmitted _
	( _
		byval _this as CPage ptr _
	) as integer

	if( _this = NULL ) then
		function = 0
	else
		function = _this->emitted
	end if

end function

'':::::
sub CPage_SetEmitted _
	( _
		byval _this as CPage ptr, _
		byval emitted as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	endif 

	_this->emitted = emitted

end sub


'':::::
function CPage_GetScanned _
	( _
		byval _this as CPage ptr _
	) as integer

	if( _this = NULL ) then
		function = 0
	else
		function = _this->scanned
	end if

end function

'':::::
sub CPage_SetScanned _
	( _
		byval _this as CPage ptr, _
		byval scanned as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	endif 

	_this->scanned = scanned

end sub

'':::::
Sub CPage_AddPageLink _
	( _
		byval _this as CPage ptr, _
		byval spagetext as zstring ptr, _
		byval spagename as zstring ptr, _
		byval level as integer _
	)

	if( _this = NULL ) then
		exit sub
	endif 

	dim as PageLinkItem ptr pagelink

	pagelink = listNewNode( @_this->pagelinklist )
	pagelink->text = *spagetext
	pagelink->url = *spagename
	pagelink->level = level
	
end sub

'':::::
function CPage_GetPageLinks _
	( _
		byval _this as CPage ptr _
	) as TLIST ptr

	if( _this = NULL ) then
		return NULL
	end if
	
	function = @_this->pagelinklist
		
end function
