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


'' CWakka2fbhelp - convert wakka format markup to fbhelp console help viewer
''
'' chng: jul/2006 written [coderJeff]
''

#include once "common.bi"
#include once "CWiki.bi"
#include once "CWakka2fbhelp.bi"

#include once "CFbCode.bi"

const chBreak = chr(10)
const chIndent = chr(9)
const chSpace = " "


#undef iif

private function iif(byval c as integer, byref a as string, byref b as string) as string
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

enum META_MODE
	META_MODE_NONE
	META_MODE_HTML
	META_MODE_ASCII
end enum

type fbdoc_item_t
	item_name as zstring ptr
	isblock as integer
	sect_name as zstring ptr
end type

type fbcode_item_t
	id as integer
	attrib as integer
	grpno as integer
end type

type CWakka2fbhelp_

	as zstring ptr urlbase
	as integer indentbase
	as integer tagDepth
	as integer tagflags(0 to WIKI_TAGS - 1)
	as integer tagGenTb(0 to WIKI_TOKENS - 1)
	as zstring ptr page
	as CFbCode ptr fbcode

	as integer maxwidth
	as integer indentlevel
	as integer indentlevel2
	as integer indentwidth
	as integer indent2
	as integer linewidth
	as integer col
	as integer row
	as integer length
	as string res
	as integer nlcount
	as integer attrib
	as integer metamode
end type

'':::::
function CWakka2fbhelp_New _
	( _
		byval _this as CWakka2fbhelp ptr _
	) as CWakka2fbhelp ptr

	dim as integer isstatic = TRUE, i
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CWakka2fbhelp ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	ZSet @_this->urlbase, @""
	ZSet @_this->page, @""
	_this->fbcode = CFbCode_New( )

	_this->maxwidth = 76
	_this->indentlevel = 0
	_this->indentlevel2 = 0
	_this->indentwidth = 3
	_this->linewidth = 0
	_this->col = 0
	_this->row = 0
	_this->length = 0
	_this->res = ""
	_this->nlcount = 0
	_this->attrib = 0
	_this->metamode = 0

	function = _this

end function

'':::::
sub CWakka2fbhelp_Delete _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval isstatic as integer _
	)
	
	dim as integer i

	if( _this = NULL ) then
		exit sub
	end if

	ZFree @_this->urlbase
	ZFree @_this->page

	''
	CFbCode_Delete( _this->fbcode )

	_this->res = ""
	
	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
sub CWakka2fbhelp_setIndentBase( byval _this as CWakka2fbhelp ptr, byval value as integer )
	_this->indentbase = value
end sub

'':::::
sub CWakka2fbhelp_setTagDoGen( byval _this as CWakka2fbhelp ptr, byval token_id as integer, byval value as integer )
	_this->tagGenTb( token_id ) = value
end sub

'' ---------------------------------------------------------------------

declare function _emitAttrib _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval attrib as integer _
	) as integer


'':::::
private function _emitIndent( byval _this as CWakka2fbhelp ptr ) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	if( _this->col = 0 ) then
		if( (_this->indentlevel + _this->indentlevel2) > 0 ) then
			_this->col = _this->indentwidth * (_this->indentlevel + _this->indentlevel2 ) + _this->indent2
			'' _this->res += string( _this->col, chSpace )
			_this->res += string( (_this->indentlevel + _this->indentlevel2), chIndent )
			_this->res += string( _this->indent2, chSpace )
		end if
	end if

	return TRUE

end function

'':::::
private function _emitBreak( byval _this as CWakka2fbhelp ptr, byval bForced as integer ) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	if( _this->col = 0 ) then
		_this->nlcount += 1
		if( (_this->nlcount < 2) or (bForced = TRUE) ) then
			_this->res += chBreak
			_this->col = 0
			_this->row += 1
			_this->indent2 = 0
			_this->indentlevel = 0
			_this->attrib = 0
		end if
	else
		_this->nlcount = 0
		_this->res += chBreak
		_this->col = 0
		_this->row += 1
		_this->indent2 = 0
		_this->indentlevel = 0
		_this->attrib = 0
	end if

	return TRUE

end function

'':::::
private function _GetStyleAttrib _
	( _
		byval _this as CWakka2fbhelp ptr _
	) as integer

	dim as integer s = 0

	if( _this->tagFlags(WIKI_TAG_BOLD) and 1 ) then
		s or = 1
	end if
	if( _this->tagFlags(WIKI_TAG_ITALIC) and 1 ) then
		s or = 2
	end if
	if( _this->tagFlags(WIKI_TAG_UNDERLINE) and 1 ) then
		s or = 4
	end if
	if( _this->tagFlags(WIKI_TAG_HEADER) and 1 ) then
		s or = 8
	end if
	if( _this->tagFlags(WIKI_TAG_STRIKE) and 1 ) then
		s or = 16
	end if
	if( _this->tagFlags(WIKI_TAG_STRIKE) and 1 ) then
		s or = 32
	end if

	if( s <> 0 ) then 
		return 1
	end if

	return 0

end function

'':::::
private function _emitText _ 
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval text as zstring ptr, _
		byval ignoreStyle as integer = FALSE _
	) as integer

	dim as integer n, c
	dim as zstring ptr p

	if( _this = NULL ) then
		return FALSE
	end if

	if( text = NULL ) then
		return FALSE
	end if

	if( len( *text ) = 0 ) then
		return FALSE
	end if

	_emitIndent( _this )

	p = text
	n = _this->maxwidth - _this->col
	c = len( *p )
	while(( c >= n ) and ( n > 0 ))

		while( n > 0 )
			if( p[n - 1] = 32 ) then
				exit while
			end if
			n -= 1
		wend

		if( n = 0 ) then
			n = _this->maxwidth - _this->col
		end if

		if( ignoreStyle = FALSE ) then
			_emitAttrib( _this, _GetStyleAttrib( _this ) )
		end if

		_this->res += left( *p, n )
		_this->res += chBreak
		_this->col = 0
		_this->row += 1
		_this->attrib = 0

		_emitIndent( _this )
		p += n
		c -= n

		while( *p = 32 )
			p += 1
			c -= 1
		wend

		n = _this->maxwidth - _this->col
	wend

	if( c > 0 ) then

		if( ignoreStyle = FALSE ) then
			_emitAttrib( _this, _GetStyleAttrib( _this ) )
		end if

		_this->res += *p
		_this->col += len(*p)
	end if

	return TRUE

end function


'':::::
private function _emitTextNoWrap _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval text as zstring ptr, _
		byval ignoreStyle as integer = FALSE _
	) as integer

	dim as integer n, c
	dim as zstring ptr p

	if( _this = NULL ) then
		return FALSE
	end if

	if( text = NULL ) then
		return FALSE
	end if

	if( len( *text ) = 0 ) then
		return FALSE
	end if

	_emitIndent( _this )

	if( ignoreStyle = FALSE ) then
		_emitAttrib( _this, _GetStyleAttrib( _this ) )
	end if

	_this->res += *text
	_this->col += len(*text)

	return TRUE

end function


'':::::
private function _emitTestLineLength( byval _this as CWakka2fbhelp ptr, byval c as integer ) as integer

	dim as integer n

	if( _this = NULL ) then
		return FALSE
	end if

	if( c <= 0 ) then
		return FALSE
	end if

	_emitIndent( _this )

	n = _this->maxwidth - _this->col

	if(( c > n ) and ( n > 0 )) then
		if( _this->col > _this->maxwidth \ 4 ) then
			_this->res += chBreak
			_this->col = 0
			_this->row += 1
			_emitIndent( _this )
			_emitAttrib( _this, _GetStyleAttrib( _this ) )
		end if
	end if

	return TRUE

end function


'':::::
private function _emitSpecial( byval _this as CWakka2fbhelp ptr, byval text as zstring ptr ) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	if( text = NULL ) then
		return FALSE
	end if

	if( len( *text ) = 0 ) then
		return FALSE
	end if

	select case *text
	case chr(27) + "-"
		if( _this->col <> 0 ) then
			_emitBreak( _this, FALSE )
		end if

		_emitAttrib( _this, _GetStyleAttrib( _this ) )
		_this->res += *text
	
	case chr(27) + chr(27)
		_this->res += chr(27)

		return _emitText( _this, chr(27) )

	case chIndent
		if( _this->col = 0 ) then
			_this->indentlevel += 1
		else
			_emitAttrib( _this, _GetStyleAttrib( _this ) )
			return _emitText( _this, chSpace )
		end if
	case chr(1), chr(2), chr(3), chr(4), chr(16), chr(23), chr(29)
		_this->res += *text
	case else
		_this->res += *text
	end select

	return TRUE

end function

'':::::
private function _emitList( byval _this as CWakka2fbhelp ptr, byval indentlevel as integer ) as integer

	dim as integer i

	if( _this = NULL ) then
		return FALSE
	end if

	for i = 1 to indentlevel
		_emitSpecial( _this, chIndent )
	next i

	_emitIndent( _this )

	_this->res += "*"
	_this->col += 2
	_this->indent2 = 2

	return TRUE

end function

'':::::
private function _emitCenterText( byval _this as CWakka2fbhelp ptr, _
	byval text as zstring ptr, byval bCentered as integer ) as integer

	return _emitText( _this, text )

end function

'':::::
private function _emitLink _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval url as zstring ptr, _
		byval text as zstring ptr, _
		byval bAnchor as integer _
	) as integer

	if ( url = NULL ) then
		return FALSE
	end if

	if( bAnchor ) then
		_emitSpecial( _this, chr(16) )              '' dle
		_emitSpecial( _this, chr(29) )              '' gs
		_emitSpecial( _this, url )					''   name of target
		_emitSpecial( _this, chr(23) )              '' etb
		return TRUE
	end if

	'if( len(*text) = 0 ) then
	'	_emitTestLineLength( _this, len( *url ) )
	'	return _emitTextNoWrap( _this, url )
	'end if

	_emitIndent( _this )

	if( lcase(left( *url, 5 )) = "keypg" ) then
		_emitTestLineLength( _this, len( FormatPageTitle(*text) ) )
	elseif( len(*text) = 0 ) then
		_emitTestLineLength( _this, len( *url ) )
	else
		_emitTestLineLength( _this, len( *text ) )
	end if

	_emitSpecial( _this, chr(16) )              '' dle
	_emitSpecial( _this, url )					''   url
	_emitSpecial( _this, chr(2) )               '' stx

	if( lcase(left( *url, 5 )) = "keypg" ) then
		_emitTextNoWrap( _this, FormatPageTitle(*text) )	''   text
	elseif( len(*text) = 0 ) then
		_emitTextNoWrap( _this, url )
	else
		_emitTextNoWrap( _this, *text )					''   text
	end if

	_emitSpecial( _this, chr(23) )              '' etb

	return TRUE

end function


'':::::
private function _emitAttrib _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval attrib as integer _
	) as integer

	if( ( attrib and &h7f ) <> _this->attrib ) then

		_this->attrib = ( attrib and &h7f )

		_emitSpecial( _this, chr(27) + chr(&h80 or ( attrib and &h7f )) )

	end if

	return TRUE

end function

private function _emitRaw _ 
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval text as zstring ptr, _
		byval ignoreStyle as integer = FALSE _
	) as integer

	select case lcase( * text )
	case "<!-- metacommand begin_html -->"
		_this->metamode = META_MODE_HTML

	case "<!-- metacommand end_html -->"
		_this->metamode = META_MODE_NONE

	case "<!-- metacommand begin_ascii -->"
		_this->metamode = META_MODE_ASCII

	case "<!-- metacommand insert_ascii_table -->"

		dim as integer p, i, j, c
		dim x as string

		_this->indentlevel2 = 1
		_emitBreak( _this, FALSE )

		for p = 0 to 1

			for j = 0 to 15

				x = ""
				for i = 0 to 7
					c = p * 128 + i * 16 + j

					if i > 0 then
						x += chr(179)
					end if

					x += right( "   " + str( c ), 3)
					x += " "
					x += right( "  " + ucase(hex( c )), 2)
					x += " "
					if( c = 0 ) then
					  x += " "
					elseif c < 32 then
						x += chr(27) + chr(c)
					else
						x += chr(c)
					end if

				next i

				_emitIndent( _this )
				_emitTextNoWrap( _this, x, TRUE )
				_emitBreak( _this, FALSE )

			next j

			_emitBreak( _this, FALSE )

		next p
		
		_this->indentlevel2 = 0

	case "<!-- metacommand end_ascii -->"
		_this->metamode = META_MODE_NONE

	case else

		select case _this->metamode
		case META_MODE_NONE, META_MODE_ASCII
			return _emitText( _this, text, ignoreStyle )
					
		end select

	end select

	return FALSE

end function


'' ---------------------------------------------------------------------


'':::::
private function _closeTags( byval _this as CWakka2fbhelp ptr ) as integer
	
	if( _this->tagFlags(WIKI_TAG_BOLD) and 1 ) then
		_this->tagFlags(WIKI_TAG_BOLD) -= 1
	end if

	if( _this->tagFlags(WIKI_TAG_ITALIC) and 1 ) then
		_this->tagFlags(WIKI_TAG_ITALIC) -= 1
	end if

	if( _this->tagFlags(WIKI_TAG_UNDERLINE) and 1 ) then
		_this->tagFlags(WIKI_TAG_UNDERLINE) -= 1
	end if

	if( _this->tagFlags(WIKI_TAG_MONOSPACE) and 1 ) then
		_this->tagFlags(WIKI_TAG_MONOSPACE) -= 1
	end if

	if( _this->tagFlags(WIKI_TAG_NOTES) and 1 ) then
		_this->tagFlags(WIKI_TAG_NOTES) -= 1
	end if

	if( _this->tagFlags(WIKI_TAG_STRIKE) and 1 ) then
		_this->tagFlags(WIKI_TAG_STRIKE) -= 1
	end if

	if( _this->tagFlags(WIKI_TAG_KEYS) and 1 ) then
		_this->tagFlags(WIKI_TAG_KEYS) -= 1
	end if

	if( _this->tagFlags(WIKI_TAG_CENTER) and 1 ) then
		_this->tagFlags(WIKI_TAG_CENTER) -= 1
	end if

	if( _this->tagFlags(WIKI_TAG_HEADER) and 1 ) then
		_this->tagFlags(WIKI_TAG_HEADER) -= 1
	end if

	while( _this->tagFlags(WIKI_TAG_LEVEL) > 0 )
		_this->tagFlags(WIKI_TAG_LEVEL) -= 1
	wend

	if( _this->tagFlags(WIKI_TAG_SECTION) <> 0 ) then
		_this->tagFlags(WIKI_TAG_SECTION) = 0
	end if
		
	return TRUE

end function


private function _emitPreformatted _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval text as zstring ptr _
	) as integer

	dim as any ptr token_i 
	dim as FbToken ptr token

	if( _this = NULL ) then
		return FALSE
	endif

	if( text = NULL ) then
		return FALSE
	end if

	if( len(*text) = 0 ) then
		return FALSE
	end if

	CFbCode_ParseLines( _this->fbcode, text )

	token = CFbCode_NewEnum( _this->fbcode, @token_i )
	while( token )

		if( token->id = FB_TOKEN_NULL ) then
			exit while
		end if

		if( token->id = FB_TOKEN_NEWLINE ) then
			_emitBreak( _this, TRUE )
		else
			_emitTextNoWrap( _this, token->text, TRUE )
		end if

		token = CFbCode_NextEnum( @token_i )
	wend

	_emitBreak( _this, FALSE )

	return TRUE
	
end function


'':::::
private function _emitCode _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval text as zstring ptr _
	) as integer

	dim as any ptr token_i 
	dim as FbToken ptr token
	dim as integer lastgrpno = 0, grpno = 0, bHaveCode = FALSE

	static AttribTb(0 to FB_TOKENS - 1) as fbcode_item_t => _
	{ _
		 ( FB_TOKEN_NULL     , &h8 , 0 ), _
		 ( FB_TOKEN_SPACE    , &h8 , 0 ), _
		 ( FB_TOKEN_NEWLINE  , &h8 , 0 ), _
		 ( FB_TOKEN_COMMENT  , &h9 , 1 ), _
		 ( FB_TOKEN_QUOTED   , &ha , 2 ), _
		 ( FB_TOKEN_NUMBER   , &hb , 3 ), _
		 ( FB_TOKEN_KEYWORD  , &hc , 4 ), _
		 ( FB_TOKEN_DEFINE   , &hd , 5 ), _
		 ( FB_TOKEN_NAME     , &he , 6 ), _
		 ( FB_TOKEN_OTHER    , &hf , 7 ) _
	}

	if( _this = NULL ) then
		return FALSE
	endif

	if( text = NULL ) then
		return FALSE
	end if

	if( len(*text) = 0 ) then
		return FALSE
	end if

	CFbCode_Parse( _this->fbcode, text )

	'' FIXME: Skip white space at head of code
	
	token = CFbCode_NewEnum( _this->fbcode, @token_i )
	while( token )

		if( token->id = FB_TOKEN_NULL ) then
			exit while
		end if

		grpno = AttribTb( token->id ).grpno
		if( lastgrpno <> grpno ) then
			if( lastgrpno <> 0 ) then
				'' closer - not needed
			end if
			if( grpno <> 0 ) then
				_emitAttrib( _this, AttribTb( token->id ).attrib )
			end if
		end if

		select case token->id
		case FB_TOKEN_NULL	
			exit while

		case FB_TOKEN_SPACE
			_emitTextNoWrap( _this, token->text, TRUE )

		case FB_TOKEN_NEWLINE
			if bHaveCode = FALSE then
				'' FIXME: need to reset if white space / empty lines before code
			else
				_emitBreak( _this, FALSE )
				grpno = 0
				lastgrpno = 0
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
			_emitTextNoWrap( _this, token->text, TRUE )
		end select

		lastgrpno = grpno
		token = CFbCode_NextEnum( @token_i )
	wend

	if( lastgrpno <> 0 ) then
		'' closer - not needed
	end if

	_emitBreak( _this, FALSE )

	return TRUE

end function

'':::::
private function _find_fbdocitem( byval itemTb as fbdoc_item_t ptr, byval itemname as zstring ptr ) as integer
	dim i as integer
	for i = 0 to FBDOC_ITEMS - 1
		if( lcase(*itemTb[i].item_name) = lcase(*itemname) ) then
			return i
		end if
	next i
	return -1
end function

'':::::
private sub _explode_link( byref strValue as string, byref strPage as string, byref strName as string )

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

private function _emitActionFbDoc _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval paramsTb as Wiki_ActionParam ptr _
	) as integer
	
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

	dim as string strItem, strValue, strName, strPage, ext
	dim as integer isblock, itemidx

	strItem = CWiki_GetActionParamValue(paramsTb, "item")
	strValue = CWiki_GetActionParamValue(paramsTb, "value")

	itemidx = _find_fbdocitem( @itemTb(0), strItem )

	if itemidx >= 0 then
		isblock = itemTb( itemidx ).isblock
	end if

	if( isblock ) then
		_closeTags( _this )
		_this->tagFlags(WIKI_TAG_SECTION) = 1
	end if

	select case lcase( strItem )
	case "title":
		if( _this->tagGenTb(WIKI_TOKEN_SECT_ITEM) ) then
			_emitAttrib( _this, 1 )
			return _emitText( _this, strValue, TRUE )
		end if
		return FALSE

	case "section":			
		_emitAttrib( _this, 1 )
		return _emitText( _this, strValue, TRUE )

	case "subsect":			
		_emitAttrib( _this, 1 )
		return _emitText( _this, strValue, TRUE )

	case "category":

		_explode_link strValue, strPage, strName

		_emitLink( _this, strPage, NULL, TRUE )
		return _emitText( _this, strName, TRUE )
		
	case "keyword":

		_explode_link strValue, strPage, strName

		return _emitLink( _this, strPage, strName, FALSE )
	
	case "back":
		if( _this->tagGenTb(WIKI_TOKEN_SECT_ITEM) ) then

			_explode_link strValue, strPage, strName

			_emitAttrib( _this, 1 )
			_emitText( _this, "{#fb_sect_back} ", TRUE )
			return _emitLink( _this, strPage, strName, FALSE )

		end if
		return FALSE

	case "close":
		if( _this->tagFlags(WIKI_TAG_SECTION) <> 0  ) then
			_this->tagFlags(WIKI_TAG_SECTION) = 0
		end if
		
		return FALSE

	case else			

		if itemidx >= 0 then
			strValue = *itemTb( itemidx ).sect_name
		end if
		_emitAttrib( _this, 1 )
		return _emitText( _this, strValue, TRUE )

	end select
	

end function

'':::::
private function _closeList( byval _this as CWakka2fbhelp ptr ) as integer

	''_emitBreak( _this, FALSE )
	_this->indentlevel = 0

	return TRUE

end function

 
'':::::
private function _index_cells _
	( _
		byval text as zstring ptr, _
		byval cellTb as zstring ptr ptr ptr, _
		byval cols as integer, _
		byref rows as integer _
	) as integer

	dim as integer i, n = 0

	rows = 0

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

	rows = (n + ( cols - 1)) \ cols

	return n

end function

'':::::
private function _emitActionTable _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval paramsTb as Wiki_ActionParam ptr _
	) as integer
	
	dim as string cellData, strCols, cell
	dim as zstring ptr ptr cellTb
	dim as integer n, cols, rows, row, col, i, j
	dim as zstring ptr cell_empty = @""
	dim as zstring ptr cell_space = @chSpace
	dim as string tmp

	const chtb_topleft = chr(218)
	const chtb_topmid = chr(194)
	const chtb_topright = chr(191)

	const chtb_horz = chr(196)
	const chtb_vert = chr(179)

	const chtb_botleft = chr(192)
	const chtb_botmid = chr(193)
	const chtb_botright = chr(217)

	_closeList( _this )
	
	cellData = CWiki_GetActionParamValue( paramsTb, "cells" )
	strCols =  CWiki_GetActionParamValue( paramsTb, "columns" )

	if( len( strCols ) > 0 ) then
		cols = val( strCols )
		if cols < 1 then
			cols = 1
		end if
	else
		cols = 1
	end if

	n = _index_cells( cellData, @cellTb, cols, rows )

	if( n = 0 or cols = 0 or rows = 0 ) then
		return FALSE
	end if

	dim cells( 0 to cols - 1, 0 to rows - 1) as zstring ptr
	dim sizes( 0 to cols - 1) as integer

	for col = 0 to cols - 1
		sizes( col ) = 0
		for row = 0 to rows - 1
			i = row * cols + col
			if( i < n ) then
				if( *cellTb[i] = "###" ) then
					cells( col, row ) = cell_space
				else
					cells( col, row ) = cellTb[i]
				end if
				if( len( *cells( col, row ) ) > sizes( col ) ) then
					sizes( col ) = len( *cells( col, row ) )
				end if
			else
				cells( col, row ) = cell_empty
			end if
		next row
	next col

	const bord_top = 1
	const bord_bottom = 2
	const bord_left = 4
	const bord_right = 8

	const bord = &hf

	if( bord and bord_top) then
		tmp = ""

		if( bord and bord_left) then
			tmp += chtb_topleft
		end if

		for i = 0 to cols - 1
			if( i > 0 ) then
				tmp += chtb_topmid
			end if

			tmp += string( sizes(i), chtb_horz )
		next i

		if( bord and bord_right) then
			tmp += chtb_topright
		end if

		_emitTextNoWrap( _this, tmp, TRUE )
		_emitBreak( _this, FALSE )

	end if

	tmp = ""
	for j = 0 to rows - 1

		tmp = ""

		if( bord and bord_left) then
			tmp += chtb_vert
		end if

		for i = 0 to cols - 1
			if( i > 0 ) then
				tmp += chtb_vert
			end if
			tmp += left( *cells(i, j) + space( sizes( i )), sizes( i ))
		next i

		if( bord and bord_right) then
			tmp += chtb_vert
		end if

		_emitTextNoWrap( _this, tmp, TRUE )
		_emitBreak( _this, FALSE )

	next j

	if( bord and bord_bottom) then

		tmp = ""

		if( bord and bord_left) then
			tmp += chtb_botleft
		end if

		for i = 0 to cols - 1
			if( i > 0 ) then
				tmp += chtb_botmid
			end if

			tmp += string( sizes(i), chtb_horz )
		next i

		if( bord and bord_right) then
			tmp += chtb_botright
		end if

		_emitTextNoWrap( _this, tmp, TRUE )
		_emitBreak( _this, FALSE )

	end if

	if( cellTb ) then
		Deallocate cellTb
	end if
		
	return TRUE

end function

'':::::
private function _emitActionAnchor _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval paramsTb as Wiki_ActionParam ptr _
	) as integer

	dim as string sName, sTarget, sLink

	_closeList( _this )

	sName = CWiki_GetActionParamValue( paramsTb, "name" )

	if instr( sName, "|" ) = 0 then
		return _emitLink( _this, sName, NULL, TRUE )
	end if

	_explode_link sName, sTarget, sLink

	return _emitLink( _this, "#" + sTarget, sLink, FALSE )

end function

'':::::
private function _emitAction _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval actionname as zstring ptr, _
		byval paramsTb as Wiki_ActionParam ptr _
	) as integer

	select case lcase(*actionname)
	case "fbdoc"	
		return _emitActionFbDoc( _this, paramsTb )
	case "table"
		_this->indentlevel2 = _this->indentlevel + 1
		_emitActionTable( _this, paramsTb )
		_this->indentlevel2 = 0
		return TRUE
	case "image"
		return FALSE
	case "anchor"
		return _emitActionAnchor( _this, paramsTb )
	end select

	return FALSE
end function

'':::::
private function _emitToken(byval _this as CWakka2fbhelp ptr, byval token as WikiToken ptr ) as integer

	dim as string x
	dim as integer dogen, i

	if( token->id = WIKI_TOKEN_NEWLINE ) then
		return _emitBreak( _this, FALSE )
	end if

	dogen = _this->tagGenTb(token->id)

	select case as const token->id
	case WIKI_TOKEN_NULL
		return _emitText( _this, "" )
	
	case WIKI_TOKEN_LT
		return _emitText( _this, "<" )
	
	case WIKI_TOKEN_GT
		return _emitText( _this, ">" )
	
	case WIKI_TOKEN_KBD
		_this->tagFlags(WIKI_TAG_KEYS) += 1
		return _emitText( _this, "" )
	
	case WIKI_TOKEN_BOLD, WIKI_TOKEN_BOLD_SECTION
		_this->tagFlags(WIKI_TAG_BOLD) += 1
		return _emitText( _this, "" )
	
	case WIKI_TOKEN_ITALIC
		_this->tagFlags(WIKI_TAG_ITALIC) += 1
		return _emitText( _this, "" )
	
	case WIKI_TOKEN_UNDERLINE
		_this->tagFlags(WIKI_TAG_UNDERLINE) += 1
		return _emitText( _this, "" )

	case WIKI_TOKEN_MONOSPACE:
		_this->tagFlags(WIKI_TAG_MONOSPACE) += 1
		return _emitText( _this, "" )

	case WIKI_TOKEN_NOTES
		_this->tagFlags(WIKI_TAG_NOTES) += 1
		return _emitText( _this, "" )

	case WIKI_TOKEN_STRIKE:
		_this->tagFlags(WIKI_TAG_STRIKE) += 1
		return _emitText( _this, "" )

	case WIKI_TOKEN_CENTER:
		_this->tagFlags(WIKI_TAG_CENTER) += 1
		return _emitCenterText( _this, "", WIKI_TAG_CENTER and 1 )

	case WIKI_TOKEN_LINK:
		return _emitLink( _this, token->link.url, token->text, FALSE )

	case WIKI_TOKEN_LIST:
		return _emitList( _this, token->indent.level )

	case WIKI_TOKEN_TEXT:
		return _emitText( _this, token->text )

	case WIKI_TOKEN_RAW:
		return _emitRaw( _this, token->text )

	case WIKI_TOKEN_ACTION:
		return _emitAction( _this, token->action.name, token->action.paramhead )

	end select
	
	_closeList( _this )
	
	select case ( token->id)
	case WIKI_TOKEN_FORCENL:
		return _emitBreak( _this, TRUE )
		
	case WIKI_TOKEN_HORZLINE:
		if( dogen ) then
			return _emitSpecial( _this, chr(27) + "-")
		else
			return _emitSpecial( _this, "" )
		end if

	case WIKI_TOKEN_BOXLEFT:
		return _emitText( _this, "" )

	case WIKI_TOKEN_BOXRIGHT:
		return _emitText( _this, "" )
		
	case WIKI_TOKEN_CLEAR:
		return _emitText( _this, "" )

	case WIKI_TOKEN_HEADER:
		_this->tagFlags(WIKI_TAG_HEADER) += 1
		return _emitText( _this, "" )
	
	case WIKI_TOKEN_PRE:
		_this->indentlevel2 = _this->indentlevel + 1
		_emitPreformatted( _this, token->text )
		_this->indentlevel2 = 0
		return TRUE
	
	case WIKI_TOKEN_CODE:
		_this->indentlevel2 = _this->indentlevel + 1
		_emitCode( _this, token->text )
		_this->indentlevel2 = 0
		return TRUE
	
	case WIKI_TOKEN_INDENT:
		for i = 1 to (token->indent.level - _this->indentbase)
			_emitSpecial( _this, chIndent )
		next i
		return TRUE

	end select

end function

'':::::
function CWakka2fbhelp_gen _
	( _
		byval _this as CWakka2fbhelp ptr, _
		byval page as zstring ptr, _
		byval wiki as CWiki ptr _
	) as string

	dim as integer i
	dim as TLIST ptr tokenlist
	dim as WikiToken ptr token

	ZSet @_this->page, page

	for i = 0 to WIKI_TAGS - 1
		_this->tagFlags( i ) = 0
	next i
	_this->tagDepth = 0
	
	_this->maxwidth = 76
	_this->indentlevel = 0
	_this->indentwidth = 3
	_this->linewidth = 0
	_this->col = 0
	_this->row = 0
	_this->length = 0
	_this->res = ""
	_this->nlcount = 0
	_this->indent2 = 0
	
	tokenlist = CWiki_GetTokenList( wiki )
	token = cast( WikiToken ptr, listGetHead( tokenlist ) )
	while( token <> NULL )
		_emitToken _this, token
		token = cast( WikiToken ptr, listGetNext( token ) )
	wend

	_closeTags( _this )

	return _this->res


end function
