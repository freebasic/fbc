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


'' CWiki2fbhelp - emitter for console fbhelp file
''
'' chng: jul/2006 written [coderJeff]
''

option explicit

#include once "common.bi"
#include once "fbdoc_lang.bi"

#include once "CWiki.bi"
#include once "CWakka2fbhelp.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_templates.bi"

#include once "CWiki2fbhelp.bi"
#include once "CPage.bi"
#include once "CPageList.bi"

type CWiki2fbhelp_
	as zstring ptr urlbase
	as integer indentbase
	as zstring ptr outputdir
	as CPageList ptr paglist
	as CPageList ptr toclist
	as CWakka2fbhelp ptr converter
	as CWiki ptr wiki
end type

'':::::
function CWiki2fbhelp_New _
	( _
		byval urlbase as zstring ptr, _
		byval indentbase as integer, _
		byval outputdir as zstring ptr, _
		byval paglist as CPageList ptr, _
		byval toclist as CPageList ptr, _
		byval _this as CWiki2fbhelp ptr _
	) as CWiki2fbhelp ptr

	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CWiki2fbhelp ) )
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
	'' _this->converter = CWakka2fbhelp_New( )

	function = _this

end function

'':::::
sub CWiki2fbhelp_Delete _
	( _
		byval _this as CWiki2fbhelp ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	ZFree @_this->urlbase
	ZFree @_this->outputdir
	'' CWakka2fbhelp_Delete( _this->converter )
	CWiki_Delete( _this->wiki )

	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

private function _OutputFile _
	( _
		byval _this as CWiki2fbhelp ptr, _
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
function CWiki2fbhelp_EmitPages _
	( _
		byval _this as CWiki2fbhelp ptr _
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
					if CWiki2fbhelp_EmitDefPage( _this, page, sBody ) then
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
function CWiki2fbhelp_EmitDefPage _
	( _
		byval _this as CWiki2fbhelp ptr, _
		byval page as CPage ptr, _
		byval sbody as zstring ptr _
	) as integer

	dim as string sBodyTxt, sTxt, sTemplate, sPageName, sPageTitle

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
		CWakka2fbhelp_setIndentBase( _this->converter, 0 ) '' 1
		sPageTitle = FormatPageTitle( CPage_GetTitle(page) )
	else
		CWakka2fbhelp_setIndentBase( _this->converter, 0 )
		sPageTitle = CPage_GetTitle(page)
	end if

	CWiki_Parse( _this->wiki, sPageName, sBody ) 
	'if( lcase(sPageName) = "??pagename??" ) then
	'	CWiki_Dump( _this->wiki )
	'end if

	sBodyTxt = CWakka2fbhelp_gen( _this->converter, @"", _this->wiki )

	''sHtml = Templates_Get("chm_def")
	''sHtml = ReplaceSubStr( sTxt, "{$pg_body}", sBodyTxt )
	''sHtml = ReplaceSubStr( sTxt, "{$pg_title}", Text2Html( sPageTitle ) )

	sTxt = chr(27, &h81) + sPageTitle + chr(10)

	if( left( sBodyTxt, 1 ) <> chr(10) ) then
		sTxt += chr(10)
	end if
	
	sTxt += Lang_ExpandString( sBodyTxt )

	function = _OutputFile( _this, CPage_GetName( page ) + ".txt", sTxt )

end function

'':::::
function CWiki2fbhelp_Emit( _
		byval _this as CWiki2fbhelp ptr _
) as integer

	_this->converter = CWakka2fbhelp_New( )

	if( _this->converter = NULL) then
		return FALSE
	end if

	CWakka2fbhelp_setTagDoGen( _this->converter, WIKI_TOKEN_HORZLINE, false )
	CWakka2fbhelp_setTagDoGen( _this->converter, WIKI_TOKEN_SECT_ITEM, false )

	CWiki2fbhelp_EmitPages( _this )

	CWakka2fbhelp_Delete( _this->converter )
	_this->converter = NULL

	return TRUE
end function
