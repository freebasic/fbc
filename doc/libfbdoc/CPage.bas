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


'' CPage - class to manage a single document page 
''         and contained links
''
'' chng: may/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "CPage.bi"
#include once "fbdoc_keywords.bi"

namespace fb.fbdoc

	type CPageCtx_
		as zstring ptr pagename
		as zstring ptr pagetitle
		as integer level
		as integer emitted
		as integer scanned
		as Clist ptr pagelinklist
	end type

	'':::::
	constructor CPage _
		( _
			byval pagename as zstring ptr, _
			byval pagetitle as zstring ptr, _
			byval level as integer _
		)

		ctx = new CPageCtx

		ctx->pagename = NULL
		ctx->pagetitle = NULL
		ZSet @ctx->pagename, pagename
		ZSet @ctx->pagetitle, pagetitle
		ctx->level = level
		ctx->emitted = FALSE
		ctx->scanned = FALSE
		ctx->pagelinklist = new CList( 16, len( PageLinkItem ))

	end constructor

	'':::::
	sub CPage.FreePageLinks _
		( _
		)

		dim as PageLinkItem ptr pagelink, nxt

		pagelink = ctx->pagelinklist->GetHead()
		do while( pagelink <> NULL )
			nxt = ctx->pagelinklist->GetNext( pagelink )
			
			pagelink->text = ""
			pagelink->url = ""
			
			ctx->pagelinklist->Remove( pagelink )
			
			pagelink = nxt
		loop
		
	end sub

	'':::::
	destructor CPage _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if

		ZFree @ctx->pagename
		ZFree @ctx->pagetitle
		ctx->level = 0
		ctx->emitted = FALSE
		ctx->scanned = FALSE
		
		this.FreePageLinks()
		delete ctx->pagelinklist
		delete ctx

	end destructor

	'':::::
	function CPage.GetName _
		( _
		) as string

		if( ctx = NULL ) then
			function = ""
		else
			function = *ctx->pagename
		end if

	end function

	'':::::
	function CPage.GetPageTitle _
		( _
		) as string

		if( ctx = NULL ) then
			function = ""
		else
			function = *ctx->pagetitle
		end if

	end function

	'':::::
	function CPage.GetTitle _
		( _
		) as string

		if( ctx = NULL ) then
			return ""
		end if

		if( len( *ctx->pagetitle) > 0 ) then
			function = *ctx->pagetitle
		elseif( len( *ctx->pagename) > 0 ) then
			function = *ctx->pagename
		else
			function = "No Title"
		end if

	end function

	'':::::
	function CPage.GetFormattedTitle _
		( _
		) as string

		if( ctx = NULL ) then
			return ""
		end if

		if( lcase(left( *ctx->pagename, 5)) = "keypg" ) then
			return FormatPageTitle( this.GetTitle() )
		end if
		
		return this.GetTitle()

	end function

	'':::::
	sub CPage.SetPageTitle _
		( _
			byval title as zstring ptr _
		)

		if( ctx = NULL ) then
			exit sub
		end if

		if( len(*title) = 0 ) then
			exit sub
		end if

		ZSet @ctx->pagetitle, title

	end sub

	'':::::
	function CPage.GetLevel _
		( _
		) as integer

		if( ctx = NULL ) then
			function = 0
		else
			function = ctx->level
		end if

	end function

	'':::::
	function CPage.GetEmitted _
		( _
		) as integer

		if( ctx = NULL ) then
			function = FALSE
		else
			function = ctx->emitted
		end if

	end function

	'':::::
	sub CPage.SetEmitted _
		( _
			byval emitted as integer _
		)
		
		if( ctx = NULL ) then
			exit sub
		endif 

		ctx->emitted = emitted

	end sub


	'':::::
	function CPage.GetScanned _
		( _
		) as integer

		if( ctx = NULL ) then
			function = FALSE
		else
			function = ctx->scanned
		end if

	end function

	'':::::
	sub CPage.SetScanned _
		( _
			byval scanned as integer _
		)
		
		if( ctx = NULL ) then
			exit sub
		endif 

		ctx->scanned = scanned

	end sub

	'':::::
	Sub CPage.AddPageLink _
		( _
			byval spagetext as zstring ptr, _
			byval spagename as zstring ptr, _
			byval level as integer, _
			byval linkclass as integer _
		)

		if( ctx = NULL ) then
			exit sub
		endif 

		dim as PageLinkItem ptr pagelink

		pagelink = ctx->pagelinklist->Insert()
		pagelink->text = *spagetext
		pagelink->url = *spagename
		pagelink->level = level
		pagelink->linkclass = linkclass
		
	end sub

	'':::::
	function CPage.GetPageLinks _
		( _
		) as CList ptr

		if( ctx = NULL ) then
			return NULL
		end if
		
		function = ctx->pagelinklist
			
	end function

end namespace