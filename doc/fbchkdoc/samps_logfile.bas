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

'' samps_logfile.bas - manage wiki example source files

'' chng: written [jeffm]

'' fbchkdoc headers
#include once "samps_logfile.bi"

dim shared logfileH as integer = 0

''
sub logopen()
	logfileH = freefile
	open "results.txt" for output as #logfileH
end sub

''
sub logprint( byref txt as string = "", byval bContinue as integer = FALSE )
	if( bContinue ) then
		print txt;
		if logfileH <> 0 then
			print #logfileH, txt;
		end if
	else
		print txt
		if logfileH <> 0 then
			print #logfileH, txt
		end if
	end if
end sub

''
sub logclose()
	if logfileH <> 0 then
		close #logfileH
	end if
	logfileH = 0
end sub
