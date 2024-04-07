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

'' funcs.bas - common functions

'' chng: written [jeffm]

'' fbchkdoc headers
#include once "funcs.bi"

const alpha = "_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
const numer = "0123456789"

''
private function FilterIn( byref s as string, filter as string ) as string
	dim ret as string
	for i as integer = 1 to len(s)
		if( instr( filter, mid(s,i,1) ) > 0 ) then
			ret += mid(s,i,1)
		end if
	next
	return ret
end function

''
private function CheckForRevisionAndPage( byref x as string, byref revision as long ) as string

	dim i as integer
	dim tmp as string
	dim rev as long

	i = instr( x, any " " + chr(9) )
	if( i > 0 ) then

		'' check for numbers
		tmp = left( x, i - 1 )

		if( FilterIn( tmp, numer ) = tmp ) then
			rev = clng(tmp)

			'' check for alphanumeric
			tmp = trim( mid( x, i ), any " " + chr(9) )

			if( FilterIn( tmp, numer+alpha) = tmp ) then
				revision = rev
				return tmp
			end if
		end if
	end if

	return ""

end function

''
function ParsePageName( byref x as string, byref comment as string, byref revision as long ) as string

	'' Line Format expected:
	''
	''    # comment line
	''    DocToc
	''    <revision> DocToc
	''    (10:05 EDT) [history] -  DocToc ? JeffMarshall [updated]
	''    14:24 UTC [26061] [history] -  DocToc ? JeffMarshall [updated]

	dim as string r, tmp
	dim as integer i, j
	dim as string cmt = ""
	dim as long rev

	r = trim( x, any " " + chr(9) )

	'' comment line?
	if( left( r, 1 ) = "#" ) then
		revision = 0
		comment = ""
		return ""
	end if

	'' Check for: {name}
	if( FilterIn( r, numer+alpha ) = tmp ) then
		revision = 0
		comment = ""
		return r
	end if

	'' Check for: {number} . ' '+ . {name}
	tmp = CheckForRevisionAndPage( r, rev )
	if( tmp > "" ) then
		revision = rev
		comment = ""
		return tmp
	end if

	'' Check for formats that may have been copy / pasted from the HTML page in to an editor

	'' Check for: (.*) '[' . {number} . ']' (.*) '-' {name} (.*) '[' . {comment} . ']'
	scope
		dim as integer b1, b2, d1, n1, b3, b4
		b1 = instr( r, "[" )
		if( b1 > 0 ) then
			b2 = instr( b1+1, r, "]" )
			if( b2 > 0 ) then
				d1 = instr( b2+1, r, "-" )
				if( d1 > 0 ) then
					rev = clng( mid( r, b1+1,b2-b1-1 ) )
				else
					rev = 0
				end if
			end if
		end if
		d1 = instr( r, "-" )
		if( d1 > 0 ) then
			n1 = instr( d1+1, r, " " + chr(9) + "().-[],?:;" )
			if( n1 > 0 ) then
				b3 = instr( n1, r, "[" )
				if( b3 > 0 ) then
					b4 = instr( n1, r, "]" )
					if( b4 > 0 ) then
						cmt = trim( mid( r, b3+1, b4-b3-1 ), any " " + chr(9) )
					end if
				end if
			else
				n1 = len(r)+1
			end if
			tmp = trim( mid( r, d1+1, n1-d1-2 ), any " " + chr(9) )
			if( FilterIn( tmp, numer+alpha ) = tmp ) then
				return tmp
			end if
		end if
	end scope

	'' Check for other old formats - probably don't work or are not needed
	'' !!! TODO : clean-up / remove

	'' any symbols or whitespace?
	if( instr( r, any " " + chr(9) + "().-[],?:;" ) > 0 ) then
		i = instr(r, "-" )
	
		'' was there a dash? it was probably copied/pasted from webpage
		if( i > 0 ) then
			j = instr(i + 1, r, "?")
			if( j > 0 ) then
				tmp = trim( mid( r, i + 1) , any " " + chr(9) )
				r = trim( mid( r, i + 1, j - i - 1) , any " " + chr(9) )

				i = instr( tmp, "[" )
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

	revision = 0
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
