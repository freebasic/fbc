#ifndef __FBDOC_STRING_BI__
#define __FBDOC_STRING_BI__

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

	declare sub ZFree( byval s as zstring ptr ptr )
	declare sub ZSet( byval s as zstring ptr ptr, byval t as zstring ptr )

	declare function ReplaceSubStr _
		( _
			byval src as zstring ptr, _
			byval old as zstring ptr, _
			byval rep as zstring ptr _
		) as string 

	Declare Function ReplaceQuotes(byref a as string, byref q as string) As String
	Declare Function StripQuotes (byref a as string) As String

	declare function LoadFileAsString _
		( _
			byval sFileName as zstring ptr _
		) as string

	declare function CapFirstLetter( byref a as string ) as string

	declare function UnescapeHtml _
		( _
			byref celltext as const string _
		) as string

	declare function Text2Html _
		( _
			byref text as string, _
			byval br as integer = FALSE, _
			byval sp as integer = FALSE _
		) as string

	declare function Text2Texinfo _
		( _
			byref text as string, _
			byval br as integer = FALSE, _
			byval sp as integer = FALSE _
		) as string

	declare function GetBaseName _
		( _
			byref filename as string _
		) as string

end namespace

#endif
