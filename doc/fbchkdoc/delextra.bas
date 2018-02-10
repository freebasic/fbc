''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008-2018 Jeffery R. Marshall (coder[at]execulink[dot]com)
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
#include once "COptions.bi"
#include once "hash.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"

using fb
using fbdoc

const def_index_file = hardcoded.default_index_file

dim shared pagehash as HASH
dim shared filehash as HASH

'' --------------------------------------------------------

''
sub loghtml( byref x as string, byval bNew as integer = FALSE )
	dim h as integer = freefile
	if( bNew ) then
		open "delete.html" for output as #h
	else
		open "delete.html" for append as #h
	end if
	print #h, x
	close #h
end sub

''
function ReadIndex( byref f as const string ) as boolean
	dim as string x
	dim as integer h
	h = freefile
	if( open( f for input access read as #h ) = 0 ) then
		while eof(h) = 0
			line input #h, x
			x = trim(x)
			if( len(x) > 0 ) then
				pagehash.add( x )
				filehash.add( lcase(x) + ".wakka" )
			end if
		wend
		close #h
		return TRUE
	end if
	return FALSE
end function

''
function ScanForDeleteMe _
	( _
		filename as const string _
	) as boolean

	dim sBody as string
	dim chk as string = "!!! DELETE ME !!!"

	sBody = LoadFileAsString( filename )
	if( left( ucase( ltrim( sBody, any " " & chr(9))), len( chk ) ) = chk ) then
		function = true
	else
		function = false
	end if

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

	dim d as string, i as integer
	dim remove as boolean
	dim pagename as string

	if( bHTML ) then
		loghtml( "", TRUE )
		loghtml( "<html><body>" )
	end if

	d = dir( path + "*.wakka" )
	while( d > "" )
		
		pagename = left( d, len(d) - len(".wakka") )

		if( filehash.test( lcase(d) ) = FALSE ) then
			remove = true
		elseif( ScanForDeleteMe( path + d ) ) then
			remove = true
		else
			remove = false
		end if

		if( bHTML and remove ) then
			loghtml( "<a href=""" + wiki_url + "?wakka=" + pagename + "/delete"">" + pagename + "/delete</a><br>" )
		end if

		if( remove ) then
			dim n as string = ReplacePathChar( path + d, asc("/") )
			if( isgit ) then
				print "Removing '" + n + "'"
				if( nodelete = FALSE ) then
					shell !"git -C \"" & path & !"\" rm \"" + n + !"\""
				end if
			else
				print "Deleting '" + path + d + "'"
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

'' from cmd_opts.bas
extern cmd_opt_help as boolean
extern cache_dir as string
extern wiki_url as string

'' private options
dim isgit as boolean = false
dim nodelete as boolean = false
dim doscan as boolean = false
dim bHTML as boolean = false

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
		case else
			cmd_opts_unrecognized_die( i )
		end select
	else
		cmd_opts_unexpected_die( i )
	end if
	i += 1
wend	

if( cmd_opt_help ) then
	print "delextra [options]"
	print
	print "   -n         only print what would happen but don't"
	print "                 actually delete any files"
	print "   -scan      scan page for !!! DELETE ME !!!"
	print "   -html      write delete.html helper file"
	print "   -git       use 'git rm' instead of file system delete"
	print
	print "   -web       delete extra files in cache_dir"
	print "   -web+      delete extra files in web cache_dir"
	print "   -dev       delete extra files in cache_dir"
	print "   -dev+      delete extra files in dev cache_dir"
	end 0
end if

cmd_opts_resolve()
cmd_opts_check()

'' --------------------------------------------------------

print "cache: "; cache_dir

print "Reading '" + def_index_file + "' ..."
if( ReadIndex( def_index_file ) = FALSE ) then
	print "Unable to read '" + def_index_file + "'"
	end 1
end if

DeleteExtraFiles( cache_dir, isgit, nodelete, doscan, bHTML, wiki_url )
