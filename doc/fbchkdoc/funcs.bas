''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008-2019 Jeffery R. Marshall (coder[at]execulink[dot]com)
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

'' funcs.bas - common functions

'' chng: written [jeffm]

'' fbchkdoc headers
#include once "funcs.bi"

''
function ParsePageName( byref x as string, byref comment as string ) as string

	dim as string r, tmp
	dim as integer i, j
	dim as string cmt = ""

	r = trim( x, any " " + chr(9) )

	if( instr( r, any " " + chr(9) + "().-[],?:;" ) > 0 ) then
		i = instr(r, "-" )
	
		if( i > 0 ) then
			j = instr(i + 1, r, "?")
			if( j > 0 ) then
				tmp = trim( mid( r, i + 1) , any " " + chr(9) )
				r = trim( mid( r, i + 1, j - i - 1) , any " " + chr(9) )

				i = instr( i + 1, tmp, "[" )
				if( i > 0 ) then
					cmt = mid( tmp, i + 1 )
					if( right( cmt, 1 ) = "]" ) then
						cmt = left( cmt, len(cmt) - 1 )
					end if
				end if
			else
				r = ""
			end if

		else
			if( right(r, 1) <> ":" ) then
				i = instr( x, chr(9) )
				if( i > 0 ) then
					r = left(x, i - 1 )
				end if
			else
				r = ""
			end if
		end if

	end if

	comment = cmt
	return r

end function

''
function ReplacePathChar( byref a as string, byval ch as integer ) as string
	dim x as string, i as integer
	x = a
	for i = 0 to len(x) - 1
		if( (x[i] = asc("\")) or (x[i] = asc("/"))) then
			x[i] = ch
		end if
	next
	function = x
end function

''
function GetUrlFileName( byref url as string ) as string
	dim i as integer
	function = ""
	for i = len( url ) to 1 step - 1
		select case mid( url, i, 1 )
		case "/", "\"
			function = trim(mid(url,i+1))
			exit for
		end select
	next
end function
