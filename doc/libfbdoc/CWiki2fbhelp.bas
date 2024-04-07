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


'' CWiki2fbhelp - emitter for console fbhelp file
''
'' chng: jul/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_lang.bi"

#include once "CWiki.bi"
#include once "CWakka2fbhelp.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_templates.bi"
#include once "fbdoc_keywords.bi"
#include once "fbdoc_string.bi"

#include once "CWiki2fbhelp.bi"
#include once "CPage.bi"
#include once "CPageList.bi"

#include once "printlog.bi"

namespace fb.fbdoc

	type CWiki2fbhelpCtx_
		as zstring ptr urlbase
		as integer indentbase
		as zstring ptr outputdir
		as CPageList ptr paglist
		as CPageList ptr toclist
		as CWakka2fbhelp ptr converter
		as CWiki ptr wiki
	end type

	'':::::
	constructor CWiki2fbhelp _
		( _
			byval urlbase as zstring ptr, _
			byval indentbase as integer, _
			byval outputdir as zstring ptr, _
			byval paglist as CPageList ptr, _
			byval toclist as CPageList ptr _
		)

		ctx = new CWiki2fbhelpCtx
		ctx->urlbase = NULL
		ZSet @ctx->urlbase, urlbase
		ctx->indentbase = indentbase
		ctx->outputdir = NULL
		ZSet @ctx->outputdir, outputdir
		ctx->paglist = paglist
		ctx->toclist = toclist
		ctx->converter = NULL
		'' ctx->converter = new CWakka2fbhelp
		ctx->wiki = new CWiki

	end constructor

	'':::::
	destructor CWiki2fbhelp _
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
			byval ctx as CWiki2fbhelpCtx ptr, _
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
	function CWiki2fbhelp.EmitPages _
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
	function CWiki2fbhelp.EmitDefPage _
		( _
			byval page as CPage ptr, _
			byval sbody as zstring ptr _
		) as integer

		dim as string sBodyTxt, sTxt, sPageName, sPageTitle, s

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

		sTxt = chr(27, &h81) + sPageTitle + chr(10)

		if( left( sBodyTxt, 1 ) <> chr(10) ) then
			sTxt += chr(10)
		end if
		
		sTxt += Lang.ExpandString( sBodyTxt )

		if( lcase( sPageName ) = "doctoc" ) then
			s = Templates.Get("fbhelp_doctoc")
			s = Lang.ExpandString( s )
			sTxt = ReplaceSubStr( s, "{$pg_body}", sTxt )
		end if
	
		function = _OutputFile( ctx, page->GetName() + ".txt", sTxt )

	end function

	'':::::
	function CWiki2fbhelp.Emit _
		( _
		) as integer

		ctx->converter = new CWakka2fbhelp

		if( ctx->converter = NULL) then
			return FALSE
		end if

		ctx->converter->setTagDoGen( WIKI_TOKEN_HORZLINE, false )
		ctx->converter->setTagDoGen( WIKI_TOKEN_SECT_ITEM, false )

		ctx->converter->setIsFlat( false )

		this.EmitPages()

		delete ctx->converter
		ctx->converter = NULL

		return TRUE
	end function

end namespace
