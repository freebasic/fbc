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

'' insert.bas - one-off utility to insert the "version" section on a page

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

const VERSIONFILE = "page-versions.txt"

function ReadMinVersion( byref sPage as const string ) as string
	'' history.txt requires the following format:
	'' page names, one per line followed by a space and version number
	'' Example:
	'' 
	'' CompilerOptentry  1090
	'' CompilerOptearray  1070
	'' CompilerOpteassert  1070

	dim h as integer = freefile
	function = ""
	if( open( VERSIONFILE for input access read as #h ) <> 0 ) then
		exit function
	end if
	while not eof( h )
		dim x as string
		line input #h, x
		dim i as integer = instr( x, " " )
		if( i > 0 ) then
			dim n as string = trim(left(x,i-1))
			dim v as string = right( "0000" & trim(mid(x,i+1)), 4)
			if( lcase(n) = lcase(sPage) ) then
				dim ver as string = left(v,1) & "." & mid(v,2,2) & "." & right(v,1)
				function = ver
				exit while
			end if
		end if
	wend
	close #1
end function

sub insertVersionSection( byref sPage as const string, byval wiki as CWiki ptr )

	dim token as WikiToken ptr
	dim as string sItem, sValue

	token = wiki->GetTokenList()->GetHead()

	do while( token <> NULL )

		select case as const token->id
		case WIKI_TOKEN_ACTION

			if lcase(token->action->name) = "fbdoc" then

				sItem = token->action->GetParam( "item")

				select case lcase(sItem)
				case "ver"
					'' already have as version section? do nothing
					exit sub
				case "diff", "lang", "target", "see", "back"
					exit do
				end select
			end if
			
		end select
		
		token = wiki->GetTokenList()->GetNext( token )
	loop

	'' found a place to insert?
	if( token <> NULL ) then
		dim ver as string = ReadMinVersion( sPage )
		if( ver > "" ) then
			'' only
			if( ver > "1.00.0" ) then
				dim as string sBody = "{{fbdoc item=""ver""}}" & chr(10) & chr(9) & "- Since fbc " & ver & chr(10, 10)
				wiki->Insert( sBody, token )
			end if
		else
			print "Error on '" & sPage & "'"
		end if
	end if

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
	print "insert [pages] [@pagelist] [options]"
	print
	cmd_opts_show_help( "insert section(s) in" )
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

	'' only process KeyPg's
	'' TODO: add a page name filer?
	if( lcase(left(sPage,5)) <> "keypg" ) then
		continue for
	end if

	f = app_opt.cache_dir + sPage + ".wakka"
	sBody1 = ReadFileAsText( f )

	wiki->Parse( sPage, sBody1 )
	sBody2 = ""

	insertVersionSection( sPage, wiki )

	sBody2 = wiki->Build()

	f = app_opt.cache_dir + sPage + ".wakka"
	if( sBody1 <> sBody2 ) then
		print "Rewriting '" + sPage + "'"
		WriteFileAsText( f, sBody2, TRUE )
	end if

	delete wiki

next
