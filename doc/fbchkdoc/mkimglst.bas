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

'' mkimglst.bas - scan wakka files and generate an image list

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWiki.bi"
#include once "CWikiCache.bi"
#include once "fbdoc_string.bi"

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

''
function ScanForImages _
	( _
		byval _this as CWiki ptr, _
		byref sPageName as string, _
		byval h as integer _
	) as integer
	
	dim as WikiToken ptr token
	dim as string t, text, sUrl, sLink
	
	dim as integer f = freefile, n = 0, bInExamples = FALSE

	function = FALSE

	token = _this->GetTokenList()->GetHead()
	do while( token <> NULL )
		text = token->text
		
		select case as const token->id
		case WIKI_TOKEN_ACTION

			if lcase(token->action->name) = "image" then

				sUrl = token->action->GetParam( "url")
				sLink = token->action->GetParam( "link")

				if( left( sUrl, 7 ) = "images/" ) then
					sUrl = "https://www.freebasic.net/wiki/images/uploaded/" + sPageName + "/" + GetBaseName(sUrl)
				elseif( left( sUrl, 8 ) = "/images/" ) then
					sUrl = "https://www.freebasic.net/wiki/images/uploaded/" + sPageName + "/" + GetBaseName(sUrl)
				end if

				print #h, sPageName; ","; sUrl
				print sUrl

				function = TRUE

			end if
			
		end select
		
		token = _this->GetTokenList()->GetNext( token )
	loop
	
end function

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
	print "mkimglst [pages] [@pagelist] [options]"
	print
	cmd_opts_show_help( "scan for image files in" )
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

dim as CWikiCache ptr wikicache
dim as string sPage, sBody

print "cache: "; app_opt.cache_dir

'' Initialize the cache
wikicache = new CWikiCache( app_opt.cache_dir, CWikiCache.CACHE_REFRESH_NONE )
if wikicache = NULL then
	print "Unable to use local cache dir " + app_opt.cache_dir
	end 1
end if

if( app_opt.pageCount > 0 ) then
	dim as integer i, h, h2
	dim as string ret

	h = freefile
	open "imagelist.txt" for output as #h
	h2 = freefile
	open "imagepages.txt" for output as #h2

	for i = 1 to app_opt.pageCount

		sPage = app_opt.pageList(i)

		print "Loading '" + sPage + "':" ; 
		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			print "Unable to load"
		else
			print "OK"
		end if

		dim as CWiki Ptr wiki
		wiki = new CWiki

		wiki->Parse( sPage, sBody )

		if( ScanForImages( wiki, sPage, h ) ) then
			print #h2, sPage
		end if

		delete wiki

	next

	close #h
	close #h2

end if

end 0


