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

'' getindex.bas - gets "PageIndex" from wiki and saves as "PageIndex.txt"
''              - or gets "RecentChanges" from wiki and saves as "RecentChanges.txt"

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWikiConUrl.bi"
#include once "CWikiConDir.bi"

#if defined(HAVE_MYSQL)
#include once "CWikiConSql.bi"
#endif

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"

'' libs
#inclib "pcre"
#inclib "curl"

using fb
using fbdoc


const def_index_file = hardcoded.default_index_file
const def_recent_file = hardcoded.default_recent_file

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

'' private options
dim as boolean bLocal = false  '' -local given on command line
dim as boolean bUseSql = false '' -usesql given on command line
dim as boolean bUseRecent = false '' -recent given on command line
dim as boolean bUseListFormat = false 
dim as string index_file '' index file to write PageIndex.txt or RecentChanges.txt
dim as CWikiCon.IndexFormat index_format = CWikiCon.IndexFormat.INDEX_FORMAT_LEGACY

dim sPage as string 
dim sBody as string

sPage = "PageIndex"
index_file = def_index_file

'' Example command line options:
'' '-web'                 PageIndex.txt, list format
'' '-web -recent'         RecentChanges.txt, index format
'' '-web -recent -list'   RecentChanges.txt, list format

'' Ideally, we would probably like to default to the index format always
'' but if any programs expect plain old text by default, we will try not
'' to break them by writing plain old text for the default PageIndex.txt.
'' Anyway, RecentChanges index works perfect for a full index and can be
'' used anywhere that PageIndex would have been used with these tools.


'' enable url and cache
#if defined(HAVE_MYSQL)
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_DATABASE or CMD_OPTS_ENABLE_TRACE )
#else
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_TRACE )
#endif

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-local"
			bLocal = TRUE
		case "-list"
			index_format = CWikiCon.IndexFormat.INDEX_FORMAT_LIST
		case "-recent"
			bUseRecent = TRUE
			if( index_format = CWikiCon.IndexFormat.INDEX_FORMAT_LEGACY ) then
				index_format = CWikiCon.IndexFormat.INDEX_FORMAT_INDEX
			end if
			index_file = def_recent_file
			sPage = "RecentChanges"
#if defined(HAVE_MYSQL)
		case "-usesql"
			bUseSql = TRUE
#endif
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
	print "   -recent          retrieve recent changes index and write to"
	print "                        RecentChanges.txt.  Default is to retrieve"
	print "                        PageIndex and write the index to PageIndex.txt"
	print "   -list            write index in list format, no revision numbers"
#if defined(HAVE_MYSQL)
	print "   -usesql          use MySQL connection to read index"
#endif
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

'' --------------------------------------------------------

dim as CWikiCon ptr wikicon = NULL

'' connect to the wiki and get PageIndex (list of all pages)

if( bLocal ) then

	cmd_opts_check_cache()

	wikicon = new CWikiConDir( app_opt.cache_dir )
	if wikicon = NULL then
		print "Unable to create connection " + app_opt.cache_dir
		end 1
	end if

	print "cache: "; app_opt.cache_dir

#if defined(HAVE_MYSQL)
elseif( bUseSql ) then

	cmd_opts_check_database()

	wikicon = new CWikiConSql( app_opt.db_host, app_opt.db_user, app_opt.db_pass, app_opt.db_name, app_opt.db_port )
	if wikicon = NULL then
		print "Unable to create connection " + app_opt.cache_dir
		end 1
	end if

	dim as CWikiConSql ptr o = cast( CWikiConSql ptr, wikicon )
	if( o->Connect() = FALSE ) then
		print "Error"
		end 1
	end if

#endif
else
	cmd_opts_check_url()

	if( len( app_opt.wiki_url ) = 0 ) then
		print "wiki_url not set. use -url, -web, -web+, -dev, or -dev+"
		end 1
	end if

	print "URL: "; app_opt.wiki_url

	wikicon = new CWikiConUrl( app_opt.wiki_url, app_opt.ca_file )
	if wikicon = NULL then
		print "Unable to create connection " + app_opt.wiki_url
		end 1
	end if

	if( app_opt.ca_file > "" ) then
		print "Certificate: "; app_opt.ca_file
	else
		print "Certificate: none"
	end if

end if

print "Loading '" + sPage + "': ";
if( wikicon->LoadIndex( sPage, sBody, index_format ) = FALSE ) then
	print "Error"
else
	print "OK"
	print "Writing '" & index_file & "'" & iif( index_format = CWikiCon.IndexFormat.INDEX_FORMAT_INDEX, " (index format)", " (list format)" )

	dim as integer h = freefile
	open index_file for output as #h
	print #h, sBody;
	close #h

end if

delete wikicon

print "Done."
