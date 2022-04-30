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


'' CPageList - class for collection of CPage
''
'' chng: may/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "CPageList.bi"
#include once "list.bi"
#include once "hash.bi"

#include once "printlog.bi"

namespace fb.fbdoc

	type PageListItem
		as CPage ptr      page
		as integer        isref
	end type

	type CPageListCtx_
		as CList ptr pagelist
		as HASH pagehash
	end type

	'':::::
	constructor CPageList _
		( _
		)

		ctx = new CPageListCtx
		ctx->pagelist = new CList( 16, len( PageListItem ))
		ctx->pagehash.alloc( 16 )

	end constructor

	'':::::
	sub CPageList.ClearList _
		( _
		)
		
		dim as PageListItem ptr itm, nxt

		itm = ctx->pagelist->GetHead()
		do while( itm <> NULL )
			nxt = ctx->pagelist->GetNext( itm )

			if( itm->isref = FALSE ) then
				delete itm->page
			end if

			ctx->pagelist->Remove( itm )
			
			itm = nxt
		loop

		ctx->pagehash.clear()
		
	end sub

	'':::::
	destructor CPageList _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if

		this.ClearList()
		delete ctx

	end destructor

	'':::::
	function CPageList.Append _
		( _
			byval page as CPage ptr, _
			byval isref as integer _
		) as CPage ptr

		if( ctx = NULL ) then
			return NULL
		end if

		if( page = NULL ) then
			return NULL
		end if

		dim as PageListItem ptr itm = ctx->pagelist->Insert()

		itm->page = page
		itm->isref = isref

		ctx->pagehash.add( lcase( page->GetName() ), page )

		return itm->page

	end function

	'':::::
	function CPageList.AddNewPage _
		( _
			byval pagename as zstring ptr, _
			byval pagetitle as zstring ptr, _
			byval level as integer, _
			byval bForceAdd as integer _
		) as CPage ptr

		if( ctx = NULL ) then
			return NULL
		end if

		dim as CPage ptr page

		if( bForceAdd = FALSE ) then
			page = Find( pagename )
			if( page ) then
				return page
			end if
		end if

		dim tmp as CPage ptr = new CPage( pagename, pagetitle, level )
		return Append( tmp )
		
	end function

	'':::::
	function CPageList.NextEnum _
		( _
			byval _iter as any ptr ptr _
		) as CPage ptr

		if( ctx = NULL ) then
			return NULL
		end if

		if( ctx->pagelist = NULL ) then
			return NULL
		end if

		if( _iter = NULL ) then
			return NULL
		end if

		*_iter = ctx->pagelist->GetNext(*_iter)

		if( *_iter ) then
			return cast(PageListItem ptr, *_iter)->page
		end if

		return NULL

	end function

	'':::::
	function CPageList.NewEnum _
		( _
			byval _iter as any ptr ptr _
		) as CPage ptr

		if( ctx = NULL ) then
			return NULL
		end if

		if( _iter = NULL ) then
			return NULL
		end if

		if( ctx->pagelist = NULL ) then
			return NULL
		end if

		*_iter = ctx->pagelist->GetHead()

		if( *_iter ) then
			return cast(PageListItem ptr, *_iter)->page
		end if

		return NULL

	end function

	'':::::
	function CPageList.Find _
		( _
			byval strFind as zstring ptr _
		) as CPage ptr

		if( ctx = NULL ) then
			return NULL
		end if

		if( strFind = NULL ) then
			return NULL
		end if

		if( len( *strFind ) = 0 ) then
			return NULL
		end if

		function = ctx->pagehash.getinfo( lcase( *strFind ) )

	end function

	'':::::
	sub CPageList.ResetEmitted _
		( _
		)

		dim as CPage ptr page
		dim as any ptr page_i

		page = NewEnum( @page_i )
		while( page )
			page->SetEmitted( FALSE )
			page = NextEnum( @page_i )
		wend

	end sub

	sub CPageList.ResetScanned _
		( _
		)

		dim as CPage ptr page
		dim as any ptr page_i

		page = NewEnum( @page_i )
		while( page )
			page->SetScanned( FALSE )
			page = NextEnum( @page_i )
		wend

	end sub

	'':::::
	sub CPageList.Dump _
		( _
		)

		dim as CPage ptr page
		dim as any ptr page_i

		page = NewEnum( @page_i )
		while( page )
			printlog Space(page->GetLevel()*3) & page->GetLevel() & " - " + page->GetName() + " = '" + page->GetTitle() + "'"
			page = NextEnum( @page_i )
		wend

	end sub

	'':::::
	function CPageList.Count _
		( _
		) as integer

		if( ctx = NULL ) then
			return NULL
		end if

		dim as CPage ptr page
		dim as any ptr page_i

		dim ret as integer = 0

		page = NewEnum( @page_i )
		while( page )
			ret += 1
			page = NextEnum( @page_i )
		wend

		return ret

	end function

end namespace
