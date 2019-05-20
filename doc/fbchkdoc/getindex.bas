''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008-2019 Jeffery R. Marshall (coder[at]execulink[dot]com)
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

'' getindex.bas - gets "PageIndex" from wiki and saves as "PageIndex.txt"

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWikiConUrl.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"

'' libs
#inclib "pcre"
#inclib "curl"

using fb
using fbdoc

#include "crt/stdlib.bi"
#include "crt/string.bi"

const def_index_file = hardcoded.default_index_file

'' --------------------------------------------------------

#ifdef __FB_LINUX__
extern "c"
    declare function strcasecmp(byval as const zstring ptr, byval as const zstring ptr) as long
end extern
#define _stricmp strcasecmp
#endif

''
function cmpPageName cdecl ( byval x as any ptr, byval y as any ptr ) as long
	function = _stricmp( *cast(zstring ptr ptr,x), *cast(zstring ptr ptr,y) )
end function

''
sub ScanCacheDir _
	( _
		byref p as string _
	)

	dim as string d, pages(1 to 2000)
	dim as integer i, h, n = 0
	dim as zstring ptr zpage(1 to 2000)
	
	d = dir( p & "*.wakka" )
	while( d > "" )
		i = instrrev( d, "." )
		if( i > 0 ) then
			d = left( d, i-1 )
			if( len(d) > 0 ) then
				n += 1
				pages(n) = d
				zpage(n) = strptr(pages(n))
			end if
		end if
		d = dir( )
	wend

	'' Sort
	qsort( @zpage(1), n, sizeof(zstring ptr), procptr(cmpPageName) )

	h = freefile
	open def_index_file for output as #h
	for i = 1 to n
		print #h, *zpage(i)
	next
	close #h

end sub

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

'' private options
dim as boolean blocal = false '' -local given on command line

'' enable url and cache
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-local"
			blocal = TRUE
		case else
			cmd_opts_unrecognized_die( i )
		end select
	else
		cmd_opts_unexpected_die( i )
	end if
	i += 1
wend	

if( app_opt.help ) then
	print "getindex {server} [options]"
	print
	print "{server}:"
	print "   -web             get index from the web server url"
	print "   -web+            get index from the web server url"
	print "   -dev             get index from the development server url"
	print "   -dev+            get index from the development server url"
	print
	print "options:"
	print "   -local           use local cache only, don't query server, just"
	print "                        read the cache dir to get the list of page names"
	print
	print "if -local is specified, then just read the file names from the cache:"
	print "   -web             get page names from cache_dir"
	print "   -web+            get page names from web_cache_dir"
	print "   -dev             get page names from cache_dir"
	print "   -dev+            get page names from dev_cache_dir"
	print
	cmd_opts_show_help( "get index from", false )
	print
	end 0
end if

cmd_opts_resolve()
cmd_opts_check()

'' --------------------------------------------------------

dim sPage as string 
dim sBody as string

sPage = "PageIndex"

if( blocal ) then

	ScanCacheDir( app_opt.cache_dir )

else

	if( len( app_opt.wiki_url ) = 0 ) then
		print "wiki_url not set. use -url, -web, -web+, -dev, or -dev+"
		end 1
	end if

	'' connect to the wiki and get PageIndex as HTML
	scope
		dim as CWikiConUrl ptr wikicon = NULL

		wikicon = new CWikiConUrl( app_opt.wiki_url, app_opt.ca_file )
		if wikicon = NULL then
			print "Unable to create connection " + app_opt.wiki_url
			end 1
		end if

		print "URL: "; app_opt.wiki_url

		if( app_opt.ca_file > "" ) then
			print "Certificate: "; app_opt.ca_file
		else
			print "Certificate: none"
		end if

		print "Loading '" + sPage + "': ";
		if( wikicon->LoadIndex( sPage, sBody ) = FALSE ) then
			print "Error"
		else
			print "OK"
			print "Writing '" & def_index_file & "'"

			dim as integer h = freefile
			open def_index_file for output as #h
			print #h, sBody;
			close #h

		end if

		delete wikicon
	end scope

end if

print "Done."
