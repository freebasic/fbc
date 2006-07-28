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


'' CWiki2Chm - somewhat based on the PHP wikiconv source
''
'' chng: jun/2006 written [coderJeff]
''

option explicit

#include once "common.bi"
#include once "fbdoc_lang.bi"

#include once "CWiki.bi"
#include once "CWakka2Html.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_templates.bi"

#include once "CWiki2Chm.bi"
#include once "CPage.bi"
#include once "CPageList.bi"

type CWiki2Chm_
	as zstring ptr urlbase
	as integer indentbase
	as zstring ptr outputdir
	as CPageList ptr paglist
	as CPageList ptr toclist
	as CWakka2Html ptr converter
	as CWiki ptr wiki
end type

'':::::
function CWiki2Chm_New _
	( _
		byval urlbase as zstring ptr, _
		byval indentbase as integer, _
		byval outputdir as zstring ptr, _
		byval paglist as CPageList ptr, _
		byval toclist as CPageList ptr, _
		byval _this as CWiki2Chm ptr _
	) as CWiki2Chm ptr

	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CWiki2Chm ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	_this->wiki = CWiki_New( )
	if( _this->wiki = NULL ) then
		deallocate( _this )
		return NULL
	end if


	ZSet @_this->urlbase, urlbase
	_this->indentbase = indentbase
	ZSet @_this->outputdir, outputdir
	_this->paglist = paglist
	_this->toclist = toclist
	'' _this->converter = CWakka2Html_New( )

	function = _this

end function

'':::::
sub CWiki2Chm_Delete _
	( _
		byval _this as CWiki2Chm ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	ZFree @_this->urlbase
	ZFree @_this->outputdir
	'' CWakka2Html_Delete( _this->converter )
	CWiki_Delete( _this->wiki )

	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

private function _OutputFile _
	( _
		byval _this as CWiki2Chm ptr, _
		byval sFileName as zstring ptr, _
		byval sContent as zstring ptr _
	) as integer

	if( _this = NULL) then
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

	ret = Lang_ExpandString( sContent )

	sOutputFile = *_this->outputdir + *sFileName

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
function CWiki2Chm_EmitPages _
	( _
		byval _this as CWiki2Chm ptr _
	) as integer

	dim as CPage ptr page
	dim as any ptr page_i
	dim as string sName, sBody
	dim as integer errCount = 0, okCount = 0

	CPageList_ResetEmitted( _this->paglist )

	page = CPageList_NewEnum( _this->paglist, @page_i )
	while( page )
		if( CPage_GetEmitted( page ) = FALSE ) then
			sName = CPage_GetName(page)
			if( len(sName) > 0 ) then
				sBody = LoadPage( sName, TRUE )
				if( len(sbody) > 0 ) then
					? "Emitting: " + Space(CPage_GetLevel(page)*3) + Str(CPage_GetLevel(page)) + " - " + CPage_GetName(page) + " = '" + CPage_GetTitle(page) + "'"
					if CWiki2Chm_EmitDefPage( _this, page, sBody ) then
						CPage_SetEmitted( page, TRUE )	
					end if
					okCount += 1
				else
					? "Error On: " + Space(CPage_GetLevel(page)*3) + Str(CPage_GetLevel(page)) + " - " + CPage_GetName(page) + " = '" + CPage_GetTitle(page) + "'"
					errCount += 1
				end if
			end if
		end if
		page = CPageList_NextEnum( @page_i )
	wend

	? str(okCount) + " pages emitted OK"  
	? str(errCount) + " pages had no content and were skipped"

	return TRUE

end function

'':::::
function CWiki2Chm_EmitDefPage _
	( _
		byval _this as CWiki2Chm ptr, _
		byval page as CPage ptr, _
		byval sbody as zstring ptr _
	) as integer

	dim as string sBodyHtml, sHtml, sTemplate, sPageName, sPageTitle

	if( page = NULL ) then
		return FALSE
	end if

	if( _this->converter = NULL ) then
		return FALSE
	end if

	if( len(*sbody) = 0 ) then
		return FALSE
	end if

	sPageName = CPage_GetName(page)

	if( lcase(left(sPageName, 5)) = "keypg" ) then
		CWakka2Html_setIndentBase( _this->converter, 1 )
		sPageTitle = FormatPageTitle( CPage_GetTitle(page) )
	else
		CWakka2Html_setIndentBase( _this->converter, 0 )
		sPageTitle = CPage_GetTitle(page)
	end if

	CWiki_Parse( _this->wiki, sPageName, sBody ) 
	'if( lcase(sPageName) = "??pagename??" ) then
	'	CWiki_Dump( _this->wiki )
	'end if

	sBodyHtml = CWakka2Html_gen( _this->converter, @"", _this->wiki )

	sHtml = Templates_Get("chm_def")
	sHtml = ReplaceSubStr( sHtml, "{$pg_body}", sBodyHtml )
	sHtml = ReplaceSubStr( sHtml, "{$pg_title}", Text2Html( sPageTitle ) )

	sHtml = Lang_ExpandString( sHtml )

	function = _OutputFile( _this, CPage_GetName( page ) + ".html", sHtml )

end function

'':::::
function CWiki2Chm_EmitToc _
	( _
		byval _this as CWiki2Chm ptr, _
		byval sTocName as zstring ptr _
	) as integer
	
	dim as integer level = 0
	dim as CPage ptr page
	dim as any ptr page_i
	dim as string sBodyHtml, sHtml

	function = FALSE

	page = CPageList_NewEnum( _this->toclist, @page_i )
	while( page )

		while( level < CPage_GetLevel( page ) )
			sBodyHtml +=  "<ul>" + crlf
			level += 1
		wend

		while( level > CPage_GetLevel( page ) )
			level -= 1
			sBodyHtml +=  "</ul>"  + crlf
		wend

		sBodyHtml +=  "<li><object type=""text/sitemap"">"
		sBodyHtml +=  "<param name=""Name"" value=""" + CPage_GetFormattedTitle( page ) + """>"
		if( len( CPage_GetName( page )) > 0 ) then
			sBodyHtml +=  "<param name=""Local"" value=""" + CPage_GetName( page ) + ".html"">"
		end if
		sBodyHtml +=  "</object>" + crlf

		page = CPageList_NextEnum( @page_i )
	wend

	while( level > CPage_GetLevel( page ) )
		level -= 1
		sBodyHtml +=  "</ul>" + crlf
	wend

	sHtml = Templates_Get("chm_toc")

	sHtml = Lang_ExpandString( sHtml )

	sHtml = ReplaceSubStr( sHtml, "{$pg_body}", sBodyHtml )

	function = _OutputFile( _this, *sTocName, sHtml )

end function

'':::::
function CWiki2Chm_EmitHtmlIndex _
	( _
		byval _this as CWiki2Chm ptr, _
		byval sFileName as zstring ptr _
	) as integer
	
	dim as integer level = 0
	dim as CPage ptr page
	dim as any ptr page_i
	dim as string sBodyHtml, sHtml

	function = FALSE

	page = CPageList_NewEnum( _this->toclist, @page_i )
	while( page )

		while( level < CPage_GetLevel( page ) )
			sBodyHtml +=  "<ul>" + crlf
			level += 1
		wend

		while( level > CPage_GetLevel( page ) )
			level -= 1
			sBodyHtml +=  "</ul>"  + crlf
		wend

		sBodyHtml +=  "<li><object type=""text/sitemap"">"

		sBodyHtml +=  "<a href=""" + CPage_GetName( page ) + ".html"">" + Text2Html( CPage_GetFormattedTitle( page ) ) + "</a><br />" + nl

		page = CPageList_NextEnum( @page_i )
	wend

	while( level > CPage_GetLevel( page ) )
		level -= 1
		sBodyHtml +=  "</ul>" + crlf
	wend

	sHtml = Templates_Get("htm_toc")

	sHtml = Lang_ExpandString( sHtml )

	sHtml = ReplaceSubStr( sHtml, "{$pg_body}", sBodyHtml )

	function = _OutputFile( _this, *sFileName, sHtml )

end function

'':::::
function CWiki2Chm_EmitIndex _
	( _
		byval _this as CWiki2Chm ptr, _
		byval sIndexName as zstring ptr _
	) as integer
	
	dim as integer level = 0
	dim as CPage ptr page
	dim as any ptr page_i
	dim as string sBodyHtml, sHtml

	function = FALSE

	page = CPageList_NewEnum( _this->paglist, @page_i )
	while( page )

		If( CPage_GetEmitted(page) ) then
			sBodyHtml +=  "<li><object type=""text/sitemap"">"
			sBodyHtml +=  "<param name=""Name"" value=""" + CPage_GetFormattedTitle( page ) + """>"
			sBodyHtml +=  "<param name=""Local"" value=""" + CPage_GetName( page ) + ".html"">"
			sBodyHtml +=  "</object>" + nl
		end if

		page = CPageList_NextEnum( @page_i )
	wend

	sHtml = Templates_Get("chm_idx")

	sHtml = Lang_ExpandString( sHtml )
	sHtml = ReplaceSubStr( sHtml, "{$pg_title}", "Index" )
	sHtml = ReplaceSubStr( sHtml, "{$pg_body}", sBodyHtml )

	function = _OutputFile( _this, *sIndexName, sHtml )

end function

'':::::
function CWiki2Chm_EmitProject _
	( _
		byval _this as CWiki2Chm ptr, _
		byval sProjectName as zstring ptr, _
		byval sChmName as zstring ptr _
	) as integer

	dim as integer h, level = 0
	dim as CPage ptr page
	dim as any ptr page_i
	dim as string sBodyHtml, sHtml

	function = FALSE

	page = CPageList_NewEnum( _this->paglist, @page_i )
	while( page )
		if( CPage_GetEmitted( page ) ) then
			sBodyHtml += CPage_GetName( page ) + ".html" + crlf
		end if
		page = CPageList_NextEnum( @page_i )
	wend

	sHtml = Templates_Get("chm_prj")

	sHtml = Lang_ExpandString( sHtml )

	sHtml = ReplaceSubStr( sHtml, "{$pg_chm_file}", sChmName )
	sHtml = ReplaceSubStr( sHtml, "{$pg_toc_file}", sChmName )
	sHtml = ReplaceSubStr( sHtml, "{$pg_idx_file}", sChmName )
	sHtml = ReplaceSubStr( sHtml, "{$pg_def_file}", "DocToc" )

	sHtml = ReplaceSubStr( sHtml, "{$pg_files}", sBodyHtml )

	function = _OutputFile( _this, *sProjectName, sHtml )

end function

'':::::
function CWiki2Chm_Emit( _
		byval _this as CWiki2Chm ptr _
) as integer

	_this->converter = CWakka2Html_New( )

	if( _this->converter = NULL) then
		return FALSE
	end if

	CWakka2Html_setCssClass( _this->converter, WIKI_TOKEN_PRE, "fb_pre" )
	CWakka2Html_setCssClass( _this->converter, WIKI_TOKEN_HEADER, "fb_header" )
	CWakka2Html_setCssClass( _this->converter, WIKI_TOKEN_BOXLEFT, "fb_box" )
	CWakka2Html_setCssClass( _this->converter, WIKI_TOKEN_BOXRIGHT, "fb_box" )
	CWakka2Html_setCssClass( _this->converter, WIKI_TOKEN_ACTION_TB, "fb_table" )
	CWakka2Html_setCssClass( _this->converter, WIKI_TOKEN_ACTION_IMG, "fb_img" )
	CWakka2Html_setTagDoGen( _this->converter, WIKI_TOKEN_HORZLINE, false )
	CWakka2Html_setTagDoGen( _this->converter, WIKI_TOKEN_SECT_ITEM, false )
	
	CWiki2Chm_EmitPages( _this )

	if( CPageList_Count( _this->toclist ) > 0 ) then
		CWiki2Chm_EmitTOC( _this, "fbdoc.hhc" )
		CWiki2Chm_EmitIndex( _this, "fbdoc.hhk" )
		CWiki2Chm_EmitProject( _this, "fbdoc.hhp", "fbdoc" )
		CWiki2Chm_EmitHtmlIndex( _this, "00index.html" )
	end if

	CWakka2Html_Delete( _this->converter )
	_this->converter = NULL

	return TRUE
end function
