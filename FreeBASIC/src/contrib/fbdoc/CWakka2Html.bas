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


'' CWakka2Html - based on the PHP wikiconv source
''
'' chng: may/2006 written [coderJeff]
''

#include once "common.bi"
#include once "CWiki.bi"
#include once "CWakka2Html.bi"
#include once "CRegex.bi"

#include once "CFbCode.bi"

#undef iif

private function iif(c as integer, a as string, b as string) as string
	if (c) then
		return a
	else
		return b
	end if
end function

enum FBDOC_ITEM	
	FBDOC_ITEM_CATEGORY
	FBDOC_ITEM_KEYWORD
	FBDOC_ITEM_TITLE
	FBDOC_ITEM_SYNTAX
	FBDOC_ITEM_USAGE
	FBDOC_ITEM_PARAM
	FBDOC_ITEM_RET
	FBDOC_ITEM_DESC
	FBDOC_ITEM_EX
	FBDOC_ITEM_DIFF
	FBDOC_ITEM_SEE
	FBDOC_ITEM_BACK
	FBDOC_ITEM_CLOSE
	FBDOC_ITEMS
end enum

type fbdoc_item_t
	item_name as zstring ptr
	isblock as integer
	sect_name as zstring ptr
end type

type fbcode_item_t
	id as integer
	cssClass as zstring ptr
	grpno as integer
end type

type CWakka2Html_

	as zstring ptr urlbase
	as integer indentbase
	as integer tagflags(0 to WIKI_TAGS - 1)
	as zstring ptr cssClassTb(0 to WIKI_TOKENS - 1)
	as integer tagGenTb(0 to WIKI_TOKENS - 1)
	as zstring ptr page
	as CRegex ptr trimre
	as CFbCode ptr fbcode
end type

private function CWakka2Html_AllocRe _
 	( _
		byval _this as CWakka2Html ptr _
	) as integer

	function = FALSE
	
	_this->trimre = CRegex_New( "^\s*(\<br \/\>)+|(\<br \/\>)+\s*$" )
	if( _this->trimre = NULL ) then
		exit function
	end if

	function = TRUE

end function

private sub CWakka2Html_FreeRe _
	( _
		byval _this as CWakka2Html ptr _
	)

	if( _this->trimre <> NULL ) then
		CRegex_Delete( _this->trimre )
		_this->trimre = NULL
	end if

end sub

'':::::
function CWakka2Html_New _
	( _
		byval _this as CWakka2Html ptr _
	) as CWakka2Html ptr

	dim as integer isstatic = TRUE, i
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CWakka2Html ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	''
	if( CWakka2Html_AllocRe( _this ) = FALSE ) then

		CWakka2Html_FreeRe( _this )
		
  		if( isstatic = FALSE ) then
  			deallocate( _this )
  		end if
		
		return NULL
	end if

  ZSet @_this->urlbase, @""
	for i = 0 to WIKI_TOKENS - 1
		ZSet @_this->cssClassTb(i), @""
		_this->tagGenTb( i ) = TRUE
	next i
	ZSet @_this->page, @""
	_this->fbcode = CFbCode_New( )


	function = _this

end function

'':::::
sub CWakka2Html_Delete _
	( _
		byval _this as CWakka2Html ptr, _
		byval isstatic as integer _
	)
	
	dim as integer i

	if( _this = NULL ) then
		exit sub
	end if

	ZFree @_this->urlbase
	for i = 0 to WIKI_TOKENS - 1
		ZFree @_this->cssClassTb(i)
	next i
	ZFree @_this->page

	''
	CWakka2Html_FreeRe( _this )

	''
	CFbCode_Delete( _this->fbcode )
	
	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
sub CWakka2Html_setUrlBase( byval _this as CWakka2Html ptr, byval value as zstring ptr )
	zSet @_this->urlbase, value
end sub

'':::::
sub CWakka2Html_setIndentBase( byval _this as CWakka2Html ptr, byval value as integer )
	_this->indentbase = value
end sub

'':::::
sub CWakka2Html_setCssClass( byval _this as CWakka2Html ptr, byval token_id as integer, byval value as zstring ptr )
	ZSet @_this->cssClassTb(token_id), value
end sub

'':::::
sub CWakka2Html_setTagDoGen( byval _this as CWakka2Html ptr, byval token_id as integer, byval value as integer )
	_this->tagGenTb( token_id ) = value
end sub

'':::::
private function _TrimTags(  byval _this as CWakka2Html ptr, byval text as zstring ptr ) as string

	dim as string res

	res = ""

	if( CRegex_Search( _this->trimre, text ) ) then
		dim as integer ofs = 0
		
		do
			dim as integer mofs = CRegex_GetOfs( _this->trimre, 0 )
			if( mofs > ofs ) then
				res += mid( *text, 1+ofs, (mofs - ofs) )
			end if
		
			'' res += CRegex_GetStr( _this->re, 0 )
		
			ofs = mofs + CRegex_GetLen( _this->trimre, 0 )

		loop while CRegex_SearchNext( _this->trimre )

		if( ofs < len( *text ) ) then
			res += mid( *text, 1+ofs )
		end if
	else
		res = *text
	end if
	
	return res
	
end function

'':::::
private function _closeTags( byval _this as CWakka2Html ptr, byval textIn as zstring ptr ) as string
	
		dim as string text

		text = *textIn

		if( _this->tagFlags(WIKI_TAG_BOLD) and 1 ) then
			_this->tagFlags(WIKI_TAG_BOLD) -= 1
			text += "</b>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_ITALIC) and 1 ) then
			_this->tagFlags(WIKI_TAG_ITALIC) -= 1
			text += "</i>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_UNDERLINE) and 1 ) then
			_this->tagFlags(WIKI_TAG_UNDERLINE) -= 1
			text += "</u>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_MONOSPACE) and 1 ) then
			_this->tagFlags(WIKI_TAG_MONOSPACE) -= 1
			text += "</tt>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_NOTES) and 1 ) then
			_this->tagFlags(WIKI_TAG_NOTES) -= 1
			text += "</span>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_STRIKE) and 1 ) then
			_this->tagFlags(WIKI_TAG_STRIKE) -= 1
			text += "</strike>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_KEYS) and 1 ) then
			_this->tagFlags(WIKI_TAG_KEYS) -= 1
			text += "</kbd>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_CENTER) and 1 ) then
			_this->tagFlags(WIKI_TAG_CENTER) -= 1
			text += "</div>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_HEADER) and 1 ) then
			_this->tagFlags(WIKI_TAG_HEADER) -= 1
			text += "</div>"
		end if

		while( _this->tagFlags(WIKI_TAG_LEVEL) > 0 )
			_this->tagFlags(WIKI_TAG_LEVEL) -= 1
			text += "</ul>"
		wend

		if( _this->tagFlags(WIKI_TAG_BOXLEFT) and 1 ) then

			_this->tagFlags(WIKI_TAG_BOXLEFT) -= 1
			text += "</td>"

			if( (_this->tagFlags(WIKI_TAG_BOXRIGHT) and 1) = 0 ) then
				text += "</tr></table>"	
			end if

		end if
		
		if( _this->tagFlags(WIKI_TAG_BOXRIGHT) and 1 ) then
			_this->tagFlags(WIKI_TAG_BOXRIGHT) -= 1
			text += "</td></tr></table>"
		end if
		
		if( _this->tagFlags(WIKI_TAG_SECTION) <> 0 ) then
			_this->tagFlags(WIKI_TAG_SECTION) = 0
			text += "</div>"
		end if
			
		return _TrimTags( _this, text )

end function


'':::::
private function _codeToHtml( byval _this as CWakka2Html ptr, text as zstring ptr ) as string

	dim res as string
	dim as any ptr token_i 
	dim as FbToken ptr token
	dim as integer bDefault = FALSE, lastgrpno = 0, grpno = 0, bHaveCode = FALSE

	static cssClassTb(0 to FB_TOKENS - 1) as fbcode_item_t => _
	{ _
		 ( FB_TOKEN_NULL     , @""    , 0 ), _
		 ( FB_TOKEN_SPACE    , @""    , 0 ), _
		 ( FB_TOKEN_NEWLINE  , @""    , 0 ), _
		 ( FB_TOKEN_COMMENT  , @"com" , 1 ), _
		 ( FB_TOKEN_QUOTED   , @"quo" , 2 ), _
		 ( FB_TOKEN_NUMBER   , @"num" , 3 ), _
		 ( FB_TOKEN_KEYWORD  , @"key" , 4 ), _
		 ( FB_TOKEN_DEFINE   , @"def" , 5 ), _
		 ( FB_TOKEN_NAME     , @"wrd" , 6 ), _
		 ( FB_TOKEN_OTHER    , @"oth" , 7 ) _
	}

	if( _this = NULL ) then
		bDefault = TRUE
	else
		if( _this->fbcode = NULL ) then
			bDefault = TRUE
		end if
	end if

	if( bDefault = TRUE ) then
		res += "<tt><div class=""qbasic"">
		res += Text2Html( *text, TRUE, TRUE )
		res += "</div></tt><br />" + nl
		return res
	end if

	CFbCode_Parse( _this->fbcode, text )

	res = ""

	token = CFbCode_NewEnum( _this->fbcode, @token_i )
	while( token )

		if( token->id = FB_TOKEN_NULL ) then
			exit while
		end if

		grpno = cssClassTb( token->id ).grpno
		if( lastgrpno <> grpno ) then
			if( lastgrpno <> 0 ) then
				res += "</span>"
			end if
			if( grpno <> 0 ) then
				res += "<span class=""" + *cssClassTb( token->id ).cssClass + """>"
			end if
		end if

		select case token->id
		case FB_TOKEN_NULL	
			exit while
		case FB_TOKEN_SPACE
			res += Text2Html( token->text, FALSE, TRUE )
		case FB_TOKEN_NEWLINE
			if bHaveCode = FALSE then
				res = ""
			else
				res += "<br />" + nl
			end if

		''case FB_TOKEN_COMMENT
		''case FB_TOKEN_QUOTED
		''case FB_TOKEN_NUMBER
		''case FB_TOKEN_KEYWORD
		''case FB_TOKEN_DEFINE
		''case FB_TOKEN_NAME
		''case FB_TOKEN_OTHER
		case else
			bHaveCode = TRUE
			res += Text2Html( token->text, FALSE, TRUE )
		end select

		lastgrpno = grpno
		token = CFbCode_NextEnum( @token_i )
	wend

	if( lastgrpno <> 0 ) then
		res += "</span>"
	end if

	res = "<tt><div class=""qbasic"">" + nl + res + "</div></tt><br />" + nl

	return res
end function

'':::::
private function _find_fbdocitem( byval itemTb as fbdoc_item_t ptr, itemname as zstring ptr ) as integer
	dim i as integer
	for i = 0 to FBDOC_ITEMS - 1
		if( lcase(*itemTb[i].item_name) = lcase(*itemname) ) then
			return i
		end if
	next i
	return -1
end function

'':::::
private sub _explode_link( strValue as string, strPage as string, strName as string )

	dim i as integer

	i = instr(strValue, "|")
	if( i > 0 ) then
		strPage = left(strValue, i - 1)
		strName = mid(strValue, i + 1)
	else
		strPage = strValue
		strName = ""
	end if

end sub

private function _actionGenfbDoc( byval _this as CWakka2Html ptr, byval paramsTb as Wiki_ActionParam ptr ) as string
	
	static itemTb(0 to FBDOC_ITEMS - 1) as fbdoc_item_t => _
	{ _
		( @"category" , false, @"{#fb_sect_cat}"    ), _
		( @"keyword"  , false, @"{#fb_sect_key}"    ), _
		( @"title"    , false, @"{#fb_sect_title}"  ), _
		( @"syntax"   , true , @"{#fb_sect_syntax}" ), _
		( @"usage"    , true , @"{#fb_sect_usage}"  ), _
		( @"param"    , true , @"{#fb_sect_param}"  ), _
		( @"ret"      , true , @"{#fb_sect_ret}"    ), _
		( @"desc"     , true , @"{#fb_sect_desc}"   ), _
		( @"ex"       , true , @"{#fb_sect_ex}"     ), _
		( @"diff"     , true , @"{#fb_sect_diff}"   ), _
		( @"see"      , true , @"{#fb_sect_see}"    ), _
		( @"back"     , false, @"{#fb_sect_back}"   ), _
		( @"close"    , false, @"{#fb_sect_close}"  ) _
	}

	dim as string res, strItem, strValue, strName, strPage, ext
	dim as integer isblock, itemidx

	strItem = CWiki_GetActionParamValue(paramsTb, "item")
	strValue = CWiki_GetActionParamValue(paramsTb, "value")

	itemidx = _find_fbdocitem( @itemTb(0), strItem )

	if itemidx >= 0 then
		isblock = itemTb( itemidx ).isblock
	end if

	res = ""

	if( isblock ) then
		res += _closeTags( _this, res )
		_this->tagFlags(WIKI_TAG_SECTION) = 1
	end if

	select case lcase( strItem )
	case "title":
		if( _this->tagGenTb(WIKI_TOKEN_SECT_ITEM) ) then
			return res + "<div class=""fb_header"">" + strValue + "</div>"
		else
			return res
		end if

	case "section":			
		return res + "<b><u>" + strValue + "</u></b>"

	case "subsect":			
		return res + "<b>" + strValue + "</b>"

	case "category":

		_explode_link strValue, strPage, strName

		return res + "<a name=""" + strPage + """></a><b>" + Text2Html( strName ) +"</b>"
		
	case "keyword":

		_explode_link strValue, strPage, strName

		if( instr( strPage, ":" ) = 0 ) then
			ext = ".html"
		else
			ext = ""
		end if

		if( lcase(left( strPage, 5 )) = "keypg" ) then
			return res + "<a href=""" + *_this->urlbase + strPage + ext + """>" + Text2Html( FormatPageTitle(strName) ) + "</a>"
		end if
		
		return res + "<a href=""" + *_this->urlbase + strPage + ext + """>" + Text2Html( strName ) + "</a>"
	
	case "back":
		if( _this->tagGenTb(WIKI_TOKEN_SECT_ITEM) ) then

			_explode_link strValue, strPage, strName
			
			return res + "<div align=""center"">{#fb_sect_back} <a href=""" + _ 
					 *_this->urlbase + strPage + """>" + Text2Html( strName ) + "</a></div>"
		else
			return res
		end if

	case "close":
		if( _this->tagFlags(WIKI_TAG_SECTION) <> 0  ) then
			_this->tagFlags(WIKI_TAG_SECTION) = 0
			res = "</div>"
		else
			res = ""
		end if
		
		return res

	case else			

		if itemidx >= 0 then
			strValue = *itemTb( itemidx ).sect_name
		end if
		
		return res + "<div class=""fb_sect_title"">" + strValue +  _
						"</div><div class=""fb_sect_cont"">"

	end select
	

end function
 
'':::::
private function _index_cells( byval text as zstring ptr, byval cellTb as zstring ptr ptr ptr ) as integer

	dim as integer i, n = 0

	if( text = NULL ) then
		return n
	end if

	n += 1
	i = 0
	while( text[i] )
		if( text[i] = asc(";") ) then
			n += 1
		end if
		i += 1
	wend


	if( cellTb ) then
		
		*cellTb = Callocate( n * sizeof( zstring ptr ) )

		n = 0
		i = 0
		(*cellTb)[n] = text
		while( text[i] )
			if( text[i] = asc(";") ) then
				n += 1
				(*cellTb)[n] = text + i + 1
				text[i] = 0
			end if
			i += 1
		wend
		n += 1
	
	end if

	return n

end function

'':::::
private function _closeList( byval _this as CWakka2Html ptr ) as string	

	dim text as string
	text = ""

	while( _this->tagFlags(WIKI_TAG_LEVEL) > 0 )
		text += "</ul>"
		_this->tagFlags(WIKI_TAG_LEVEL) -= 1
	wend

	return text

end function

'':::::
private function _actionGenTable( byval _this as CWakka2Html ptr, byval paramsTb as Wiki_ActionParam ptr ) as string
	
	dim as string res, cellData, strCols, cell
	dim as zstring ptr ptr cellTb
	dim as integer n, cols, col, i

	res = _closeList( _this )
	
	cellData = CWiki_GetActionParamValue( paramsTb, "cells" )
	strCols =  CWiki_GetActionParamValue( paramsTb, "columns" )

	n = _index_cells( cellData, @cellTb )
	
	if( len( strCols ) > 0 ) then
		cols = val( strCols )
	else
		cols = 1
	end if

	res += "<div class=""" + *_this->cssClassTb(WIKI_TOKEN_ACTION_TB) + """><table>"
	  ''  cols=" + str(cols) + " cellpadding=0
		
	col = 1
	for i = 0 to n - 1
		cell = *cellTb[i]
		if( col = 1) then
			res += "<tr>"
		end if
		if( cell = "###" ) then
			res += "<td>&nbsp;</td>"
		else
			res += "<td>" + Text2Html( cell ) + "</td>"
		end if
		col += 1
		if( col > cols ) then
			col = 1
			res += "</tr>"
		end if
	next i

	if( cols > 1) then
		if( col <> 1 ) then
			while( col <= cols)
				res += "<td>&nbsp;</td>"
				col += 1
			wend
			res += "</tr>"
		end if
	end if

	res += "</table></div>"

	if( cellTb ) then
		Deallocate cellTb
	end if
		
	return res

end function

'':::::
private function _actionGenImage( byval _this as CWakka2Html ptr, byval paramsTb as Wiki_ActionParam ptr ) as string
	
	dim as string res, class, strAlt, strUrl

	class = *_this->cssClassTb(WIKI_TOKEN_ACTION_IMG)

	res = "<div class=""" + class + """><img"

	strAlt = CWiki_GetActionParamValue( paramsTb, "alt" )
	strUrl = CWiki_GetActionParamValue( paramsTb, "url" )

	if( len(strAlt) > 0 ) then
		res += " alt=""" + strAlt + """"
	end if

	if( len(strUrl) > 0 ) then
		if left(strUrl, 1) = "/" then
			strUrl = mid( strUrl, 2)
		end if
		res += " src=""" + strUrl + """"
	end if

	res += " /></div>"

	return res

end function

'':::::
private function _actionGenAnchor( byval _this as CWakka2Html ptr, byval paramsTb as Wiki_ActionParam ptr ) as string

	dim as string res, sName, sTarget, sLink

	res = _closeList( _this )
		
	sName = CWiki_GetActionParamValue( paramsTb, "name" )

	if instr( sName, "|" ) = 0 then
		return res + "<a name=""" + sName + """></a>"
	end if

	_explode_link sName, sTarget, sLink

	return res + "<a href=""#" + sTarget + """>" + Text2Html( sLink ) + "</a>"
	
end function

'':::::
private function _actionToHtml( byval _this as CWakka2Html ptr, byval actionname as zstring ptr, byval paramsTb as Wiki_ActionParam ptr ) as string
	select case lcase(*actionname)
	case "fbdoc"	
		return _actionGenFbDoc( _this, paramsTb )
	case "table"
		return _actionGenTable( _this, paramsTb )
	case "image"
		return _actionGenImage( _this, paramsTb )
	case "anchor"
		return _actionGenAnchor( _this, paramsTb )
	case else
		return ""
	end select
end function

'':::::
private function _linkToHtml( byval _this as CWakka2Html ptr, byval url as zstring ptr, byval text as zstring ptr ) as string
	
	dim ext as string
	
	if ( url = NULL ) then
		return ""
	end if

	if( len(*text) = 0 ) then
		return *url
	end if

	if( instr( *url, ":" ) = 0 ) then
		ext = ".html"
	else
		ext = ""
	end if
	
	if( lcase(left( *url, 5 )) = "keypg" ) then
		return "<a href=""" + *_this->urlbase + *url + ext + """>" + Text2Html( FormatPageTitle(*text) ) + "</a>"
	end if

	return "<a href=""" + *_this->urlbase + *url + ext + """>" + Text2Html( *text ) + "</a>"

end function

'':::::
private function _listToHtml( byval _this as CWakka2Html ptr, byval level as integer ) as string
	
	dim res as string

	while( level > _this->tagFlags(WIKI_TAG_LEVEL) )
		res += "<ul>"
		_this->tagFlags(WIKI_TAG_LEVEL) += 1
	wend

	while( level < _this->tagFlags(WIKI_TAG_LEVEL) )
		res += "</ul>"
		_this->tagFlags(WIKI_TAG_LEVEL) -= 1
	wend

	res += "<li>"

	return res

end function

'':::::
private function _tokenToHtml(byval _this as CWakka2Html ptr, byval token as WikiToken ptr) as string
	static nlcnt as integer = 0, skipnl as integer = 0

	dim as string res, cssclass, x
	dim as integer dogen, i

	if( token->id = WIKI_TOKEN_NEWLINE ) then
		if( _this->tagFlags(WIKI_TAG_LEVEL) > 0 ) then
			if( nlcnt > 0 ) then
				_this->tagFlags(WIKI_TAG_LEVEL) -= 1
				nlcnt = 0
				skipnl = true
				return "</ul>" + nl
			end if
		end if
					
		res = ""
		if( skipnl = 0) then
			nlcnt += 1
			if( nlcnt < 3 ) then
				res = "<br />" + nl
			else
				nlcnt = 0
			end if
		else
			skipnl = false
			nlcnt = 0
		end if
		
		return res
	end if

	nlcnt = 0
	skipnl = false

	cssclass = *_this->cssClassTb(token->id)
	if( len( cssclass ) > 0 ) then
		cssclass = "class=""" + cssclass + """"
	end if
		
	dogen = _this->tagGenTb(token->id)

	select case as const token->id
	case WIKI_TOKEN_NULL
		return ""
	
	case WIKI_TOKEN_LT
		return "&lt;"
	
	case WIKI_TOKEN_GT
		return "&gt;"
	
	case WIKI_TOKEN_KBD
		_this->tagFlags(WIKI_TAG_KEYS) += 1
		return( iif(_this->tagFlags(WIKI_TAG_KEYS) and 1, "<kbd " + cssclass + ">", "</kbd>"))
	
	case WIKI_TOKEN_BOLD, WIKI_TOKEN_BOLD_SECTION
		_this->tagFlags(WIKI_TAG_BOLD) += 1
		return( iif(_this->tagFlags(WIKI_TAG_BOLD) and 1, "<b>", "</b>"))
	
	case WIKI_TOKEN_ITALIC
		_this->tagFlags(WIKI_TAG_ITALIC) += 1
		return( iif(_this->tagFlags(WIKI_TAG_ITALIC) and 1, "<i>", "</i>"))
	
	case WIKI_TOKEN_UNDERLINE
		_this->tagFlags(WIKI_TAG_UNDERLINE) += 1
		return( iif(_this->tagFlags(WIKI_TAG_UNDERLINE) and 1, "<u>", "</u>"))

	case WIKI_TOKEN_MONOSPACE:
		_this->tagFlags(WIKI_TAG_MONOSPACE) += 1
		return( iif(_this->tagFlags(WIKI_TAG_MONOSPACE) and 1, "<tt>", "</tt>"))

	case WIKI_TOKEN_NOTES
		_this->tagFlags(WIKI_TAG_NOTES) += 1
		return( iif(_this->tagFlags(WIKI_TAG_NOTES) and 1, "<span " + cssclass + ">", "</span>"))

	case WIKI_TOKEN_STRIKE:
		_this->tagFlags(WIKI_TAG_STRIKE) += 1
		return( iif(_this->tagFlags(WIKI_TAG_STRIKE) and 1, "<strike>", "</strike>"))

	case WIKI_TOKEN_CENTER:
		_this->tagFlags(WIKI_TAG_CENTER) += 1
		return( iif(_this->tagFlags(WIKI_TAG_CENTER) and 1, "<div style=""text-align: center;"">", "</div>"))

	case WIKI_TOKEN_LINK:
		return _linkToHtml( _this, token->link.url, token->text )

	case WIKI_TOKEN_LIST:
		skipnl = true
		return _listToHtml( _this, token->indent.level )

	case WIKI_TOKEN_TEXT, WIKI_TOKEN_RAW:
		return token->text

	case WIKI_TOKEN_ACTION:
		return _actionToHtml( _this, token->action.name, token->action.paramhead )

	end select
	
	skipnl = TRUE
	
	res = _closeList( _this )
	
	select case ( token->id)
	case WIKI_TOKEN_FORCENL:
		return res + "<br />"
		
	case WIKI_TOKEN_HORZLINE:
		if( dogen ) then
			return res + "<hr " + cssclass + " />"
		else
			return res
		end if

	case WIKI_TOKEN_BOXLEFT:
		_this->tagFlags(WIKI_TAG_BOXLEFT) += 1
		if _this->tagFlags(WIKI_TAG_BOXLEFT) and 1 then
			return res + "<table " + cssclass + "><tr><td>"
		else
			return res + "</td>"
		end if

	case WIKI_TOKEN_BOXRIGHT:
		if _this->tagFlags(WIKI_TAG_BOXLEFT) and 1 then
			return res + "</td></tr></table>"
		end if

		_this->tagFlags(WIKI_TAG_BOXRIGHT) += 1
		if _this->tagFlags(WIKI_TAG_BOXRIGHT) and 1 then
			return res + "<td>"
		else
			return res + "</td></tr></table>"
		end if
		
	case WIKI_TOKEN_CLEAR:
		return res + "<div style=""clear:both"">&nbsp;</div>"

	case WIKI_TOKEN_HEADER:
		skipnl = false
		_this->tagFlags(WIKI_TAG_HEADER) += 1
		if _this->tagFlags(WIKI_TAG_HEADER) and 1 then
			return res + "<div " + cssclass + ">"
		else
			return res + "</div>"
		end if
	
	case WIKI_TOKEN_PRE:
		return res + "<pre " + cssclass + ">" + token->text + "</pre>"
	
	case WIKI_TOKEN_CODE:
		return res + _codeToHtml( _this, token->text )
	
	case WIKI_TOKEN_INDENT:
		skipnl = false
		x = ""
		for i = 1 to (token->indent.level - _this->indentbase) * 2
			x += "&nbsp; "
		next i
		return res + x
	end select

end function

'':::::
function CWakka2Html_gen _
	( _
		byval _this as CWakka2Html ptr, _
		byval page as zstring ptr, _
		byval wiki as CWiki ptr _
	) as string

	dim as integer i
	dim as string text
	dim as TLIST ptr tokenlist
	dim as WikiToken ptr token

	ZSet @_this->page, page

	for i = 0 to WIKI_TAGS - 1
		_this->tagFlags( i ) = 0
	next i
	
	text = ""
	
	tokenlist = CWiki_GetTokenList( wiki )
	token = cast( WikiToken ptr, listGetHead( tokenlist ) )
	while( token <> NULL )
		text += _tokenToHtml( _this, token )
		token = cast( WikiToken ptr, listGetNext( token ) )
	wend

	return _closeTags( _this, text )

end function
