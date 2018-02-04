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
function ReadIndex( byref f as string ) as integer
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
sub DeleteExtraFiles _
	( _
		byref path as string, _
		byval isgit as integer, _
		byval nodelete as integer _
	)

	dim d as string, i as integer
	d = dir( path + "*.wakka" )
	while( d > "" )
		if( filehash.test( lcase(d) ) = FALSE ) then
			dim n as string = ReplacePathChar( path + d, asc("/") )
			if( isgit ) then
				print "Removing '" + n + "'"
				if( nodelete = FALSE ) then
					shell !"git rm \"" + n + !"\""
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

end sub

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

'' from cmd_opts.bas
extern cmd_opt_help as boolean
extern cache_dir as string

'' private options
dim isgit as boolean = false
dim nodelete as boolean = false

'' enable cache
cmd_opts_init( CMD_OPTS_ENABLE_CACHE )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-git"
			isgit = TRUE
		case "-n"
			nodelete = TRUE
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

DeleteExtraFiles( cache_dir, isgit, nodelete )
