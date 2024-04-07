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


'' CWiki2texinfo - emitter for texinfo file
''
'' chng: apr/2008 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_lang.bi"

#include once "CWiki.bi"
#include once "CWakka2texinfo.bi"

#include once "fbdoc_loader.bi"
#include once "fbdoc_templates.bi"
#include once "fbdoc_keywords.bi"
#include once "fbdoc_string.bi"

#include once "CWiki2texinfo.bi"
#include once "CPage.bi"
#include once "CPageList.bi"

#include once "printlog.bi"

namespace fb.fbdoc

	type CWiki2texinfoCtx_
		as zstring ptr urlbase
		as integer indentbase
		as zstring ptr outputdir
		as CPageList ptr paglist
		as CPageList ptr toclist
		as CWakka2texinfo ptr converter
		as CWiki ptr wiki
	end type

	'':::::
	constructor CWiki2texinfo _
		( _
			byval urlbase as zstring ptr, _
			byval indentbase as integer, _
			byval outputdir as zstring ptr, _
			byval paglist as CPageList ptr, _
			byval toclist as CPageList ptr _
		)

		ctx = new CWiki2texinfoCtx
		ctx->urlbase = NULL
		ZSet @ctx->urlbase, urlbase
		ctx->indentbase = indentbase
		ctx->outputdir = NULL
		ZSet @ctx->outputdir, outputdir
		ctx->paglist = paglist
		ctx->toclist = toclist
		ctx->converter = NULL
		'' ctx->converter = new CWakka2texinfo
		ctx->wiki = new CWiki

	end constructor

	'':::::
	destructor CWiki2texinfo _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if

		ZFree @ctx->urlbase
		ZFree @ctx->outputdir
		'' delete ctx->converter
		delete ctx->wiki

		delete ctx

	end destructor

	private function _OutputFile _
		( _
			byval ctx as CWiki2texinfoCtx ptr, _
			byval sFileName as zstring ptr, _
			byval sContent as zstring ptr _
		) as integer

		if( ctx = NULL) then
			return FALSE
		end if

		if( ( sFileName = NULL ) or ( sContent = NULL ) ) then
			return FALSE
		end if

		if( (len(*sFileName) = 0) or (len(*sContent) = 0) ) then
			return FALSE
		end if

		dim as integer h
		dim as string sOutputFile, ret

		ret = Lang.ExpandString( sContent )

		sOutputFile = *ctx->outputdir + *sFileName

		h = freefile
		if( open(  sOutputFile for output as #h ) = 0 ) then
			'' ? #h, ret;
			put #h,,ret
			close #h
			return TRUE
		end if

		return FALSE

	end function

	'':::::
	function CWiki2texinfo.EmitPages _
		( _
		) as integer

		dim as CPage ptr page
		dim as any ptr page_i
		dim as string sName, sBody
		dim as integer errCount = 0, okCount = 0

		ctx->paglist->ResetEmitted()

		page = ctx->paglist->NewEnum( @page_i )
		while( page )
			if( page->GetEmitted() = FALSE ) then
				sName = page->GetName()
				if( len(sName) > 0 ) then
					sBody = LoadPage( sName, TRUE )
					if( len(sbody) > 0 ) then
						printlog "Emitting: " + page->GetName() + " = '" + page->GetTitle() + "'"
						if this.EmitDefPage( page, sBody ) then
							page->SetEmitted( TRUE )	
						end if
						okCount += 1
					else
						printlog "Error On: " + page->GetName() + " = '" + page->GetTitle() + "'"
						errCount += 1
					end if
				end if
			end if
			page = ctx->paglist->NextEnum( @page_i )
		wend

		printlog str(okCount) + " pages emitted OK"  
		if( errCount > 0 ) then
			printlog str(errCount) + " pages had no content and were skipped"
		end if

		return TRUE

	end function

	'':::::
	function CWiki2texinfo.EmitDefPage _
		( _
			byval page as CPage ptr, _
			byval sbody as zstring ptr _
		) as integer

		dim as string sBodyTxt, sTxt, sPageName, sPageTitle

		if( page = NULL ) then
			return FALSE
		end if

		if( ctx->converter = NULL ) then
			return FALSE
		end if

		if( len(*sbody) = 0 ) then
			return FALSE
		end if

		sPageName = page->GetName()

		if( lcase(left(sPageName, 5)) = "keypg" ) then
			ctx->converter->setIndentBase( 0 )
			sPageTitle = FormatPageTitle( page->GetTitle() )
		else
			ctx->converter->setIndentBase( 0 )
			sPageTitle = page->GetTitle()
		end if

		ctx->wiki->Parse( sPageName, sBody ) 

		sBodyTxt = ctx->converter->gen( sPageName, ctx->wiki )

		if( lcase( sPageName ) = "doctoc" ) then
			sTxt = Templates.Get("texinfo_doctoc")
		else
			sTxt = Templates.Get("texinfo_def")
		end if

		sTxt = ReplaceSubStr( sTxt, "{$pg_body}", sBodyTxt ) 
		sTxt = ReplaceSubStr( sTxt, "{$pg_title}", sPageTitle )
		sTxt = ReplaceSubStr( sTxt, "{$pg_name}", sPageName )

		sTxt = Lang.ExpandString( sTxt )

		function = _OutputFile( ctx, page->GetName() + ".texinfo", sTxt )

	end function


	'':::::
	function CWiki2texinfo.LoadAndEmitTOC _
		( _
			byval sPageName as zstring ptr, _
			byval sOutputFile as zstring ptr _
		) as integer

		dim as CPage ptr page
		dim as string sBody, sTitle, sBodyTxt, sTxt, f
		dim as CList ptr lst
		dim as integer h
		dim as WikiPageLink ptr pagelink

		'' Load and Emit PrintToc
		page = new CPage( *sPageName )

		if( len(*sPageName) = 0 ) then
			return FALSE
		end if

		sBody = LoadPage( *sPageName, TRUE )
		if( len(sbody) > 0 ) then

			ctx->wiki->Parse( *sPageName, sBody ) 

			sTitle = ctx->wiki->GetPageTitle()
			if( len(sTitle) > 0 ) then
				page->SetPageTitle( sTitle )
			end if

			printlog "Emitting: " + page->GetName() + " = '" + page->GetTitle() + "'"

			if this.EmitDefPage( page, sBody ) then
				page->SetEmitted( TRUE )	
			end if
		else
			printlog "Error On: " + page->GetName() + " = '" + page->GetTitle() + "'"
		end if

		delete page

		'' build output
		lst = ctx->wiki->GetDocTocLinks( false )

		'' First pass - generate a top level menu
		'' !!! TODO - auto-generate nodes and menus for chapters/sections !!!
		pagelink = lst->GetHead()
		sBodyTxt +=  "@menu" + crlf
		do while( pagelink <> NULL )
			select case pagelink->link.linkclass
			case WIKI_PAGELINK_CLASS_SECTION
			case WIKI_PAGELINK_CLASS_SUBSECT
			case else
				'' hack, menus can't contain ':'
				sBodyTxt +=  "* " + ReplaceSubStr( pagelink->text, ":", "" ) + ":" + pagelink->link.url + "." + crlf
			end select

			pagelink = lst->GetNext( pagelink )
		loop
		sBodyTxt +=  "@end menu" + crlf

		'' Second pass, generate sectioning and include topics
		pagelink = lst->GetHead()
		do while( pagelink <> NULL )
			select case pagelink->link.linkclass
			case WIKI_PAGELINK_CLASS_SECTION
				sBodyTxt +=  "@chapter " + pagelink->text + crlf

			case WIKI_PAGELINK_CLASS_SUBSECT
				sBodyTxt +=  "@section " + pagelink->text + crlf
			case else
				sBodyTxt +=  "@node " + pagelink->link.url + ", , , Top" + crlf
				sBodyTxt +=  "@subsection " + pagelink->text + crlf
				sBodyTxt +=  "@include " + pagelink->link.url + ".texinfo" + crlf
			end select

			pagelink = lst->GetNext( pagelink )
		loop

		sTxt = Templates.Get("texinfo_toc")

		sTxt = Lang.ExpandString( sTxt )

		sTxt = ReplaceSubStr( sTxt, "{$pg_body}", sBodyTxt )

		function = _OutputFile( ctx, sOutputFile, sTxt )

		return TRUE

	end function

	'':::::
	function CWiki2texinfo.Emit _
		( _
		) as integer

		ctx->converter = new CWakka2texinfo

		if( ctx->converter = NULL) then
			return FALSE
		end if

		ctx->converter->setTagDoGen( WIKI_TOKEN_HORZLINE, false )
		ctx->converter->setTagDoGen( WIKI_TOKEN_SECT_ITEM, false )

		ctx->converter->setIsFlat( true )

		this.EmitPages()

		this.LoadAndEmitTOC( @"PrintToc", @"fbdoc.texinfo" )

		delete ctx->converter
		ctx->converter = NULL

		return TRUE
	end function

end namespace
