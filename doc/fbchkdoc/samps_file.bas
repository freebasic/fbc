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

'' samps_file.bas - manage wiki example source files

'' chng: written [jeffm]

'' fb headers
#include once "dir.bi"

'' fbchkdoc headers
#include once "buffer.bi"
#include once "funcs.bi"
#include once "samps_file.bi"
#include once "samps_logfile.bi"

''
function GetRefID( byref b as buffer ) as string

	dim i as integer, j as integer
	dim refid as string = ""
	dim magic as string = "$$REF:"

	for i = 1 to b.count
		j = instr( b.item(i), magic )
		if( j > 0 ) then
			refid = trim(mid( b.item(i), j + len(magic) ))
			exit for
		end if
	next

	function = refid

end function

''
function GetPageID( byref b as buffer ) as string

	dim i as integer, j as integer
	dim refid as string = ""
	dim magic as string = "wikka.php?wakka="

	for i = 1 to b.count
		j = instr( b.item(i), magic )
		if( j > 0 ) then
			refid = trim(mid( b.item(i), j + len(magic) ))
			exit for
		end if
	next

	function = refid

end function

''
sub SplitRefID( byref refid as string, byref pagename as string, byref codeid as integer )
	dim i as integer, n as string

	pagename = ""
	codeid = -1

	i = instr( refid, "." )
	if( i > 0 ) then
		n = left( refid, i - 1 )
	else
		n = refid
	end if

	i = instr( n, "_" )
	if( i > 0 ) then
		pagename = left( n, i - 1 )
		codeid = val( mid( n, i + 1 ))
	else
		pagename = n
		codeid = 0
	end if
end sub

''
sub RewriteFileEOL( byref path as string, byref filename as string, byref eol as string )
	
	dim x as string, b as buffer
	x = ReadFileAsText( path & filename )
	b.text = x
	x = b.gettext( eol )
	WriteFileAsText( path & filename, x, TRUE )

end sub

''
function ReadExampleFile( byref path as string, byref filename as string, byval skipheader as integer, byval bQuiet as integer ) as string

	dim text as string

	text = ReadFileAsText( path & filename )
	if( text > "" ) then
		if( skipheader ) then
			dim b as buffer, i as integer, j as integer
			b.text = text
			for i = 1 to b.count
				if( left( b.item(i), 11 ) = "'' --------" ) then
					for j = 1 to i
						b.remove(1)
						text = b.text
					next
					exit for
				end if
			next
		end if
	else
		if( bQuiet = FALSE ) then
			logprint "Error while reading '" & path & filename & "'"
		end if
	end if

	function = text

end function

''
function WriteExampleFile _
	( _
		byref sPage as string, _
		byref path as string, _
		byref filename as string, _
		byref text as string, _
		byval CompareFirst as integer, _
		byref RefID as string, _
		byval force as boolean, _
		byref title as string _
	) as integer
	
	dim x as string, b as buffer, idx as integer, text2 as string, b2 as buffer

	function = FALSE

	if( right(filename,4) = ".bas" or right(filename,3) = ".bi" ) then
		b.text = FormatFbCode(text)
	else
		b.text = text
	end if

	if( b.item(1) <> "" ) then
		b.insert( 1, "" ) 
	end if

	text2 = ReadExampleFile( path, filename, TRUE, TRUE )
	if( text2 > "" ) then
		b2.text = text2
		if( CompareFirst <> FALSE ) then
			if( CompareBuffersEqual( b, b2 )) then
				'' logprint "SKIPPED: " & filename & " is up to date"
				if( force = false ) then
					exit function
				end if
			end if
		end if
	end if

	idx = 1
	idx = b.insert( idx, "'' " & filename )
	if( RefID > "" ) then
		idx = b.insert( idx, "'' $$REF:" & RefID )
	end if
	idx = b.insert( idx, "''" )
	idx = b.insert( idx, "'' Example extracted from the FreeBASIC Manual" )
	idx = b.insert( idx, "'' from topic '" & title & "'" )
	idx = b.insert( idx, "''" )
	idx = b.insert( idx, "'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=" & sPage )
	idx = b.insert( idx, "'' --------" )

	x = b.text_crlf()

	dim p as string, i as integer, j as integer = 1
	i = instr( j, filename, "/" )
	while( i > 0 )

		p = path & left( filename, i - 1 )

		if( dir( p, fbDirectory ) = "" ) then
			logprint "Making '" & p & "'"
			mkdir p
		end if

		j = i + 1
		i = instr( j, filename, "/" )
	wend

	logprint "Writing '" & path & filename & "'"
	if( WriteFileAsText( path & filename, x, TRUE ) = FALSE ) then
		logprint "Error while writing '" & path & filename & "'"
	else
		function = TRUE
	end if
	
end function

''
function CompareBuffersEqual( byref b1 as buffer, byref b2 as buffer ) as integer

	dim i as integer

	function = TRUE

	if( b1.count <> b2.count ) then
		function = FALSE
	else
		for i = 1 to b1.count
			if( lcase(b1.item(i)) <> lcase(b2.item(i)) ) then
				function = FALSE
				exit for
			end if
		next
	end if

end function
