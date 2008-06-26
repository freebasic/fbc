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

'' chkdocs.bas - check wiki for possible problems

'' chng: written [jeffm]

'' fb headers
#include once "string.bi"
#include once "file.bi"
#include once "datetime.bi"

'' fbdoc headers
#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "CRegex.bi"
#include once "list.bi"
#include once "CWiki.bi"
#include once "hash.bi"
#include once "COptions.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"

'' libs
#inclib "pcre"
#inclib "funcs"

using fb
using fbdoc

enum LINK_FLAGS
	FLAG_NONE                   = 0

	FLAG_LINK_KEYPG				= 1 shl 0
	FLAG_LINK_CATPG				= 1 shl 1
	FLAG_LINK_PROPG				= 1 shl 2

	FLAG_LINK_BACK				= 1	shl 3
	FLAG_LINK_LINK				= 1 shl 4
	FLAG_LINK_URL				= 1 shl 5
	FLAG_LINK_KEYWORD			= 1 shl 6

	FLAG_PAGE_KEYPG				= 1 shl 7
	FLAG_PAGE_CATPG				= 1 shl 8 
	FLAG_PAGE_PROPG				= 1 shl 9

	FLAG_PAGE_DOCPAGE			= 1 shl 10  

	FLAG_PAGE_HASBACKLINK		= 1 shl 11
	FLAG_PAGE_LINKED_FROM_CATPG = 1 shl 12
	FLAG_PAGE_LINKED_FROM_INDEX = 1 shl 13

	FLAG_FILE_NOT_FOUND			= 1 shl 14
	FLAG_FILE_DUPLICATE			= 1 shl 15

end enum

Type PageInfo_t
	sName as string
	flags as integer
	sTitle as string
	msg as integer
End Type

Type LinkInfo_t
  sName as string
  sType as string
  sLink as string
  flags as integer
End Type

Type SampInfo_t
	sFile as string
	sPage as string
	flags as integer
End Type

Type ImageInfo_t
	sUrl as string
	sLink as string
	sPage as string
	flags as integer
end Type

dim shared cache_dir as string

const PageIndex_File = def_index_file
const DocPages_File = "DocPages.txt"
const LinkList_File = "linklist.csv"
const FixList_File = "fixlist.txt"
const SampList_File = "samplist.log"

''
redim shared sPages() as PageInfo_t
redim preserve sPages(1 to 1) as PageInfo_t
dim shared nPages as integer = 0, maxPages as integer = 1

redim shared sLinks() as LinkInfo_t
redim preserve sLinks(1 to 1) as LinkInfo_t
dim shared nLinks as integer = 0, maxLinks as integer = 1

redim shared sSamps() as SampInfo_t
redim preserve sSamps(1 to 1) as SampInfo_t
dim shared nSamps as integer = 0, maxSamps as integer = 1

redim shared sImages() as ImageInfo_t
redim preserve sImages(1 to 1) as ImageInfo_t
dim shared nImages as integer = 0, maxImages as integer = 1


redim shared sTemps() as string
redim preserve sTemps(1 to 1) as string
dim shared nTemps as integer = 0, maxTemps as integer = 1

dim shared temphash as HASH

dim shared pagehash as HASH
dim shared pagehash_lcase as HASH
dim shared pagehash_keypg as HASH
dim shared pagehash_catpg as HASH
dim shared pagehash_scanned as HASH

dim shared linkhash as HASH
dim shared linkhash_back as HASH
dim shared linkhash_link as HASH
dim shared linkhash_url as HASH
dim shared linkhash_keyword as HASH

dim shared samphash as HASH

dim shared imagehash as HASH

type timers_t
	text as string
	value as double
	lapsed as double
end type

dim shared as timers_t timers(1 to 20)
dim shared as integer ntimers = 0


'' ----------------------------------------------------

sub Timer_Begin()
	ntimers += 1
	timers( ntimers ).text = "BEGIN"
	timers( ntimers ).value = timer
	timers( ntimers ).lapsed = 0
end sub

sub Timer_Mark( byref text as string )
	ntimers += 1
	timers( ntimers ).text = text
	timers( ntimers ).value = timer
	timers( ntimers ).lapsed = timers( ntimers ).value - timers( ntimers - 1 ).value
end sub

sub Timer_End()
	ntimers += 1
	timers( ntimers ).text = "END"
	timers( ntimers ).value = timer
	timers( ntimers ).lapsed = timers( ntimers ).value - timers( 1 ).value
end sub

sub Timer_Dump()
	dim h as integer, i as integer
	h = freefile
	open "timer.log" for output as #h
	for i = 1 to ntimers
		print #h, right(space(32) + timers(i).text, 32);
		print #h, " = ";
		print #h, str(csng(cint( timers(i).lapsed * 100 )) / 100); " seconds"
	next
	close #h
end sub


'' ----------------------------------------------------

'':::::
dim shared logfileH as integer

sub logopen()
	logfileH = freefile
	open "results.txt" for output as #logfileH
end sub

sub logprint( byref txt as string = "" )
	'if( txt ) > "" then
		print txt
		if logfileH <> 0 then
			print #logfileH, txt
		end if
	'end if
end sub

sub logclose()
	if logfileH <> 0 then
		close #logfileH
	end if
end sub

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

'' ----------------------------------------------------

'':::::
sub Temps_Clear ()
	nTemps = 0
	maxTemps = 1
	redim sTemps( 1 to maxTemps ) as string
	temphash.clear()
end sub

'':::::
sub Temps_Add( byref text as string, byval bAllowDup as integer = FALSE )

	dim as integer i

	if( bAllowDup <> FALSE ) then
		i = nTemps + 1
	else
		if( temphash.test( text ) = 0 ) then
			i = nTemps + 1
		end if
	end if

	if( i > nTemps ) then
		nTemps += 1
		if nTemps > maxTemps then
			maxTemps *= 2
			redim preserve sTemps( 1 to maxTemps ) as string
		end if
		sTemps(i) = text
		temphash.add( text )
	end if

end sub

'' ----------------------------------------------------

'':::::
sub Pages_Clear ()
	nPages = 0
	maxPages = 1
	redim sPages( 1 to maxPages ) as PageInfo_t
	pagehash.clear()
	pagehash_lcase.clear()
	pagehash_catpg.clear()
	pagehash_keypg.clear()
	pagehash_scanned.clear()
end sub

'':::::
sub Pages_Add ( byref d as string, byref t as string = "" )
	dim as integer i
	nPages += 1
	if nPages > maxPages then
		maxPages *= 2
		redim preserve sPages( 1 to maxPages )
	end if
	with sPages(nPages)
		i = instr(d,".")
		if i > 0 then
			.sName = left(d, -1)
		else
			.sName = d
		end if
		.sTitle = t
		.flags = FLAG_NONE

		pagehash.add( .sName, cast(any ptr, nPages) )
		pagehash_lcase.add( lcase(.sName), cast(any ptr, nPages) )
		
		select case lcase(left(d, 5))
		case "keypg"
			.flags or= FLAG_PAGE_KEYPG
			pagehash_keypg.add( lcase(.sName), cast(any ptr, nPages) )

		case "catpg"
			.flags or= FLAG_PAGE_CATPG
			pagehash_catpg.add( lcase(.sName), cast(any ptr, nPages) )

		end select				
	end with
end sub

'':::::
sub Pages_LoadFromFile( byref sFileName as string, byval mask as integer = 0 )

	dim h as integer, x as string, i as integer, j as integer, c as integer = 0
	dim as string sName, sTitle

	if( mask = 0 ) then
		Pages_Clear
	end if
	
	h = freefile
	open sFileName for input as #h

	while eof(h) = 0
		line input #h,x
		i = instr(x, chr(9) )
		if( i > 0 ) then
			sName = Trim( Left( x, i - 1 ))
			sTitle = Trim( Mid( x, i + 1 ))
		else
			sName = Trim(x)
			sTitle = ""
		end if
		if( mask ) then
			j = cint( pagehash_lcase.getinfo( lcase(sName) ) )
			if( j ) then
				c += 1
				sPages(j).flags or= mask
				sPages(j).sTitle = sTitle
			end if
		else
			Pages_Add sName, sTitle
		end if
	wend

	close #h

	if( mask ) then
		logprint "Merged " + str(c) + " page titles from '" + sFileName + "'"
	else
		logprint "Loaded " + str(nPages) + " page names from '" + sFileName + "'"
	end if

end sub

'':::::
sub Pages_LoadFromCache()
	dim as string d

	Pages_Clear

	d = dir( cache_dir + "*.wakka" )
	while d > ""
		Pages_Add Trim(d)
		d = dir()
	wend

	logprint "Found " & nPages & " pages."

end sub

'':::::
sub Pages_SaveToFile( byref sFileName as string, byval mask as integer = -1 )

	dim as integer i, h, c = 0

	h = freefile
	open sFileName for output as #h
	for i = 1 to nPages
		if( sPages(i).flags and mask ) then
			c += 1
			print #h, sPages(i).sName + chr(9) + sPages(i).sTitle
		end if
	next
	close #h

	LogPrint "Saved " + str(c) + " page names to '" + sFileName + "'"

end sub

'':::::
function Pages_Exists( byref sPageName as string, byval bCaseSensitive as integer ) as integer
	dim i as integer
	if( bCaseSensitive = 0 ) then
		function = pagehash.test( sPageName )
	else
		function = pagehash_lcase.test( lcase(sPageName))
	end if
end function

'' ----------------------------------------------------

'':::::
sub Samps_Clear()
	nSamps = 0
	maxSamps = 1
	redim sSamps( 1 to maxSamps ) as SampInfo_t
	samphash.clear()
end sub

'':::::
sub Samps_Add( byref sFile as string, byref sPage as string )

    dim j as integer
	nSamps += 1
	if nSamps > maxSamps then
		maxSamps *= 2
		redim preserve sSamps( 1 to maxSamps )
	end if
	with sSamps(nSamps)
		.sFile = Trim(sFile)
		.sPage = Trim(sPage)
		.flags = FLAG_NONE

		if( samphash.test( lcase(sFile) ) <> 0 ) then
			.flags or= FLAG_FILE_DUPLICATE
		else
			samphash.add( lcase(sFile) )
		end if

	end with
	
end sub

'':::::
sub Samps_SaveToFile( byref sFileName as string, byval mask as integer = -1 )

	dim as integer i, h, c = 0

	h = freefile
	open sFileName for output as #h
	for i = 1 to nSamps
		'' if( sSamps(i).flags and mask ) then
			c += 1
			'' print #h, sSamps(i).sFile & "," & sSamps(i).sPage & "," & str( sSamps(i).flags )
			print #h, sSamps(i).sFile
		'' end if
	next
	close #h

	LogPrint "Saved " + str(c) + " file names to '" + sFileName + "'"

end sub

'' ----------------------------------------------------

'':::::
sub Images_Clear()
	nImages = 0
	maxImages = 1
	redim sImages( 1 to maxImages ) as ImageInfo_t
	imagehash.clear()
end sub

'':::::
sub Images_Add( byref sUrl as string, byref sLink as string, byref sPage as string )

    dim j as integer
	nImages += 1
	if nImages > maxImages then
		maxImages *= 2
		redim preserve sImages( 1 to maxImages )
	end if
	with sImages(nImages)
		.sUrl = Trim(sUrl)
		.sLink = Trim(sLink)
		.sPage = Trim(sPage)
		.flags = FLAG_NONE
/'
		if( imagehash.test( lcase(sFile) ) <> 0 ) then
			.flags or= FLAG_FILE_DUPLICATE
		else
			imagehash.add( lcase(sFile) )
		end if
'/
	end with
	
end sub


'' ----------------------------------------------------

'':::::
sub Links_Clear()
	nLinks = 0
	maxLinks = 1
	redim sLinks( 1 to maxLinks ) as LinkInfo_t
	linkhash.clear()
	linkhash_back.clear()
	linkhash_link.clear()
	linkhash_url.clear()
	linkhash_keyword.clear()
end sub

'':::::
sub Links_Add( byref sName as string, byref sType as string, byref sLink as string )
    dim j as integer
	nLinks += 1
	if nLinks > maxLinks then
		maxLinks *= 2
		redim preserve sLinks( 1 to maxLinks )
	end if
	with sLinks(nLinks)
		.sName = Trim(sName)
		.sType = Trim(sType)
		.sLink = Trim(sLink)
		.flags = FLAG_NONE

		select case lcase( .sType )
		case "back"
			linkhash_back.add( lcase(.sName) + "|" + lcase(.sLink), cast( any ptr, nLinks) )
			.flags or= FLAG_LINK_BACK

			j = cint( pagehash_lcase.getinfo( lcase(.sName) ))
			if( j ) then
				sPages(j).flags or= FLAG_PAGE_HASBACKLINK
			end if

		case "link"
			linkhash_link.add( lcase(.sName) + "|" + lcase(.sLink), cast( any ptr, nLinks) )
			.flags or= FLAG_LINK_LINK

		case "url"
			linkhash_url.add( lcase(.sName) + "|" + lcase(.sLink), cast( any ptr, nLinks) )
			.flags or= FLAG_LINK_URL

		case "keyword"
			linkhash_keyword.add( lcase(.sName) + "|" + lcase(.sLink), cast( any ptr, nLinks) )
			.flags or= FLAG_LINK_KEYWORD

		end select

		select case left( lcase( .sName ), 5 )
		case "keypg"
			.flags or= FLAG_PAGE_KEYPG

		case "catpg", "docto" '' FIXME => doctoc
			.flags or= FLAG_PAGE_CATPG

			j = cint( pagehash_lcase.getinfo( lcase(.sLink) ))
			if( j ) then
				if( lcase(.sName) = "catpgfullindex" ) then
					sPages(j).flags or= FLAG_PAGE_LINKED_FROM_INDEX
				elseif( lcase(.sName) = "catpgfunctindex" ) then
					sPages(j).flags or= FLAG_PAGE_LINKED_FROM_INDEX
				elseif( lcase(.sName) = "catpggfx" ) then
					sPages(j).flags or= FLAG_PAGE_LINKED_FROM_INDEX
				elseif( lcase(.sName) = "catpgopindex" ) then
					sPages(j).flags or= FLAG_PAGE_LINKED_FROM_INDEX
				elseif( lcase(.sName) = "catpgcompopt" ) then
					sPages(j).flags or= FLAG_PAGE_LINKED_FROM_INDEX
				else
					sPages(j).flags or= FLAG_PAGE_LINKED_FROM_CATPG
				end if

			else
				'' LINKS TO NON-EXISTANT PAGE

			end if

		case "propg"
			.flags or= FLAG_PAGE_PROPG

		end select

		select case left( lcase( .sLink ), 5 )
		case "keypg"
			.flags or= FLAG_LINK_KEYPG
		case "catpg"
			.flags or= FLAG_LINK_CATPG
		case "propg"
			.flags or= FLAG_LINK_PROPG
		end select


	end with

end sub

'':::::
sub Links_LoadFromFile( byref sFileName as string )
	dim h as integer
	dim as string sName, sType, sLink

	h = freefile
	open sFileName for input as #h

	while eof(h) = 0
		input #h, sName, sType, sLink
		Links_Add sName, sType, sLink
	wend

	close #h

	logprint "Loaded " + str(nLinks) + " links from '" + sFileName + "'"

end sub

declare sub Links_LoadFromPage( byval j as integer, byval exflags as LINK_FLAGS )

'':::::
sub Links_LoadFromPage_Scan _
	( _
		byval j as integer, _
		byval exflags as LINK_FLAGS, _
		byval wiki as CWiki ptr, _
		byref sPageTitle as string _
	)

	dim as CList ptr tokenlist
	dim as WikiToken ptr token
	dim as string sPage, sItem, sValue, n, sTitle, text, sUrl, sLink
	dim as integer i, k

	tokenlist = wiki->GetTokenList()

	token = tokenlist->GetHead()

	while( token <> NULL )

		if( token->id = WIKI_TOKEN_ACTION ) then

			if lcase(token->action->name) = "fbdoc" then

				sItem = token->action->GetParam( "item")
				sValue = token->action->GetParam( "value")

				select case lcase(sItem)
				case "keyword", "back"

					i = instr(sValue, "|")
					if i > 0 then
						sPage = left(sValue, i - 1)
						sTitle = mid(sValue, i + 1)
					else
						sPage = sValue
						sTitle = ""
					end if
		
					Links_Add sPages(j).sName, lcase(sItem), sPage

					if( lcase(sItem) = "keyword" ) then
						i = cint( pagehash_lcase.getinfo( lcase(sPage) ))
						if( i ) then
							Links_LoadFromPage( i, exflags )
						end if
					end if

				case "title"
					sPageTitle = sValue
				
				case "filename"
					Samps_Add( sValue, sPages(j).sName )

				end select

			elseif lcase(token->action->name) = "image" then

				sUrl = token->action->GetParam( "url")
				sLink = token->action->GetParam( "link")

				Images_Add( sUrl, sLink, sPages(j).sName )


			end if

		elseif( token->id = WIKI_TOKEN_LINK ) then
			if( instr( token->link->url, "://" ) > 0 _
				or instr( token->link->url, "." ) > 0 ) then

				Links_Add sPages(j).sName, "url", token->link->url

			else
				Links_Add sPages(j).sName, "link", token->link->url

				i = cint( pagehash_lcase.getinfo( lcase(token->link->url) ))
				if( i ) then
					Links_LoadFromPage( i, exflags )
				end if

			end if
		end if

		token = tokenlist->GetNext( token )

	wend


end sub

'':::::
function is_fbdoc_title( byval token as WikiToken ptr ) as integer
	dim as string sItem, sValue
	'' ((fbdoc item="title" ...}}
	if( token <> NULL ) then
		if( token->id = WIKI_TOKEN_ACTION ) then
			if lcase(token->action->name) = "fbdoc" then
				sItem = token->action->GetParam( "item" )
				sValue = token->action->GetParam( "value" )
				if( lcase(sItem) = "title" ) then
					return 0
				end if
			end if
		end if
	end if
	return 1
end function

'':::::
function is_horzline( byval token as WikiToken ptr ) as integer
	'' ----
	if( token <> NULL ) then
		if( token->id = WIKI_TOKEN_HORZLINE ) then
			return 0
		end if
	end if
	return 2
end function

'':::::
function is_newline( byval token as WikiToken ptr ) as integer
	'' NEWLINE
	if( token <> NULL ) then
		if( token->id = WIKI_TOKEN_NEWLINE ) then
			return 0
		end if
	end if
	return 3
end function

'':::::
function is_header_text( byval token as WikiToken ptr ) as integer
	'' TEXT
	if( token <> NULL ) then
		if( token->id = WIKI_TOKEN_TEXT ) then
			return 0
		end if
	end if
	return 4
end function

'':::::
#macro CHK_TOKEN( f )
	if( token <> NULL ) then
		if( msg = 0 ) then
			if( msg = 0 ) then msg = f( token )
			token = tokenlist->GetNext( token )
		end if
	end if
#endmacro

''::::
function Links_LoadFromPage_ScanHeader _
	( _
		byref sName as string, _
		byval wiki as CWiki ptr _
	) as integer

	dim as string text, sPage, sItem, sValue, sTitle, n
	dim as CList ptr tokenlist
	dim as WikiToken ptr token
	dim as integer msg

	tokenlist = wiki->GetTokenList()

	msg = 0
	token = tokenlist->GetHead()

	if lcase(left(sName,5)) = "keypg" _
		or lcase(left(sName,3)) = "gfx" _
		or lcase(left(sName,3)) = "src" then

		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )
		CHK_TOKEN( is_header_text )

	elseif lcase(left(sName,5)) = "catpg" then
		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )

	elseif lcase(left(sName,8)) = "compiler" then
		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )

	elseif lcase(left(sName,5)) = "propg" _
		or lcase(left(sName,3)) = "tbl" then

		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )

	elseif lcase(left(sName,7)) = "license" then

		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )


	elseif lcase(left(sName,3)) = "tut" _
		or lcase(left(sName,3)) = "cvs" _
		or lcase(left(sName,3)) = "svn" _
		or lcase(left(sName,3)) = "faq" _
		then

		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )

	else
		msg = - 1

	end if

	
	function = msg

end function


'':::::
sub Links_LoadFromPage _
	( _
		byval j as integer, _
		byval exflags as LINK_FLAGS _
	)

	dim as CWiki ptr wiki
	dim as string f, sBody, sPageTitle

	wiki = new CWiki

	sPageTitle = ""

	sPages(j).flags or= exflags

	if( pagehash_scanned.test( lcase( sPages(j).sName )) ) then
		exit sub
	end if

	pagehash_scanned.add( lcase(sPages(j).sName), cast(any ptr, j) )

	f = cache_dir + sPages(j).sName + ".wakka"

	print ".";

	sBody = LoadFileAsString( f )
	if sBody > "" then
		wiki->Parse( sPages(j).sName, sBody )
		Links_LoadFromPage_Scan( j, exflags, wiki, sPageTitle )
		sPages(j).msg = Links_LoadFromPage_ScanHeader( sPages(j).sName, wiki )
	end if

	delete wiki 
	wiki = NULL

	' !!!
	'if sPageTitle = "" then
	'	sPageTitle = sPages(j).sName
	'end if

	sPages(j).sTitle = sPageTitle

end sub

'':::::
sub Links_LoadFromPages()

	dim as integer j

	logprint "scanning pages:"

	j = cint( pagehash_lcase.getinfo( lcase("DocToc") ))
	if( j ) then
		Links_LoadFromPage( j, FLAG_PAGE_DOCPAGE )
	end if

	for j = 1 to nPages
		Links_LoadFromPage( j, FLAG_NONE )
	next

	logprint
	logprint "Found " + str(nLinks) + " links"

end sub

'':::::
sub Links_SaveToFile( byref sFileName as string )

	dim as integer i, h

	h = freefile

	open sFileName for output as #h
	for i = 1 to nLinks
		with sLinks(i)
			print #h, .sName + "," + .sType + "," + .sLink
		end with
	next

	close #h

	logPrint "Saved " + str(nLinks) + " links to '" + sFileName + "'"

end sub

'':::::
function Links_Exists( byref sPageName as string, byref sLinkName as string, byref sLinkType as string ) as integer
	dim ret as integer

	select case lcase(sLinkType)
	case "back"
		function = linkhash_back.test( lcase(sPageName) + "|" + lcase(sLinkName) )
	case "link"
		function = linkhash_link.test( lcase(sPageName) + "|" + lcase(sLinkName) )
	case "url"
		function = linkhash_url.test( lcase(sPageName) + "|" + lcase(sLinkName) )
	case "keyword"
		function = linkhash_keyword.test( lcase(sPageName) + "|" + lcase(sLinkName) )
	case else
		ret = 0
		ret or= linkhash_back.test( lcase(sPageName) + "|" + lcase(sLinkName) )
		ret or= linkhash_link.test( lcase(sPageName) + "|" + lcase(sLinkName) )
		ret or= linkhash_url.test( lcase(sPageName) + "|" + lcase(sLinkName) )
		ret or= linkhash_keyword.test( lcase(sPageName) + "|" + lcase(sLinkName) )

		function = ret		 
	end select

end function

'' ----------------------------------------------------

'':::::
sub Check_MissingPages()
	dim i as integer
	logprint "Checking missing pages:"
	
	Temps_Clear()

	for i = 1 to nLinks
		if( (sLinks(i).flags and FLAG_LINK_URL ) = 0 ) then
			if Pages_Exists( sLinks(i).sLink, FALSE ) = FALSE then
				Temps_Add( sLinks(i).sLink )
			end if
		end if
	next

	if nTemps = 0 then
		logprint "No missing pages"
	else
		for i = 1 to nTemps
			logprint "Missing page '" + sTemps(i) + "'"
		next
		logprint "Found " + str(nTemps) + " links to missing pages"
	end if
	logprint

end sub

'':::::
sub Check_NameCase( byref outfile as string )
	dim i as integer, c as integer, j as integer, h as integer, body as string

	logprint "Checking mismatched name case in links:"

	Temps_Clear()
	
	c = 0

	for i = 1 to nLinks
		if(( sLinks(i).flags and FLAG_LINK_URL ) = 0 ) then

			j = cint( pagehash_lcase.getinfo( lcase(sLinks(i).sLink ) ))
			if( j ) then
				if( sPages(j).sName <> sLinks(i).sLink ) then
					c += 1
					logprint "'" + sLinks(i).sLink + "' should be '" + sPages(j).sName + "' on page '" + sLinks(i).sName + "'"
					Temps_Add( sLinks(i).sName + "," + sLinks(i).sLink + "," + sPages(j).sName )
					'if outfile > "" then
					'	body = ReadTextFile( cache_dir + sLinks(i).sName + ".wakka" )
					'	if( body > "" ) then
					'		Temps_Add( sLinks(i).sName )
					'		body = ReplaceSubStr( body, sLinks(i).sLink, sPages(j).sName )
					'		WriteTextFile( cache_dir + sLinks(i).sName + ".wakka", body )
					'	end if
					'end if
				end if
			else
				'' FIXME: Link is not a page name
			end if

		end if
	next

	if outfile > "" then
		h = freefile
		open outfile for output as #h
		for i = 1 to nTemps
			print #h, sTemps(i)
		next
		close #h
	end if

	if c = 0 then
		logprint "No mismatched name case in links"
	else
		logprint "Found " + str(c) + " mismatched name case in links"
	end if
	logprint

end sub

'':::::
sub Check_Headers()

	dim as integer i, j, msg, c

	Temps_Clear()

	logprint "Checking headers:"

	for j = 1 to nPages
		
		select case sPages(j).msg
		case 1
			logprint "'" + sPages(j).sName + "' has invalid title"
			c += 1
		case 2
			logprint "'" + sPages(j).sName + "' has invalid horzline"
			c += 1
		case 3
			logprint "'" + sPages(j).sName + "' has invalid newline"
			c += 1
		case 4
			logprint "'" + sPages(j).sName + "' has invalid starting text"
			c += 1
		case -1
			Temps_Add( sPages(j).sName )
		end select

	next

	logprint "Found " + str(c) + " invalid headers"
	logprint

/'
	logprint "Pages not checked for headers"
	if nTemps > 0 then
		for i = 1 to nTemps
			logprint "'" + sTemps(i) + "'"
		next
	end if
	logprint str(nTemps) + " pages(s) not checked."
	logprint
'/

end sub


'':::::
sub Check_DuplicateFilenames()

	dim as integer j, msg, c

	logprint "Checking duplicate filenames:"

	c = 0
	for j = 1 to nSamps
		if( ( sSamps( j ).flags and FLAG_FILE_DUPLICATE ) <> 0 ) then
			logprint "'" & sSamps(j).sPage & "' has duplicate file name '" & sSamps(j).sFile & "'"
			c += 1
		end if
	next

	if c = 0 then
		logprint "No duplicate file names"
	else
		logprint "Found " + str(c) + " pages with duplicate file names"
	end if
	logprint

end sub

'':::::
sub Check_ImageFilenames( byref image_path as string )

	dim as integer i, j, msg, c
	dim as string url, filename

	logprint "Checking Image References:"

	c = 0
	for j = 1 to nImages
		'' Do we have file
		
		url = trim( sImages(j).sUrl )

		filename = GetUrlFileName( url )
		if( filename > "" ) then
			if( fileexists( image_path & filename ) = 0 ) then
				i = cint( pagehash_lcase.getinfo( lcase(sImages(j).sPage) ))
				if( i ) then
					if( ( sPages(i).flags and FLAG_PAGE_DOCPAGE ) <> 0 ) then
						logprint "Missing '" & filename & "', referenced on '" & sImages(j).sPage & "'"
					else
						logprint "Missing '" & filename & "', but is not on a DOC page"
					end if

				else
					logprint "Missing '" & filename & "', referenced on '" & sImages(j).sPage & "', and no page info found"
				end if
				c += 1
			end if
		end if

	next

	if c = 0 then
		logprint "No references to missing image files"
	else
		logprint "Found " + str(c) + " references to missing image files"
	end if
	logprint

end sub

'':::::
sub Check_IndexLinks( byref mode as string )
	dim as integer i
	dim pg as string
	Temps_Clear()

	if( mode = "full" ) then
		pg = "CatPgFullIndex"
	else
		pg = "CatPgFunctIndex"
	end if

	logprint "Checking '" + pg + "':"
	logprint "    Ignoring 'KeyPgOp*' pages"

	for i = 1 to nPages
		if( (sPages(i).flags and FLAG_PAGE_KEYPG) <> 0 ) then
			if( Links_Exists( pg, sPages(i).sName, "" ) = FALSE ) then
				if( Links_Exists( "CatPgOperators", sPages(i).sName, "" ) = FALSE ) then
					if( lcase(sPages(i).sName) = "keypgoperator" ) then
						Temps_Add( sPages(i).sName )
					elseif( lcase(left(sPages(i).sName,7)) = "keypgop" ) then
					else
						Temps_Add( sPages(i).sName )
					end if
				end if
			endif
		end if
	next

	if nTemps = 0 then
		logprint "All keypages on '" + pg + "'"
	else
		for i = 1 to nTemps
			logprint "'" + pg + "' is missing '" + sTemps(i) + "'"
		next
		logprint "Found " + str(nTemps) + " links missing"
	end if
	logprint


end sub

'':::::
sub Check_MissingBacklinks()

	dim as integer i, c, b
	dim pg as string

	logprint "Checking missing backlinks:"
	logprint "    Ignoring missing backlinks to 'catpgfunctindex'"
	logprint "    Ignoring missing backlinks to 'catpgfullindex'"
	logprint "    Ignoring missing backlinks to 'catpggfx'"
	logprint "    Ignoring missing backlinks to 'catpgopindex'"
	logprint "    Ignoring missing backlinks to 'catpgcompopt'"

	c = 0
	for i = 1 to nLinks

		pg = lcase(sLinks(i).sName)

		b = FALSE

			'' and pg <> "catpgprogrammer" _
		
		if( pg <> "catpgfunctindex" _
			and pg <> "catpgfullindex" _
			and pg <> "catpggfx" _
			and pg <> "catpgcompopt" _
			and pg <> "catpgopindex" ) then

			if( sLinks(i).sType <> "back" ) then
				if left(pg, 5) = "catpg" or pg = "doctoc" or pg = "catpgprogrammer" then
					if( sLinks(i).sType = "keyword" ) then
						b = TRUE
					elseif( pg = "doctoc" or pg = "catpgprogrammer" ) then
						b = TRUE
					end if
				end if
			end if
		end if

		if( b ) then
			if( Links_Exists( sLinks(i).sLink, sLinks(i).sName, "" ) = FALSE ) then '' was "back"
				logprint "'" + sLinks(i).sLink + "' does not have backlink to '" + sLinks(i).sName + "'"
				c += 1
			end if
		end if

	next

	if c = 0 then
		logprint "No missing backlinks"
	else
		logprint "Found " + str(c) + " missing backlinks"
	end if

	logprint

end sub

'':::::
sub Check_InvalidBacklinks()

	dim as integer i, c, b
	dim pg as string

	logprint "Checking invalid backlinks:"

	c = 0
	for i = 1 to nLinks

		pg = lcase(sLinks(i).sName)

		b = FALSE

		if( sLinks(i).sType = "back" ) then
			if( lcase(sLinks(i).sLink) = "catpgfunctindex" or lcase(sLinks(i).sLink) = "catpgfullindex" ) then
				b = TRUE
			else
				if( Links_Exists( sLinks(i).sLink, sLinks(i).sName, "" ) = FALSE ) then
					if( lcase(left(pg,7)) = "keypgop" ) then
						if( lcase(sLinks(i).sLink) = lcase("CatPgOperators") ) then
						else
							b = TRUE
						end if
					else
						b = TRUE
					end if
				end if
			end if
		end if

		if( b ) then
			logprint "'" + sLinks(i).sLink + "' should be removed from '" + sLinks(i).sName + "'"
			c += 1
		end if

	next

	if c = 0 then
		logprint "No invalid backlinks"
	else
		logprint "Found " + str(c) + " invalid backlinks"
	end if

	logprint

end sub

'':::::
sub Check_PrintToc()
	'' Find any links missing from PrintToc.wakka

	dim as string f, sPage, sBody
	dim as integer i, c, bFound
	dim wiki as CWiki Ptr
	dim as CList ptr lst
	dim as WikiToken ptr token
	dim as WikiPageLink ptr pagelink

	logprint "Checking PrintToc for missing pages:"

	f = cache_dir + "PrintToc.wakka"
	logprint "Reading '" + f + "'"

	sBody = LoadFileAsString( f )
	if( sBody = "" ) then
		logprint "Page Empty"
		logprint
		exit sub
	end if
	
	wiki = new CWiki
	wiki->Parse( "PrintToc", sBody )
	lst = wiki->GetDocTocLinks( false )

	c = 0
	for i = 1 to nPages
		if( ( sPages(i).flags and FLAG_PAGE_DOCPAGE ) <> 0 ) then

			sPage = sPages(i).sName

			bFound = False

			pagelink = lst->GetHead()
			do while( pagelink <> NULL )
				if( sPage = pagelink->link.url ) then
					bFound = True
					exit do
				end if
				pagelink = lst->GetNext( pagelink )
			loop

			if( bFound = False ) then
				logprint "Missing '" + sPage + "'"
				c += 1
			end if
		end if		
	next

	delete wiki
	wiki = NULL

	logprint "Found " + str(c) + " missing pages"
	logprint

end sub

sub Check_PagesNotLinked()

	dim as integer j, c = 0

	logprint "Checking pages not linked from any CatPg:"

	for j = 1 to nPages
		if( (sPages(j).flags and (FLAG_PAGE_KEYPG or FLAG_PAGE_CATPG or FLAG_PAGE_PROPG)) <> 0 ) then
			if( (sPages(j).flags and FLAG_PAGE_LINKED_FROM_CATPG) = 0 ) then
				c += 1
				logprint "'" + sPages(j).sName + "' not linked from any CatPg"
			end if
		end if
	next

	logprint "Found " + str(c) + " not linked from any CatPg"
	logprint

end sub

sub Check_PagesNoBackLink()

	dim as integer j, c = 0

	logprint "Checking pages with no back link:"

	for j = 1 to nPages
		if( (sPages(j).flags and ( FLAG_PAGE_KEYPG or FLAG_PAGE_CATPG or FLAG_PAGE_PROPG )) <> 0 ) then
			if( (sPages(j).flags and FLAG_PAGE_HASBACKLINK) = 0 ) then
				c += 1
				logprint "'" + sPages(j).sName + "' has no backlink"
			end if
		end if
	next

	logprint "Found " + str(c) + " pages with no backlink at all"

	logprint

end sub

sub Check_DocPagesMissingTitles()

	dim as integer j, c = 0

	logprint "Checking DOC pages with no title:"

	for j = 1 to nPages
		if( (sPages(j).flags and ( FLAG_PAGE_DOCPAGE )) <> 0 ) then
			if( len( sPages(j).sTitle ) = 0 ) then
				c += 1
				logprint "'" + sPages(j).sName + "' has no title"
			end if
		end if
	next

	logprint "Found " + str(c) + " DOC pages with no title"

	logprint

end sub


'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

dim i as integer = 1
dim as string def_cache_dir, web_cache_dir, dev_cache_dir, image_dir

enum OPTIONS
	OPT_MISSING_PAGES = 1
	OPT_FULL_INDEX = 2
	OPT_FUNCT_INDEX = 4
	OPT_LINK_NAME_CASE = 8
	OPT_MISSING_BACKLINK = 16
	OPT_INVALID_BACKLINK = 32
	OPT_NO_BACKLINK = 64
	OPT_HEADERS = 128
	OPT_NOT_LINKED = 256
	OPT_PRINT_TOC = 512

	OPT_LOAD_FROM_FILE = 1024
	OPT_TIMER_LOG = 2048

	OPT_NO_TITLE = 4096
	OPT_DUP_FILE_NAME = 8192

	OPT_IMAGES = 16384

	OPT_ALL_LINKS = _
		OPT_MISSING_PAGES _
		or OPT_FULL_INDEX _
		or OPT_FUNCT_INDEX _
		or OPT_LINK_NAME_CASE _
		or OPT_MISSING_BACKLINK _
		or OPT_INVALID_BACKLINK _
		or OPT_NO_BACKLINK _
		or OPT_NOT_LINKED _
		or OPT_PRINT_TOC _
		or OPT_NO_TITLE _
		or OPT_IMAGES

	OPT_ALL_TOKEN = _
		OPT_HEADERS _
		or OPT_DUP_FILE_NAME

	OPT_ALL = _
		OPT_ALL_LINKS _
		or OPT_ALL_TOKEN

end enum

dim opt as OPTIONS

cache_dir = default_CacheDir

if command(i) = "" then
	print "chkdocs [options]"
	print
	print "options:"
	print "   -web    check cache dir"
	print "   -web+   check web cache dir"
	print "   -dev    check cache dir"
	print "   -dev+   check dev cache dir"
	print
	print "   z       load links from files instead of scanning pages"
	print
	print "   a       perform all link checks ( m full func n b k q c p d f i )"
	print "   m       check missing pages"
	print "   full    check CatPgFullIndex links"
	print "   func    check CatPgFunctIndex links"
	print "   b       check missing backlinks"
	print "   k       check invalid backlinks"
	print "   q       check KeyPg, CatPg, ProPg, no back link at all"
	print "   c       check KeyPg, CatPg, ProPg, not linked from any CatPg"
	print "   p       check missing pages from PrintToc"
	print "   d       doc pages with no title"
	print "   f       check duplicate file names"
	print "   i       check image file names"
	print
	print "   t       perform all token checks ( h n )"
	print "   h       check page headers"
	print "   n       check name case in links"
	print
	print "   e       check everything! ( a t )"
	print
	end 0
end if

'' read defaults from the configuration file (if it exists)
scope
	dim as COptions ptr opts = new COptions( default_optFile )
	if( opts <> NULL ) then
		def_cache_dir = opts->Get( "cache_dir", default_CacheDir )
		web_cache_dir = opts->Get( "web_cache_dir", default_web_CacheDir )
		dev_cache_dir = opts->Get( "dev_cache_dir", default_dev_CacheDir )
		image_dir = opts->Get( "image_dir", default_image_dir )
		delete opts
	else
		'' print "Warning: unable to load options file '" + default_optFile + "'"
		'' end 1
		def_cache_dir = default_CacheDir
		web_cache_dir = default_web_CacheDir
		dev_cache_dir = default_dev_CacheDir
		image_dir = default_image_dir
	end if
end scope

opt = 0

while command(i) > ""
	
	select case lcase(command(i))
	case "-web", "-dev"
		cache_dir = def_cache_dir
	case "-web+"
		cache_dir = web_cache_dir
	case "-dev+"
		cache_dir = dev_cache_dir

	case "z"
		opt or= OPT_LOAD_FROM_FILE

	case "e"
		opt or= OPT_ALL
		opt or= OPT_TIMER_LOG

	case "a"
		opt or= OPT_ALL_LINKS
		opt or= OPT_TIMER_LOG
	case "m"
		opt or= OPT_MISSING_PAGES
	case "full"
		opt or= OPT_FULL_INDEX
	case "func"
		opt or= OPT_FUNCT_INDEX
	case "n"
		opt or= OPT_LINK_NAME_CASE
	case "b"
		opt or= OPT_MISSING_BACKLINK
	case "k"
		opt or= OPT_INVALID_BACKLINK
	case "q"
		opt or= OPT_NO_BACKLINK
	case "c"
		opt or= OPT_NOT_LINKED
	case "p"
		opt or= OPT_PRINT_TOC
	case "d"
		opt or= OPT_NO_TITLE

	case "t"
		opt or= OPT_ALL_TOKEN
		opt or= OPT_TIMER_LOG
	case "h"
		opt or= OPT_HEADERS
	case "f"
		opt or= OPT_DUP_FILE_NAME
	case "i"
		opt or= OPT_IMAGES

	case else
		print "option '"; command(i); "' ignored"
	end select

	i += 1

wend

if( (opt and OPT_ALL) = 0 ) then
	print "No options specified"
	end 1
end if

Timer_Begin()

logopen()

logprint "chkdocs: " + format( now(), "yyyy/mm/dd hh:mm:ss" )
logprint "cache: " & cache_dir
logprint

Timer_Mark("Startup")

''
Pages_Clear
Samps_Clear

Pages_LoadFromFile( PageIndex_File )

Links_Clear

''
if( (opt and OPT_LOAD_FROM_FILE) <> 0 ) then
	Pages_LoadFromFile( DocPages_File, FLAG_PAGE_DOCPAGE )
	Links_LoadFromFile( LinkList_File )
''	Samps_LoadFromFile( SampList_File )
else
	Links_LoadFromPages()
	Links_SaveToFile( LinkList_File )
	Pages_SaveToFile( DocPages_File, FLAG_PAGE_DOCPAGE )
	Samps_SaveToFile( SampList_File )
end if

logprint

Timer_Mark("Page Loading/Scanning")

if( (opt and OPT_MISSING_PAGES) <> 0 ) then
	Check_MissingPages()
	Timer_Mark("Check_MissingPages()")
end if

if( (opt and OPT_FULL_INDEX) <> 0 ) then
	Check_IndexLinks("full")
	Timer_Mark("Check_IndexLinks(""full"")")
end if

if( (opt and OPT_FUNCT_INDEX) <> 0 ) then
	Check_IndexLinks("func")
	Timer_Mark("Check_IndexLinks(""func"")")
end if

if( (opt and OPT_MISSING_BACKLINK) <> 0 ) then
	Check_MissingBacklinks()
	Timer_Mark("Check_MissingBacklinks()")
end if

if( (opt and OPT_INVALID_BACKLINK) <> 0 ) then
	Check_InvalidBacklinks()
	Timer_Mark("Check_InvalidBacklinks()")
end if

if( (opt and OPT_HEADERS) <> 0 ) then
	Check_Headers()
	Timer_Mark("Check_Headers()")
end if
	
if( (opt and OPT_LINK_NAME_CASE) <> 0 ) then
	Check_NameCase( FixList_File )
	'' Check_NameCase( "" )
	Timer_Mark("Check_NameCase()")
end if

if( (opt and OPT_NOT_LINKED) <> 0 ) then
	Check_PagesNotLinked()
	Timer_Mark("Check_PagesNotLinked()")
end if

if( (opt and OPT_NO_BACKLINK) <> 0 ) then
	Check_PagesNoBackLink()
	Timer_Mark("Check_PagesNoBackLink()")
end if

if( (opt and OPT_PRINT_TOC) <> 0 ) then
	Check_PrintToc()
	Timer_Mark("Check_PrintToc()")
end if

if( (opt and OPT_NO_TITLE) <> 0 ) then
	'' Pages included in the downloadable docs that have no title
	Check_DocPagesMissingTitles()
	Timer_Mark("Check_DocPagesMissingTitles()")
end if

if( (opt and OPT_DUP_FILE_NAME) <> 0 ) then
	'' duplicated file names
	Check_DuplicateFilenames()
	Timer_Mark("Check_DuplicateFilenames()")
end if

if( (opt and OPT_IMAGES) <> 0 ) then
	'' Image file names
	Check_ImageFilenames( image_dir )
	Timer_Mark("Check_ImageFilenames()")
end if

logprint
logprint "Execution time: " + str(cint(timer - timers(1).value)) + " seconds."

logclose()

Timer_Mark("Cleanup")

Timer_End()

if( (opt and OPT_TIMER_LOG) <> 0 ) then
	Timer_Dump()
end if

