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

'' getpage.bas - gets pages from wiki and saves to a cache directory

'' chng: written [jeffm]

'' fbdoc headers
#include once "fbdoc_cache.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_loader_web.bi"

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

'' enable url and cache
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_PAGELIST )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-auto"
			allow_retry = false
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
	print
	end 1
end if

cmd_opts_resolve()
cmd_opts_check()

'' no pages? nothing to do...
if( app_opt.webPageCount = 0 ) then
	print "no pages specified."
	end 1
end if

'' --------------------------------------------------------

dim as integer nfailedpages = 0
redim failedpages(1 to 1) as string

'' main loop - has option to retry/list failed pages
do

	'' Initialize the cache
	if LocalCache_Create( app_opt.cache_dir, CWikiCache.CACHE_REFRESH_ALL ) = FALSE then
		print "Unable to use local cache dir " + app_opt.cache_dir
		end 1
	end if

	'' Initialize the wiki connection
	Connection_SetUrl( app_opt.wiki_url, app_opt.ca_file )

	print "URL: "; app_opt.wiki_url
	if( app_opt.ca_file > "" ) then
		print "Certificate: "; app_opt.ca_file
	else
		print "Certificate: none"
	end if
	print "cache: "; app_opt.cache_dir

	nfailedpages = 0

	if( app_opt.webPageCount > 0 ) then
		dim as integer i, j
		dim as string ret
		for i = 1 to app_opt.webPageCount
			ret = LoadPage( app_opt.webPageList(i), FALSE, TRUE )
			if( ret = "" ) then
				print "Failed to load '" & app_opt.webPageList(i) & "'"
				nfailedpages += 1
				redim preserve failedpages( 1 to nfailedpages )
				failedpages(nfailedpages) = app_opt.webPageList(i)
			end if

			if( inkey = chr(27) ) then
				
				for j = i + 1 to app_opt.webPageCount
					nfailedpages += 1
					redim preserve failedpages( 1 to nfailedpages )
					failedpages(nfailedpages) = app_opt.webPageList(j)
				next

				exit for
				
			end if

		next
	end if

	Connection_Destroy()
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
					app_opt.webPageList(i) = failedpages(i)
				next
				app_opt.webPageCount = nfailedpages

				exit do

			case "n"
				exit do, do

			end select
		loop

	else
		exit do

	end if

loop
