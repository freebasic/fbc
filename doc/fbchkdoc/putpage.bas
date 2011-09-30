''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008 Jeffery R. Marshall (coder[at]execulink[dot]com)
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
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.

'' putpage.bas - puts pages to the wiki from a cache directory

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
dim as string def_cache_dir, web_cache_dir, dev_cache_dir
dim as string web_user, web_pass, dev_user, dev_pass

dim as string sPage, sBody, sNote, sBodyOld, sUserName, sPassword, sNoteDef
dim as integer iComment = 0

sUserName = ""
sPassword = ""
sNote = "Auto-update"
sNoteDef = ""

dim as CWikiCache ptr wikicache = NULL
dim as CWikiCon ptr wikicon = NULL

dim as integer i = 1, webPageCount = 0
redim webPageList(1 to 1) as string, webPageComments(1 to 1) as string
dim as string wiki_url, cache_dir, cmt, sComment

if( command(i) = "" ) then
	print "putpage {location} [options]"
	print
	print "location:"
	print "   -web       put pages on the web server from cache_dir"
	print "   -web+      put pages on the web server from web_cache_dir"
	print "   -dev       put pages on the development server from cache_dir"
	print "   -dev+      put pages on the development server from dev_cache_dir"
	print "   -url URL   put pages on URL from cache_dir"
	print
	print "options:"
	print "   pages      list of wiki pages on the command line"
	print "   @pagelist	 text file with a list of pages, one per line"
	print "   -comment   prompt for comment line when storing pages"
	print "   -comment1  prompt for comment line only once"
	print "   -u user    specifiy wiki account username"
	print "   -p pass    specifiy wiki account password"
	print
	end 1
end if

'' read defaults from the configuration file (if it exists)
scope
	dim as COptions ptr opts = new COptions( default_optFile )
	if( opts <> NULL ) then
		web_wiki_url = opts->Get( "web_wiki_url" )
		dev_wiki_url = opts->Get( "dev_wiki_url" )
		def_cache_dir = opts->Get( "cache_dir", default_CacheDir )
		web_cache_dir = opts->Get( "web_cache_dir", default_web_CacheDir )
		dev_cache_dir = opts->Get( "dev_cache_dir", default_dev_CacheDir )
		web_user = opts->Get( "web_username" )
		web_pass = opts->Get( "web_password" )
		dev_user = opts->Get( "dev_username" )
		dev_pass = opts->Get( "dev_password" )
		delete opts
	else
		'' print "Warning: unable to load options file '" + default_optFile + "'"
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
			sUserName = web_user
			sPassword = web_pass
		case "-dev"
			wiki_url = dev_wiki_url 
			cache_dir = def_cache_dir
			sUserName = dev_user
			sPassword = dev_pass
		case "-web+"
			wiki_url = web_wiki_url 
			cache_dir = web_cache_dir
			sUserName = web_user
			sPassword = web_pass
		case "-dev+"
			wiki_url = dev_wiki_url 
			cache_dir = dev_cache_dir
			sUserName = dev_user
			sPassword = dev_pass
		case "-url"
			i += 1
			wiki_url = command(i)
			cache_dir = def_cache_dir
			sUserName = ""
			sPassword = ""
		case "-u"
			i += 1
			sUserName = command(i)
		case "-p"
			i += 1
			sPassword = command(i)
		case "-comment"
			iComment = 1
		case "-comment1"
			iComment = 2
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
								redim preserve webPageComments(1 to Ubound(webPageComments) * 2)
							end if
							webPageList(webPageCount) = x
							webPageComments(webPageCount) = cmt
						end if
					wend
					close #h
				end if
			end scope
		else
			webPageCount += 1
			if( webPageCount > ubound(webPageList) ) then
				redim preserve webPageList(1 to Ubound(webPageList) * 2)
				redim preserve webPageComments(1 to Ubound(webPageComments) * 2)
			end if
			webPageList(webPageCount) = command(i)		
			webPageComments(webPageCount) = ""
		end if
	end if
	i += 1
wend

'' URL must be set
if( len( wiki_url ) = 0 ) then
	print "wiki_url not set."
	end 1
end if

if( webPageCount = 0 ) then
	print "No pages specified"
end if

'' Initialize the cache
wikicache = new CWikiCache( cache_dir, CWikiCache.CACHE_REFRESH_NONE )
if wikicache = NULL then
	print "Unable to use local cache dir " + cache_dir
	end 1
end if

wikicon = new CWikiCon( wiki_url )
if wikicon = NULL then
	print "Unable to create connection " + wiki_url
	delete wikicache
	end 1
end if

'' we have web pages? go to work...
if( webPageCount > 0 ) then
	dim as integer i
	dim as string ret
	print "URL: "; wiki_url
	print "cache: "; cache_dir
	for i = 1 to webPageCount
		sPage = webPageList(i)
		sComment = webPageComments(i)
		sBody = ""
		print "Loading '" + sPage + "': ";
		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			print "Unable to load"
		else
			print "OK"
			if( wikicon->LoadPage( sPage, TRUE, TRUE, sBodyOld ) <> FALSE ) then
				if( wikicon->GetPageID() > 0 ) then
					if( wikicon->Login( sUserName, sPassword ) ) = FALSE then
						print "Unable to login"
					else
						if( iComment > 0 ) then
							if( iComment = 1 or sNoteDef = "" ) then
								print "Enter note for '" + sPage + "' : ";
								Line input sNote
								if trim(sNote) = "" then sNote = "Auto-Update"
								sNoteDef = sNote
							else
								sNote = sNoteDef
							end if
						else
							if( sComment > "" ) then
								sNote = sComment
							elseif( sNoteDef > "" ) then
								sNote = sNoteDef
							else
								sNote = ""
							end if
						end if

						print "Storing '" + sPage + "' [" + sNote + "] : ";

						if( wikicon->StorePage( sBody, sNote ) = FALSE ) then
							print "FAILED"
						else
							print "OK"
						end if
					end if
				else
					print "Unable to get existing page ID - will try to store as a new page .."
					if( wikicon->Login( sUserName, sPassword ) ) = FALSE then
						print "Unable to login"
					else
						print "Storing '" + sPage + "': ";
						if( wikicon->StoreNewPage( sBody, sPage ) = FALSE ) then
							print "FAILED"
						else
							print "OK"
						end if
					end if
				end if
			else
				print "Unable to existing page"
			end if
		end if
	next
end if

delete wikicache
delete wikicon

LocalCache_Destroy()

end 0
