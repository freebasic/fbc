#ifndef __CFBCODE_BI__
#define __CFBCODE_BI__

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

enum FB_TOKEN
	FB_TOKEN_NULL
	FB_TOKEN_SPACE
	FB_TOKEN_NEWLINE
	FB_TOKEN_COMMENT
	FB_TOKEN_QUOTED
	FB_TOKEN_NUMBER
	FB_TOKEN_KEYWORD
	FB_TOKEN_DEFINE
	FB_TOKEN_NAME
	FB_TOKEN_OTHER
	FB_TOKENS
end enum

type CFbCode as CFbCode_

type FbToken
	as any ptr				ll_prev
	as any ptr				ll_next
	as integer id     '' FB_TOKEN
	as string text
end type

declare function CFbCode_New _
	( _
		byval _this as CFbCode ptr = NULL _
	) as CFbCode ptr

declare sub CFbCode_Delete _
	( _
		byval _this as CFbCode ptr, _
		byval isstatic as integer = FALSE _
	)

declare function CFbCode_Parse _
	( _
		byval _this as CFbCode ptr, _
		byval text as zstring ptr _
	) as integer

declare function CFbCode_NewEnum _
	( _
		byval _this as CFbCode ptr, _
		byval _iter as any ptr ptr _
	) as FbToken ptr

declare function CFbCode_NextEnum _
	( _
		byval _iter as any ptr ptr _
	) as FbToken ptr

#endif