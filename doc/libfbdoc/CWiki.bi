#ifndef __CWIKI_BI__
#define __CWIKI_BI__

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


#include once "fbdoc_defs.bi"
#include once "list.bi"

namespace fb.fbdoc

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

	enum WIKI_PAGELINK_CLASS
		WIKI_PAGELINK_CLASS_UNKNOWN = 0
		WIKI_PAGELINK_CLASS_SECTION = 1
		WIKI_PAGELINK_CLASS_SUBSECT = 2
		WIKI_PAGELINK_CLASS_KEYWORD = 3
		WIKI_PAGELINK_CLASS_DEFAULT = 4
	end enum

	type WikiAction_Param
		as string 				name
		as string 				value
		as WikiAction_Param ptr	next
	end type

	type WikiToken_Action
		as string				name
		as WikiAction_Param ptr	paramhead

		declare function GetParam _
			( _
				byval sParamName as zstring ptr, _
				byval default as zstring ptr = NULL _
			) as string

		declare sub SetParam _
			( _
				byval sParamName as zstring ptr, _
				byref sValue as string _
			)

	end type

	type WikiToken_Link
		as string 				url
		as integer				linkclass
		as integer				pipechar
	end type

	type WikiToken_Code
		as string 				lang
	end type

	type WikiToken_Indent
		as integer				level
		as string               indent
		as string               bullet
	end type

	type WikiToken
		private:
			as WIKI_TOKEN			_id
		
		public:

		as string 				text
		as integer              start
		as integer              length

		union
			as WikiToken_Action ptr action
			as WikiToken_Link 	ptr link
			as WikiToken_Indent	ptr indent
			as WikiToken_Indent	ptr list
			as WikiToken_Indent	ptr header
			as WikiToken_Code   ptr code
		end union

		declare property id () as WIKI_TOKEN
		declare property id ( byval new_value as WIKI_TOKEN )

		declare operator let( byref other as WikiToken )
		declare operator cast() as string

	end type

	type WikiPageLink
		as string         text
		as WikiToken_Link link
		as integer        level
	end type

		
	type CWikiCtx as CWikiCtx_

	type CWiki

		declare constructor _
			( _
			)

		declare destructor _
			( _
			)

		declare function Parse _
			( _
				byval pagename as zstring ptr, _
				byval body as zstring ptr _
			) as integer

		declare function MoveFirst() as WikiToken ptr

		declare function MoveLast() as WikiToken ptr

		declare function MoveNext() as WikiToken ptr

		declare function MovePrevious() as WikiToken ptr

		declare function GetCurrent() as WikiToken ptr

		declare function Insert _
			( _
				byval body as zstring ptr, _
				byval token as WikiToken ptr = NULL _
			) as integer

		declare function Remove _
			( _
				byval token as WikiToken ptr = NULL _
			) as integer

		declare function Build _
			( _
			) as string

		declare sub Dump _
			( _
			)

		declare function GetTokenList _
			( _
			) as CList ptr

		declare function GetDocTocLinks _
			( _
				byval useboldlinks as integer _
			) as CList ptr

		declare function GetPageTitle _
			( _
			) as string

		declare property PageName _
			( _
			) as string

		declare property PageName _
			( _
				byref sPageName as string _
			)
			

		ctx as CWikiCtx ptr

	end type

end namespace

#endif
