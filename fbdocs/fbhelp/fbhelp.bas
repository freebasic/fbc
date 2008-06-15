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
#include once "fbhelp.bi"
#include once "fbhelp_screen.bi"
#include once "fbhelp_controls.bi"
#include once "fbhelp_file.bi"

declare sub HelpScreen_Show ( byval pexepath as zstring ptr )


#ifdef __FB_WIN32__
extern _CRT_glob alias "_CRT_glob" As integer
dim shared _CRT_glob As integer = 0
const opt_char = "/"
#else

#ifdef __FB_DOS__
public function __crt0_glob_function alias "__crt0_glob_function" ( byval arg as ubyte ptr ) as ubyte ptr ptr
  return 0
end function
const opt_char = "/"

#else
const opt_char = "-"


#endif
#endif

'' ============================
'' MAIN
'' ============================

	dim as string pexepath, filename, filenamez
	dim i as integer

	i = 1
	while( len( command(i) ) > 0 )
		select case lcase(command(i))
		case "-help", "-h", "/help", "/h", "/?"
			? "Usage: " + APP_NAME + " [options]
			?
			? "options:
			? "   " + opt_char + "h " + opt_char + "help      this help page"
			? "   " + opt_char + "bw           black and white only"
			? "   " + opt_char + "version      display version"
			end 0
		case "-bw", "/bw"
			Screen_SetColorMode( FALSE )
		case "-blue", "/blue"
			DEFAULT_BACKCOLOR = 1 '' Blue background
		case "-version", "/version"
			? APP_NAME + " - Version " + APP_VERSION + " for " + APP_TARGET
			? APP_COPYRIGHT
			? "Last built on " + __DATE__ + " " + __TIME__
			? "Please report bugs to " + APP_CONTACT
			end 0
		case else
			? "Invalid option '" + command(i) + "'"
			end 1
		end select
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
