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


'' fbdoc_keywords.bas - lookup for FreeBASIC keywords
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "hash.bi"

namespace fb.fbdoc

	dim shared keyworddata as string
	dim shared keywordhash as HASH

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
		
		k = keywordhash.getinfo( c ) 

		if( k ) then
			return *k + suffix
		end if

		return ""
		
	end function

	function fbdoc_loadkeywords _
		( _
			byval sFilename as zstring ptr _
		) as integer

		keyworddata = LoadFileAsString( sFileName )

		keywordhash.alloc( 2000 )

		if( keyworddata = "" ) then
			print "Unable to open keywords file " & *sFileName 
			return 0
		end if

		dim as integer n, b
		dim as ubyte ptr p
		dim as zstring ptr lastp

		n = 0
		b = FALSE

		p = StrPtr( keyworddata )

		while( *p )

			if( *p < 32 ) then

				b = FALSE
				*p = 0

				if( lastp ) then
					if( len(*lastp) > 0 ) then
						keywordhash.add( lcase( *lastp ), lastp )
						lastp = NULL
					end if
				end if

			else

				if( b = FALSE ) then
					lastp = p
					n += 1
					b = TRUE		
				end if

			end if
			
			p += 1
		wend

		if( lastp ) then
			if( len(*lastp) > 0 ) then
				keywordhash.add( lcase( *lastp ), lastp )
				lastp = NULL
			end if
		end if

		return n

	end function

	'':::::
	function FormatPageTitle(byref a as string) as string

		dim k as string
		k = fbdoc_FindKeyword( a )
		if( len(k) > 0 ) then
			return k
		end if

		dim as string r = a
		dim as integer i = 0, n = len(a), c = 1
		while i < n
			select case r[i]
			case asc("a") to asc("z")
				if (c) then 
					r[i] -= 32
					c = 0
				end if
			case asc("A") to asc("Z")
				if (c=0) then
					r[i] += 32
				end if
				c = 0
			case else
				c = 1
			end select
			i += 1
		wend
		function = r

	end function

end namespace
