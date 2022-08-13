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

'' getpage.bas - gets pages from wiki and saves to a cache directory

'' chng: written [jeffm]

'' fbdoc headers
#include once "fbdoc_cache.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_loader_web.bi"

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

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

'' private options
dim allow_retry as boolean = true
dim as boolean bUseSql = false '' -usesql given on command line
dim as boolean bUseDiff = false '' -diff given on command line
dim as string diff_file         '' file name to diff with
dim as long diff_revision       '' highest revision number in the diff flie

'' enable url and cache
#if defined(HAVE_MYSQL)
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_PAGELIST or CMD_OPTS_ENABLE_DATABASE or CMD_OPTS_ENABLE_TRACE )
#else
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_PAGELIST or CMD_OPTS_ENABLE_TRACE )
#endif

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-auto"
			allow_retry = false
		case "-diff"
			if( command(i+1) = "" ) then
				cmd_opts_missingarg_die( i )
			end if
			i += 1
			diff_file = command(i)
			diff_revision = 0
			bUseDiff = true
#if defined(HAVE_MYSQL)
		case "-usesql"
			bUseSql = true
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
	print "getpage {server} [options] [pages] [@pagelist]"
	print
	print "{server}:"
	print "   -web             get pages from the web server in to cache_dir"
	print "   -web+            get pages from the web server in to web_cache_dir"
	print "   -dev             get pages from the development server in to cache_dir"
	print "   -dev+            get pages from the development server in to dev_cache_dir"
	print
	cmd_opts_show_help( "get page from", false )
	print "   -diff pagelist   name an index file with last changes only pages with"
	print "                        a revision number greater than the largest revision"
	print "                        in the diff file will be fetched from the server"
	print
#if defined(HAVE_MYSQL)
	print "   -usesql          use MySQL connection to read index"
#endif
	end 1
end if

cmd_opts_resolve()
cmd_opts_check_cache()
cmd_opts_check_url()
if( len( app_opt.wiki_url ) = 0 ) then
	print "wiki_url not set. use -url, -web, -web+, -dev, or -dev+"
	end 1
end if
if( bUseSql ) then
	cmd_opts_check_database()
end if

'' no pages? nothing to do...
if( app_opt.pageCount = 0 ) then
	print "no pages specified."
	end 1
end if

'' --------------------------------------------------------

'' Get last revision from diff file
if( bUseDiff ) then
	dim h as integer, x as string, cmt as string, rev as long
	h = freefile
	if open( diff_file for input access read as #h ) <> 0 then
		print "Error reading '" + diff_file + "'"
	else
		while eof(h) = 0
			line input #h, x
			x = ParsePageName( x, cmt, rev )
			if( x > "" ) then 
				if( rev > diff_revision ) then
					diff_revision = rev
				end if
			end if
		wend
		close #h
	end if
	if( diff_revision > 0 ) then
		print "Checking last revision: " & diff_revision
	else
		print "No revision found in diff file '" & diff_file & "'"
	end if
end if

'' --------------------------------------------------------

dim as integer nfailedpages = 0
redim failedpages(1 to 1) as string

'' main loop - has option to retry/list failed pages
do

	dim as CWikiCon ptr wikicon = NULL

	'' Initialize the cache
	if LocalCache_Create( app_opt.cache_dir, CWikiCache.CACHE_REFRESH_ALL ) = FALSE then
		print "Unable to use local cache dir " + app_opt.cache_dir
		end 1
	end if

	if( bUseSql ) then
#if defined(HAVE_MYSQL)
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

		print "cache: "; app_opt.cache_dir
	end if

	nfailedpages = 0

	if( app_opt.pageCount > 0 ) then
		dim as integer i, j
		dim as string ret
		for i = 1 to app_opt.pageCount
			'' get the page only if the revision number is greater than the
			'' last known revision, or if it is zero.  If the revision number
			'' is zero, then we don't know the revision number and anything
			'' could be changed, so read everything.  If the specified revision
			'' number is zero, then we don't know the revision of the page we
			'' want so go ahead and get it anyway.
			if( (app_opt.pageRevision(i) > diff_revision) or (app_opt.pageRevision(i) = 0) or (diff_revision = 0) ) then
				dim sBody as string = ""
				print "Loading '" + app_opt.pageList(i) + "'"
				if( wikicon->LoadPage( app_opt.pageList(i), sBody ) = FALSE ) then
					print "Failed to load '" & app_opt.pageList(i) & "'"
					nfailedpages += 1
					redim preserve failedpages( 1 to nfailedpages )
					failedpages(nfailedpages) = app_opt.pageList(i)
				else
					if( wikicon->GetPageID() > 0 ) then
						if( len(sBody) > 0 ) then
							dim as CWikiCache ptr wikicache = LocalCache_Get()
							wikicache->SavePage( app_opt.pageList(i), sBody )
						end if
					end if
				end if
			end if

			if( inkey = chr(27) ) then
				
				for j = i + 1 to app_opt.pageCount
					nfailedpages += 1
					redim preserve failedpages( 1 to nfailedpages )
					failedpages(nfailedpages) = app_opt.pageList(j)
				next

				exit for
				
			end if

		next
	end if

	delete wikicon

	LocalCache_Destroy()

	'' Check for failed pages
	if( (nfailedpages > 0) and allow_retry ) then
		print
		dim k as string
		do
			print nfailedpages & " pages could not be downloaded. Try again? [Y/N/L] : ";
			do
				k = inkey
			loop while k = ""
			print k
			select case lcase(k)
			case "l"
				for i = 1 to nfailedpages
					print failedpages(i); " ";
				next
				print
			case "y"
				
				for i = 1 to nfailedpages
					app_opt.pageList(i) = failedpages(i)
				next
				app_opt.pageCount = nfailedpages

				exit do

			case "n"
				exit do, do

			end select
		loop

	else
		exit do

	end if

loop
