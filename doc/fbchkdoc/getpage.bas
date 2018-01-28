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
#include once "COptions.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"

'' libs
#inclib "pcre"
#inclib "curl"

using fb
using fbdoc


'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

dim as string web_wiki_url, dev_wiki_url
dim as string ca_file, web_ca_file, dev_ca_file
dim as string def_cache_dir, web_cache_dir, dev_cache_dir

dim as integer i = 1, webPageCount = 0, nfailedpages = 0
redim webPageList(1 to 1) as string
redim failedpages(1 to 1) as string
dim as string wiki_url, cache_dir, cmt
var allow_retry = true

if( command(i) = "" ) then
	print "getpage {server} [pages] [@pagelist]"
	print
	print "server:"
	print "   -web       get pages from the web server in to cache_dir"
	print "   -web+      get pages from the web server in to web_cache_dir"
	print "   -dev       get pages from the development server in to cache_dir"
	print "   -dev+      get pages from the development server in to dev_cache_dir"
	print "   -url URL   get pages from URL"
	print "   -certificate file"
	print "              certificate to use to authenticate server (.pem)"
	print
	print "options:"
	print "   pages      list of wiki pages on the command line"
	print "   @pagelist	 text file with a list of pages, one per line"
	print "   -auto      don't ask for user input, don't retry failed downloads"
	print
	end 1
end if

'' read defaults from the configuration file (if it exists)
scope
	dim as COptions ptr opts = new COptions( default_optFile )
	if( opts <> NULL ) then
		web_wiki_url = opts->Get( "web_wiki_url" )
		dev_wiki_url = opts->Get( "dev_wiki_url" )
		web_ca_file = opts->Get( "web_certificate" )
		dev_ca_file = opts->Get( "dev_certificate" )
		def_cache_dir = opts->Get( "cache_dir", default_CacheDir )
		web_cache_dir = opts->Get( "web_cache_dir", default_web_CacheDir )
		dev_cache_dir = opts->Get( "dev_cache_dir", default_dev_CacheDir )
		delete opts
	else
		print "Warning: unable to load options file '" + default_optFile + "'"
		'' end 1
		def_cache_dir = default_CacheDir
		web_cache_dir = default_web_CacheDir
		dev_cache_dir = default_dev_CacheDir
	end if
end scope

while command(i) > ""
	if( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-web"
			wiki_url = web_wiki_url 
			cache_dir = def_cache_dir
			ca_file = web_ca_file
		case "-dev"
			wiki_url = dev_wiki_url 
			cache_dir = def_cache_dir
			ca_file = dev_ca_file
		case "-web+"
			wiki_url = web_wiki_url 
			cache_dir = web_cache_dir 
			ca_file = web_ca_file
		case "-dev+"
			wiki_url = dev_wiki_url 
			cache_dir = dev_cache_dir
			ca_file = dev_ca_file
		case "-url"
			i += 1
			wiki_url = command(i)
			cache_dir = def_cache_dir
		case "-certificate"
			i += 1
			ca_file = command(i)
		case "-auto"
			allow_retry = false
		case else
			print "Unrecognized option '" + command(i) + "'"
			end 1
		end select
	else
		if left( command(i), 1) = "@" then
			scope
				dim h as integer, x as string
				h = freefile
				if open( mid(command(i),2) for input access read as #h ) <> 0 then
					print "Error reading '" + command(i) + "'"
				else
					while eof(h) = 0
						line input #h, x
						x = ParsePageName( x, cmt )
						if( x > "" ) then 
							webPageCount += 1
							if( webPageCount > ubound(webPageList) ) then
								redim preserve webPageList(1 to Ubound(webPageList) * 2)
							end if
							webPageList(webPageCount) = x
						end if
					wend
					close #h
				end if
			end scope
		else
			webPageCount += 1
			if( webPageCount > ubound(webPageList) ) then
				redim preserve webPageList(1 to Ubound(webPageList) * 2)
			end if
			webPageList(webPageCount) = command(i)		
		end if
	end if
	i += 1
wend

'' URL must be set
if( len( wiki_url ) = 0 ) then
	print "wiki_url not set. use -url, -web, -web+, -dev, -dev+"
	end 1
end if

'' no pages? nothing to do...
if( webPageCount = 0 ) then
	print "no pages specified."
	end 1
end if

'' main loop - has option to retry/list failed pages
do

	'' Initialize the cache
	if LocalCache_Create( cache_dir, CWikiCache.CACHE_REFRESH_ALL ) = FALSE then
		print "Unable to use local cache dir " + cache_dir
		end 1
	end if

	'' Initialize the wiki connection
	Connection_SetUrl( wiki_url, ca_file )

	print "URL: "; wiki_url
	if( ca_file > "" ) then
		print "Certificate: "; ca_file
	else
		print "Certificate: none"
	end if
	print "cache: "; cache_dir

	nfailedpages = 0

	if( webPageCount > 0 ) then
		dim as integer i, j
		dim as string ret
		for i = 1 to webPageCount
			ret = LoadPage( webPageList(i), FALSE, TRUE )
			if( ret = "" ) then
				print "Failed to load '" & webPageList(i) & "'"
				nfailedpages += 1
				redim preserve failedpages( 1 to nfailedpages )
				failedpages(nfailedpages) = webPageList(i)
			end if

			if( inkey = chr(27) ) then
				
				for j = i + 1 to webPageCount
					nfailedpages += 1
					redim preserve failedpages( 1 to nfailedpages )
					failedpages(nfailedpages) = webPageList(j)
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
					webPageList(i) = failedpages(i)
				next
				webPageCount = nfailedpages

				exit do

			case "n"
				exit do, do

			end select
		loop

	else
		exit do

	end if

loop
