''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006-2021 Jeffery R. Marshall (coder[at]execulink.com)

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

enum OPTIONS
	opt_INVALID = 1
	opt_HELP = 2
	opt_BLUE = 4
	opt_BW = 8
	opt_VERSION = 16
end enum

'' ============================
'' MAIN
'' ============================

	dim as string pexepath, filename, filenamez
	dim as integer i, bAddNL = FALSE, ret = 0
	dim as integer opt = 0

	i = 1
	while( len( command(i) ) > 0 )
		select case lcase(command(i))
		case "-help", "-h", "/help", "/h", "/?"
			opt or= opt_HELP
		case "-bw", "/bw"
			opt or= opt_BW
			opt and= (not opt_BLUE)
			Screen_SetColorMode( FALSE )
			DEFAULT_BACKCOLOR = 0
		case "-blue", "/blue"
			if((  opt and opt_BW ) = 0 ) then
				'' Blue background
				DEFAULT_BACKCOLOR = 1
			end if
		case "-version", "/version"
			opt or= opt_VERSION
		case else
			? "Invalid option '" + command(i) + "'"
			opt or= opt_INVALID
			ret = 1
			exit while
		end select
		i += 1
	wend

	if( ( opt and ( opt_HELP or opt_VERSION or opt_INVALID )) <> 0 ) then

		if( opt and opt_INVALID ) then
			? "Use '" + APP_NAME + " " + opt_char + "help' for options"
			bAddNL = TRUE
		end if

		if( opt and opt_HELP ) then
			if( bAddNL ) then
				?
			end if
			? "Usage: " + APP_NAME + " [options]"
			?
			? "options:"
			? "   " + opt_char + "h " + opt_char + "help      this help page"
			? "   " + opt_char + "blue         use blue back ground"
			? "   " + opt_char + "bw           black and white only"
			? "   " + opt_char + "version      display version"
			bAddNL = TRUE
		end if

		if( opt and opt_VERSION ) then
			if( bAddNL ) then
				?
			end if
			? APP_NAME + " - Version " + APP_VERSION + " for " + APP_TARGET
			? APP_COPYRIGHT
			? "Last built on " + __DATE__ + " " + __TIME__
			? "Please report bugs to " + APP_CONTACT
			bAddNL = TRUE
		end if

		end ret

	end if

	pexepath = FixPath( exepath )
	filename = pExePath + "fbhelp.dat"

	if( HelpFile_Open( filename, TRUE ) = FALSE ) then

		filename = pExePath + "fbhelp.daz"

		if( HelpFile_Open( filename, FALSE ) = FALSE ) then

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
