''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008-2017 Jeffery R. Marshall (coder[at]execulink[dot]com)
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

'' rebuild.bas - read wakka files, parse, and write back

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWiki.bi"
#include once "COptions.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"

'' libs
#inclib "fbdoc"
#inclib "pcre"

using fb
using fbdoc

'':::::
function ReadTextFile( byref sFile as string ) as string
	dim ret as string, h as integer
	h = freefile
	if( open( sFile for input access read as #h ) = 0 ) then
		close #h
		open sFile for binary access read as #h
		ret = space(lof(h))
		get #h,,ret
		close #h
	end if
	return ret
end function

'':::::
sub WriteTextFile( byref sFile as string, byref text as string )
	dim h as integer
	h = freefile
	if( open( sFile for output as #h ) = 0 ) then
		close #h
		open sFile for binary as #h
		put #h,,text
		close #h
	end if
end sub


'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

dim as string cache_dir, def_cache_dir, web_cache_dir, dev_cache_dir

dim as integer i = 1, webPageCount = 0
redim webPageList(1 to 1) as string
dim as string cmt, x

if( command(i) = "" ) then
	print "rebuild [pages] [@pagelist] [options]"
	print
	print "   pages      list of wiki pages on the command line"
	print "   @pagelist	 text file with a list of pages, one per line"
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

dim as string sPage, sBody1, sBody2, f
dim as CWiki ptr wiki

if( cache_dir = "" ) then
	cache_dir = default_CacheDir
end if
print "cache: "; cache_dir

for i = 1 to webpagecount

	wiki = new CWiki

	sPage = webpagelist(i)

	f = cache_dir + sPage + ".wakka"
	sBody1 = ReadTextFile( f )

	wiki->Parse( sPage, sBody1 )
	sBody2 = ""
	sBody2 = wiki->Build()

	f = cache_dir + sPage + ".wakka"
	if( sBody1 <> sBody2 ) then
		print "Rewriting '" + sPage + "'"
		WriteTextFile( f, sBody2 )
	end if

	delete wiki

next

