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


'' CWakka2Html - convert wakka format markup to html markup
''
'' chng: may/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "CWiki.bi"
#include once "CWakka2Html.bi"
#include once "CRegex.bi"

#include once "CFbCode.bi"
#include once "fbdoc_keywords.bi"

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

	type CWakka2HtmlCtx_

		as zstring ptr urlbase
		as integer indentbase
		as integer tagflags(0 to WIKI_TAGS - 1)
		as zstring ptr cssClassTb(0 to WIKI_TOKENS - 1)
		as integer tagGenTb(0 to WIKI_TOKENS - 1)
		as zstring ptr page
		as CRegex ptr trimre
		as CFbCode ptr fbcode
		as integer nlcnt
		as integer skipnl
		as integer newindent
		as integer indent
		as integer newlevel
		as integer level
		as zstring ptr outputdir

	end type

	private function _AllocRe _
 		( _
			byval ctx as CWakka2HtmlCtx ptr _
		) as integer

		function = FALSE
		
		ctx->trimre = new CRegex( "^\s*(\<br \/\>)+|(\<br \/\>)+\s*$" )
		if( ctx->trimre = NULL ) then
			exit function
		end if

		function = TRUE

	end function

	private sub _FreeRe _
		( _
			byval ctx as CWakka2HtmlCtx ptr _
		)

		if( ctx->trimre <> NULL ) then
			delete ctx->trimre
			ctx->trimre = NULL
		end if

	end sub

	'':::::
	constructor CWakka2Html _
		( _
		)

		dim i as integer = any

		ctx = new CWakka2HtmlCtx

		ctx->urlbase = NULL
		ctx->outputdir = NULL
		ctx->indentbase = 0

		for i = 0 to WIKI_TAGS - 1
			ctx->tagflags(i) = 0
		next

		for i = 0 to WIKI_TOKENS - 1
			ctx->cssClassTb(i) = NULL
			ZSet @ctx->cssClassTb(i), @""
			ctx->tagGenTb(i) = TRUE
		next

		ctx->page = NULL
		ctx->trimre = NULL
		ctx->fbcode = new CFbCode
		ctx->nlcnt = 0
		ctx->skipnl = 0
		ctx->newindent = 0
		ctx->indent = 0
		ctx->newlevel = 0
		ctx->level = 0

		if( _AllocRe( ctx ) = FALSE ) then
			_FreeRe( ctx )
		end if

		ZSet @ctx->urlbase, @""
		ZSet @ctx->page, @""
		ZSet @ctx->outputdir, @""

	end constructor

	'':::::
	destructor CWakka2Html _
		( _
		)
		
		dim as integer i

		if( ctx = NULL ) then
			exit destructor
		end if

		ZFree @ctx->urlbase
		for i = 0 to WIKI_TOKENS - 1
			ZFree @ctx->cssClassTb(i)
		next
		ZFree @ctx->page
		ZFree @ctx->outputdir

		''
		_FreeRe( ctx )

		''
		delete ctx->fbcode
		
		delete ctx

	end destructor

	'':::::
	sub CWakka2Html.setUrlBase _
		( _
			byval value as zstring ptr _
		)

		zSet @ctx->urlbase, value

	end sub

	'':::::
	sub CWakka2Html.setIndentBase _
		( _
			byval value as integer _
		)

		ctx->indentbase = value

	end sub

	'':::::
	sub CWakka2Html.setCssClass _
		( _
			byval token_id as integer, _
			byval value as zstring ptr _
		)

		ZSet @ctx->cssClassTb(token_id), value

	end sub

	'':::::
	sub CWakka2Html.setTagDoGen _
		( _
			byval token_id as integer, _
			byval value as integer _
		)

		ctx->tagGenTb( token_id ) = value

	end sub

	'':::::
	sub CWakka2Html.setOutputDir _
		( _
			byval value as zstring ptr _
		)

		zSet @ctx->outputdir, value

	end sub

	'':::::
	private function _TrimTags _
		( _
			 byval ctx as CWakka2HtmlCtx ptr, _
			 byval text as zstring ptr _
		) as string

		dim as string res

		res = ""

		if( ctx->trimre->Search( text ) ) then
			dim as integer ofs = 0
			
			do
				dim as integer mofs = ctx->trimre->GetOfs( 0 )
				if( mofs > ofs ) then
					res += mid( *text, 1+ofs, (mofs - ofs) )
				end if
			
				'' res += ctx->trimre->GetStr( 0 )
			
				ofs = mofs + ctx->trimre->GetLen( 0 )

			loop while ctx->trimre->SearchNext()

			if( ofs < len( *text ) ) then
				res += mid( *text, 1+ofs )
			end if
		else
			res = *text
		end if
		
		return res
		
	end function

	'':::::
	private function _closeTags _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval textIn as zstring ptr _
		) as string
		
		dim as string text

		text = *textIn

		if( ctx->tagFlags(WIKI_TAG_BOLD) and 1 ) then
			ctx->tagFlags(WIKI_TAG_BOLD) -= 1
			text += "</b>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_ITALIC) and 1 ) then
			ctx->tagFlags(WIKI_TAG_ITALIC) -= 1
			text += "</i>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_UNDERLINE) and 1 ) then
			ctx->tagFlags(WIKI_TAG_UNDERLINE) -= 1
			text += "</u>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_MONOSPACE) and 1 ) then
			ctx->tagFlags(WIKI_TAG_MONOSPACE) -= 1
			text += "</tt>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_NOTES) and 1 ) then
			ctx->tagFlags(WIKI_TAG_NOTES) -= 1
			text += "</span>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_STRIKE) and 1 ) then
			ctx->tagFlags(WIKI_TAG_STRIKE) -= 1
			text += "</strike>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_KEYS) and 1 ) then
			ctx->tagFlags(WIKI_TAG_KEYS) -= 1
			text += "</kbd>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_CENTER) and 1 ) then
			ctx->tagFlags(WIKI_TAG_CENTER) -= 1
			text += "</div>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_HEADER) and 1 ) then
			ctx->tagFlags(WIKI_TAG_HEADER) -= 1
			text += "</div>"
		end if

		while( ctx->level > 0 )
			ctx->level -= 1
			text += "</ul>"
		wend

		while( ctx->indent > 0 )
			ctx->indent -= 1
			text += "</div>"
		wend

		if( ctx->tagFlags(WIKI_TAG_BOXLEFT) and 1 ) then

			ctx->tagFlags(WIKI_TAG_BOXLEFT) -= 1
			text += "</td>"

			if( (ctx->tagFlags(WIKI_TAG_BOXRIGHT) and 1) = 0 ) then
				text += "</tr></table>"	
			end if

		end if
		
		if( ctx->tagFlags(WIKI_TAG_BOXRIGHT) and 1 ) then
			ctx->tagFlags(WIKI_TAG_BOXRIGHT) -= 1
			text += "</td></tr></table>"
		end if
		
		if( ctx->tagFlags(WIKI_TAG_SECTION) <> 0 ) then
			ctx->tagFlags(WIKI_TAG_SECTION) = 0
			text += "</div>"
		end if
			
		return _TrimTags( ctx, text )

	end function


	'':::::
	private function _codeToHtml _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval text as zstring ptr _
		) as string

		dim res as string
		dim as FbToken ptr token
		dim as any ptr token_i
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

		if( ctx = NULL ) then
			bDefault = TRUE
		else
			if( ctx->fbcode = NULL ) then
				bDefault = TRUE
			end if
		end if

		if( bDefault ) then
			'' select class based on code tag?
			'' res += "<tt><div class=""qbasic"">
			'' only qbasic/freebasic should be formatted here
			'' all other formatters should be <PRE> only

			res += "<tt><div class=""freebasic"">"
			res += Text2Html( *text, TRUE, TRUE )
			res += "</div></tt><br />" + nl
			return res
		end if

		ctx->fbcode->Parse( text )

		res = ""

		token = ctx->fbcode->NewEnum( @token_i )
		while( token )

			if( token->id = FB_TOKEN_NULL ) then
				exit while
			end if

			if( token->flags and FBTOKEN_FLAGS_DEFINE ) then
				grpno = cssClassTb( FB_TOKEN_DEFINE ).grpno
			else
				grpno = cssClassTb( token->id ).grpno
			end if

			if( lastgrpno <> grpno ) then
				if( lastgrpno <> 0 ) then
					res += "</span>"
				end if
				if( grpno <> 0 ) then
					if( token->flags and FBTOKEN_FLAGS_DEFINE ) then
						res += "<span class=""" + *cssClassTb( FB_TOKEN_DEFINE ).cssClass + """>"
					else
						res += "<span class=""" + *cssClassTb( token->id ).cssClass + """>"
					end if
				end if
			end if

			select case token->id
			case FB_TOKEN_NULL	
				exit while
			case FB_TOKEN_SPACE
				token->text = ReplaceSubStr( token->text, chr(9), space(4) )
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
			token = ctx->fbcode->NextEnum( @token_i )
		wend

		if( lastgrpno <> 0 ) then
			res += "</span>"
		end if

		'' select class based on code tag?
		'' res = "<tt><div class=""qbasic"">" + nl + res + "</div></tt><br />" + nl
		'' only freebasic/qbasic should ever be formatted here
		'' all other code types will get <PRE>

		res = "<tt><div class=""freebasic"">" + nl + res + "</div></tt><br />" + nl

		return res
	end function

	'':::::
	private function _find_fbdocitem _
		( _
			byval itemTb as fbdoc_item_t ptr, _
			byval itemname as zstring ptr _
		) as integer

		dim i as integer
		for i = 0 to FBDOC_ITEMS - 1
			if( lcase(*itemTb[i].item_name) = lcase(*itemname) ) then
				return i
			end if
		next
		return -1

	end function

	'':::::
	private sub _explode_link _
		( _
			byref strValue as string, _
			byref strPage as string, _
			byref strName as string _
		)

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

	private function _actionGenfbDoc _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as string
		
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

		dim as string res, strItem, strValue, strVisible, strName, strPage, ext
		dim as integer isblock, itemidx, isVisible

		strItem = paramsTb->GetParam( "item" )
		strValue = paramsTb->GetParam( "value" )

		itemidx = _find_fbdocitem( @itemTb(0), strItem )

		if itemidx >= 0 then
			isblock = itemTb( itemidx ).isblock
		end if

		res = ""

		if( isblock ) then
			res += _closeTags( ctx, res )
			ctx->tagFlags(WIKI_TAG_SECTION) = 1
		end if

		select case lcase( strItem )
		case "title":

			strVisible = paramsTb->GetParam( "visible", "1" )
			isVisible = cbool( strVisible )

			if( isVisible ) then
				if( ctx->tagGenTb(WIKI_TOKEN_SECT_ITEM) ) then
					return res + "<div class=""fb_header"">" + strValue + "</div>"
				end if
			end if

			return res

		case "section":
			
			if( ctx->indentbase = 1 ) then
				res += _closeTags( ctx, res )
				ctx->tagFlags(WIKI_TAG_SECTION) = 1
				return res + "<div class=""fb_sect_title"">" + strValue +  _
							"</div><div class=""fb_sect_cont"">"
			end if

			return res + "<b><u>" + strValue + "</u></b>"

		case "subsect":			

			if( ctx->indentbase = 1 ) then
				'' res += _closeTags( ctx, res )
				'' ctx->tagFlags(WIKI_TAG_SECTION) = 1
				res += "<div class=""fb_sect_title"">" + strValue + "</div>"
				'' res += "<div class=""fb_sect_cont"">"
				return res
			end if

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
				return res + "<a href=""" + *ctx->urlbase + strPage + ext + """>" + Text2Html( FormatPageTitle(strName) ) + "</a>"
			end if
			
			return res + "<a href=""" + *ctx->urlbase + strPage + ext + """>" + Text2Html( strName ) + "</a>"
		
		case "back":
			if( ctx->tagGenTb(WIKI_TOKEN_SECT_ITEM) ) then

				_explode_link strValue, strPage, strName
				
				return res + "<div align=""center"">{#fb_sect_back} <a href=""" + _ 
						 *ctx->urlbase + strPage + """>" + Text2Html( strName ) + "</a></div>"
			else
				return res
			end if

		case "close":
			if( ctx->tagFlags(WIKI_TAG_SECTION) <> 0  ) then
				ctx->tagFlags(WIKI_TAG_SECTION) = 0
				res = "</div>"
			else
				res = ""
			end if
			
			return res

		case "filename":

			return res

		case "tag"

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
	private function _index_cells _
		( _
			byval text as zstring ptr, _
			byval cellTb as zstring ptr ptr ptr _
		) as integer

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
	private function _closeList _
		( _
			byval ctx as CWakka2HtmlCtx ptr _
		) as string	

		dim text as string
		text = ""

		while( ctx->level > 0 )
			ctx->level -= 1
			text += "</ul>"
		wend

		return text

	end function


	'':::::
	private function _actionGenTable _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as string
		
		dim as string res, cellData, strCols, cell
		dim as zstring ptr ptr cellTb
		dim as integer n, cols, col, i

		res = _closeList( ctx )
		
		cellData = UnescapeHtml( paramsTb->GetParam( "cells" ) )
		strCols = paramsTb->GetParam( "columns" )

		n = _index_cells( cellData, @cellTb )
		
		if( len( strCols ) > 0 ) then
			cols = val( strCols )
		else
			cols = 1
		end if

		res += "<div class=""" + *ctx->cssClassTb(WIKI_TOKEN_ACTION_TB) + """><table>"
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
		next

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
	private function _actionGenImage _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as string
		
		dim as string res, cssclass, strAlt, strUrl, strFile
		dim as integer h = any, bAdd = FALSE

		cssclass = *ctx->cssClassTb(WIKI_TOKEN_ACTION_IMG)

		strAlt = paramsTb->GetParam( "alt" )
		strUrl = paramsTb->GetParam( "url" )

		strUrl = "images/" + GetBaseName( strUrl )
		strFile = *ctx->outputdir + strUrl

		h = freefile
		if( open( strFile for input access read as #h ) = 0 ) then
			bAdd = TRUE
			close #h
		end if

		if( bAdd ) then

			res = "<div class=""" + cssclass + """><img"

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

		end if

		return res

	end function

	'':::::
	private function _actionGenColor _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as string

		dim as string res, sColor, sText

		sColor = paramsTb->GetParam( "c" )
		sText = paramsTb->GetParam( "text" )

		if( sColor > "" ) then
			res = "<span style=""color: " & sColor & """>" & Text2Html(sText) & "</span>"
		else
			res = Text2Html(sText)
		end if

		return res

	end function

	'':::::
	private function _actionGenAnchor _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as string

		dim as string res, sName, sTarget, sLink

		sName = paramsTb->GetParam( "name" )

		if instr( sName, "|" ) = 0 then
			res = _closeList( ctx )
			return res + "<a name=""" + sName + """></a>"
		end if

		_explode_link sName, sTarget, sLink

		return res + "<a href=""#" + sTarget + """>" + Text2Html( sLink ) + "</a>"
		
	end function

	'':::::
	private function _actionToHtml _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval actionname as zstring ptr, _
			byval paramsTb as WikiToken_Action ptr _
		) as string

		select case lcase(*actionname)
		case "fbdoc"	
			return _actionGenFbDoc( ctx, paramsTb )
		case "table"
			return _actionGenTable( ctx, paramsTb )
		case "image"
			return _actionGenImage( ctx, paramsTb )
		case "anchor"
			return _actionGenAnchor( ctx, paramsTb )
		case "color", "colour"
			return _actionGenColor( ctx, paramsTb )
		case else
			return ""
		end select
	end function

	'':::::
	private function _linkToHtml _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval url as zstring ptr, _
			byval text as zstring ptr _
		) as string
		
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
			return "<a href=""" + *ctx->urlbase + *url + ext + """>" + Text2Html( FormatPageTitle(*text) ) + "</a>"
		end if

		return "<a href=""" + *ctx->urlbase + *url + ext + """>" + Text2Html( *text ) + "</a>"

	end function

	'':::::
	private function _listToHtml _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval level as integer _
		) as string
		
		dim res as string

		res += "<li>"

		return res

	end function

	'':::::
	private function _tokenToHtml _
		( _
			byval ctx as CWakka2HtmlCtx ptr, _
			byval token as WikiToken ptr _
		) as string
		
		dim as string res, cssclass, x
		dim as integer dogen, i

		res = ""

		select case as const token->id
		case WIKI_TOKEN_NEWLINE
			ctx->nlcnt += 1

			if( ctx->skipnl = false ) then
				res += "<br \>" + nl
			end if

			ctx->skipnl = false
			ctx->newlevel = 0
			ctx->newindent = 0
			return res

		case WIKI_TOKEN_INDENT
			ctx->newindent = (token->indent->level - ctx->indentbase)
			if( ctx->newindent < 0 ) then
				ctx->newindent = 0
			end if
			ctx->newlevel = 0
			if( ctx->newindent <> ctx->indent ) then
				ctx->skipnl = true
			else
				ctx->skipnl = false
			end if
			return res

		case WIKI_TOKEN_LIST
			ctx->newindent = 0
			ctx->newlevel = token->indent->level
			if( ctx->newlevel < 0 ) then
				ctx->newlevel = 0
			end if

		end select

		while( ctx->level > ctx->newlevel )
			ctx->level -= 1
			res += "</ul>"
		wend
		while( ctx->indent > ctx->newindent )
			ctx->indent -= 1
			res += "</div>"
		wend

		if( token->id = WIKI_TOKEN_NEWLINE ) then
			return res
		end if

		while( ctx->level < ctx->newlevel )
			ctx->level += 1
			res += "<ul>"
		wend
		while( ctx->indent < ctx->newindent )
			ctx->indent += 1
			res += "<div class=""fb_indent"">"
		wend

		ctx->nlcnt = 0
		ctx->skipnl = false

		cssclass = *ctx->cssClassTb(token->id)
		if( len( cssclass ) > 0 ) then
			cssclass = "class=""" + cssclass + """"
		end if
			
		dogen = ctx->tagGenTb(token->id)

		select case as const token->id
		case WIKI_TOKEN_NULL
			return ""
		
		case WIKI_TOKEN_LT
			res += "&lt;"
			return res
		
		case WIKI_TOKEN_GT
			res += "&gt;"
			return res
		
		case WIKI_TOKEN_KBD
			ctx->tagFlags(WIKI_TAG_KEYS) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_KEYS) and 1, "<kbd " + cssclass + ">", "</kbd>")
			return res
		
		case WIKI_TOKEN_BOLD
			ctx->tagFlags(WIKI_TAG_BOLD) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_BOLD) and 1, "<b>", "</b>")
			return res

		case WIKI_TOKEN_BOLD_SECTION
			ctx->tagFlags(WIKI_TAG_BOLD) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_BOLD) and 1, "<b>", "</b>")
			return res
		
		case WIKI_TOKEN_ITALIC
			ctx->tagFlags(WIKI_TAG_ITALIC) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_ITALIC) and 1, "<i>", "</i>")
			return res
		
		case WIKI_TOKEN_UNDERLINE
			ctx->tagFlags(WIKI_TAG_UNDERLINE) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_UNDERLINE) and 1, "<u>", "</u>")
			return res

		case WIKI_TOKEN_MONOSPACE:
			ctx->tagFlags(WIKI_TAG_MONOSPACE) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_MONOSPACE) and 1, "<tt>", "</tt>")
			return res

		case WIKI_TOKEN_NOTES
			ctx->tagFlags(WIKI_TAG_NOTES) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_NOTES) and 1, "<span " + cssclass + ">", "</span>")
			return res

		case WIKI_TOKEN_STRIKE:
			ctx->tagFlags(WIKI_TAG_STRIKE) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_STRIKE) and 1, "<strike>", "</strike>")
			return res

		case WIKI_TOKEN_CENTER:
			ctx->tagFlags(WIKI_TAG_CENTER) += 1
			res += iif(ctx->tagFlags(WIKI_TAG_CENTER) and 1, "<div style=""text-align: center;"">", "</div>")
			return res

		case WIKI_TOKEN_LINK:
			res += _linkToHtml( ctx, token->link->url, token->text )
			return res

		case WIKI_TOKEN_LIST:
			res += _listToHtml( ctx, token->indent->level )
			return res

		case WIKI_TOKEN_TEXT, WIKI_TOKEN_RAW:
			if( (ctx->tagFlags(WIKI_TAG_BOLD) and 1) _
				and (ctx->tagFlags(WIKI_TAG_MONOSPACE) and 1)) then
					dim k as string
					k = fbdoc_FindKeyword( token->text )
					if( len(k) > 0 ) then
						res += k
						return res
					end if
			end if
			res += token->text
			'' !!! TODO : we should be converting text to HTML, but that will
			'' currently break pages that have HTML directly on them.  HTML
			'' injection has been used to try and work around the fact that
			'' fbdoc doesn't handle unicode properly and fbc is missing a
			'' var-len w-string
			'' res += Text2Html( token->text )
			return res

		case WIKI_TOKEN_ACTION:
			res += _actionToHtml( ctx, token->action->name, token->action )
			return res

		end select
		
		res += _closeList( ctx )
		ctx->skipnl = TRUE
		
		select case ( token->id )
		case WIKI_TOKEN_FORCENL:
			res += "<br />"
			return res
			
		case WIKI_TOKEN_HORZLINE:
			if( dogen ) then
				res += "<hr " + cssclass + " />"
			end if
			return res

		case WIKI_TOKEN_BOXLEFT:
			ctx->tagFlags(WIKI_TAG_BOXLEFT) += 1
			if ctx->tagFlags(WIKI_TAG_BOXLEFT) and 1 then
				res += "<table " + cssclass + "><tr><td>"
			else
				res += "</td>"
			end if
			return res

		case WIKI_TOKEN_BOXRIGHT:
			if ctx->tagFlags(WIKI_TAG_BOXLEFT) and 1 then
				res += "</td></tr></table>"
				return res
			end if

			ctx->tagFlags(WIKI_TAG_BOXRIGHT) += 1
			if ctx->tagFlags(WIKI_TAG_BOXRIGHT) and 1 then
				res += "<td>"
			else
				res += "</td></tr></table>"
			end if
			return res
			
		case WIKI_TOKEN_CLEAR:
			res += "<div style=""clear:both"">&nbsp;</div>"
			return res

		case WIKI_TOKEN_HEADER:
			ctx->skipnl = FALSE
			ctx->tagFlags(WIKI_TAG_HEADER) += 1
			if ctx->tagFlags(WIKI_TAG_HEADER) and 1 then
				res += "<div " + cssclass + ">"
			else
				res += "</div>"
			end if
			return res
		
		case WIKI_TOKEN_PRE:
			res += "<pre " + cssclass + ">" + token->text + "</pre>"
			'' !!! TODO : we should be converting text to HTML, but that will
			'' currently break pages that have HTML directly on them.  HTML
			'' injection has been used to try and work around the fact that
			'' fbdoc doesn't handle unicode properly and fbc is missing a
			'' var-len w-string
			'' res += "<pre " + cssclass + ">" + Text2Html( token->text ) + "</pre>"
			return res
		
		case WIKI_TOKEN_CODE:
			res += _codeToHtml( ctx, token->text )
			return res

		case WIKI_TOKEN_INDENT:
			x = ""
			for i = 1 to token->indent->level * 2
				x += "&nbsp; "
			next
			res += x
		
		end select

		return res

	end function

	'':::::
	function CWakka2Html.gen _
		( _
			byval page as zstring ptr, _
			byval wiki as CWiki ptr _
		) as string

		dim as integer i
		dim as string text
		dim as Clist ptr tokenlist
		dim as WikiToken ptr token

		ZSet @ctx->page, page

		for i = 0 to WIKI_TAGS - 1
			ctx->tagFlags( i ) = 0
		next
		
		text = ""

		ctx->nlcnt = 0
		ctx->skipnl = TRUE
		ctx->indent = 0
		
		tokenlist = wiki->GetTokenList()
		token = tokenlist->GetHead()
		while( token <> NULL )
			text += _tokenToHtml( ctx, token )
			token = tokenlist->GetNext( token )
		wend

		return _closeTags( ctx, text )

	end function

end namespace
