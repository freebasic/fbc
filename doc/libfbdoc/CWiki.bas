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


'' CWiki - class for parsing wakka wiki raw content
''       - based on PHP wikiconv
''
'' chng: apr/2006 written [v1ctor]
'' chng: may/2006 added page links list [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "CRegex.bi"
#include once "list.bi"
#include once "CWiki.bi"

namespace fb.fbdoc

	type CWikiCtx_
		as CRegex ptr 		re, _
							codere, _
							rawre, _
							linkre, _
							actionre, _
							action2re, _
							indentre, _
							actionparamre

		as CList ptr 		tokenlist
		as CList ptr		actparamlist
		as CList ptr		pagelinklist

		as WikiToken ptr    currenttoken
		as string           pagename
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

	public property WikiToken.id () as WIKI_TOKEN
		property = _id
	end property

	public property WikiToken.id ( byval new_value as WIKI_TOKEN )

		select case _id
		case WIKI_TOKEN_ACTION
			'' !!! FIXME: !!! - this will not release action parameters, until
			'' either CWiki goes out of scope, or CWiki->Parse() is called again
			delete action
			action = NULL
		case WIKI_TOKEN_INDENT, WIKI_TOKEN_LIST, WIKI_TOKEN_HEADER
			delete indent
			indent = NULL
		case WIKI_TOKEN_LINK
			delete link
			link = NULL
		case WIKI_TOKEN_CODE
			delete code
			code = NULL
		end select

		_id = new_value

		select case _id
		case WIKI_TOKEN_ACTION
			action = new WikiToken_Action
		case WIKI_TOKEN_INDENT, WIKI_TOKEN_LIST, WIKI_TOKEN_HEADER
			indent = new WikiToken_Indent
		case WIKI_TOKEN_LINK
			link = new WikiToken_Link
		case WIKI_TOKEN_CODE
			code = new WikiToken_Code
		end select
		
	end property

	'':::::
	public operator WikiToken.Let( byref other as WikiToken )
		
		with other

			text = .text
			start = .start
			length = .length

			id = _id

			select case _id
			case WIKI_TOKEN_ACTION
				*action = *.action
			case WIKI_TOKEN_INDENT, WIKI_TOKEN_LIST, WIKI_TOKEN_HEADER
				*indent = *.indent
			case WIKI_TOKEN_LINK
				*link = *.link
			case WIKI_TOKEN_CODE
				*code = *.code
			end select

		end with

	end operator

	'':::::
	operator WikiToken.cast _
		( _
		) as string

		dim i as integer
		dim as WikiToken ptr token = @this
		dim as string t
		
		select case as const token->id
		case WIKI_TOKEN_LT
			t = "<"
		case WIKI_TOKEN_GT
			t = ">"
		case WIKI_TOKEN_BOXLEFT
			t = "<<"
		case WIKI_TOKEN_BOXRIGHT
			t = ">>"
		case WIKI_TOKEN_CLEAR
			t = "::c::"
		case WIKI_TOKEN_KBD
			t = "#%"
		case WIKI_TOKEN_BOLD
			t = "**"
		case WIKI_TOKEN_BOLD_SECTION
			t = "=="
		case WIKI_TOKEN_ITALIC
			t = "//"
		case WIKI_TOKEN_UNDERLINE
			t = "__"
		case WIKI_TOKEN_MONOSPACE
			t = "##"
		case WIKI_TOKEN_NOTES
			t = "''"
		case WIKI_TOKEN_STRIKE
			t = "++"
		case WIKI_TOKEN_CENTER
			t = "@@"
		case WIKI_TOKEN_HEADER
			t = string( token->header->level, "=" )
		case WIKI_TOKEN_NEWLINE
			t = chr(10)
		case WIKI_TOKEN_CODE
			t = "%%(" + token->code->lang + ")"
			t += token->text
			t += "%%"
		case WIKI_TOKEN_PRE
			t = "%%"
			t += token->text
			t += "%%"
		case WIKI_TOKEN_LINK
			if( token->text > "" ) then
				if( token->link->pipechar ) then
					t = "[[" + token->link->url + "|" + token->text + "]]"
				else
					t = "[[" + token->link->url + " " + token->text + "]]"
				end if
			else
				t = "[[" + token->link->url + "]]"
			end if

		case WIKI_TOKEN_ACTION

			dim as WikiAction_Param ptr param, nxt
			dim as string tmp
			dim as integer i

			t = "{{" + token->action->name

			param = token->action->paramhead
			dim as integer p = 1
			do while( param <> NULL )
				i = instr( param->value, chr(34) )
				if( i > 0 ) then
					tmp = param->value
					do
						tmp = left( tmp, i - 1) & "&quot" & mid( tmp, i + 1 )
						i = instr(i + 5, tmp, chr(34) )
					loop while ( i > 0 )
					t += " " + param->name + "=""" + tmp + """"
				else
					t += " " + param->name + "=""" + param->value + """"
				end if
				param = param->next
				p += 1
			loop

			t += "}}"
			
		case WIKI_TOKEN_INDENT
			'' t = string( token->indent->level, 9 ) + token->indent->bullet
			t = token->indent->indent + token->indent->bullet
		case WIKI_TOKEN_LIST
			'' t = string( token->indent->level, 9 ) + token->indent->bullet
			t = token->indent->indent + token->indent->bullet
		case WIKI_TOKEN_TEXT
			t = token->text
		case WIKI_TOKEN_RAW
			t = """""" + token->text + """"""
		case WIKI_TOKEN_FORCENL
			t = "---"
		case WIKI_TOKEN_HORZLINE
			t = "----"
		end select

		operator = t

	end operator

	'':::::
	private function _AllocRe _
 		( _
			byval ctx as CWikiCtx ptr _
		) as integer

		function = FALSE
		
		ctx->re = new CRegex( WIKI_PATTERN, REGEX_OPT_MULTILINE or REGEX_OPT_DOTALL )
		if( ctx->re = NULL ) then
			exit function
		end if

		ctx->codere = new CRegex( $"^%%(.*?)%%$", REGEX_OPT_MULTILINE or REGEX_OPT_DOTALL )
		if( ctx->codere = NULL ) then
			exit function
		end if

		ctx->rawre = new CRegex( $"""""(.*?)""""", REGEX_OPT_MULTILINE or REGEX_OPT_DOTALL )
		if( ctx->rawre = NULL ) then
			exit function
		end if

		'' [[link]]
		'' [[link|text]]
		ctx->linkre = new CRegex( $"^\[\[([^\|]+)(?:\|(.+))?\]\]$", REGEX_OPT_DOTALL )
		if( ctx->linkre = NULL ) then
			exit function
		end if

		ctx->actionre = new CRegex( $"^\{\{(.*?)\}\}$", REGEX_OPT_DOTALL )
		if( ctx->actionre = NULL ) then
			exit function
		end if

		ctx->action2re = new CRegex( $"([a-zA-Z0-9_]+)([\t ]+(.*?$))?" )
		if( ctx->action2re = NULL ) then
			exit function
		end if

		ctx->indentre = new CRegex( $"^([\t|\~]+)((-|&|[0-9a-zA-Z]+\))?)", REGEX_OPT_DOTALL )
		if( ctx->indentre = NULL ) then	
			exit function
		end if

		ctx->actionparamre = new CRegex( $"([a-zA-Z]+)[ \t]*\=[ \t]*""(.*?)""", REGEX_OPT_DOTALL )
		if( ctx->actionparamre = NULL ) then	
			exit function
		end if


		function = TRUE

	end function

	'':::::
	private sub _FreeRe _
 		( _
			byval ctx as CWikiCtx ptr _
		) 

		if( ctx->actionparamre <> NULL ) then
			delete ctx->actionparamre
			ctx->actionparamre = NULL
		end if

		if( ctx->indentre <> NULL ) then
			delete ctx->indentre
			ctx->indentre = NULL
		end if

		if( ctx->action2re <> NULL ) then
			delete ctx->action2re
			ctx->action2re = NULL
		end if

		if( ctx->actionre <> NULL ) then
			delete ctx->actionre
			ctx->actionre = NULL
		end if
		
		if( ctx->linkre <> NULL ) then
			delete ctx->linkre
			ctx->linkre = NULL
		end if
		
		if( ctx->rawre <> NULL ) then
			delete ctx->rawre
			ctx->rawre = NULL
		end if
		
		if( ctx->codere <> NULL ) then
			delete ctx->codere
			ctx->codere = NULL
		end if

		if( ctx->re <> NULL ) then
			delete ctx->re
			ctx->re = NULL
		end if		

	end sub
		
	'':::::
	constructor CWiki _
		( _
		)
		
		ctx = new CWikiCtx

		if( _AllocRe( ctx ) = FALSE ) then
			_FreeRe( ctx )
		end if

		ctx->tokenlist = new CList( 16, len( WikiToken ) )
		ctx->actparamlist = new CList( 16, len( WikiAction_Param ) )
		ctx->pagelinklist = new CList( 16, len( WikiPageLink ) )

		ctx->pagename = ""

		ctx->currenttoken = NULL
		
	end constructor

	'':::::
	private sub _FreeTokenList _
		( _
			byval ctx as CWikiCtx ptr _
		)

		dim as WikiToken ptr token, nxt

		token = ctx->tokenlist->GetHead()
		do while( token <> NULL )
			nxt = ctx->tokenlist->GetNext( token )
			
			token->text = ""
			token->id = WIKI_TOKEN_NULL
			
			ctx->tokenlist->Remove( token )
			
			token = nxt
		loop

		ctx->currenttoken = NULL
		
	end sub

	'':::::
	private sub _FreeActParamList _
		( _
			byval ctx as CWikiCtx ptr _
		)
		
		dim as WikiAction_Param ptr param, nxt

		param = ctx->actparamlist->GetHead()
		do while( param <> NULL )
			nxt = ctx->actparamlist->GetNext( param )
			
			param->name = ""
			param->value = ""
			
			ctx->actparamlist->Remove( param )
			
			param = nxt
		loop
		
	end sub

	'':::::
	private sub _FreePageLinkList _
		( _
			byval ctx as CWikiCtx ptr _
		)

		dim as WikiPageLink ptr pagelink, nxt

		pagelink = ctx->pagelinklist->GetHead()
		do while( pagelink <> NULL )
			nxt = ctx->pagelinklist->GetNext( pagelink )
			
			pagelink->text = ""
			pagelink->link.url = ""
			
			ctx->pagelinklist->Remove( pagelink )
			
			pagelink = nxt
		loop
		
	end sub


	'':::::
	destructor CWiki _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if

		ctx->pagename = ""
		
		''
		_FreeActParamList( ctx )
		delete ctx->actparamlist

		_FreeTokenList( ctx )
		delete ctx->tokenlist

		_FreePageLinkList( ctx )
		delete ctx->pagelinklist
		
		''
		_FreeRe( ctx )
		
		delete ctx

	end destructor

	'':::::
	private sub _GetActionParams _
		( _
			byval ctx as CWikiCtx ptr, _
			byval token as WikiToken ptr, _
			byval text as zstring ptr _
		) 
		
		dim as WikiAction_Param ptr param, last
		dim as zstring ptr match
		
		token->action->paramhead = NULL

		if( ctx->actionparamre->Search( text ) ) then
			last = NULL
			do
				param = ctx->actparamlist->Insert()
				if( last = NULL ) then
					token->action->paramhead = param
				else
					last->next = param
				end if
				param->next = NULL
				
				param->name = *ctx->actionparamre->GetStr( 1 )
				match = ctx->actionparamre->GetStr( 2 )
				param->value = *match

				last = param

			loop while ctx->actionparamre->SearchNext()
		end if

	end sub

	'':::::	
	private sub _AddToken _
		( _
			byval ctx as CWikiCtx ptr, _
			byval text as zstring ptr, _
			byval start as integer, _
			byval length as integer _
		)
		
		dim as WikiToken ptr token = any
		
		if( ctx->currenttoken <> NULL ) then
			token = ctx->tokenlist->Insert( CList.insert_before, ctx->currenttoken )
		else
			token = ctx->tokenlist->Insert( CList.insert_last )
		end if

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
			token->header->level = len(*text)
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
		if( ctx->codere->Search( text ) ) then
			match = ctx->codere->GetStr( 1 )

			if( left( *match, 8 ) = "(qbasic)" ) then
				token->id = WIKI_TOKEN_CODE
				token->code->lang = "qbasic"
				token->text = mid( *match, 1+8 )

			elseif( left( *match, 11 ) = "(freebasic)" ) then
				token->id = WIKI_TOKEN_CODE
				token->text = mid( *match, 1+11 )
				token->code->lang = "freebasic"

			elseif( left( *match, 3 ) = "(c)" ) then
				token->id = WIKI_TOKEN_CODE
				token->text = mid( *match, 1+3 )
				token->code->lang = "c"

			else
				token->id = WIKI_TOKEN_PRE
				token->text = *match

			end if
			exit sub
		end if
		
		'' raw?
		if( ctx->rawre->Search( text ) ) then
			token->id = WIKI_TOKEN_RAW
			token->text = *ctx->rawre->GetStr( 1 )
			exit sub
		end if
		
		'' link?
		if( ctx->linkre->Search( text ) ) then
			token->id = WIKI_TOKEN_LINK
			token->link->url = *ctx->linkre->GetStr( 1 )
			token->text = trim( *ctx->linkre->GetStr( 2 ) )

			if( token->text = "" ) then
				token->link->pipechar = FALSE
			else
				token->link->pipechar = TRUE
			end if

			exit sub
		end if
		
		'' action?
		if( ctx->actionre->Search( text ) ) then
			match = ctx->actionre->GetStr( 0 )
			if( match <> NULL ) then
				token->id = WIKI_TOKEN_ACTION
				if( ctx->action2re->Search( match ) ) then
					token->action->name = *ctx->action2re->GetStr( 1 )
					_GetActionParams( ctx, token, ctx->action2re->GetStr( 2 ) )
				else
					token->action->name = *ctx->actionre->GetStr( 0 )
				end if
			
			else
				token->id = WIKI_TOKEN_TEXT
				token->text  = "{{}}"
			end if
			
			exit sub
		end if

		'' indent?
		if( ctx->indentre->Search( text ) ) then
			match = ctx->indentre->GetStr( 1 )
			dim as integer level = len( *match )
			if( (match[0] = asc( "~" )) or _
				(len( *ctx->indentre->GetStr( 2 ) ) = 0) ) then
				token->id = WIKI_TOKEN_INDENT
			else
				token->id = WIKI_TOKEN_LIST
			end if

			token->indent->level = level
			token->indent->indent = *ctx->indentre->GetStr( 1 )
			token->indent->bullet = *ctx->indentre->GetStr( 2 )
				
			exit sub
		end if

		token->id = WIKI_TOKEN_TEXT
		token->text = *text
		
	end sub

	'':::::	
	private sub _AddToken_Text _
		( _
			byval ctx as CWikiCtx ptr, _
			byval text as zstring ptr, _
			byval start as integer, _
			byval length as integer _
		)

		if( ctx = NULL ) then
			exit sub
		end if

		if( text = NULL ) then
			exit sub
		end if

		if( *cast( short ptr, text ) = &h0a0d ) then
			exit sub
		end if

		dim as WikiToken ptr token = any

		if( ctx->currenttoken <> NULL ) then
			token = ctx->tokenlist->Insert( CList.insert_before, ctx->currenttoken )
		else
			token = ctx->tokenlist->Insert( CList.insert_last )
		end if

		token->start = start
		token->length = length
		token->id = WIKI_TOKEN_TEXT
		token->text = *text

	end sub

	''::::
	function CWiki.MoveFirst() as WikiToken ptr
		ctx->currenttoken = ctx->tokenlist->GetHead()
		function = ctx->currenttoken
	end function

	''::::
	function CWiki.MoveLast() as WikiToken ptr
		ctx->currenttoken = ctx->tokenlist->GetTail()
		function = ctx->currenttoken
	end function

	''::::
	function CWiki.MoveNext() as WikiToken ptr
		ctx->currenttoken = ctx->tokenlist->GetNext( ctx->currenttoken )
		function = ctx->currenttoken
	end function

	''::::
	function CWiki.MovePrevious() as WikiToken ptr
		ctx->currenttoken = ctx->tokenlist->GetPrev( ctx->currenttoken )
		function = ctx->currenttoken
	end function

	''::::
	function CWiki.GetCurrent() as WikiToken ptr
		function = ctx->currenttoken
	end function

	'':::::
	function CWiki.Insert _
		( _
			byval body as zstring ptr, _
			byval token as WikiToken ptr = NULL _
		) as integer

		if( token <> NULL ) then
			'' TODO: verify that token is in the token list
			ctx->currenttoken = token
		end if

		if( ctx->re->Search( body ) ) then
			dim as integer ofs = 0
			
			do
				dim as integer mofs = ctx->re->GetOfs( 0 )
				if( mofs > ofs ) then
					_AddToken_Text( ctx, mid( *body, 1+ofs, (mofs - ofs) ), 1+ofs, mofs - ofs )
				end if
			
				_AddToken( ctx, ctx->re->GetStr( 0 ), 1+mofs, ctx->re->GetLen( 0 ) )
			
				ofs = mofs + ctx->re->GetLen( 0 )
			loop while ctx->re->SearchNext()

			if( ofs < len( *body ) ) then
				_AddToken_Text( ctx, mid( *body, 1+ofs ), 1+ofs, len( *body ) - ofs )
			end if
		else
			_AddToken_Text( ctx, *body, 1, len( *body) )
		end if
		
		function = TRUE

	end function

	'':::::
	function CWiki.Parse _
		( _
			byval spagename as zstring ptr, _
			byval body as zstring ptr _
		) as integer

		_FreeTokenlist( ctx )
		_FreePageLinkList( ctx )
		_FreeActParamlist( ctx )
		
		ctx->pagename = *spagename
		function = Insert( body )
			
	end function

	'':::::
	function CWiki.Remove _
	( _
		byval token as WikiToken ptr = NULL _
	) as integer

		_FreePageLinkList( ctx )

		if( token = NULL ) then
			token = ctx->currenttoken
		end if

		if( token <> NULL ) then

			ctx->currenttoken = ctx->tokenlist->GetNext(token)

			token->text = ""
			token->id = WIKI_TOKEN_NULL

			ctx->tokenlist->Remove(token)

			function = TRUE

		else

			function = FALSE

		end if

	end function

	'':::::
	sub CWiki.Dump _
		( _
		)
		
		dim as WikiToken ptr token
		dim as string t, text
		
		dim as integer f = freefile
		open cons for output as #f

		token = ctx->tokenlist->GetHead()
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
				t = "code:" + token->code->lang
			case WIKI_TOKEN_PRE
				t = "pre"
			case WIKI_TOKEN_LINK
				t = "link:" + token->link->url
			case WIKI_TOKEN_ACTION
				t = "action:" + token->action->name
				
				dim as WikiAction_Param ptr param, nxt
				param = token->action->paramhead
				dim as integer p = 1
				text = ""
				do while( param <> NULL )
					text += "param" & p & "(" + param->name + " = " + param->value + ")"
					param = param->next
					p += 1
				loop
				
			case WIKI_TOKEN_INDENT
				t = "indent:" & token->indent->level
			case WIKI_TOKEN_LIST
				t = "list:" & token->indent->level
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
			
			token = ctx->tokenlist->GetNext( token )
		loop
		
		close #f
		
	end sub

	'':::::
	private sub _AddPageLink _
		( _
			byval lst as CList ptr, _
			byref spagetext as string, _
			byref spagename as string, _
			byval level as integer, _
			byval linkclass as integer _
		)

		dim as WikiPageLink ptr pagelink

		pagelink = lst->Insert()
		pagelink->text = spagetext
		pagelink->link.url = spagename
		pagelink->link.linkclass = linkclass
		pagelink->level = level

	end sub

	'':::::
	function CWiki.GetTokenList _
		( _
		) as CList ptr

		if( ctx = NULL ) then
			return NULL
		end if
		
		function = ctx->tokenlist
			
	end function

	'':::::
	function CWiki.GetDocTocLinks _
		( _
			byval useboldlinks as integer _
		) as CList ptr

		dim as WikiToken ptr token
		dim as integer level = 0, i
		dim as string text, sPage, sTitle, sItem, sValue

		_FreePageLinkList( ctx )
		
		if( ctx = NULL ) then
			return NULL
		end if

		token = ctx->tokenlist->GetHead()
		do while( token <> NULL )
			text = token->text

			select case as const token->id
			case WIKI_TOKEN_LINK
				_AddPageLink( ctx->pagelinklist, text, token->link->url, level, WIKI_PAGELINK_CLASS_DEFAULT ) 

			case WIKI_TOKEN_ACTION
				
				if lcase(token->action->name) = "fbdoc" then

					sItem = token->action->GetParam( "item")
					sValue = token->action->GetParam( "value")

					select case lcase(sItem)
					case "section"
						_AddPageLink( ctx->pagelinklist, sValue, "", 0, WIKI_PAGELINK_CLASS_SECTION ) 
						level = 1

					case "subsect"
						_AddPageLink( ctx->pagelinklist, sValue, "", 1, WIKI_PAGELINK_CLASS_SUBSECT ) 
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

						_AddPageLink( ctx->pagelinklist, sTitle, sPage, level, WIKI_PAGELINK_CLASS_KEYWORD ) 

					end select

				end if
			case else

				if( useboldlinks ) then
					if( token->id = WIKI_TOKEN_BOLD_SECTION ) then
						token = ctx->tokenlist->GetNext( token )
						_AddPageLink( ctx->pagelinklist, token->text, "", 0, WIKI_PAGELINK_CLASS_SECTION ) 
						level = 1
						token = ctx->tokenlist->GetNext( token )
					end if
				end if
				
			end select
			
			token = ctx->tokenlist->GetNext( token )
		loop

		function = ctx->pagelinklist
	end function

	'':::::
	function CWiki.GetPageTitle _
		( _
		) as string

		dim as WikiToken ptr token
		dim as integer level = 0, i
		dim as string text, sPage, sTitle, sItem, sValue
		
		if( ctx = NULL ) then
			return ""
		end if

		token = ctx->tokenlist->GetHead()
		do while( token <> NULL )

			if( token->id = WIKI_TOKEN_ACTION) then
				
				if lcase(token->action->name) = "fbdoc" then

					sItem = token->action->GetParam( "item")
					sValue = token->action->GetParam( "value")

					if( lcase(sItem) = "title" ) then
						sTitle = sValue
						exit do
					end if

				end if

			end if
			
			token = ctx->tokenlist->GetNext( token )
		loop

		function = sTitle
	end function


	'':::::
	function WikiToken_Action.GetParam _
		( _
			byval sParamName as zstring ptr, _
			byval default as zstring ptr = NULL _
		) as string

		dim as WikiAction_Param ptr param = this.paramhead

		function = ""

		do while( param <> NULL )

			if lcase(param->name) = lcase(*sParamName) then
				function = param->value
				exit function
			end if

			param = param->next

		loop

		if( default ) then
			function = *default
		end if

	end function

	'':::::
	sub WikiToken_Action.SetParam _
		( _
			byval sParamName as zstring ptr, _
			byref sValue as string _
		)

		dim as WikiAction_Param ptr param = this.paramhead

		do while( param <> NULL )

			if lcase(param->name) = lcase(*sParamName) then
				param->value = sValue
				exit sub
			end if

			param = param->next

		loop

	end sub

	'':::::
	function CWiki.Build _
		( _
		) as string

		dim ret as string
		dim as WikiToken ptr token = ctx->tokenlist->GetHead()
		
		do while( token <> NULL )
			ret &= *token
			token = ctx->tokenlist->GetNext( token )
		loop
		
		function = ret	

	end function

	'':::::
	property CWiki.PageName _
		( _
		) as string

		property = ctx->pagename

	end property

	'':::::
	property CWiki.PageName _
		( _
			byref spagename as string _
		)

		ctx->pagename = spagename

	end property

end namespace
