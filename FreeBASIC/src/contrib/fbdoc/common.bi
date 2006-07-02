#ifndef __COMMON_BI__
#define __COMMON_BI__

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


#define NULL 0

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

const nl as string = chr(10)
const crlf as string = chr(13) + chr(10)
const cTab as string = chr(9)

declare sub ZFree( byval s as zstring ptr ptr )
declare sub ZSet( byval s as zstring ptr ptr, byval t as zstring ptr )

declare function ReplaceSubStr _
	( _
		byval src as zstring ptr, _
		byval old as zstring ptr, _
		byval rep as zstring ptr _
	) as string 

Declare Function ReplaceQuotes(a as string, q as string) As String
Declare Function StripQuotes (a as string) As String

declare function LoadFileAsString _
	( _
		byval sFileName as zstring ptr _
	) as string

declare function CapFirstLetter( a as string ) as string
declare function FormatPageTitle(a as string) as string

declare function Text2Html _
	( _
		text as string, _
		byval br as integer = FALSE, _
		byval sp as integer = FALSE _
	) as string

#endif
