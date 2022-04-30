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


'' CWiki2Chm - emmitter for HTML pages and HTML help project
''
'' chng: jun/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "fbdoc_lang.bi"

#include once "CWiki.bi"
#include once "CWakka2Html.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_templates.bi"
#include once "fbdoc_keywords.bi"

#include once "CWiki2Chm.bi"
#include once "CPage.bi"
#include once "CPageList.bi"

#include once "printlog.bi"

namespace fb.fbdoc

	type CWiki2ChmCtx_
		as zstring ptr urlbase
		as integer indentbase
		as zstring ptr outputdir
		as CPageList ptr paglist
		as CPageList ptr toclist
		as CPageList ptr lnklist
		as CWakka2Html ptr converter
		as CWiki ptr wiki
	end type

	'':::::
	constructor CWiki2Chm _
		( _
			byval urlbase as zstring ptr, _
			byval indentbase as integer, _
			byval outputdir as zstring ptr, _
			byval paglist as CPageList ptr, _
			byval toclist as CPageList ptr, _
			byval lnklist as CPageList ptr _
		)

		ctx = new CWiki2ChmCtx
		ctx->urlbase = NULL
		ZSet @ctx->urlbase, urlbase
		ctx->indentbase = indentbase
		ctx->outputdir = NULL
		ZSet @ctx->outputdir, outputdir
		ctx->paglist = paglist
		ctx->toclist = toclist
		ctx->lnklist = lnklist
		ctx->converter = NULL
		'' ctx->converter = new CWakka2Html
		ctx->wiki = new CWiki

	end constructor

	'':::::
	destructor CWiki2Chm _
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
			byval ctx as CWiki2ChmCtx ptr, _
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
	function CWiki2Chm.EmitPages _
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
	function CWiki2Chm.EmitDefPage _
		( _
			byval page as CPage ptr, _
			byval sbody as zstring ptr _
		) as integer

		dim as string sBodyHtml, sHtml, sPageName, sPageTitle

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
			ctx->converter->setIndentBase( 1 )
			sPageTitle = FormatPageTitle( page->GetTitle() )
		elseif( lcase(left(sPageName, 5)) = "propg" ) then
			ctx->converter->setIndentBase( 1 )
			sPageTitle = page->GetTitle()
		else
			ctx->converter->setIndentBase( 0 )
			sPageTitle = page->GetTitle()
		end if

		ctx->wiki->Parse( sPageName, sBody ) 
		'if( lcase(sPageName) = "??pagename??" ) then
		'	ctx->wiki->Dump()
		'end if

		sBodyHtml = ctx->converter->gen( sPageName, ctx->wiki )

		if( lcase( sPageName ) = "doctoc" ) then
			sHtml = Templates.Get("chm_doctoc")
		else
			sHtml = Templates.Get("chm_def")
		end if

		sHtml = ReplaceSubStr( sHtml, "{$pg_body}", sBodyHtml )
		sHtml = ReplaceSubStr( sHtml, "{$pg_title}", Text2Html( sPageTitle ) )

		sHtml = Lang.ExpandString( sHtml )

		function = _OutputFile( ctx, page->GetName() + ".html", sHtml )

	end function

	'':::::
	function CWiki2Chm.EmitToc _
		( _
			byval sTocName as zstring ptr _
		) as integer
		
		dim as integer level = 0
		dim as CPage ptr page
		dim as any ptr page_i
		dim as string sBodyHtml, sHtml

		#if __FB_DEBUG__
			#define DBG_INDENT space(level * 4)
		#else
			#define DBG_INDENT ""
		#endif

		function = FALSE

		page = ctx->toclist->NewEnum( @page_i )
		while( page )

			while( level < page->GetLevel() )
				sBodyHtml +=  DBG_INDENT + "<ul>" + crlf
				level += 1
			wend

			while( level > page->GetLevel() )
				level -= 1
				sBodyHtml +=  DBG_INDENT + "</ul>"  + crlf
			wend

			if( level = 0 ) then
				sBodyHtml +=  DBG_INDENT + "<ul>" + crlf
			end if

			sBodyHtml +=  DBG_INDENT + "<li><object type=""text/sitemap"">"
			sBodyHtml +=  "<param name=""Name"" value=""" + Text2Html( page->GetFormattedTitle() ) + """>"
			if( len( page->GetName()) > 0 ) then
				sBodyHtml +=  "<param name=""Local"" value=""" + page->GetName() + ".html"">"
			end if
			sBodyHtml +=  "</object>" + crlf

			if( level = 0 ) then
				sBodyHtml +=  DBG_INDENT + "</ul>" + crlf
			end if

			page = ctx->toclist->NextEnum( @page_i )
		wend

		while( level > 0 )
			level -= 1
			sBodyHtml += DBG_INDENT + "</ul>" + crlf
		wend

		sHtml = Templates.Get("chm_toc")

		sHtml = Lang.ExpandString( sHtml )

		sHtml = ReplaceSubStr( sHtml, "{$pg_body}", sBodyHtml )

		function = _OutputFile( ctx, *sTocName, sHtml )

		#undef DBG_INDENT

	end function

	'':::::
	function CWiki2Chm.EmitHtmlIndex _
		( _
			byval sFileName as zstring ptr _
		) as integer
		
		dim as integer level = 0
		dim as CPage ptr page
		dim as any ptr page_i
		dim as string sBodyHtml, sHtml

		function = FALSE

		page = ctx->toclist->NewEnum( @page_i )
		while( page )

			while( level < page->GetLevel() )
				sBodyHtml +=  "<ul>" + crlf
				level += 1
			wend

			while( level > page->GetLevel() )
				level -= 1
				sBodyHtml +=  "</ul>"  + crlf
			wend

			sBodyHtml +=  "<li><object type=""text/sitemap"">"

			sBodyHtml +=  "<a href=""" + page->GetName() + ".html"">" + Text2Html( page->GetFormattedTitle() ) + "</a><br />" + nl

			page = ctx->toclist->NextEnum( @page_i )
		wend

		while( level > 0 )
			level -= 1
			sBodyHtml +=  "</ul>" + crlf
		wend

		sHtml = Templates.Get("htm_toc")

		sHtml = Lang.ExpandString( sHtml )

		sHtml = ReplaceSubStr( sHtml, "{$pg_body}", sBodyHtml )

		function = _OutputFile( ctx, *sFileName, sHtml )

	end function

	'':::::
	function CWiki2Chm.EmitIndex _
		( _
			byval sIndexName as zstring ptr _
		) as integer
		
		dim as integer level = 0
		dim as CPage ptr page
		dim as any ptr page_i
		dim as string sBodyHtml, sHtml

		function = FALSE

		page = ctx->lnklist->NewEnum( @page_i )
		while( page )

			'' If( page->GetEmitted() ) then
				sBodyHtml +=  "<li><object type=""text/sitemap"">"
				sBodyHtml +=  "<param name=""Name"" value=""" + Text2Html( page->GetFormattedTitle() ) + """>"
				sBodyHtml +=  "<param name=""Local"" value=""" + page->GetName() + ".html"">"
				sBodyHtml +=  "</object>" + crlf
			'' end if

			page = ctx->lnklist->NextEnum( @page_i )
		wend

		sHtml = Templates.Get("chm_idx")

		sHtml = Lang.ExpandString( sHtml )
		sHtml = ReplaceSubStr( sHtml, "{$pg_title}", "Index" )
		sHtml = ReplaceSubStr( sHtml, "{$pg_body}", sBodyHtml )

		function = _OutputFile( ctx, *sIndexName, sHtml )

	end function

	'':::::
	function CWiki2Chm.EmitProject _
		( _
			byval sProjectName as zstring ptr, _
			byval sChmName as zstring ptr _
		) as integer

		dim as integer h, level = 0
		dim as CPage ptr page
		dim as any ptr page_i
		dim as string sBodyHtml, sHtml, sDefName

		function = FALSE

		'' Get the first page of TOC
		page = ctx->toclist->NewEnum( @page_i )
		sDefName = page->GetName()
		if( sDefName = "" ) then
			sDefName = "doctoc"
		end if

		page = ctx->paglist->NewEnum( @page_i )
		while( page )
			if( page->GetEmitted() ) then
				sBodyHtml += page->GetName() + ".html" + crlf
			end if
			page = ctx->paglist->NextEnum( @page_i )
		wend

		sHtml = Templates.Get("chm_prj")

		sHtml = Lang.ExpandString( sHtml )

		sHtml = ReplaceSubStr( sHtml, "{$pg_chm_file}", sChmName )
		sHtml = ReplaceSubStr( sHtml, "{$pg_toc_file}", sChmName )
		sHtml = ReplaceSubStr( sHtml, "{$pg_idx_file}", sChmName )
		sHtml = ReplaceSubStr( sHtml, "{$pg_def_file}", sDefName )

		sHtml = ReplaceSubStr( sHtml, "{$pg_files}", sBodyHtml )

		function = _OutputFile( ctx, *sProjectName, sHtml )

	end function

	'':::::
	function CWiki2Chm.Emit _
		( _
		) as integer

		ctx->converter = new CWakka2Html

		if( ctx->converter = NULL) then
			return FALSE
		end if

		ctx->converter->setCssClass( WIKI_TOKEN_PRE, "fb_pre" )
		ctx->converter->setCssClass( WIKI_TOKEN_HEADER, "fb_header" )
		ctx->converter->setCssClass( WIKI_TOKEN_BOXLEFT, "fb_box" )
		ctx->converter->setCssClass( WIKI_TOKEN_BOXRIGHT, "fb_box" )
		ctx->converter->setCssClass( WIKI_TOKEN_ACTION_TB, "fb_table" )
		ctx->converter->setCssClass( WIKI_TOKEN_ACTION_IMG, "fb_img" )
		ctx->converter->setTagDoGen( WIKI_TOKEN_HORZLINE, false )
		ctx->converter->setTagDoGen( WIKI_TOKEN_SECT_ITEM, false )

		ctx->converter->setOutputDir( *ctx->outputdir )
		
		this.EmitPages()

		if( ctx->toclist->Count() > 0 ) then
			this.EmitTOC( "fbdoc.hhc" )
			this.EmitIndex( "fbdoc.hhk" )
			this.EmitProject( "fbdoc.hhp", "fbdoc" )
			''this.EmitHtmlIndex( "00index.html" )
		end if

		delete ctx->converter
		ctx->converter = NULL

		return TRUE
	end function

end namespace
