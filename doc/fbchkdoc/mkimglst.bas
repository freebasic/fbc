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

'' mkimglst.bas - scan wakka files and generate an image list

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWiki.bi"
#include once "CWikiCache.bi"
#include once "CRegex.bi"
#include once "list.bi"
#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "COptions.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"

'' libs
#inclib "pcre"
#inclib "curl"

using fb
using fbdoc

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
					sUrl = "http://www.freebasic.net/wiki/images/uploaded/" + sPageName + "/" + GetBaseName(sUrl)
				elseif( left( sUrl, 8 ) = "/images/" ) then
					sUrl = "http://www.freebasic.net/wiki/images/uploaded/" + sPageName + "/" + GetBaseName(sUrl)
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

dim as string cache_dir, def_cache_dir, web_cache_dir, dev_cache_dir

dim as integer i = 1, webPageCount = 0
redim webPageList(1 to 1) as string
dim as string cmt

if( command(i) = "" ) then
	print "mkimglst [pages] [@pagelist] [options]"
	print
	print "   pages      list of wiki pages on the command line"
	print "   @pagelist  text file with a list of pages, one per line"
	print
	print "   -web       rebuild files in cache_dir"
	print "   -web+      rebuild files in web cache_dir"
	print "   -dev       rebuild files in cache_dir"
	print "   -dev+      rebuild files in dev cache_dir"
	end 0
end if

'' read defaults from the configuration file (if it exists)
scope
	dim as COptions ptr opts = new COptions( default_optFile )
	if( opts <> NULL ) then
		def_cache_dir = opts->Get( "cache_dir", default_CacheDir )
		web_cache_dir = opts->Get( "web_cache_dir", default_web_CacheDir )
		dev_cache_dir = opts->Get( "dev_cache_dir", default_dev_CacheDir )
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
	if( left(command(i), 1) = "-" ) then
		select case lcase(command(i))
		case "-web", "-dev"
			cache_dir = def_cache_dir
		case "-web+"
			cache_dir = web_cache_dir
		case "-dev+"
			cache_dir = dev_cache_dir
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

if( webPageCount = 0 ) then
	print "no pages specified."
	end 1
end if

dim as CWikiCache ptr wikicache
dim as string sPage, sBody

if( cache_dir = "" ) then
	cache_dir = default_CacheDir
end if
print "cache: "; cache_dir

'' Initialize the cache
wikicache = new CWikiCache( cache_dir, CWikiCache.CACHE_REFRESH_NONE )
if wikicache = NULL then
	print "Unable to use local cache dir " + cache_dir
	end 1
end if

if( webPageCount > 0 ) then
	dim as integer i, h, h2
	dim as string ret

	h = freefile
	open "imagelist.txt" for output as #h
	h2 = freefile
	open "imagepages.txt" for output as #h2

	for i = 1 to webPageCount

		sPage = webPageList(i)

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


