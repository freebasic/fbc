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

'' mkprntoc.bas - generate a linear TOC for single file output formats

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWiki.bi"
#include once "CWikiCache.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"

'' libs
#inclib "pcre"
#inclib "curl"

using fb
using fbdoc

'' private options
dim shared as CWikiCache ptr wikicache
dim shared opt_with_tut_pages as boolean = false
dim shared opt_with_dev_pages as boolean = false

declare sub MakeTOC( byval h as integer, byref sPage as string, byval baselevel as integer )

'' --------------------------------------------------------

''
sub WriteText( byval h as integer, byref sOut as string, byval break as integer, byval indent as integer )
	
	dim i as integer

	if( sOut > "" and h <> 0 ) then

		for i = 1 to break
			print #h,
		next
		for i = 1 to indent
			print #h, chr(9);
		next
		print #h, sOut

	end if

end sub

''
function MakeLink( byref sLink as string, byref sName as string ) as string
	if( instr( sLink+sName, any "[]" ) > 0 ) then
		function = "{{fbdoc item=""keyword"" value=""" + sLink + "|" + sName + """}}"
	else
		function = "[[" + sLink + "|" + sName + "]]"
	end if
end function

''
sub MakePage( byval h as integer, byref sPage as string, byval _this as CWiki ptr, byval baselevel as integer )

	dim as WikiToken ptr token
	dim as string t, text, sItem, sValue, ret, sTitle, sOut, sName, sLink, sSection
	dim as integer idx, next_level = 0, level = 0, break = 0, i
	
	sTitle = ""

	token = _this->GetTokenList()->GetHead()
	do while( token <> NULL )
		text = token->text

		sOut = ""
		
		select case as const token->id
		case WIKI_TOKEN_ACTION

			if lcase(token->action->name) = "fbdoc" then

				sItem = token->action->GetParam( "item")
				sValue = token->action->GetParam( "value")

				select case lcase( sItem ) 
				case "section"

					if( baselevel = 0 ) then
						sSection = "section"
					else
						sSection = "subsect"
					end if

					if( lcase( svalue ) = lcase("Programming Reference") ) then

						sOut = "{{fbdoc item=""" + sSection + """ value=""Programmer's Guide""}}"

					elseif( lcase( sValue ) = lcase("Indexes") ) then

						sOut = "{{fbdoc item=""" + sSection + """ value=""Keyword Index""}}"

					elseif( lcase(sPage) = lcase("CatPgFullIndex") and lcase(sValue) = lcase("Operators")) then

					else

						sOut = "{{fbdoc item=""" + sSection + """ value=""" + sValue + """}}"

					end if

					break = 1
					level = 0
					next_level = 1

				case "subsect"

					if ( lcase( sValue ) = lcase("Operators" ) ) then

					else
					
						sOut = "{{fbdoc item=""subsect"" value=""" + sValue + """}}"

						break = 1
						level = 1
						next_level = 2
					
					end if

				case "keyword"
					idx = instr( sValue, "|" )
					sLink = trim(left( sValue, idx - 1 ))
					sName = trim(mid( sValue, idx + 1 ))

					if( lcase(sLink) = lcase("CatPgProgrammer") ) then
						MakeTOC( h, sLink, baselevel + 1 )

					elseif( lcase(sLink) = lcase("CatPgFullIndex") ) then
						MakeTOC( h, sLink, baselevel + 1 )

					elseif( lcase(sLink) = lcase("CVSCompile") ) then
						WriteText h, MakeLink( sLink, sName ), 0, baselevel + 1
						MakeTOC( h, sLink, baselevel + 2 )

					elseif( lcase(sLink) = lcase("SVNCompile") ) then
						WriteText h, MakeLink( sLink, sName ), 0, baselevel + 1
						MakeTOC( h, sLink, baselevel + 2 )

					elseif( lcase(sLink) = lcase("GnuLicenses") ) then
						WriteText h, MakeLink( sLink, sName ), 0, baselevel + level
						WriteText h, "[[LicenseGPL GPL]]", 0, baselevel + level + 1
						WriteText h, "[[LicenseLGPL LGPL]]", 0, baselevel + level + 1
						WriteText h, "[[LicenseGFDL GFDL]]", 0, baselevel + level + 1

					elseif( lcase(sLink) = lcase("CatPgOperators") ) then
						
						if( lcase(sPage) = lcase("DocToc") ) then
''							WriteText h, MakeLink( sLink, sName ), 0, baselevel + 1
							MakeTOC( h, sLink, baselevel + 1 )
						
						elseif( lcase(sPage) = lcase("CatPgFullIndex") ) then
''							MakeTOC( h, "", baselevel + 1 )
						
						end if

					elseif( lcase(sLink) = lcase("ExtLibTOC") ) then
						WriteText h, "{{fbdoc item=""section"" value=""" + sName + """}}", 1, 0
						MakeTOC( h, sLink, baselevel + 1 )

					elseif( lcase(sLink) = lcase("CommunityTutorials") ) then
						if( opt_with_tut_pages ) then
							WriteText h, "{{fbdoc item=""section"" value=""" + sName + """}}", 1, 0
							MakeTOC( h, sLink, baselevel + 1 )
						else
							sOut = MakeLink( sLink, sName )
							break = 0
							level = next_level
						end if
					
					elseif( lcase(sLink) = lcase("DevToc") ) then
						if( opt_with_dev_pages ) then
							WriteText h, "{{fbdoc item=""section"" value=""" + sName + """}}", 1, 0
							MakeTOC( h, sLink, baselevel + 1 )
						else
							sOut = MakeLink( sLink, sName )
							break = 0
							level = next_level
						end if

					elseif( lcase(sLink) = lcase("CatPgCompOpt") ) then
''						if( lcase(sPage) = lcase("CatPgProgrammer") ) then
							WriteText h, "{{fbdoc item=""section"" value=""" + sName + """}}", 1, 1
							MakeTOC( h, sLink, 2 )
''						end if

					elseif( lcase(sPage) = lcase("CatPgOperators") ) then
						WriteText h, "{{fbdoc item=""subsect"" value=""" + sName + """}}", 1, baselevel
						MakeTOC( h, sLink, baselevel + 1 )

					elseif( lcase(sLink) = lcase("CatPgFunctIndex") ) then
						'' ignore
					
					elseif( lcase(sLink) = lcase("CatPgGfx") ) then
						'' ignore

''					elseif( left(lcase(sLink), 5) = lcase("CatPg") ) then
''						MakeTOC( h, sLink, baselevel + 1 )

					else
						sOut = MakeLink( sLink, sName )

						break = 0
						level = next_level
					end if

				case "title"
					sTitle = sValue

					if( lcase(sPage) = lcase("DocToc") ) then

						sOut = "{{fbdoc item=""title"" value=""Table of Contents""}}"

						level = 0
						next_level = 1
						break = 0

					end if

				end select

			end if

		case WIKI_TOKEN_LINK
			
			'' special hack for tutorials page

			if( sPage = "CommunityTutorials" ) then
				WriteText h, "[[" + token->link->url + "|" + token->text + "]]", 0, baselevel + level + 1
			end if

		end select

		WriteText h, sOut, break, baselevel + level

		token = _this->GetTokenList()->GetNext( token )
	loop

end sub

''
sub MakeTOC( byval h as integer, byref sPage as string, byval baselevel as integer )

	dim sBody as string

	print "Loading '" + sPage + "':" ; 
	if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
		print "Unable to load"
		exit sub
	else
		print "OK"
	end if

	dim as CWiki Ptr wiki
	wiki = new CWiki

	wiki->Parse( sPage, sBody )

	MakePage( h, sPage, wiki, baselevel )

	delete wiki

end sub

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

cmd_opts_init( CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_AUTOCACHE )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-with-tut-pages"
			opt_with_tut_pages = true
		case "-with-dev-pages"
			opt_with_dev_pages = true
		case else
			cmd_opts_unrecognized_die( i )
		end select
	else
		cmd_opts_unexpected_die( i )
	end if
	i += 1
wend	

if( app_opt.help ) then
	print "mkprntoc [options]"
	print
	print "options:"
	print "   -with-tut-pages  include tutorial pages"
	print "   -with-dev-pages  include developer pages"
	print
	cmd_opts_show_help()
	print
 	end 0
end if

cmd_opts_resolve()
cmd_opts_check_cache()
cmd_opts_check_url()

'' --------------------------------------------------------

dim as string sPage, sBody
dim as integer h

print "cache: "; app_opt.cache_dir

'' Initialize the cache
wikicache = new CWikiCache( app_opt.cache_dir, CWikiCache.CACHE_REFRESH_NONE )
if wikicache = NULL then
	print "Unable to use local cache dir " + app_opt.cache_dir
	end 1
end if

h = Freefile
print "Writing " + app_opt.cache_dir + "PrintToc.wakka"
open app_opt.cache_dir + "PrintToc.wakka" for output as #h

MakeTOC( h, "DocToc", 0 )

close #h

end 0

