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


'' CWakka2fbhelp - convert wakka format markup to fbhelp console help viewer
''
'' chng: jul/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "CWiki.bi"
#include once "CWakka2fbhelp.bi"
#include once "CFbCode.bi"
#include once "fbdoc_keywords.bi"
#include once "fbdoc_string.bi"

const chBreak = chr(10)
const chIndent = chr(9)
const chSpace = " "

namespace fb.fbdoc

	#undef iif

	private function iif _
		( _
			byval c as integer, _
			byref a as string, _
			byref b as string _
		) as string

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
		FBDOC_ITEM_VER
		FBDOC_ITEM_LANG
		FBDOC_ITEM_TARGET
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

	type CWakka2fbhelpCtx_

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

		as integer isflat

	end type

	'':::::
	constructor CWakka2fbhelp _
		( _
		)

		dim i as integer = any

		ctx = new CWakka2fbhelpCtx
		ctx->indentbase = 0
		ctx->tagDepth = 0
		for i = 0 to WIKI_TAGS - 1
			ctx->tagflags(i) = 0
		next
		for i = 0 to WIKI_TOKENS - 1
			ctx->tagGenTb(i) = NULL
		next
		ctx->page = NULL
		ZSet @ctx->page, @""
		ctx->fbcode = new CFbCode
		ctx->maxwidth = 76
		ctx->indentlevel = 0
		ctx->indentlevel2 = 0
		ctx->indentwidth = 3
		ctx->linewidth = 0
		ctx->indent2 = 0
		ctx->col = 0
		ctx->row = 0
		ctx->length = 0
		ctx->res = ""
		ctx->nlcount = 0
		ctx->attrib = 0
		ctx->metamode = 0
		ctx->isflat = FALSE

	end constructor

	'':::::
	destructor CWakka2fbhelp _
		( _
		)
		
		dim as integer i

		if( ctx = NULL ) then
			exit destructor
		end if

		ZFree @ctx->page

		delete ctx->fbcode
		ctx->res = ""
		delete ctx

	end destructor

	'':::::
	sub CWakka2fbhelp.setIndentBase _
		( _
			byval value as integer _
		)

		ctx->indentbase = value

	end sub

	'':::::
	sub CWakka2fbhelp.setIsflat _
		( _
			byval value as integer _
		)

		ctx->isflat = value

	end sub

	'':::::
	sub CWakka2fbhelp.setTagDoGen _
		( _
			byval token_id as integer, _
			byval value as integer _
		)

		ctx->tagGenTb( token_id ) = value

	end sub

	'' ---------------------------------------------------------------------

	declare function _emitAttrib _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval attrib as integer _
		) as integer


	'':::::
	private function _emitIndent _
		( _
			byval ctx as CWakka2fbhelpCtx ptr _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		if( ctx->col = 0 ) then
			if( (ctx->indentlevel + ctx->indentlevel2) > 0 ) then
				ctx->linewidth = 0
				ctx->col = ctx->indentwidth * (ctx->indentlevel + ctx->indentlevel2 ) + ctx->indent2
				ctx->linewidth = ctx->maxwidth - ctx->col

				'' ctx->res += string( ctx->col, chSpace )
				if( ctx->isflat ) then
					ctx->res += string( ctx->indentwidth * (ctx->indentlevel + ctx->indentlevel2), chSpace)
				else
					ctx->res += string( (ctx->indentlevel + ctx->indentlevel2), chIndent )
				end if
				ctx->res += string( ctx->indent2, chSpace )
			end if
		end if

		return TRUE

	end function

	'':::::
	private function _emitBreak _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval bForced as integer _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		if( ctx->col = 0 ) then
			ctx->nlcount += 1
			if( (ctx->nlcount < 2) or bForced ) then
				ctx->res += chBreak
				ctx->col = 0
				ctx->row += 1
				ctx->indent2 = 0
				ctx->indentlevel = 0
				ctx->attrib = 0
			end if
		else
			ctx->nlcount = 0
			ctx->res += chBreak
			ctx->col = 0
			ctx->row += 1
			ctx->indent2 = 0
			ctx->indentlevel = 0
			ctx->attrib = 0
		end if

		return TRUE

	end function

	'':::::
	private function _GetStyleAttrib _
		( _
			byval ctx as CWakka2fbhelpCtx ptr _
		) as integer

		dim as integer s = 0

		if( ctx->tagFlags(WIKI_TAG_BOLD) and 1 ) then
			s or = 1
		end if
		if( ctx->tagFlags(WIKI_TAG_ITALIC) and 1 ) then
			s or = 2
		end if
		if( ctx->tagFlags(WIKI_TAG_UNDERLINE) and 1 ) then
			s or = 4
		end if
		if( ctx->tagFlags(WIKI_TAG_HEADER) and 1 ) then
			s or = 8
		end if
		if( ctx->tagFlags(WIKI_TAG_STRIKE) and 1 ) then
			s or = 16
		end if

		if( s <> 0 ) then 
			'' TODO: maybe add some other colors?
			return 1
		end if

		return 0

	end function

	'':::::
	private function _emitText _ 
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval text as zstring ptr, _
			byval ignoreStyle as integer = FALSE _
		) as integer

		dim as integer n, c
		dim as zstring ptr p

		if( ctx = NULL ) then
			return FALSE
		end if

		if( text = NULL ) then
			return FALSE
		end if

		if( len( *text ) = 0 ) then
			return FALSE
		end if

		_emitIndent( ctx )

		p = text
		n = ctx->maxwidth - ctx->col
		c = len( *p )
		while(( c >= n ) and ( n >= 0 ))

			while( n > 0 )
				if( p[n - 1] = 32 ) then
					exit while
				end if
				n -= 1
			wend

			if( n = 0 ) then
				if( len( *p ) >= ctx->linewidth ) then
					n = ctx->maxwidth - ctx->col
				end if
			end if

			if( ignoreStyle = FALSE ) then
				_emitAttrib( ctx, _GetStyleAttrib( ctx ) )
			end if

			ctx->res += left( *p, n )
			ctx->res += chBreak
			ctx->col = 0
			ctx->row += 1
			ctx->attrib = 0

			_emitIndent( ctx )
			p += n
			c -= n

			while( *p = 32 )
				p += 1
				c -= 1
			wend

			n = ctx->maxwidth - ctx->col
		wend

		if( c > 0 ) then

			if( ignoreStyle = FALSE ) then
				_emitAttrib( ctx, _GetStyleAttrib( ctx ) )
			end if

			ctx->res += *p
			ctx->col += len(*p)
		end if

		return TRUE

	end function


	'':::::
	private function _emitTextNoWrap _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval text as zstring ptr, _
			byval ignoreStyle as integer = FALSE _
		) as integer

		dim as integer n, c
		dim as zstring ptr p

		if( ctx = NULL ) then
			return FALSE
		end if

		if( text = NULL ) then
			return FALSE
		end if

		if( len( *text ) = 0 ) then
			return FALSE
		end if

		_emitIndent( ctx )

		if( ignoreStyle = FALSE ) then
			_emitAttrib( ctx, _GetStyleAttrib( ctx ) )
		end if

		ctx->res += *text
		ctx->col += len(*text)

		return TRUE

	end function


	'':::::
	private function _emitTestLineLength _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval c as integer _
		) as integer

		dim as integer n

		if( ctx = NULL ) then
			return FALSE
		end if

		if( c <= 0 ) then
			return FALSE
		end if

		_emitIndent( ctx )

		n = ctx->maxwidth - ctx->col

		if(( c > n ) and ( n > 0 )) then
			if( ctx->col > ctx->maxwidth \ 4 ) then
				ctx->res += chBreak
				ctx->col = 0
				ctx->row += 1
				_emitIndent( ctx )
				_emitAttrib( ctx, _GetStyleAttrib( ctx ) )
			end if
		end if

		return TRUE

	end function


	'':::::
	private function _emitSpecial _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval text as zstring ptr _
		) as integer

		if( ctx = NULL ) then
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
			if( ctx->col <> 0 ) then
				_emitBreak( ctx, FALSE )
			end if

			_emitAttrib( ctx, _GetStyleAttrib( ctx ) )
			ctx->res += *text
		
		case chr(27) + chr(27)
			ctx->res += chr(27)

			return _emitText( ctx, chr(27) )

		case chIndent
			if( ctx->col = 0 ) then
				ctx->indentlevel += 1
			else
				_emitAttrib( ctx, _GetStyleAttrib( ctx ) )
				return _emitText( ctx, chSpace )
			end if
		case chr(1), chr(2), chr(3), chr(4), chr(16), chr(23), chr(29)
			ctx->res += *text
		case else
			ctx->res += *text
		end select

		return TRUE

	end function

	'':::::
	private function _emitList _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval indentlevel as integer _
		) as integer

		dim as integer i

		if( ctx = NULL ) then
			return FALSE
		end if

		for i = 1 to indentlevel
			_emitSpecial( ctx, chIndent )
		next

		_emitIndent( ctx )

		ctx->res += "*"
		ctx->col += 2
		ctx->indent2 = 2

		return TRUE

	end function

	'':::::
	private function _emitCenterText _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval text as zstring ptr, _
			byval bCentered as integer _
		) as integer

		return _emitText( ctx, text )

	end function

	'':::::
	private function _emitLink _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval url as zstring ptr, _
			byval text as zstring ptr, _
			byval bAnchor as integer _
		) as integer

		if ( url = NULL ) then
			return FALSE
		end if

		if( bAnchor ) then
			if( ctx->isflat = false ) then
				_emitSpecial( ctx, chr(16) )              '' dle
				_emitSpecial( ctx, chr(29) )              '' gs
				_emitSpecial( ctx, url )					''   name of target
				_emitSpecial( ctx, chr(23) )              '' etb
			end if
			return TRUE
		end if

		'if( len(*text) = 0 ) then
		'	_emitTestLineLength( ctx, len( *url ) )
		'	return _emitTextNoWrap( ctx, url )
		'end if

		_emitIndent( ctx )

		if( lcase(left( *url, 5 )) = "keypg" ) then
			_emitTestLineLength( ctx, len( FormatPageTitle(*text) ) )
		elseif( len(*text) = 0 ) then
			_emitTestLineLength( ctx, len( *url ) )
		else
			_emitTestLineLength( ctx, len( *text ) )
		end if

		if( ctx->isflat = false ) then
			_emitSpecial( ctx, chr(16) )              '' dle
			_emitSpecial( ctx, url )					''   url
			_emitSpecial( ctx, chr(2) )               '' stx
		end if
		
		if( lcase(left( *url, 5 )) = "keypg" ) then
			_emitTextNoWrap( ctx, FormatPageTitle(*text) )	''   text
		elseif( len(*text) = 0 ) then
			_emitTextNoWrap( ctx, url )
		else
			_emitTextNoWrap( ctx, *text )					''   text
		end if

		if( ctx->isflat = false ) then
			_emitSpecial( ctx, chr(23) )              '' etb
		end if

		return TRUE

	end function


	'':::::
	private function _emitAttrib _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval attrib as integer _
		) as integer

		if( ctx->isflat ) then
			return TRUE
		end if

		if( ( attrib and &h7f ) <> ctx->attrib ) then

			ctx->attrib = ( attrib and &h7f )

			_emitSpecial( ctx, chr(27) + chr(&h80 or ( attrib and &h7f )) )

		end if

		return TRUE

	end function

	private function _emitRaw _ 
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval text as zstring ptr, _
			byval ignoreStyle as integer = FALSE _
		) as integer

		select case lcase( * text )
		case "<!-- metacommand begin_html -->"
			ctx->metamode = META_MODE_HTML

		case "<!-- metacommand end_html -->"
			ctx->metamode = META_MODE_NONE

		case "<!-- metacommand begin_ascii -->"
			ctx->metamode = META_MODE_ASCII

		case "<!-- metacommand insert_ascii_table -->"

			dim as integer p, i, j, c
			dim x as string

			ctx->indentlevel2 = 1
			_emitBreak( ctx, FALSE )

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
							if( ctx->isflat ) then
								x += " "
							else
								x += chr(27) + chr(c)
							end if
						else
							x += chr(c)
						end if

					next

					_emitIndent( ctx )
					_emitTextNoWrap( ctx, x, TRUE )
					_emitBreak( ctx, FALSE )

				next

				_emitBreak( ctx, FALSE )

			next
			
			ctx->indentlevel2 = 0

		case "<!-- metacommand end_ascii -->"
			ctx->metamode = META_MODE_NONE

		case else

			select case ctx->metamode
			case META_MODE_NONE, META_MODE_ASCII
				return _emitText( ctx, text, ignoreStyle )
						
			end select

		end select

		return FALSE

	end function


	'' ---------------------------------------------------------------------


	'':::::
	private function _closeTags _
		( _
			byval ctx as CWakka2fbhelpCtx ptr _
		) as integer
		
		if( ctx->tagFlags(WIKI_TAG_BOLD) and 1 ) then
			ctx->tagFlags(WIKI_TAG_BOLD) -= 1
		end if

		if( ctx->tagFlags(WIKI_TAG_ITALIC) and 1 ) then
			ctx->tagFlags(WIKI_TAG_ITALIC) -= 1
		end if

		if( ctx->tagFlags(WIKI_TAG_UNDERLINE) and 1 ) then
			ctx->tagFlags(WIKI_TAG_UNDERLINE) -= 1
		end if

		if( ctx->tagFlags(WIKI_TAG_MONOSPACE) and 1 ) then
			ctx->tagFlags(WIKI_TAG_MONOSPACE) -= 1
		end if

		if( ctx->tagFlags(WIKI_TAG_NOTES) and 1 ) then
			ctx->tagFlags(WIKI_TAG_NOTES) -= 1
		end if

		if( ctx->tagFlags(WIKI_TAG_STRIKE) and 1 ) then
			ctx->tagFlags(WIKI_TAG_STRIKE) -= 1
		end if

		if( ctx->tagFlags(WIKI_TAG_KEYS) and 1 ) then
			ctx->tagFlags(WIKI_TAG_KEYS) -= 1
		end if

		if( ctx->tagFlags(WIKI_TAG_CENTER) and 1 ) then
			ctx->tagFlags(WIKI_TAG_CENTER) -= 1
		end if

		if( ctx->tagFlags(WIKI_TAG_HEADER) and 1 ) then
			ctx->tagFlags(WIKI_TAG_HEADER) -= 1
		end if

		while( ctx->tagFlags(WIKI_TAG_LEVEL) > 0 )
			ctx->tagFlags(WIKI_TAG_LEVEL) -= 1
		wend

		if( ctx->tagFlags(WIKI_TAG_SECTION) <> 0 ) then
			ctx->tagFlags(WIKI_TAG_SECTION) = 0
		end if
			
		return TRUE

	end function


	private function _emitPreformatted _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval text as zstring ptr _
		) as integer

		dim as FbToken ptr token
		dim as any ptr token_i

		if( ctx = NULL ) then
			return FALSE
		endif

		if( text = NULL ) then
			return FALSE
		end if

		if( len(*text) = 0 ) then
			return FALSE
		end if

		ctx->fbcode->ParseLines( text )

		token = ctx->fbcode->NewEnum( @token_i )
		while( token )

			if( token->id = FB_TOKEN_NULL ) then
				exit while
			end if

			if( token->id = FB_TOKEN_NEWLINE ) then
				_emitBreak( ctx, TRUE )
			else
				_emitTextNoWrap( ctx, token->text, TRUE )
			end if

			token = ctx->fbcode->NextEnum( @token_i )
		wend

		_emitBreak( ctx, FALSE )

		return TRUE
		
	end function


	'':::::
	private function _emitCode _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval text as zstring ptr _
		) as integer

		dim as FbToken ptr token
		dim as any ptr token_i
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

		if( ctx = NULL ) then
			return FALSE
		endif

		if( text = NULL ) then
			return FALSE
		end if

		if( len(*text) = 0 ) then
			return FALSE
		end if

		ctx->fbcode->Parse( text )

		'' FIXME: Skip white space at head of code
		
		token = ctx->fbcode->NewEnum( @token_i )
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
					_emitAttrib( ctx, AttribTb( token->id ).attrib )
				end if
			end if

			select case token->id
			case FB_TOKEN_NULL	
				exit while

			case FB_TOKEN_SPACE
				token->text = ReplaceSubStr( token->text, chr(9), space(3) )
				_emitTextNoWrap( ctx, token->text, TRUE )

			case FB_TOKEN_NEWLINE
				if bHaveCode = FALSE then
					'' FIXME: need to reset if white space / empty lines before code
				else
					_emitBreak( ctx, FALSE )
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
				_emitTextNoWrap( ctx, token->text, TRUE )
			end select

			lastgrpno = grpno
			token = ctx->fbcode->NextEnum( @token_i )
		wend

		if( lastgrpno <> 0 ) then
			'' closer - not needed
		end if

		_emitBreak( ctx, FALSE )

		return TRUE

	end function

	'':::::
	private function _find_fbdocitem( byval itemTb as fbdoc_item_t ptr, byval itemname as zstring ptr ) as integer
		dim i as integer
		for i = 0 to FBDOC_ITEMS - 1
			if( lcase(*itemTb[i].item_name) = lcase(*itemname) ) then
				return i
			end if
		next
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
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
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
			( @"ver"      , true , @"{#fb_sect_ver}"    ), _
			( @"lang"     , true , @"{#fb_sect_lang}"   ), _
			( @"target"   , true , @"{#fb_sect_target}" ), _
			( @"diff"     , true , @"{#fb_sect_diff}"   ), _
			( @"see"      , true , @"{#fb_sect_see}"    ), _
			( @"back"     , false, @"{#fb_sect_back}"   ), _
			( @"close"    , false, @"{#fb_sect_close}"  ) _
		}
		'' "filename" and "tag" are also valid, but have no output, 
		'' so they aren't in the table above

		dim as string strItem, strValue, strVisible, strName, strPage, ext
		dim as integer isblock, itemidx, isVisible

		strItem = paramsTb->GetParam( "item" )
		strValue = paramsTb->GetParam( "value" )

		itemidx = _find_fbdocitem( @itemTb(0), strItem )

		if itemidx >= 0 then
			isblock = itemTb( itemidx ).isblock
		end if

		if( isblock ) then
			_closeTags( ctx )
			ctx->tagFlags(WIKI_TAG_SECTION) = 1
		end if

		select case lcase( strItem )
		case "title":
			strVisible = paramsTb->GetParam( "visible", "1" )
			isVisible = cbool( strVisible )

			if( isVisible ) then
				if( ctx->tagGenTb(WIKI_TOKEN_SECT_ITEM) ) then
					_emitAttrib( ctx, 1 )
					return _emitText( ctx, strValue, TRUE )
				end if
			end if

			return FALSE

		case "section":			
			_emitAttrib( ctx, 1 )
			return _emitText( ctx, strValue, TRUE )

		case "subsect":			
			_emitAttrib( ctx, 1 )
			return _emitText( ctx, strValue, TRUE )

		case "category":

			_explode_link strValue, strPage, strName

			_emitLink( ctx, strPage, NULL, TRUE )
			return _emitText( ctx, strName, TRUE )
			
		case "keyword":

			_explode_link strValue, strPage, strName

			return _emitLink( ctx, strPage, strName, FALSE )
		
		case "back":
			if( ctx->tagGenTb(WIKI_TOKEN_SECT_ITEM) ) then

				_explode_link strValue, strPage, strName

				_emitAttrib( ctx, 1 )
				_emitText( ctx, "{#fb_sect_back} ", TRUE )
				return _emitLink( ctx, strPage, strName, FALSE )

			end if
			return FALSE

		case "close":
			if( ctx->tagFlags(WIKI_TAG_SECTION) <> 0  ) then
				ctx->tagFlags(WIKI_TAG_SECTION) = 0
			end if
			
			return FALSE

		case "filename":
			return FALSE
			
		case "close"
			return FALSE

		case else			

			if itemidx >= 0 then
				strValue = *itemTb( itemidx ).sect_name
			end if
			_emitAttrib( ctx, 1 )
			return _emitText( ctx, strValue, TRUE )

		end select
		

	end function

	'':::::
	private function _closeList _
		( _
			byval ctx as CWakka2fbhelpCtx ptr _
		) as integer

		''_emitBreak( ctx, FALSE )
		ctx->indentlevel = 0

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
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as integer
		
		dim as string cellData, strCols, cell
		dim as zstring ptr ptr cellTb
		dim as integer n, cols, rows, row, col, i, j
		dim as zstring ptr cell_empty = @""
		dim as zstring ptr cell_space = @chSpace
		dim as string tmp

		dim as string chtb_topleft, chtb_topmid, chtb_topright
		dim as string chtb_horz, chtb_vert
		dim as string chtb_botleft, chtb_botmid, chtb_botright


		if( ctx->isflat ) then

			chtb_topleft = "+"
			chtb_topmid = "+"
			chtb_topright = "+"

			chtb_horz = "-"
			chtb_vert = "|"

			chtb_botleft = "+"
			chtb_botmid = "+"
			chtb_botright = "+"

		else

			chtb_topleft = chr(218)
			chtb_topmid = chr(194)
			chtb_topright = chr(191)

			chtb_horz = chr(196)
			chtb_vert = chr(179)

			chtb_botleft = chr(192)
			chtb_botmid = chr(193)
			chtb_botright = chr(217)

		end if

		_closeList( ctx )
		
		cellData = UnescapeHtml( paramsTb->GetParam( "cells" ) )
		strCols =  paramsTb->GetParam( "columns" )

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
			next
		next

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
			next

			if( bord and bord_right) then
				tmp += chtb_topright
			end if

			_emitTextNoWrap( ctx, tmp, TRUE )
			_emitBreak( ctx, FALSE )

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
			next

			if( bord and bord_right) then
				tmp += chtb_vert
			end if

			_emitTextNoWrap( ctx, tmp, TRUE )
			_emitBreak( ctx, FALSE )

		next

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
			next

			if( bord and bord_right) then
				tmp += chtb_botright
			end if

			_emitTextNoWrap( ctx, tmp, TRUE )
			_emitBreak( ctx, FALSE )

		end if

		if( cellTb ) then
			Deallocate cellTb
		end if
			
		return TRUE

	end function

	'':::::
	private function _emitActionAnchor _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as integer

		dim as string sName, sTarget, sLink

		_closeList( ctx )

		sName = paramsTb->GetParam( "name" )

		if instr( sName, "|" ) = 0 then
			return _emitLink( ctx, sName, NULL, TRUE )
		end if

		_explode_link sName, sTarget, sLink

		return _emitLink( ctx, "#" + sTarget, sLink, FALSE )

	end function

	'':::::
	private function _emitActionColor _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as integer

		dim as string sText

		sText = paramsTb->GetParam( "text" )

		return _emitText( ctx, sText )

	end function

	'':::::
	private function _emitAction _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval actionname as zstring ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as integer

		select case lcase(*actionname)
		case "fbdoc"	
			return _emitActionFbDoc( ctx, paramsTb )
		case "table"
			ctx->indentlevel2 = ctx->indentlevel + 1
			_emitActionTable( ctx, paramsTb )
			ctx->indentlevel2 = 0
			return TRUE
		case "image"
			return FALSE
		case "anchor"
			return _emitActionAnchor( ctx, paramsTb )
		case "color", "colour"
			return _emitActionColor( ctx, paramsTb )
		end select

		return FALSE
	end function

	'':::::
	private function _emitToken _
		( _
			byval ctx as CWakka2fbhelpCtx ptr, _
			byval token as WikiToken ptr _
		) as integer

		dim as string x
		dim as integer dogen, i

		if( token->id = WIKI_TOKEN_NEWLINE ) then
			return _emitBreak( ctx, FALSE )
		end if

		dogen = ctx->tagGenTb(token->id)

		select case as const token->id
		case WIKI_TOKEN_NULL
			return _emitText( ctx, "" )
		
		case WIKI_TOKEN_LT
			return _emitText( ctx, "<" )
		
		case WIKI_TOKEN_GT
			return _emitText( ctx, ">" )
		
		case WIKI_TOKEN_KBD
			ctx->tagFlags(WIKI_TAG_KEYS) += 1
			return _emitText( ctx, "" )
		
		case WIKI_TOKEN_BOLD, WIKI_TOKEN_BOLD_SECTION
			ctx->tagFlags(WIKI_TAG_BOLD) += 1
			return _emitText( ctx, "" )
		
		case WIKI_TOKEN_ITALIC
			ctx->tagFlags(WIKI_TAG_ITALIC) += 1
			return _emitText( ctx, "" )
		
		case WIKI_TOKEN_UNDERLINE
			ctx->tagFlags(WIKI_TAG_UNDERLINE) += 1
			return _emitText( ctx, "" )

		case WIKI_TOKEN_MONOSPACE:
			ctx->tagFlags(WIKI_TAG_MONOSPACE) += 1
			return _emitText( ctx, "" )

		case WIKI_TOKEN_NOTES
			ctx->tagFlags(WIKI_TAG_NOTES) += 1
			return _emitText( ctx, "" )

		case WIKI_TOKEN_STRIKE:
			ctx->tagFlags(WIKI_TAG_STRIKE) += 1
			return _emitText( ctx, "" )

		case WIKI_TOKEN_CENTER:
			ctx->tagFlags(WIKI_TAG_CENTER) += 1
			return _emitCenterText( ctx, "", WIKI_TAG_CENTER and 1 )

		case WIKI_TOKEN_LINK:
			return _emitLink( ctx, token->link->url, token->text, FALSE )

		case WIKI_TOKEN_LIST:
			return _emitList( ctx, token->indent->level )

		case WIKI_TOKEN_TEXT:
			if( (ctx->tagFlags(WIKI_TAG_BOLD) and 1) _
				and (ctx->tagFlags(WIKI_TAG_MONOSPACE) and 1)) then
				dim k as string
				k = fbdoc_FindKeyword( token->text )
				if( len(k) > 0 ) then
					return _emitText( ctx, k )
				end if
			end if
			return _emitText( ctx, token->text )

		case WIKI_TOKEN_RAW:
			return _emitRaw( ctx, token->text )

		case WIKI_TOKEN_ACTION:
			return _emitAction( ctx, token->action->name, token->action )

		end select
		
		_closeList( ctx )
		
		select case ( token->id)
		case WIKI_TOKEN_FORCENL:
			return _emitBreak( ctx, TRUE )
			
		case WIKI_TOKEN_HORZLINE:
			if( dogen ) then
				return _emitSpecial( ctx, chr(27) + "-")
			else
				return _emitSpecial( ctx, "" )
			end if

		case WIKI_TOKEN_BOXLEFT:
			return _emitText( ctx, "" )

		case WIKI_TOKEN_BOXRIGHT:
			return _emitText( ctx, "" )
			
		case WIKI_TOKEN_CLEAR:
			return _emitText( ctx, "" )

		case WIKI_TOKEN_HEADER:
			ctx->tagFlags(WIKI_TAG_HEADER) += 1
			return _emitText( ctx, "" )
		
		case WIKI_TOKEN_PRE:
			ctx->indentlevel2 = ctx->indentlevel + 1
			_emitPreformatted( ctx, token->text )
			ctx->indentlevel2 = 0
			return TRUE
		
		case WIKI_TOKEN_CODE:
			ctx->indentlevel2 = ctx->indentlevel + 1
			select case token->code->lang
			case "freebasic", "qbasic"
				_emitCode( ctx, token->text )
			case else
				_emitPreformatted( ctx, token->text )
			end select
			ctx->indentlevel2 = 0
			return TRUE
		
		case WIKI_TOKEN_INDENT:
			for i = 1 to (token->indent->level - ctx->indentbase)
				_emitSpecial( ctx, chIndent )
			next
			return TRUE

		end select

	end function

	'':::::
	function CWakka2fbhelp.gen _
		( _
			byval page as zstring ptr, _
			byval wiki as CWiki ptr _
		) as string

		dim as integer i
		dim as Clist ptr tokenlist
		dim as WikiToken ptr token

		ZSet @ctx->page, page

		for i = 0 to WIKI_TAGS - 1
			ctx->tagFlags( i ) = 0
		next
		ctx->tagDepth = 0
		
		ctx->maxwidth = 76
		ctx->indentlevel = 0
		ctx->indentwidth = 3
		ctx->linewidth = 0
		ctx->col = 0
		ctx->row = 0
		ctx->length = 0
		ctx->res = ""
		ctx->nlcount = 0
		ctx->indent2 = 0
		
		tokenlist = wiki->GetTokenList()
		token = tokenlist->GetHead()
		while( token <> NULL )
			_emitToken ctx, token
			token = tokenlist->GetNext( token )
		wend

		_closeTags( ctx )

		return ctx->res


	end function

end namespace
