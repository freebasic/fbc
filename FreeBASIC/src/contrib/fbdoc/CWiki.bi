#ifndef __CWIKI_BI__
#define __CWIKI_BI__

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


#include once "common.bi"
#include once "list.bi"

enum WIKI_TOKEN
	WIKI_TOKEN_NULL
	WIKI_TOKEN_LT
	WIKI_TOKEN_GT
	WIKI_TOKEN_BOXLEFT
	WIKI_TOKEN_BOXRIGHT
	WIKI_TOKEN_CLEAR
	WIKI_TOKEN_KBD
	WIKI_TOKEN_BOLD
	WIKI_TOKEN_ITALIC
	WIKI_TOKEN_UNDERLINE
	WIKI_TOKEN_MONOSPACE
	WIKI_TOKEN_NOTES
	WIKI_TOKEN_STRIKE
	WIKI_TOKEN_CENTER
	WIKI_TOKEN_HEADER
	WIKI_TOKEN_NEWLINE
	WIKI_TOKEN_CODE
	WIKI_TOKEN_PRE
	WIKI_TOKEN_LINK
	WIKI_TOKEN_ACTION
	WIKI_TOKEN_INDENT
	WIKI_TOKEN_LIST
	WIKI_TOKEN_TEXT
	WIKI_TOKEN_FORCENL
	WIKI_TOKEN_HORZLINE
	WIKI_TOKEN_SECT_ITEM
	WIKI_TOKEN_ACTION_TB
	WIKI_TOKEN_ACTION_IMG
	WIKI_TOKEN_BOLD_SECTION
	WIKI_TOKEN_RAW
	WIKI_TOKENS
end enum
	
enum WIKI_TAG	
	WIKI_TAG_BOLD
	WIKI_TAG_ITALIC
	WIKI_TAG_UNDERLINE
	WIKI_TAG_MONOSPACE
	WIKI_TAG_NOTES
	WIKI_TAG_STRIKE
	WIKI_TAG_BOXLEFT
	WIKI_TAG_BOXRIGHT
	WIKI_TAG_KEYS
	WIKI_TAG_CENTER
	WIKI_TAG_HEADER
	WIKI_TAG_LEVEL
	WIKI_TAG_SECTION
	WIKI_TAGS
end enum

type Wiki_ActionParam
	as any ptr				ll_prev
	as any ptr				ll_next

	as string 				name
	as string 				value
	as Wiki_ActionParam ptr	next
end type

type WikiToken_Action
	as string				name
	as Wiki_ActionParam ptr	paramhead
end type

type WikiToken_Link
	as string 				url
end type

type WikiToken_Indent
	as integer				level
end type

type WikiToken
	as any ptr				ll_prev
	as any ptr				ll_next

	as WIKI_TOKEN			id
	as string 				text
	
	union 
		as WikiToken_Action action
		as WikiToken_Link 	link
		as WikiToken_Indent	indent
	end union
end type

type WikiPageLink
	as any ptr				ll_prev
	as any ptr				ll_next

	as string         text
	as WikiToken_Link link
	as integer        level
		
end type

	
type CWiki as CWiki_


declare function 	CWiki_New 							( _
															byval _this as CWiki ptr = NULL _
														) as CWiki ptr

declare sub 		CWiki_Delete 						( _
															byval _this as CWiki ptr, _
															byval isstatic as integer = FALSE _
														)

declare function 	CWiki_Parse 						( _
															byval _this as CWiki ptr, _
															byval pagename as zstring ptr, _
															byval body as zstring ptr _
														) as integer

declare sub 		CWiki_Dump 							( _
															byval _this as CWiki ptr _
														)

declare function CWiki_GetTokenList _
	( _
		byval _this as CWiki ptr _
	) as TLIST ptr


declare function CWiki_GetActionParamValue _
	( _
		byval paramhead as Wiki_ActionParam ptr, _
		byval sParamName as zstring ptr _
	) as string



declare function CWiki_GetDocTocLinks 	( _
			byval _this as CWiki ptr _
		) as TLIST ptr

declare function CWiki_GetPageTitle _
	( _
		byval _this as CWiki ptr _
	) as string

#endif
