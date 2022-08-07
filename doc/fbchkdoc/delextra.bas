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

'' delextra.bas - delete extra files (deleted pages) from the cache directory

'' chng: written [jeffm]

'' fbdoc headers
#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "hash.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"

using fb
using fbdoc

const def_index_file = hardcoded.default_index_file
const def_recent_file = hardcoded.default_recent_file
const def_output_file = "delete.html"
const wakka_extension = "wakka"
const DELETE_ME_SENTINEL = "!!! DELETE ME !!!"

dim shared filehash as HASH

'' --------------------------------------------------------

''
sub loghtml( byref x as string, byval bNew as integer = FALSE )
	dim h as integer = freefile
	if( bNew ) then
		open def_output_file for output as #h
	else
		open def_output_file for append as #h
	end if
	print #h, x
	close #h
end sub

''
function ReadIndex( byref f as const string ) as boolean
	dim as string x
	dim as integer h = freefile
	if( open( f for input access read as #h ) = 0 ) then
		while eof(h) = 0
			line input #h, x
			x = trim(x)
			if( len(x) > 0 ) then
				filehash.add( lcase(x) + "." + wakka_extension )
			end if
		wend
		close #h
		return TRUE
	end if
	return FALSE
end function

''
function ShouldRemove _
	( _
		byref path as const string, _
		byref filename as const string, _
		byval doscan as const boolean _
	) as boolean

	if( filehash.test( lcase(filename) ) ) then
		if( doscan ) then
			dim sBody as string = LoadFileAsString( path + filename )
			return left( ucase( ltrim( sBody, any " " & chr(9))), len( DELETE_ME_SENTINEL ) ) = DELETE_ME_SENTINEL
		end if
		return false
	end if

	return true

end function

''
sub DeleteExtraFiles _
	( _
		byref path as const string, _
		byval isgit as boolean, _
		byval nodelete as boolean, _
		byval doscan as boolean, _
		byval bHTML as boolean, _
		byref wiki_url as const string _
	)

	if( bHTML ) then
		loghtml( "", TRUE )
		loghtml( "<html><body>" )
	end if

	dim d as string = dir( path + "*." + wakka_extension )
	while( d > "" )
		
		if( ShouldRemove( path, d, doscan ) ) then

			if( bHTML ) then
				dim pagename as string = left( d, len(d) - len("." + wakka_extension) )
				loghtml( "<a href=""" + wiki_url + "?wakka=" + pagename + "/delete"">" + pagename + "/delete</a><br>" )
			end if

			dim n as string = ReplacePathChar( path + d, asc("/") )
			if( isgit ) then
				print "Removing '" + n + "'"
				dim cmd as string = !"git -C \"" & path & !"\" rm \"" + n + !"\""
				if( app_opt.verbose ) then
					print "   SHELL: " & cmd
				end if
				if( nodelete = FALSE ) then
					shell cmd
				end if
			else
				print "Deleting '" + path + d + "'"
				if( app_opt.verbose ) then
					print "   KILL: " & n
				end if
				if( nodelete = FALSE ) then
					kill n
				end if
			end if
		end if

		d = dir()
	wend

	if( bHTML ) then
		loghtml( "" )
		loghtml( "</body></html>" )
	end if

end sub

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

'' private options
dim isgit as boolean = false
dim nodelete as boolean = false
dim doscan as boolean = false
dim bHTML as boolean = false
dim index_file as string
dim bUseRecent as boolean = false

index_file = def_index_file

'' enable cache
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-scan"
			doscan = true
		case "-html"
			bHTML = true
		case "-git"
			isgit = true
		case "-n"
			nodelete = true
		case "-recent"
			bUseRecent = true
			index_file = def_recent_file
		case else
			cmd_opts_unrecognized_die( i )
		end select
	else
		cmd_opts_unexpected_die( i )
	end if
	i += 1
wend	

if( app_opt.help ) then
	print "delextra [options]"
	print
	print "options:"
	cmd_opts_show_help_item( "-n", "only print what would happen but don't actually delete any files" )
	cmd_opts_show_help_item( "-scan", "scan page for " + DELETE_ME_SENTINEL )
	cmd_opts_show_help_item( "-html", "write '" + def_output_file + "' helper file" )
	cmd_opts_show_help_item( "-git", "use 'git rm' instead of file system delete" )
	cmd_opts_show_help_item( "-recent", "read from RecentChanges.txt instead of PageIndex.txt" )
	print
	cmd_opts_show_help( "delete extra files in" )
	print
	end 0
end if

cmd_opts_resolve()
cmd_opts_check_cache()
cmd_opts_check_url()

'' --------------------------------------------------------

print "cache: "; app_opt.cache_dir

print "Reading '" + index_file + "' ..."
if( ReadIndex( index_file ) = FALSE ) then
	print "Unable to read '" + index_file + "'"
	end 1
end if

DeleteExtraFiles( app_opt.cache_dir, isgit, nodelete, doscan, bHTML, app_opt.wiki_url )
