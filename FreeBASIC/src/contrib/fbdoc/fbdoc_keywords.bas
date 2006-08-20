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


'' fbdoc_keywords.bas - lookup for FreeBASIC keywords
''
'' chng: jun/2006 written [coderJeff]
''

#include once "common.bi"

dim shared keyworddata as string
dim shared keywords(0 to 1000) as zstring ptr

function fbdoc_FindKeyword _
	( _
		byval text as zstring ptr _
	) as string

	dim as integer i
	dim as zstring ptr k
	dim as string c, suffix

	if( text = NULL ) then
		return ""
	end if

	if( len(*text) = 0 ) then
		return ""
	end if

	i = 0
	suffix = ""
	c = *text

	if( instr("$%&!#", right( c, 1 )) > 0 ) then
		suffix = right(c, 1)
		c = left( c, len(c) - 1)
	end if

	if( len(c) = 0 ) then
		return ""
	end if

	c = lcase(c)
	
	k = keywords( i )
	while( k )

		if( c = lcase( *k ) ) then
			return *k + suffix
		end if
	
		i += 1
		k = keywords( i )

	wend

	return ""
	
end function

function fbdoc_loadkeywords _
	( _
		byval sFilename as zstring ptr _
	) as integer

	keyworddata = LoadFileAsString( sFileName )

	dim as integer n, b
	dim as ubyte ptr p

	n = 0
	b = FALSE

	p = StrPtr( keyworddata )

	while( *p )

		if( *p < 32 ) then

			b = FALSE
			*p = 0

		else

			if( b = FALSE ) then
				keywords( n ) = p
				n += 1
				b = TRUE		
			end if

		end if
		
		p += 1
	wend

	keywords( n ) = NULL

	return n

end function
