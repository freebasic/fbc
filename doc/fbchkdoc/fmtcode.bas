''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008-2022 Jeffery R. Marshall (coder[at]execulink[dot]com)
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

'' fmtcode.bas - FreeBASIC code formatter

'' chng: written [jeffm]

'' fbchkdoc headers
#include once "funcs.bi"

#include once "CFbCode.bi"
#include once "fbdoc_string.bi"
#include once "fbdoc_keywords.bi"
#include once "fbchkdoc.bi"

declare function _LookUpAttrib( byval attrib as integer ) as integer
declare function _emitCode ( byref text as string ) as string

using fb.fbdoc

'':::::
private function _LookUpAttrib( byval attrib as integer ) as integer

	static attribs(0 to 15) as integer = _
		{ _
			 7, _ '' ATTRIB_DEFAULT
			15, _ '' ATTRIB_BOLD
			10, _ '' ATTRIB_LINK
			 5, _ '' ATTRIB_3
			 5, _ '' ATTRIB_4
			 5, _ '' ATTRIB_5
			 5, _ '' ATTRIB_6
			 5, _ '' ATTRIB_7
			 7, _ '' ATTRIB_WHITE_SPACE
			 8, _ '' ATTRIB_COMMENT
			10, _ '' ATTRIB_QUOTED
			12, _ '' ATTRIB_NUMBER
			14, _ '' ATTRIB_KEYWORD
			10, _ '' ATTRIB_DEFINE
			 7, _ '' ATTRIB_NAME
			 7  _ '' ATTRIB_OTHER 
		} 

	return( attribs( attrib and &hf ) )

end function

type fbcode_item_t
	id as integer
	attrib as integer
	grpno as integer
end type

'':::::
private function _emitCode ( byref text as string ) as string

	dim as FbToken ptr token
	dim as any ptr token_i
	dim as string txt, kw

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

	dim as CFbCode ptr fbcode = new CFbCode

	fbcode->Parse( text )

	token = fbcode->NewEnum( @token_i )
	while( token )

		if( token->id = FB_TOKEN_NULL ) then
			exit while
		end if

		'' color _LookUpAttrib( AttribTb( token->id ).attrib )

		select case token->id
		case FB_TOKEN_NULL	
			exit while

		case FB_TOKEN_SPACE
			''token->text = ReplaceSubStr( token->text, chr(9), space(3) )
			txt &= token->text

		case FB_TOKEN_KEYWORD
			kw = fbdoc_FindKeyword( token->text )
			if( kw > "" ) then
				txt &= kw
			else
				txt &= ucase(left(token->text,1)) & lcase( mid(token->text,2))
			end if



		case FB_TOKEN_NEWLINE
			txt &= chr(10)

		case else
			txt &= token->text

		end select

		token = fbcode->NextEnum( @token_i )
	wend

	'' txt &= chr(10)

	delete fbcode

	function = txt

end function

''
function FormatFbCodeLoadKeywords( byref filename as string ) as boolean

	static kw_loaded as integer = FALSE

	if( kw_loaded = FALSE ) then
		'' Load the keywords, this will allow keywords to be cased.

		if( filename = "" ) then
			filename = hardcoded.default_manual_dir + "templates/default/keywords.lst"
		end if
		function = ( fbdoc_loadkeywords( filename ) <> 0 )

		kw_loaded = TRUE

	end if

end function

'' main entry point
function FormatFbCode( byref txt as string ) as string

	function = _emitCode( txt )

end function

