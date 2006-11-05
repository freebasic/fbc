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


'' CWiki - psuedo class for parsing wakka wiki raw content
''       - based on PHP wikiconv
''
'' chng: apr/2006 written [v1ctor]
'' chng: may/2006 added page links list [coderJeff]

#include once "common.bi"
#include once "CRegex.bi"
#include once "list.bi"
#include once "CWiki.bi"

type CWiki_
	as CRegex ptr 		re, _
						codere, _
						rawre, _
						linkre, _
						actionre, _
						action2re, _
						indentre, _
						actionparamre

	as TLIST 			tokenlist
	as TLIST 			actparamlist
	as TLIST      pagelinklist
end type

const WIKI_PATTERN =  $"\%\%.*?\%\%|" + _
				  	  $""""".*?""""|" + _
				  	  $"\[\[[^\[]*?\]\]|" + _
				  	  $"-{4,}|\-\-\-|" + _
				  	  $"\b[a-z]+:\/\/\S+|" + _
				  	  $"\*\*|\'\'|\#\#|\#\%|\@\@|\:\:c\:\:|\>\>|\<\<|\+\+|\_\_|\<|\>|\/\/|" + _
				  	  $"\=\=\=\=\=\=|\=\=\=\=\=|\=\=\=\=|\=\=\=|\=\=|" + _
				  	  $"^[\t|\~]+(-|&|[0-9a-zA-Z]+\))?|" + _
				  	  $"\{\{.*?\}\}|" + _
				  	  $"\n|\r\n"

'':::::
private function CWiki_AllocRe _
 	( _
		byval _this as CWiki ptr _
	) as integer

	function = FALSE
	
	_this->re = CRegex_New( WIKI_PATTERN, REGEX_OPT_MULTILINE or REGEX_OPT_DOTALL )
	if( _this->re = NULL ) then
		exit function
	end if

	_this->codere = CRegex_New( "^%%(.*?)%%$", REGEX_OPT_MULTILINE or REGEX_OPT_DOTALL )
	if( _this->codere = NULL ) then
		exit function
	end if

	_this->rawre = CRegex_New( """""(.*?)""""", REGEX_OPT_MULTILINE or REGEX_OPT_DOTALL )
	if( _this->rawre = NULL ) then
		exit function
	end if

	_this->linkre = CRegex_New( "^\[\[(\S*)(\s+(.+))?\]\]$", REGEX_OPT_DOTALL )
	if( _this->linkre = NULL ) then
		exit function
	end if

	_this->actionre = CRegex_New( "^\{\{(.*?)\}\}$", REGEX_OPT_DOTALL )
	if( _this->actionre = NULL ) then
		exit function
	end if

	_this->action2re = CRegex_New( $"([a-zA-Z0-9_]+)[\t ]+(.*?$)" )
	if( _this->action2re = NULL ) then
		exit function
	end if

	_this->indentre = CRegex_New( $"^([\t|\~]+)((-|&|[0-9a-zA-Z]+\))?)", REGEX_OPT_DOTALL )
	if( _this->indentre = NULL ) then	
		exit function
	end if

	_this->actionparamre = CRegex_New( $"([a-zA-Z]+)[ \t]*\=[ \t]*""(.*?)""", REGEX_OPT_DOTALL )
	if( _this->actionparamre = NULL ) then	
		exit function
	end if

	function = TRUE

end function

'':::::
private sub CWiki_FreeRe _
 	( _
		byval _this as CWiki ptr _
	) 

	if( _this->actionparamre <> NULL ) then
		CRegex_Delete( _this->actionparamre )
		_this->actionparamre = NULL
	end if

	if( _this->indentre <> NULL ) then
		CRegex_Delete( _this->indentre )
		_this->indentre = NULL
	end if

	if( _this->action2re <> NULL ) then
		CRegex_Delete( _this->action2re )
		_this->action2re = NULL
	end if

	if( _this->actionre <> NULL ) then
		CRegex_Delete( _this->actionre )
		_this->actionre = NULL
	end if
	
	if( _this->linkre <> NULL ) then
		CRegex_Delete( _this->linkre )
		_this->linkre = NULL
	end if
	
	if( _this->rawre <> NULL ) then
		CRegex_Delete( _this->rawre )
		_this->rawre = NULL
	end if
	
	if( _this->codere <> NULL ) then
		CRegex_Delete( _this->codere )
		_this->codere = NULL
	end if

	if( _this->re <> NULL ) then
		CRegex_Delete( _this->re )
		_this->re = NULL
	end if		

end sub
	
'':::::
function CWiki_New _
	( _
		byval _this as CWiki ptr _
	) as CWiki ptr
	
	dim as integer isstatic = TRUE	
	
	''
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CWiki ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if
	
	''
	if( CWiki_AllocRe( _this ) = FALSE ) then

		CWiki_FreeRe( _this )
		
  		if( isstatic = FALSE ) then
  			deallocate( _this )
  		end if
		
		return NULL
	end if

	''
	listNew( @_this->tokenlist, 16, len( WikiToken ), TRUE )
	listNew( @_this->actparamlist, 16, len( Wiki_ActionParam ), TRUE )
	listNew( @_this->pagelinklist, 16, len( WikiToken ), TRUE )
	
	''
	function = _this
	
end function

'':::::
private sub CWiki_FreeTokenList _
	( _
		byval _this as CWiki ptr _
	)

	dim as WikiToken ptr token, nxt

	token = cast( WikiToken ptr, listGetHead( @_this->tokenlist ) )
	do while( token <> NULL )
		nxt = cast( WikiToken ptr, listGetNext( token ) )
		
		token->text = ""
		select case as const token->id
		case WIKI_TOKEN_LINK
			token->link.url = ""
		case WIKI_TOKEN_ACTION
			token->action.name = ""
		end select
		
		listDelNode( @_this->tokenlist, cast( any ptr, token ) )
		
		token = nxt
	loop
	
end sub

'':::::
private sub CWiki_FreeActParamList _
	( _
		byval _this as CWiki ptr _
	)
	
	dim as Wiki_ActionParam ptr param, nxt

	param = cast( Wiki_ActionParam ptr, listGetHead( @_this->actparamlist ) )
	do while( param <> NULL )
		nxt = cast( Wiki_ActionParam ptr, listGetNext( param ) )
		
		param->name = ""
		param->value = ""
		
		listDelNode( @_this->actparamlist, cast( any ptr, param ) )
		
		param = nxt
	loop
	
end sub

'':::::
private sub CWiki_FreePageLinkList _
	( _
		byval _this as CWiki ptr _
	)

	dim as WikiPageLink ptr pagelink, nxt

	pagelink = cast( WikiPageLink ptr, listGetHead( @_this->pagelinklist ) )
	do while( pagelink <> NULL )
		nxt = cast( WikiPageLink ptr, listGetNext( pagelink ) )
		
		pagelink->text = ""
		pagelink->link.url = ""
		
		listDelNode( @_this->pagelinklist, cast( any ptr, pagelink ) )
		
		pagelink = nxt
	loop
	
end sub


'':::::
sub CWiki_Delete _
	( _
		byval _this as CWiki ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if
	
	''
	CWiki_FreeActParamList( _this )
	listFree( @_this->actparamlist )

	CWiki_FreeTokenList( _this )
	listFree( @_this->tokenlist )

	CWiki_FreePageLinkList( _this )
	listFree( @_this->pagelinklist )
	
	''
	CWiki_FreeRe( _this )
	
	''
	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
private sub CWiki_GetActionParams _
	( _
		byval _this as CWiki ptr, _
		byval token as WikiToken ptr, _
		byval text as zstring ptr _
	) 
	
	dim as Wiki_ActionParam ptr param, last
	
	token->action.paramhead = NULL
		
	if( CRegex_Search( _this->actionparamre, text ) ) then
		last = NULL
		do
			param = listNewNode( @_this->actparamlist )
			if( last = NULL ) then
				token->action.paramhead = param
			else
				last->next = param
			end if
			param->next = NULL
			
			param->name = *CRegex_GetStr( _this->actionparamre, 1 )
			param->value = *CRegex_GetStr( _this->actionparamre, 2 )

			last = param

		loop while CRegex_SearchNext( _this->actionparamre )
	end if

end sub

'':::::	
private sub CWiki_AddToken _
	( _
		byval _this as CWiki ptr, _
		byval text as zstring ptr, _
		byval start as integer, _
		byval length as integer _
	)
	
	dim as WikiToken ptr token = listNewNode( @_this->tokenlist )

	token->start = start
	token->length = length

	select case *text
	case "<"
		token->id = WIKI_TOKEN_LT
		exit sub
	
	case ">"
		token->id = WIKI_TOKEN_GT
		exit sub
		
	case "<<"
		token->id = WIKI_TOKEN_BOXLEFT
		exit sub

	case ">>"
		token->id = WIKI_TOKEN_BOXRIGHT
		exit sub
		
	case "::c::"
		token->id = WIKI_TOKEN_CLEAR
		exit sub

	case "#%"
		token->id = WIKI_TOKEN_KBD
		exit sub

	case "=="
		token->id = WIKI_TOKEN_BOLD_SECTION
		exit sub

	case "**"
		token->id = WIKI_TOKEN_BOLD
		exit sub

	case "//"
		token->id = WIKI_TOKEN_ITALIC
		exit sub

	case "__"
		token->id = WIKI_TOKEN_UNDERLINE
		exit sub

	case "##"
		token->id = WIKI_TOKEN_MONOSPACE
		exit sub

	case "''"
		token->id = WIKI_TOKEN_NOTES
		exit sub

	case "++"
		token->id = WIKI_TOKEN_STRIKE
		exit sub

	case "@@"
		token->id = WIKI_TOKEN_CENTER
		exit sub

	case "===", "====", "=====", "======"
		token->id = WIKI_TOKEN_HEADER
		exit sub
	
	case "---"
		token->id = WIKI_TOKEN_FORCENL
		exit sub
	
	case "----"
		token->id = WIKI_TOKEN_HORZLINE
		exit sub

	case chr( 10 ), chr( 13, 10 )
		token->id = WIKI_TOKEN_NEWLINE
		exit sub
	end select
		
	dim as zstring ptr match
	
	'' code?	 	
	if( CRegex_Search( _this->codere, text ) ) then
		match = CRegex_GetStr( _this->codere, 1 )
		if( left( *match, 8 ) = "(qbasic)" ) then
			token->id = WIKI_TOKEN_CODE
			token->text = mid( *match, 1+8 )
		else
			token->id = WIKI_TOKEN_PRE
			token->text = *match
		end if
		exit sub
	end if
	
	'' raw?
	if( CRegex_Search( _this->rawre, text ) ) then
		token->id = WIKI_TOKEN_RAW
		token->text = *CRegex_GetStr( _this->rawre, 1 )
		exit sub
	end if
	
	'' link?
	if( CRegex_Search( _this->linkre, text ) ) then
		token->id = WIKI_TOKEN_LINK
		token->link.url = *CRegex_GetStr( _this->linkre, 1 )
		token->text = trim( *CRegex_GetStr( _this->linkre, 2 ) )

		exit sub
	end if
	
	'' action?
	if( CRegex_Search( _this->actionre, text ) ) then
		match = CRegex_GetStr( _this->actionre, 0 )
		if( match <> NULL ) then
			CRegex_Search( _this->action2re, match )
			token->id = WIKI_TOKEN_ACTION
			token->action.name = *CRegex_GetStr( _this->action2re, 1 )
			CWiki_GetActionParams( _this, token, CRegex_GetStr( _this->action2re, 2 ) )
		
		else
			token->id = WIKI_TOKEN_TEXT
			token->text  = "{{}}"
		end if
		
		exit sub
	end if

	'' indent?
	if( CRegex_Search( _this->indentre, text ) ) then
		match = CRegex_GetStr( _this->indentre, 1 )
		dim as integer level = len( *match )
		if( (match[0] = asc( "~" )) or _
			(len( *CRegex_GetStr( _this->indentre, 2 ) ) = 0) ) then
			token->id = WIKI_TOKEN_INDENT
			token->indent.level = level
		else
			token->id = WIKI_TOKEN_LIST
			token->indent.level = level
		end if
			
		exit sub
	end if

	token->id = WIKI_TOKEN_TEXT
	token->text = *text
	
end sub

'':::::	
private sub CWiki_AddToken_Text _
	( _
		byval _this as CWiki ptr, _
		byval text as zstring ptr, _
		byval start as integer, _
		byval length as integer _
	)

	if( _this = NULL ) then
		exit sub
	end if

	if( text = NULL ) then
		exit sub
	end if

	if( *cast( short ptr, text ) = &h0a0d ) then
		exit sub
	end if

	dim as WikiToken ptr token = listNewNode( @_this->tokenlist )

	token->start = start
	token->length = length
	token->id = WIKI_TOKEN_TEXT
	token->text = *text
	
end sub

'':::::
function CWiki_Parse _
	( _
		byval _this as CWiki ptr, _
		byval pagename as zstring ptr, _
		byval body as zstring ptr _
	) as integer

	CWiki_FreeTokenlist( _this )
	CWiki_FreePageLinkList( _this )
	CWiki_FreeActParamlist( _this )
	
	if( CRegex_Search( _this->re, body ) ) then
		dim as integer ofs = 0
		
		do
			dim as integer mofs = CRegex_GetOfs( _this->re, 0 )
			if( mofs > ofs ) then
				CWiki_AddToken_Text( _this, mid( *body, 1+ofs, (mofs - ofs) ), 1+ofs, mofs - ofs )
			end if
		
			CWiki_AddToken( _this, CRegex_GetStr( _this->re, 0 ), 1+mofs, CRegex_GetLen( _this->re, 0 ) )
		
			ofs = mofs + CRegex_GetLen( _this->re, 0 )
		loop while CRegex_SearchNext( _this->re )

		if( ofs < len( *body ) ) then
			CWiki_AddToken_Text( _this, mid( *body, 1+ofs ), 1+ofs, len( *body ) - ofs )
		end if
	else
		CWiki_AddToken_Text( _this, *body, 1, len( *body) )
	end if
	
	function = TRUE
		
end function
	

'':::::
sub CWiki_Dump _
	( _
		byval _this as CWiki ptr _
	)
	
	dim as WikiToken ptr token
	dim as string t, text
	
	dim as integer f = freefile
	open cons for output as #f

	token = cast( WikiToken ptr, listGetHead( @_this->tokenlist ) )
	do while( token <> NULL )
		text = token->text
		
		select case as const token->id
		case WIKI_TOKEN_LT
			t = "lt"
		case WIKI_TOKEN_GT
			t = "gt"
		case WIKI_TOKEN_BOXLEFT
			t = "boxleft"
		case WIKI_TOKEN_BOXRIGHT
			t = "boxright"
		case WIKI_TOKEN_CLEAR
			t = "clear"
		case WIKI_TOKEN_KBD
			t = "kbd"
		case WIKI_TOKEN_BOLD
			t = "bold"
		case WIKI_TOKEN_BOLD_SECTION
			t = "bold section"
		case WIKI_TOKEN_ITALIC
			t = "italic"
		case WIKI_TOKEN_UNDERLINE
			t = "underline"
		case WIKI_TOKEN_MONOSPACE
			t = "monospc"
		case WIKI_TOKEN_NOTES
			t = "notes"
		case WIKI_TOKEN_STRIKE
			t = "strike"
		case WIKI_TOKEN_CENTER
			t = "center"
		case WIKI_TOKEN_HEADER
			t = "header"	
		case WIKI_TOKEN_NEWLINE
			t = "nl"
		case WIKI_TOKEN_CODE
			t = "code"
		case WIKI_TOKEN_PRE
			t = "pre"
		case WIKI_TOKEN_LINK
			t = "link:" + token->link.url
		case WIKI_TOKEN_ACTION
			t = "action:" + token->action.name
			
			dim as Wiki_ActionParam ptr param, nxt
			param = token->action.paramhead
			dim as integer p = 1
			text = ""
			do while( param <> NULL )
				text += "param" & p & "(" + param->name + " = " + param->value + ")"
				param = param->next
				p += 1
			loop
			
		case WIKI_TOKEN_INDENT
			t = "indent:" & token->indent.level
		case WIKI_TOKEN_LIST
			t = "list:" & token->indent.level
		case WIKI_TOKEN_TEXT
			t = "text"
		case WIKI_TOKEN_RAW
			t = "raw"
		case WIKI_TOKEN_FORCENL
			t = "forcenl"
		case WIKI_TOKEN_HORZLINE
			t = "horzline"
		end select
		
		print #f, str(token->start) + "," + str(token->length) + " - ";
		print #f, "<" + t + ">";
		if( len( text ) > 0 ) then
			print #f, text;
		end if
		print #f, "</" + t + ">"
		
		token = cast( WikiToken ptr, listGetNext( token ) )
	loop
	
	close #f
	
end sub

'':::::
private sub _AddPageLink _
	( _
		byval lst as TLIST ptr, _
		byref spagetext as string, _
		byref spagename as string, _
		byval level as integer _
	)

	dim as WikiPageLink ptr pagelink

	pagelink = listNewNode( lst )
	pagelink->text = spagetext
	pagelink->link.url = spagename
	pagelink->level = level

end sub

'':::::
'declare function CWiki_GetActionParamValue _
'	( _
'		byval token as WikiToken ptr, _
'		byval sParamName as zstring ptr _
'	) as string
function CWiki_GetActionParamValue _
	( _
		byval param as Wiki_ActionParam ptr, _
		byval sParamName as zstring ptr _
	) as string

	'dim as Wiki_ActionParam ptr param

	function = ""

	''if( token = NULL ) then
	if( param = NULL ) then
		exit function
	end if

	'if lcase(token->action.name) <> lcase(sAction) then
	'	exit function
	'end if

	''param = token->action.paramhead
	do while( param <> NULL )

		if lcase(param->name) = lcase(*sParamName) then
			function = param->value
			exit function
		end if

		param = param->next

	loop

end function

'':::::
function CWiki_GetTokenList _
	( _
		byval _this as CWiki ptr _
	) as TLIST ptr

	if( _this = NULL ) then
		return NULL
	end if
	
	function = @_this->tokenlist
		
end function

'':::::
function CWiki_GetDocTocLinks _
	( _
		byval _this as CWiki ptr, _
		byval useboldlinks as integer _
	) as TLIST ptr

	dim as WikiToken ptr token
	dim as integer level = 0, i
	dim as string text, sPage, sTitle, sItem, sValue

	CWiki_FreePageLinkList( _this )
	
	if( _this = NULL ) then
		return NULL
	end if

	token = cast( WikiToken ptr, listGetHead( @_this->tokenlist ) )
	do while( token <> NULL )
		text = token->text

		select case as const token->id
		case WIKI_TOKEN_LINK
			_AddPageLink( @_this->pagelinklist, text, token->link.url, level ) 

		case WIKI_TOKEN_ACTION
			
			if lcase(token->action.name) = "fbdoc" then

				sItem = CWiki_GetActionParamValue(token->action.paramhead, "item")
				sValue = CWiki_GetActionParamValue(token->action.paramhead, "value")

				select case lcase(sItem)
				case "section"
					_AddPageLink( @_this->pagelinklist, sValue, "", 0 ) 
					level = 1

				case "subsect"
					_AddPageLink( @_this->pagelinklist, sValue, "", 1 ) 
					level = 2

				case "keyword"

					i = instr(sValue, "|")
					if i > 0 then
						sPage = left(sValue, i - 1)
						sTitle = mid(sValue, i + 1)
					else
						sPage = sValue
						sTitle = ""
					end if

					_AddPageLink( @_this->pagelinklist, sTitle, sPage, level ) 

				end select

			end if
		case else

			''if( lcase( _this->pagename ) = "catpgfunctindex" ) then

			if( useboldlinks ) then
				if( token->id = WIKI_TOKEN_BOLD_SECTION ) then
					token = cast( WikiToken ptr, listGetNext( token ) )
					''_AddPageLink( @_this->pagelinklist, FormatPageTitle( token->text ), "", 0 ) 
					_AddPageLink( @_this->pagelinklist, token->text, "", 0 ) 
					level = 1
					token = cast( WikiToken ptr, listGetNext( token ) )
				end if
			end if
			
		end select
		
		token = cast( WikiToken ptr, listGetNext( token ) )
	loop

	function = @_this->pagelinklist
end function

'':::::
function CWiki_GetPageTitle _
	( _
		byval _this as CWiki ptr _
	) as string

	dim as WikiToken ptr token
	dim as integer level = 0, i
	dim as string text, sPage, sTitle, sItem, sValue
	
	if( _this = NULL ) then
		return ""
	end if

	token = cast( WikiToken ptr, listGetHead( @_this->tokenlist ) )
	do while( token <> NULL )

		if( token->id = WIKI_TOKEN_ACTION) then
			
			if lcase(token->action.name) = "fbdoc" then

				sItem = CWiki_GetActionParamValue(token->action.paramhead, "item")
				sValue = CWiki_GetActionParamValue(token->action.paramhead, "value")

				if( lcase(sItem) = "title" ) then
					sTitle = sValue
					exit do
				end if

			end if

		end if
		
		token = cast( WikiToken ptr, listGetNext( token ) )
	loop

	function = sTitle
end function
