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


'' fbdoc_string - string related functions
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "fbdoc_keywords.bi"

namespace fb.fbdoc

	'':::::
	sub ZFree( byval s as zstring ptr ptr )
		if( s ) then
			if( *s ) then
				deallocate *s
			end if
			*s = NULL
		end if
	end sub

	'':::::
	sub ZSet( byval s as zstring ptr ptr, byval t as zstring ptr )
		if( s ) then
			ZFree s
			if( t ) then
				*s = allocate( len( *t ) + 1 )
				**s = *t
			end if
		end if
	end sub

	'':::::
	function ReplaceSubStr _
		( _
			byval src as zstring ptr, _
			byval old as zstring ptr, _
			byval rep as zstring ptr _
		) as string 

	   dim i as integer = 1, ret as string 
	   ret = *src 
	   do 
		  i = instr(i, ret, *old) 
		  if i = 0 then exit do 
		  ret = left(ret, i - 1) + *rep + mid(ret, i + len(*old)) 
		  i += len(*rep) 
	   loop 
	   return ret 
	end function

	'':::::
	function ReplaceQuotes(byref a as string, byref q as string) As String

		dim b as string, bOK as integer
		if len(a) >= 2 then
			if left(a, 1) = """" and right(a, 1) = """" then
				bok = true
			elseif left(a, 1) = "'" and right(a, 1) = "'" then
				bok = true
			elseif left(a, 1) = "`" and right(a, 1) = "'" then
				bok = true
			end if
			if bok then
				b = mid(a, 2, len(a) - 2)
			else
				b = a
			end if
		else
			b = a
		end if

		select case left(q, 1)
		case ""
		case """"
			b = """" & b & """"
		case "'"
			b = "'" & b & "'"
		case "`"
			b = "`" & b & "'"
		case else
			b = left(q, 1) & b & right(q, 1)
		end select

		replacequotes = b

	end function

	'':::::
	function StripQuotes (byref a As String) As String
		return ReplaceQuotes(a, "")
	end function

	'':::::
	function LoadFileAsString _
		( _
			byval sFileName as zstring ptr _
		) as string

		if( sFileName = NULL ) then	
			return ""
		end if

		if( len(*sFileName) = 0 ) then
			return ""
		end if

		dim as integer h, bytes
		dim as string sData

		h = freefile
		if( open( *sFileName for input as #h ) = 0 ) then
			close #h

			if( open( *sFileName for binary as #h ) = 0 ) then

				bytes = lof( h ) 
				if( bytes > 0 ) then
					sData = space( bytes )
					get #h,,sData
				else
					sData = ""
				end if
			
				close #h

				return sData
		
			end if

		end if

		return ""

	end function

	'':::::
	function CapFirstLetter( byref a as string ) as string
		return ucase(left(trim(a),1)) + lcase(mid(trim(a),2))
	end function

	'':::::
	function UnescapeHtml _
		( _
			byref celltext as const string _
		) as string

		'' Unescape HTML-like codes (eg &amp, &#...) which may be
		'' found in {{table}} blocks.  Note that the ';' terminator is optional for backward compatibility.
		dim as string HtmlCodes(0 to ...) = { "amp", "&", "quot", """", "lt", "<", "gt", ">" }

		dim i as integer = 1, ret as string
		dim j as integer
		ret = celltext
		do

			i = instr(i, ret, "&") 
			if i = 0 then exit do

			if( asc( ret , i + 1 ) = asc( "#" ) ) then
				dim as integer j = i + 2
				dim as integer c = 0
				do
					select case asc( ret, j )
					case asc("0") to asc("9")
						if( c <= 255 ) then c = c * 10 + asc( ret, j ) - asc("0")
					case else
						exit do
					end select
					j += 1
				loop
				if( c > 0 and c <= 255 ) then
					if( mid( ret, j, 1) = ";" ) then j += 1
					ret = left(ret, i - 1) + chr(c) + mid(ret, j)
				end if
			else
				for q as integer = 0 to ubound(HtmlCodes) step 2
					if( mid( ret, i + 1, len( HtmlCodes(q) )) = HtmlCodes(q) ) then
						j = i + len( HtmlCodes(q) ) + 1
						if( mid( ret, j, 1) = ";" ) then j += 1
						ret = left(ret, i - 1) + HtmlCodes(q+1) + mid(ret, j)
						i += len( HtmlCodes(q+1) ) - 1
						exit for
					end if
				next
			end if

			i += 1
		loop

		'' new string should not be longer
		'' (it may be written inline into a contiguous region of zstring data)
		assert( len( ret ) <= len( celltext ) )

		return ret

	end function

	'':::::
	function Text2Html _
		( _
			byref text as string, _
			byval br as integer, _
			byval sp as integer _
		) as string
		
		dim as string res
		dim as integer i
		dim as integer lastcr
		dim as string HtmlCodes(0 to ...) = { "amp", "&", "quot", """", "lt", "<", "gt", ">" }

		res = ""
		lastcr = FALSE

		for i = 1 to len(text)
			select case mid( text, i, 1)
			case " ", chr(9)
				if( sp ) then
					res += "&nbsp;"
				else
					res += mid( text, i, 1)
				end if
			case chr(13)
				if( br ) then
					res += "<br />"
				else
					res += mid( text, i, 1)
				end if
			case chr(10)
				if( br ) then
					if( lastcr = FALSE ) then
						res += "<br />"
					end if
				end if
				res += mid( text, i, 1)
			case else
				for q as integer = 1 to ubound(HtmlCodes) step 2
					if( mid( text, i, 1) = HtmlCodes(q) ) then
						res += "&" + HtmlCodes(q-1) + ";"
						exit select
					end if
				next
				res += mid( text, i, 1)
			end select

			if( mid( text, i, 1) = chr(13) ) then
				lastcr = TRUE
			else
				lastcr = FALSE
			end if
		next

		return res

	end function

	'':::::
	function Text2Texinfo _
		( _
			byref text as string, _
			byval br as integer, _
			byval sp as integer _
		) as string
		
		dim as string res
		dim as integer i
		dim as integer lastcr

		res = ""
		lastcr = FALSE

		for i = 1 to len(text)
			select case mid( text, i, 1)
			case " ", chr(9)
				if( sp ) then
					res += "@ "
				else
					res += mid( text, i, 1)
				end if
			case "#"
				res += "@pounds{}"
			case "{"
				res += "@{"
			case "}"
				res += "@}"
			case "@"
				res += "@@"
			case ":"
				res += "@:"
			case chr(13)
				if( br ) then
					res += "@*"
				else
					res += mid( text, i, 1)
				end if
			case chr(10)
				if( br ) then
					if( lastcr = FALSE ) then
						res += "@*"
					end if
				end if
				res += mid( text, i, 1)
			case else
				res += mid( text, i, 1)
			end select

			if( mid( text, i, 1) = chr(13) ) then
				lastcr = TRUE
			else
				lastcr = FALSE
			end if
		next

		return res

	end function

	'':::::
	function GetBaseName _
		( _
			byref filename as string _
		) as string

		dim i as integer = any

		function = filename

		for i = len( filename ) to 1 step -1
			select case mid( filename, i, 1 )
			case "/", "\"
				function = mid( filename, i + 1 )
				exit for
			end select
		next

	end function

end namespace
