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


'' fbdoc_buildtoc
''
''
'' chng: sep/2006 written [coderJeff]
''

#include once "fbdoc_buildtoc.bi"
#include once "fbdoc_loader.bi"
#include once "CWiki.bi"

#include once "printlog.bi"

namespace fb.fbdoc

	dim shared as CWiki ptr wiki

	'' --------------------------------------------------------------------------
	'' Content Scanning
	'' --------------------------------------------------------------------------


	'':::::
	function _LoadAndScanPageLinks _
		( _	
			byval page as CPage ptr, _
			byval paglist as CPageList ptr, _
			byval bFollowLinks as integer _
		) as integer

		dim as CList ptr lst

		dim as CPage ptr newpage, prevpage
		dim as string sPageName, sBody, sTitle

		if( page = NULL ) then
			return FALSE
		end if

		if( page->GetScanned() ) then
			return TRUE
		end if

		page->SetScanned( TRUE )

		sPageName = page->GetName()
		if( len(sPageName) = 0 ) then
			printlog "Warning: Page with no key name should never happen."
			return FALSE
		end if

		printlog "Scanning: " + sPageName
		sBody = LoadPage( sPageName )
		if( len( sBody ) = 0 ) then
			return FALSE
		end if

		wiki->Parse( page->GetName(), sBody ) 

		sTitle = wiki->GetPageTitle()
		if( len(sTitle) > 0 ) then
			page->SetPageTitle( sTitle )
		end if
		
		'' Get a list of all the links on the currently loaded page
		lst = wiki->GetDocTocLinks( (lcase(sPageName) = "catpgfunctindex") )

		dim as WikiPageLink ptr pagelink

		page->FreePageLinks()

		pagelink = lst->GetHead()

		do while( pagelink <> NULL )

			page->AddPageLink( pagelink->text, pagelink->link.url, pagelink->level, pagelink->link.linkclass )
		
			if( len(pagelink->link.url) > 0 ) then
				if( instr(pagelink->link.url, ":") = 0 ) then
				if( instr(pagelink->link.url, "/") = 0 ) then
				if( instr(pagelink->link.url, ".") = 0 ) then
						prevpage = paglist->Find( pagelink->link.url )
						if( prevpage = NULL ) then
							if( bFollowLinks ) then
								newpage = paglist->AddNewPage( pagelink->link.url, pagelink->text, 0, FALSE )
							end if
						end if
				end if
				end if
				end if
			end if

			pagelink = lst->GetNext( pagelink )
			
		loop
		
	end function


	'':::::
	private function IsTOCPage( byval sPage as zstring ptr ) as integer

		function = FALSE

		if( sPage = NULL ) then
			exit function
		end if

		if( len(*sPage) = 0 ) then
			exit function
		end if

		'' !!! TODO !!!: use a datafile to specify a list, matched on patterns of pages names
		'' to include in auto-generated TOC.  e.g. DocToc, CatPg*, CVS*

		if( _
			( lcase(*sPage) = "doctoc" ) _
			or ( lcase(left(*sPage, 5)) = "catpg") _
			or ( lcase(left(*sPage, 3)) = "cvs") _
			or ( lcase(left(*sPage, 3)) = "svn") _
			or ( lcase(*sPage) = "extlibtoc" ) _
		) then
			function = TRUE
		end if

	end function

	'':::::
	private function IsInternalURL( byref sUrl as string ) as integer
		
		function = FALSE

		if( len(sUrl) > 0 ) then
			if( instr(sUrl, ":") = 0 ) then
				if( instr(sUrl, "/") = 0 ) then
					function = TRUE
				end if
			end if
		end if

	end function

	'':::::
	private sub _BuildTOCFromPage _
		( _
			byval page as CPage ptr, _
			byval startlevel as integer, _
			byval toclist as CPageList ptr, _
			byval paglist as CPageList ptr, _
			byval lnklist as CPageList ptr _
		)

		dim as CPage ptr newpage, prevpage
		dim as string sBody, sPageName, sTitle
		dim as CList ptr lst
		dim as PageLinkItem ptr pagelink
		dim as integer bAddPage, bFollowPage, bAddLink

		if( page = NULL ) then
			exit sub
		end if

		sPageName = page->GetName()
		if( len(sPageName) = 0 ) then
			exit sub
		end if
		
		if( IsTOCPage(strptr(sPageName)) = FALSE ) then
			exit sub
		endif 

		prevpage = paglist->Find( sPageName )
		if( prevpage = NULL ) then
			exit sub
		end if

		lst = prevpage->GetPageLinks()
		if( lst->GetHead() = NULL ) then
			exit sub
		end if

		printlog "Building Toc: " + sPageName
		
		sTitle = page->GetTitle()

		'' Loop through each link.  Record the page and search for more sections
		pagelink = lst->GetHead()
		do while( pagelink <> NULL )
				
			bAddPage = FALSE
			bAddLink = FALSE
			bFollowPage = FALSE

			'' Only {{fbdoc item="sect|subsect"}} links are used as branches in TOC
			select case pagelink->linkclass
			case WIKI_PAGELINK_CLASS_SECTION, WIKI_PAGELINK_CLASS_SUBSECT
				bAddPage = TRUE

			case WIKI_PAGELINK_CLASS_KEYWORD

				'' Only internal pages can be TOC nodes
				if( IsInternalURL( pagelink->url ) ) then

					bAddPage = TRUE
					bAddLink = TRUE

					'' Only special named TOC pages are followed
					if( IsTOCPage(pagelink->url) ) then
						bFollowPage = TRUE
					end if
				end if

			case WIKI_PAGELINK_CLASS_DEFAULT

				if( IsInternalURL( pagelink->url ) ) then

					bAddLink = TRUE

				end if


			end select

			''
			if( bAddLink ) then

				newpage = lnklist->AddNewPage( _
					pagelink->url, _
					pagelink->text, _
					0, TRUE )
			
			end if

			''
			if( bAddPage ) then

				'' Add it to the TOC list
				newpage = toclist->AddNewPage( _
					pagelink->url, _
					pagelink->text, _
					startlevel + pagelink->level, TRUE )

				if( bFollowPage ) then
					' Only follow links that will be later emitted
					prevpage = paglist->Find( pagelink->url )
					if( prevpage ) then
						_BuildTOCFromPage( prevpage, startlevel + pagelink->level + 1, toclist, paglist, lnklist )
					end if
				end if
			end if

			pagelink = lst->GetNext( pagelink )

		loop

	end sub

	'':::::
	function FBDoc_BuildTOC _
		( _
			byval toc_pagename as zstring ptr, _
			byval toc_pagetitle as zstring ptr, _
			byval paglist as CPageList ptr ptr, _
			byval toclist as CPageList ptr ptr, _
			byval lnklist as CPageList ptr ptr _
		) as integer

		dim as CPage ptr page
		dim as any ptr page_i

		if( paglist = NULL ) then
			return FALSE
		end if

		if( toclist = NULL ) then
			return FALSE
		end if

		if( lnklist = NULL ) then
			return FALSE
		end if

		*paglist = new CPageList
		*toclist = new CPageList
		*lnklist = new CPageList

		if( *paglist = NULL or *toclist = NULL or *lnklist = NULL ) then
			if( *paglist ) then
				delete *paglist
				*paglist = NULL
			end if

			if( *toclist ) then
				delete *toclist
				*toclist = NULL
			end if

			if( *lnklist ) then
				delete *lnklist
				*lnklist = NULL
			end if

			return FALSE
		end if

		wiki = new CWiki

		page = (*paglist)->AddNewPage( toc_pagename, toc_pagetitle, 0, TRUE )

		'' Build a list of all pages to include in the documentation
		page = (*paglist)->NewEnum( @page_i )
		while( page )
			if( len(page->GetName()) > 0 ) then
				_LoadAndScanPageLinks( page, *paglist, TRUE )
			end if
			page = (*paglist)->NextEnum( @page_i )
		wend

		'' Build a list of pages as they will appear in the TOC
		page = (*toclist)->AddNewPage( toc_pagename, toc_pagetitle, 0, TRUE )
		_BuildTOCFromPage( page, 1, *toclist, *paglist, *lnklist )

		delete wiki
		wiki = NULL

		return TRUE

	end function


	'':::::
	function FBDoc_BuildSinglePage _
		( _
			byval toc_pagename as zstring ptr, _
			byval toc_pagetitle as zstring ptr, _
			byval paglist as CPageList ptr ptr, _
			byval toclist as CPageList ptr ptr, _
			byval followlinks as integer _
		) as integer

		dim as CPage ptr page
		dim as any ptr page_i
		dim as integer bFirstTime

		if( paglist = NULL ) then
			return FALSE
		end if

		if( toclist = NULL ) then
			return FALSE
		end if

		*paglist = new CPageList

		if( *paglist = NULL ) then
			return FALSE
		end if

		*toclist = new CPageList

		if( *toclist = NULL ) then
			delete *paglist
			*paglist = NULL
			return FALSE
		end if

		wiki = new CWiki

		page = (*paglist)->AddNewPage( toc_pagename, toc_pagetitle, 0, TRUE )
		page = (*paglist)->NewEnum( @page_i )

		bFirstTime = followlinks

		while( page )
			if( len(page->GetName()) > 0 ) then
				_LoadAndScanPageLinks( page, *paglist, bFirstTime )
				bFirstTime = FALSE
			end if
			page = (*paglist)->NextEnum( @page_i )
		wend

		''page = *toclist->AddNewPage( toc_pagename, toc_pagetitle, 0, TRUE )
		''_BuildTOCFromPage( page, 1, *toclist, *paglist )

		delete wiki
		wiki = NULL

		return TRUE

	end function

end namespace
