''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006 Jeffery R. Marshall (coder[at]execulink.com)

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

'' chng: jul/2006 written [coderJeff]

#include once "common.bi"
#include once "fbhelp_screen.bi"
#include once "fbhelp_controls.bi"
#include once "fbhelp_file.bi"

declare sub HelpScreen_Show ( byval pexepath as zstring ptr )

'' ============================
'' MAIN
'' ============================

	dim as string pexepath, filename, filenamez
	dim i as integer

	i = 1
	while( len( command(i) ) > 0 )
		if( lcase(command(i)) = "/bw" ) then
			Screen_SetColorMode( FALSE )
		end if
		i += 1
	wend

	pexepath = FixPath( exepath )
	filename = pExePath + "fbhelp.dat"

	if( HelpFile_Open( filename ) = FALSE ) then

		filename = pExePath + "fbhelp.daz"

		if( HelpFile_Open( filename ) = FALSE ) then

			print "unable to open help file"
			end 1
		
		end if

	end if

	Screen_Init

	HelpScreen_Show( pexepath )

	Screen_Shut

	HelpFile_Close

	end 0

'' ============================

'' EOF
