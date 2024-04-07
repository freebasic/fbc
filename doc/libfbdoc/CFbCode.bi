#ifndef __CFBCODE_BI__
#define __CFBCODE_BI__

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

namespace fb.fbdoc

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

	type CFbCodeCtx as CFbCodeCtx_

	type FbToken
		as integer              id         '' FB_TOKEN
		as string               text
		as integer              flags
	end type

	const FBTOKEN_FLAGS_NONE = 0
	const FBTOKEN_FLAGS_DEFINE = 1

	type CFbCode

		declare constructor _
			( _
			)

		declare destructor _
			( _
			)

		declare function Parse _
			( _
				byval text as zstring ptr _
			) as integer

		declare function ParseLines _
			( _
				byval text as zstring ptr _
			) as integer

		declare function NewEnum _
			( _
				byval _iter as any ptr ptr _
			) as FbToken ptr

		declare function NextEnum _
			( _
				byval _iter as any ptr ptr _
			) as FbToken ptr

		ctx as CFbCodeCtx ptr

	end type

end namespace

#endif