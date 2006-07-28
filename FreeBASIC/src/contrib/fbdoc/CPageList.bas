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


'' CPageList - pseudo class for collection of CPage
''
'' chng: may/2006 written [coderJeff]
''

option explicit

#include once "CPageList.bi"
#include once "list.bi"

type PageListItem
	as any ptr				ll_prev
	as any ptr				ll_next

	as CPage ptr      page
	as integer        isref
end type

type CPageList_
	as TLIST pagelist
end type

'':::::
function CPageList_New _
	( _
		byval _this as CPageList ptr _
	) as CPageList ptr

	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CPageList ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	listNew( @_this->pagelist, 16, len( PageListItem ), TRUE )

	function = _this

end function

'':::::
private sub CPageList_FreePageList _
	( _
		byval _this as CPageList ptr _
	)
	
	dim as PageListItem ptr itm, nxt

	itm = cast( PageListItem ptr, listGetHead( @_this->pagelist ) )
	do while( itm <> NULL )
		nxt = cast( PageListItem ptr, listGetNext( itm ) )

		if( itm->isref = FALSE ) then
			CPage_Delete( itm->page )
		end if

		listDelNode( @_this->pagelist, cast( any ptr, itm ) )
		
		itm = nxt
	loop
	
end sub

'':::::
sub CPageList_Delete _
	( _
		byval _this as CPageList ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	CPageList_FreePageList _this

	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
function CPageList_Append _
	( _
		byval _this as CPageList ptr, _
		byval page as CPage ptr, _
		byval isref as integer _
	) as CPage ptr

	if( _this = NULL ) then
		return NULL
	end if

	if( page = NULL ) then
		return NULL
	end if

	dim as PageListItem ptr itm = listNewNode( @_this->pagelist )

	itm->page = page
	itm->isref = isref

	return itm->page

end function

'':::::
function CPageList_AddNewPage _
	( _
		byval _this as CPageList ptr, _
		byval pagename as zstring ptr, _
		byval pagetitle as zstring ptr, _
		byval linktitle as zstring ptr, _
		byval level as integer, _
		byval bForceAdd as integer _
	) as CPage ptr

	if( _this = NULL ) then
		return NULL
	end if

	dim as CPage ptr page

	if( bForceAdd = FALSE ) then
		page = CPageList_Find( _this, pagename )
		if( page ) then
			return page
		end if
	end if

	return CPageList_Append( _this, CPage_New( pagename, pagetitle, linktitle, level ) )
	
end function

'':::::
function CPageList_NextEnum _
	( _
		byval _iter as any ptr ptr _
	) as CPage ptr

	if( _iter = NULL ) then
		return NULL
	end if

	if( *_iter = NULL ) then
		return NULL
	end if

	dim as PageListItem ptr itm

	itm = cast( PageListItem ptr, *_iter )
	itm = listGetNext( itm )

	*_iter = itm

	if( *_iter = NULL ) then
		return NULL
	end if

	return itm->page
	
end function

'':::::
function CPageList_NewEnum _
	( _
		byval _this as CPageList ptr, _
		byval _iter as any ptr ptr _
	) as CPage ptr

	if( _this = NULL ) then
		return NULL
	end if

	if( _iter = NULL ) then
		return NULL
	end if

	dim as PageListItem ptr itm = listGetHead( @_this->pagelist )

	if( itm = NULL ) then
		return NULL
	end if

	*_iter = itm

	return itm->page

end function

'':::::
function CPageList_Find _
	( _
		byval _this as CPageList ptr, _
		byval strFind as zstring ptr _
	) as CPage ptr

	if( _this = NULL ) then
		return NULL
	end if

	if( strFind = NULL ) then
		return NULL
	end if

	if( len( *strFind ) = 0 ) then
		return NULL
	end if

	dim as CPage ptr page
	dim as any ptr page_i
	function = FALSE

	page = CPageList_NewEnum( _this, @page_i )
	while( page )
		if lcase( *strFind ) = lcase( CPage_GetName( page ) ) then
			function = page
			exit while
		end if
		page = CPageList_NextEnum( @page_i )
	wend

end function

'':::::
sub CPageList_ResetEmitted _
	( _
		byval _this as CPageList ptr _
	)

	dim as CPage ptr page
	dim as any ptr page_i

	page = CPageList_NewEnum( _this, @page_i )
	while( page )
		CPage_SetEmitted( page, FALSE )
		page = CPageList_NextEnum( @page_i )
	wend

end sub

sub CPageList_ResetScanned _
	( _
		byval _this as CPageList ptr _
	)

	dim as CPage ptr page
	dim as any ptr page_i

	page = CPageList_NewEnum( _this, @page_i )
	while( page )
		CPage_SetScanned( page, FALSE )
		page = CPageList_NextEnum( @page_i )
	wend

end sub

'':::::
sub CPageList_Dump _
	( _
		byval _this as CPageList ptr _
	)

	dim as CPage ptr page
	dim as any ptr page_i

	page = CPageList_NewEnum( _this, @page_i )
	while( page )
		? Space(CPage_GetLevel(page)*3) & CPage_GetLevel(page) & " - " + CPage_GetName(page) + " = '" + CPage_GetTitle(page) + "'"
		page = CPageList_NextEnum( @page_i )
	wend

end sub

'':::::
function CPageList_Count _
	( _
		byval _this as CPageList ptr _
	) as integer

	if( _this = NULL ) then
		return NULL
	end if

	dim as CPage ptr page
	dim as any ptr page_i

	dim ret as integer = 0

	page = CPageList_NewEnum( _this, @page_i )
	while( page )
		ret += 1
		page = CPageList_NextEnum( @page_i )
	wend

	return ret

end function
