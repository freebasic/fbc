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

'' rebuild.bas - read wakka files, parse, and write back

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWiki.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"

'' libs
#inclib "fbdoc"
#inclib "pcre"

using fb
using fbdoc

'' --------------------------------------------------------

'':::::
function ReadTextFile( byref sFile as string ) as string
	'' !!!TODO!!! refactor
	return ReadFileAsText( sFile )
end function

'':::::
sub WriteTextFile( byref sFile as string, byref text as string )
	'' !!!TODO!!! refactor
	WriteFileAsText( sFile, text, TRUE )
end sub


'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

'' enable url and cache
cmd_opts_init( CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_AUTOCACHE or CMD_OPTS_ENABLE_PAGELIST )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		cmd_opts_unrecognized_die( i )
	else
		cmd_opts_unexpected_die( i )
	end if
	i += 1
wend	

if( app_opt.help ) then
	print "rebuild [pages] [@pagelist] [options]"
	print
	cmd_opts_show_help( "rebuild files in" )
	print
	end 0
end if

cmd_opts_resolve()
cmd_opts_check_cache()
cmd_opts_check_url()

'' no pages? nothing to do...
if( app_opt.pageCount = 0 ) then
	print "no pages specified."
	end 1
end if

'' --------------------------------------------------------

dim as string sPage, sBody1, sBody2, f
dim as CWiki ptr wiki

print "cache: "; app_opt.cache_dir

for i = 1 to app_opt.pageCount

	wiki = new CWiki

	sPage = app_opt.pageList(i)

	f = app_opt.cache_dir + sPage + ".wakka"
	sBody1 = ReadTextFile( f )

	wiki->Parse( sPage, sBody1 )
	sBody2 = ""
	sBody2 = wiki->Build()

	f = app_opt.cache_dir + sPage + ".wakka"
	if( sBody1 <> sBody2 ) then
		print "Rewriting '" + sPage + "'"
		WriteTextFile( f, sBody2 )
	end if

	delete wiki

next
