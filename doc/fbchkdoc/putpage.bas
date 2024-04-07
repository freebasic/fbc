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

'' putpage.bas - puts pages to the wiki from a cache directory

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
dim as integer iComment = 0
dim as string sNoteDef

'' enable url, cache, and login
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_LOGIN or CMD_OPTS_ENABLE_PAGELIST or CMD_OPTS_ENABLE_TRACE )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-comment"
			iComment = 1
		case "-comment1"
			iComment = 2
		case "-c"
			i += 1
			sNoteDef = command(i)
		case else
			cmd_opts_unrecognized_die( i )
		end select
	else
		cmd_opts_unexpected_die( i )
	end if
	i += 1
wend

if( app_opt.help ) then
	print "putpage {server} [options] [pages] [@pagelist]"
	print
	print "{server}:"
	print "   -web             put pages on the web server from cache_dir"
	print "   -web+            put pages on the web server from web_cache_dir"
	print "   -dev             put pages on the development server from cache_dir"
	print "   -dev+            put pages on the development server from dev_cache_dir"
	print
	print "options:"
	print "   -c ""comment""     use message for comment line when storing pages"              
	print "   -comment         prompt for comment line when storing pages"
	print "   -comment1        prompt for comment line only once"
	print "   -u user          specifiy wiki account username"
	print "   -p pass          specifiy wiki account password"
	print
	cmd_opts_show_help( "put page to", false )
	print
	end 1
end if

cmd_opts_resolve()
cmd_opts_check_cache()
cmd_opts_check_url()

'' --------------------------------------------------------

dim as string sPage, sBody, sNote, sBodyOld, sComment

sNote = "Auto-update"

dim as CWikiCache ptr wikicache = NULL
dim as CWikiConUrl ptr wikicon = NULL

if( app_opt.pageCount = 0 ) then
	print "No pages specified"
end if

'' Initialize the cache
wikicache = new CWikiCache( app_opt.cache_dir, CWikiCache.CACHE_REFRESH_NONE )
if wikicache = NULL then
	print "Unable to use local cache dir " + app_opt.cache_dir
	end 1
end if

wikicon = new CWikiConUrl( app_opt.wiki_url, app_opt.ca_file )
if wikicon = NULL then
	print "Unable to create connection " + app_opt.wiki_url
	delete wikicache
	end 1
end if

'' we have web pages? go to work...
if( app_opt.pageCount > 0 ) then
	dim as integer i
	dim as string ret
	print "URL: "; app_opt.wiki_url
	if( app_opt.ca_file > "" ) then
		print "Certificate: "; app_opt.ca_file
	else
		print "Certificate: none"
	end if
	print "cache: "; app_opt.cache_dir
	for i = 1 to app_opt.pageCount
		sPage = app_opt.pageList(i)
		sComment = app_opt.pageComments(i)
		sBody = ""
		print "Loading '" + sPage + "': ";
		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			print "Unable to load"
		else
			print "OK"
			
			'' wikicon->LoadPage() may return FALSE if the page does not
			'' yet exist.  Test the page ID instead to determine if it
			'' is a new page
			wikicon->LoadPage( sPage, sBodyOld )
			if( wikicon->GetPageID() > 0 ) then
				if( wikicon->Login( app_opt.wiki_username, app_opt.wiki_password ) ) = FALSE then
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
				if( wikicon->Login( app_opt.wiki_username, app_opt.wiki_password ) ) = FALSE then
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
		end if
	next
end if

delete wikicache
delete wikicon

LocalCache_Destroy()

end 0
