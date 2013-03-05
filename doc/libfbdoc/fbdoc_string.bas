''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2008 The FreeBASIC development team.
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
	Function ReplaceQuotes(byref a as string, byref q as string) As String
	  Dim b As String, bOK As integer
	  If Len(a) >= 2 Then
		If Left(a, 1) = """" And Right(a, 1) = """" Then
		  bOK = True
		ElseIf Left(a, 1) = "'" And Right(a, 1) = "'" Then
		  bOK = True
		ElseIf Left(a, 1) = "`" And Right(a, 1) = "'" Then
		  bOK = True
		End If
		If bOK Then
		  b = Mid(a, 2, Len(a) - 2)
		Else
		  b = a
		End If
	  Else
		b = a
	  End If
  
	  Select Case Left(q, 1)
	  Case ""
	  Case """"
		b = """" & b & """"
	  Case "'"
		b = "'" & b & "'"
	  Case "`"
		b = "`" & b & "'"
	  Case Else
		b = Left(q, 1) & b & Left(q, 1)
	  End Select
  
	  ReplaceQuotes = b
	End Function

	'':::::
	Function StripQuotes (byref a As String) As String
	  return ReplaceQuotes(a, "")
	End Function

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
	function CellUnescapeCodes _
		( _
			byref celltext as const string _
		) as string

		'' Unescape HTML-like codes (eg &amp, &quo, &#...) which may be
		'' found in {{table}} blocks.  Note the lack of ';' terminator.

		dim i as integer = 1, ret as string 
		ret = celltext
		do

			i = instr(i, ret, "&") 
			if i = 0 then exit do

			select case mid( ret, i + 1, 3 )
			case "amp"
				ret = left(ret, i - 1) + "&" + mid(ret, i + 3 + 1) 
				i += 3
			case "quo"
				ret = left(ret, i - 1) + """" + mid(ret, i + 3 + 1) 
				i += 3
			case else
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
						ret = left(ret, i - 1) + chr(c) + mid(ret, j)
					end if
					i = j - 1
				end if
			end select

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
			case "<"
				res += "&lt;"
			case ">"
				res += "&gt;"
			case "&"
				res += "&amp;"
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
