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


'' CWiki2txt - emitter for txt file
''
'' chng: dec/2006 written [coderJeff]
''

#include once "common.bi"
#include once "fbdoc_lang.bi"

#include once "CWiki.bi"
#include once "CWakka2fbhelp.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_templates.bi"

#include once "CWiki2txt.bi"
#include once "CPage.bi"
#include once "CPageList.bi"

#include once "vbcompat.bi"

type CWiki2txt_
	as zstring ptr urlbase
	as integer indentbase
	as zstring ptr outputdir
	as CPageList ptr paglist
	as CPageList ptr toclist
	as CWakka2fbhelp ptr converter
	as CWiki ptr wiki
end type

'':::::
function CWiki2txt_New _
	( _
		byval urlbase as zstring ptr, _
		byval indentbase as integer, _
		byval outputdir as zstring ptr, _
		byval paglist as CPageList ptr, _
		byval toclist as CPageList ptr, _
		byval _this as CWiki2txt ptr _
	) as CWiki2txt ptr

	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CWiki2txt ) )
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
	'' _this->converter = CWakka2txt_New( )

	function = _this

end function

'':::::
sub CWiki2txt_Delete _
	( _
		byval _this as CWiki2txt ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	ZFree @_this->urlbase
	ZFree @_this->outputdir
	'' CWakka2txt_Delete( _this->converter )
	CWiki_Delete( _this->wiki )

	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

private function _OutputFile _
	( _
		byval _this as CWiki2txt ptr, _
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

	ret = ReplaceSubStr( ret, "&middot;", "-" )

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
function CWiki2txt_EmitPages _
	( _
		byval _this as CWiki2txt ptr _
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
					? "Emitting: " + CPage_GetName(page) + " = '" + CPage_GetTitle(page) + "'"
					if CWiki2txt_EmitDefPage( _this, page, sBody ) then
						CPage_SetEmitted( page, TRUE )	
					end if
					okCount += 1
				else
					? "Error On: " + CPage_GetName(page) + " = '" + CPage_GetTitle(page) + "'"
					errCount += 1
				end if
			end if
		end if
		page = CPageList_NextEnum( @page_i )
	wend

	print str(okCount) + " pages emitted OK"  
	if( errCount > 0 ) then
		print str(errCount) + " pages had no content and were skipped"
	end if

	return TRUE

end function

'':::::
function CWiki2txt_EmitDefPage _
	( _
		byval _this as CWiki2txt ptr, _
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

	sBodyTxt = CWakka2fbhelp_gen( _this->converter, @"", _this->wiki )

	sTxt = sPageTitle + chr(10)

	if( left( sBodyTxt, 1 ) <> chr(10) ) then
		sTxt += chr(10)
	end if
	
	sTxt += Lang_ExpandString( sBodyTxt )

	function = _OutputFile( _this, CPage_GetName( page ) + ".txt", sTxt )

end function

'':::::
private function _MakePageHeader _
	( _
		byref sText as string, _
		byval style as integer _
	) as string
	
	dim ret as string

	'' section
	if( style = 1 ) then
		ret += chr(10) + chr(10)
		ret += string( 76, asc("=") ) + chr(10)
		ret += space(2) + ucase( sText ) + chr(10)
		ret += space(2) + string( len(sText), "-" ) + chr(10)
		ret += chr(10) + chr(10)

	'' sub-section
	elseif( style = 2 ) then
		ret += chr(10)
		ret += string( 76, asc("=") ) + chr(10)
		ret += space(4) + sText + chr(10)
		ret += chr(10)

	else
		ret += string( 76 - 6 - len(sText) , asc("-") ) 
		ret += " " + sText + " "
		ret += string( 4, asc("-") ) 
		ret += chr(10)

	end if

	return ret

end function

'':::::
private function _LoadAndEmitTOC _
	( _
		byval _this as CWiki2txt ptr, _
		byval sPageName as zstring ptr, _
		byval sOutputFile as zstring ptr _
	) as integer

	dim as CPage ptr page
	dim as string sBody, sTitle, f, a
	dim as TLIST ptr lst
	dim as integer h
	dim as WikiPageLink ptr pagelink

	'' Load and Emit PrintToc
	page = CPage_New( *sPageName )

	if( len(*sPageName) = 0 ) then
		return FALSE
	end if

	sBody = LoadPage( *sPageName, TRUE )
	if( len(sbody) > 0 ) then

		CWiki_Parse( _this->wiki, *sPageName, sBody ) 

		sTitle = CWiki_GetPageTitle( _this->wiki )
		if( len(sTitle) > 0 ) then
			CPage_SetPageTitle( page, sTitle )
		end if

		? "Emitting: " + CPage_GetName(page) + " = '" + CPage_GetTitle(page) + "'"
		if CWiki2txt_EmitDefPage( _this, page, sBody ) then
			CPage_SetEmitted( page, TRUE )	
		end if
	else
		? "Error On: " + CPage_GetName(page) + " = '" + CPage_GetTitle(page) + "'"
	end if

	CPage_Delete( page )
	

	'' Build Output file
	lst = CWiki_GetDocTocLinks( _this->wiki, false )

	f = *_this->outputdir + *sOutputFile

	h = freefile
	if( open(  f for output as #h ) <> 0 ) then
		print "Unable to write '" + f + "'"
		return FALSE
	end if


	a += "FreeBASIC User's Manual" + chr(10)
	a += "-----------------------" + chr(10)
	a += chr(10)
	a += "From http://www.freebasic.net/wiki" + chr(10)
	a += chr(10)
	a += "This file last built : " & format( now(), "yyyy/mm/dd hh:mm:ss" ) & chr(10)
	a += chr(10)
	a += chr(10)

	put #h,,a

	f = *_this->outputdir + *sPageName + ".txt"

	sBody = LoadFileAsString( f )
	if( len(sbody) > 0 ) then
		a = _MakePageHeader( *sPageName, 0 ) + sBody + chr(10)
		put #h,,a
	end if

	pagelink = cast( WikiPageLink ptr, listGetHead( lst ) )
	do while( pagelink <> NULL )
		
		select case pagelink->linkclass
		case WIKI_PAGELINK_CLASS_SECTION
			a = _MakePageHeader( pagelink->text, 1 )
			put #h,,a

		case WIKI_PAGELINK_CLASS_SUBSECT
			a = _MakePageHeader( pagelink->text, 2 )
			put #h,,a

		case else

			f = *_this->outputdir + pagelink->link.url + ".txt"

			sBody = LoadFileAsString( f )
			if( len(sbody) > 0 ) then

				a = _MakePageHeader( pagelink->link.url, 0 )
				put #h,,a

				put #h,,sBody

				a = chr(10) + chr(10)
				put #h,,a

			end if

		end select

		pagelink = cast( WikiPageLink ptr, listGetNext( pagelink ) )
	loop

	close #h

	return TRUE

end function

'':::::
function CWiki2txt_Emit _
	( _
		byval _this as CWiki2txt ptr _
	) as integer

	_this->converter = CWakka2fbhelp_New( )

	if( _this->converter = NULL) then
		return FALSE
	end if

	CWakka2fbhelp_setTagDoGen( _this->converter, WIKI_TOKEN_HORZLINE, false )
	CWakka2fbhelp_setTagDoGen( _this->converter, WIKI_TOKEN_SECT_ITEM, false )

	CWakka2fbhelp_setIsFlat( _this->converter, true )

	CWiki2txt_EmitPages( _this )
	_LoadAndEmitTOC( _this, @"PrintToc", @"fbdoc.txt" )

	CWakka2fbhelp_Delete( _this->converter )
	_this->converter = NULL

	return TRUE
end function
