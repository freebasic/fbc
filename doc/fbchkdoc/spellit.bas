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

'' spellit.bas - checks spelling of individual words

'' chng: written [jeffm]

#include once "spellcheck.bi"
#inclib "funcs"

''
function DoCheck( byref x as string ) as integer
	if( SpellCheck_Word( x ) ) then
		print
		print "'" + x + "' is correct"
		function = 0
	else
		dim as integer n = SpellCheck_GetWordCount()
		print
		print "Suggestions for '" + x + "':"
		print
		for i as integer = 0 to n - 1
			print SpellCheck_GetWord(i),
		next
		print
		function = 1
	end if
end function

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

dim as integer i = 1, wrong = 0, ret = 0
dim as string x

SpellCheck_Init( "en_US" )

if( command(i) = "" ) then
	do
		print
		input "Enter word : ", x
		x = trim(x)
		if( x = "" ) then	
			exit do
		end if
		DoCheck( x )
	loop
	ret = 0
else
	while( command(i) > "" )
		wrong += DoCheck( command(i) )
		i += 1
	wend
	ret = wrong
end if

SpellCheck_Exit()

end ret
