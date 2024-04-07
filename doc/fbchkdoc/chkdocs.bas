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

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"

'' libs
#inclib "pcre"
#inclib "funcs"

using fb
using fbdoc

enum LINK_FLAGS
	FLAG_NONE                   = 0

	FLAG_LINK_KEYPG				= 1 shl 0   '' dest link page begins with 'KeyPg'
	FLAG_LINK_CATPG				= 1 shl 1   '' dest link page begins with 'CatPg'
	FLAG_LINK_PROPG				= 1 shl 2   '' dest link page begins with 'ProPg'
	FLAG_LINK_DEVPG             = 1 shl 3   '' dest link page begins with 'Dev'

	FLAG_LINK_BACK				= 1	shl 4   '' dest link is {{fbdoc item="back" value=".."}}
	FLAG_LINK_LINK				= 1 shl 5   '' dest link is a wiki link specified with [[ ]]
	FLAG_LINK_URL				= 1 shl 6   '' dest link is an url link specified with [[url]]
	FLAG_LINK_KEYWORD			= 1 shl 7   '' dest link is {{fbdoc item="keyword" value=".."}}

	FLAG_PAGE_KEYPG				= 1 shl 8   '' page name begins with "KeyPg"
	FLAG_PAGE_CATPG				= 1 shl 9   '' page name begins with "CatPg"
	FLAG_PAGE_PROPG				= 1 shl 10  '' page name begins with "ProPg"
	FLAG_PAGE_DEVPG             = 1 shl 11  '' page name begins with 'Dev'

	FLAG_PAGE_DOCPAGE			= 1 shl 12  '' page is reachable from DocToc

	FLAG_PAGE_HASBACKLINK		= 1 shl 13  '' page contains at least one backlink
	FLAG_PAGE_LINKED_FROM_CATPG = 1 shl 14  '' page is linked from DocToc, or CatPg*
	FLAG_PAGE_LINKED_FROM_INDEX = 1 shl 15  '' page is linked from CatPgFunctIndex, CatPgFullIndex, CatPgGfx, CatPgOpIndex, CatPgCompOpt

	FLAG_FILE_NOT_FOUND			= 1 shl 16
	FLAG_FILE_DUPLICATE			= 1 shl 17  '' {{fbdoc item="filename" value="..."}} filename value is used more than once (duplicate)

end enum

const PageIndex_File = hardcoded.default_index_file
const DocPages_File = "DocPages.txt"
const LinkList_File = "linklist.csv"
const FixList_File = "fixlist.txt"
const SampList_File = "samplist.log"

dim shared token_names(0 to WIKI_TOKENS-1) as zstring ptr = _
{ _
	@"WIKI_TOKEN_NULL", _
	@"WIKI_TOKEN_LT", _
	@"WIKI_TOKEN_GT", _
	@"WIKI_TOKEN_BOXLEFT", _
	@"WIKI_TOKEN_BOXRIGHT", _
	@"WIKI_TOKEN_CLEAR", _
	@"WIKI_TOKEN_KBD", _
	@"WIKI_TOKEN_BOLD", _
	@"WIKI_TOKEN_ITALIC", _
	@"WIKI_TOKEN_UNDERLINE", _
	@"WIKI_TOKEN_MONOSPACE", _
	@"WIKI_TOKEN_NOTES", _
	@"WIKI_TOKEN_STRIKE", _
	@"WIKI_TOKEN_CENTER", _
	@"WIKI_TOKEN_HEADER", _
	@"WIKI_TOKEN_NEWLINE", _
	@"WIKI_TOKEN_CODE", _
	@"WIKI_TOKEN_PRE", _
	@"WIKI_TOKEN_LINK", _
	@"WIKI_TOKEN_ACTION", _
	@"WIKI_TOKEN_INDENT", _
	@"WIKI_TOKEN_LIST", _
	@"WIKI_TOKEN_TEXT", _
	@"WIKI_TOKEN_FORCENL", _
	@"WIKI_TOKEN_HORZLINE", _
	@"WIKI_TOKEN_SECT_ITEM", _
	@"WIKI_TOKEN_ACTION_TB", _
	@"WIKI_TOKEN_ACTION_IMG", _
	@"WIKI_TOKEN_BOLD_SECTION", _
	@"WIKI_TOKEN_RAW" _
}

dim shared token_counts(0 to WIKI_TOKENS-1) as integer

'' ----------------------------------------------
'' TIMERS
'' ----------------------------------------------

type timers_t
	text as string
	value as double
	lapsed as double
end type

dim shared as timers_t timers(1 to 30)
dim shared as integer ntimers = 0

'':::::
sub Timer_Begin()
	ntimers += 1
	timers( ntimers ).text = "BEGIN"
	timers( ntimers ).value = timer
	timers( ntimers ).lapsed = 0
end sub

'':::::
sub Timer_Mark( byref text as string )
	ntimers += 1
	timers( ntimers ).text = text
	timers( ntimers ).value = timer
	timers( ntimers ).lapsed = timers( ntimers ).value - timers( ntimers - 1 ).value
end sub

'':::::
sub Timer_End()
	ntimers += 1
	timers( ntimers ).text = "END"
	timers( ntimers ).value = timer
	timers( ntimers ).lapsed = timers( ntimers ).value - timers( 1 ).value
end sub

'':::::
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

'' ----------------------------------------------
'' LOG FILE
'' ----------------------------------------------

dim shared logfileH as integer

'':::::
sub logopen()
	logfileH = freefile
	open "results.txt" for output as #logfileH
end sub

'':::::
sub logprint( byref txt as string = "" )
	'if( txt ) > "" then
		print txt
		if logfileH <> 0 then
			print #logfileH, txt
		end if
	'end if
end sub

'':::::
sub logclose()
	if logfileH <> 0 then
		close #logfileH
	end if
end sub

'':::::
function ReadTextFile( byref sFile as string ) as string
	'' !!!TODO!!! refactor
	return ReadFileAsText( sFile )
end function

'':::::
sub WriteTextFile( byref sFile as string, byref text as string )
	'' !!!TODO!!! refactor
	WriteFileAsText( sFile, text, TRUE )
end sub

'' ----------------------------------------------
'' TEMPORARY LIST
'' ----------------------------------------------

type TempInfo_t
	text as string
	extra as string
end type

redim shared sTemps() as TempInfo_t
redim preserve sTemps(1 to 1) as TempInfo_t
dim shared nTemps as integer = 0, maxTemps as integer = 1

dim shared temphash as HASH

'':::::
sub Temps_Clear ()
	nTemps = 0
	maxTemps = 1
	redim sTemps( 1 to maxTemps ) as TempInfo_t
	temphash.clear()
end sub

'':::::
sub Temps_Add( byref text as string, byref extra as string = "", byval bAllowDup as integer = FALSE )

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
			redim preserve sTemps( 1 to maxTemps ) as TempInfo_t
		end if
		sTemps(i).text = text
		sTemps(i).extra = extra
		temphash.add( text, cast(any ptr, nTemps) )
	end if

end sub

'':::::
function Temps_Exists( byref text as string ) as integer
	function = temphash.test( text )
end function

'' ----------------------------------------------
'' FILES
'' ----------------------------------------------

type FileInfo_t
	sFileName as string
end type

redim shared sFiles() as FileInfo_t
redim preserve sFiles(1 to 1) as FileInfo_t
dim shared nFiles as integer = 0, maxFiles as integer = 1

dim shared filehash as HASH
dim shared filehash_lcase as HASH

'':::::
sub Files_Clear ()
	nFiles = 0
	maxFiles = 1
	redim sFiles( 1 to maxFiles ) as FileInfo_t
	filehash.clear()
	filehash_lcase.clear()
end sub

'':::::
sub Files_Add( byref filename as string, byval bAllowDup as integer = FALSE )

	dim as integer i

	if( bAllowDup <> FALSE ) then
		i = nfiles + 1
	else
		if( filehash.test( filename ) = 0 ) then
			i = nfiles + 1
		end if
	end if

	if( i > nfiles ) then
		nfiles += 1
		if nfiles > maxFiles then
			maxfiles *= 2
			redim preserve sFiles( 1 to maxFiles ) as FileInfo_t
		end if
		sFiles(i).sFileName = filename
		filehash.add( filename, cast(any ptr, nFiles) )
		filehash_lcase.add( lcase( filename ), cast(any ptr, nFiles) )
	end if

end sub

'':::::
sub Files_LoadFromCache( byref path as const string )
	dim as string d

	Files_Clear

	d = dir( path + "*.wakka" )
	while d > ""
		Files_Add left( d, len(d) - 6 )
		d = dir()
	wend

	logprint "Found " & nFiles & " *.wakka files in the cache directory."

end sub

'' ----------------------------------------------
'' PAGES
'' ----------------------------------------------

type SPECIAL_PAGE_INFO
	name as zstring ptr
end type

''
dim shared Special_Pages_tbl( 1 to ... ) as zstring ptr = _
	{ _
		( @"DocToc" ), _
		( @"DevToc" ), _
		( @"CommunityTutorials" ), _
		( @"CatPgFullIndex" ), _
		( @"CatPgFunctIndex" ), _
		( @"CatPgGfx" ), _
		( @"CatPgOpIndex" ), _
		( @"CatPgCompOpt" ) _
	}

enum PAGEINFO_HEADER_MSG
	PAGEINFO_HEADER_MSG_INVALID
	PAGEINFO_HEADER_MSG_NONE
	PAGEINFO_HEADER_MSG_NO_TITLE
	PAGEINFO_HEADER_MSG_NO_HORZLINE
	PAGEINFO_HEADER_MSG_NO_NEWLINE
	PAGEINFO_HEADER_MSG_NO_INTRO_TEXT
end enum

type PageInfo_t
	sName as string
	flags as integer
	sTitle as string
	header_msg as PAGEINFO_HEADER_MSG
End type

redim shared sPages() as PageInfo_t
redim preserve sPages(1 to 1) as PageInfo_t
dim shared nPages as integer = 0, maxPages as integer = 1

dim shared pagehash as HASH
dim shared pagehash_lcase as HASH
dim shared pagehash_keypg as HASH
dim shared pagehash_catpg as HASH
dim shared pagehash_devpg as HASH
dim shared pagehash_scanned as HASH
dim shared pagehash_ops as HASH

'':::::
sub Pages_Clear ()
	nPages = 0
	maxPages = 1
	redim sPages( 1 to maxPages ) as PageInfo_t
	pagehash.clear()
	pagehash_lcase.clear()
	pagehash_catpg.clear()
	pagehash_keypg.clear()
	pagehash_devpg.clear()
	pagehash_scanned.clear()
	pagehash_ops.clear()
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

		case else

			select case lcase(left(d, 3))
			case "dev"
				.flags or= FLAG_PAGE_DEVPG
				pagehash_devpg.add( lcase(.sName), cast(any ptr, nPages) )

			end select

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
	if( bCaseSensitive ) then
		function = pagehash.test( sPageName )
	else
		function = pagehash_lcase.test( lcase(sPageName))
	end if
end function

'' ----------------------------------------------
'' SAMPLES
'' ----------------------------------------------

type SampInfo_t
	sFile as string
	sPage as string
	flags as integer
end type

redim shared sSamps() as SampInfo_t
redim preserve sSamps(1 to 1) as SampInfo_t
dim shared nSamps as integer = 0, maxSamps as integer = 1

dim shared samphash as HASH

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

'' ----------------------------------------------
'' IMAGES
'' ----------------------------------------------

type ImageInfo_t
	sUrl as string
	sLink as string
	sPage as string
	flags as integer
end type

redim shared sImages() as ImageInfo_t
redim preserve sImages(1 to 1) as ImageInfo_t
dim shared nImages as integer = 0, maxImages as integer = 1

dim shared imagehash as HASH

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

'' ----------------------------------------------
'' LINKS
'' ----------------------------------------------

type LinkInfo_t
  sName as string    '' page name (source)
  sType as string    '' link type
  sLink as string    '' destination
  flags as integer
end type

redim shared sLinks() as LinkInfo_t
redim preserve sLinks(1 to 1) as LinkInfo_t
dim shared nLinks as integer = 0, maxLinks as integer = 1

dim shared linkhash as HASH
dim shared linkhash_back as HASH
dim shared linkhash_link as HASH
dim shared linkhash_url as HASH
dim shared linkhash_keyword as HASH

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

		if( left( lcase( .sName ), 5 ) = "keypg" ) then
			.flags or= FLAG_PAGE_KEYPG

		elseif( ( left( lcase( .sName ), 5 ) = "catpg" ) orelse ( lcase( .sName ) = "doctoc" ) ) then
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
		elseif( lcase( .sName ) = "devtoc" ) then
			.flags or= FLAG_PAGE_DEVPG

		elseif( left( lcase( .sName ), 3 ) = "dev" ) then
			.flags or= FLAG_PAGE_DEVPG

		elseif( left( lcase( .sName ), 5 ) = "propg" ) then
			.flags or= FLAG_PAGE_PROPG

		end if

		select case left( lcase( .sLink ), 5 )
		case "keypg"
			.flags or= FLAG_LINK_KEYPG
		case "catpg"
			.flags or= FLAG_LINK_CATPG
		case "propg"
			.flags or= FLAG_LINK_PROPG
		case else
			select case left( lcase( .sLink ), 3 )
			case "dev"
				.flags or= FLAG_LINK_DEVPG
			end select
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

		token_counts( token->id ) += 1

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
			'' normally expect all pages to start with {{{fbdoc item="title" ... }}
			if lcase(token->action->name) = "fbdoc" then
				sItem = token->action->GetParam( "item" )
				sValue = token->action->GetParam( "value" )
				if( lcase(sItem) = "title" ) then
					return PAGEINFO_HEADER_MSG_NONE
				end if
			end if
		end if
	end if
	return PAGEINFO_HEADER_MSG_NO_TITLE
end function

'':::::
function is_horzline( byval token as WikiToken ptr ) as integer
	'' ----
	if( token <> NULL ) then
		if( token->id = WIKI_TOKEN_HORZLINE ) then
			return PAGEINFO_HEADER_MSG_NONE
		end if
	end if
	return PAGEINFO_HEADER_MSG_NO_HORZLINE
end function

'':::::
function is_newline( byval token as WikiToken ptr ) as integer
	'' NEWLINE
	if( token <> NULL ) then
		if( token->id = WIKI_TOKEN_NEWLINE ) then
			return PAGEINFO_HEADER_MSG_NONE
		end if
	end if
	return PAGEINFO_HEADER_MSG_NO_NEWLINE
end function

'':::::
function is_header_text( byval token as WikiToken ptr ) as integer
	'' TEXT
	if( token <> NULL ) then
		if( ( token->id = WIKI_TOKEN_TEXT ) or ( token->id = WIKI_TOKEN_RAW ) )then
			return PAGEINFO_HEADER_MSG_NONE
		end if
	end if
	return PAGEINFO_HEADER_MSG_NO_INTRO_TEXT
end function

''::::
function Links_LoadFromPage_ScanHeader _
	( _
		byref sName as string, _
		byval wiki as CWiki ptr _
	) as integer

	/'
		check that certain kinds of pages start off with correct formats
	'/

	#macro CHK_TOKEN( f )
		if( token <> NULL ) then
			if( msg = PAGEINFO_HEADER_MSG_NONE ) then
				msg = f( token )
				token = tokenlist->GetNext( token )
			end if
		end if
	#endmacro

	#macro SKP_TOKEN( tokenid )
		if( token <> NULL ) then
			if( msg = PAGEINFO_HEADER_MSG_NONE ) then
				if( token->id = tokenid ) then
					token = tokenlist->GetNext( token )
				end if
			end if
		end if
	#endmacro

	dim as string text, sPage, sItem, sValue, sTitle, n
	dim as CList ptr tokenlist
	dim as WikiToken ptr token
	dim as integer msg

	tokenlist = wiki->GetTokenList()

	msg = PAGEINFO_HEADER_MSG_NONE
	token = tokenlist->GetHead()

	if lcase(left(sName,5)) = "keypg" _
		or lcase(left(sName,5)) = "propg" _
		or lcase(left(sName,6)) = "fbwiki" _
		or lcase(left(sName,3)) = "gfx" _
		or lcase(left(sName,3)) = "src" then

		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )
		SKP_TOKEN( WIKI_TOKEN_BOLD )
		CHK_TOKEN( is_header_text )

	elseif lcase(left(sName,5)) = "catpg" then
		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )

	elseif lcase(left(sName,8)) = "compiler" _
		or lcase(left(sName,3)) = "dev" _
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
		or lcase(left(sName,3)) = "ext" _
		then

		CHK_TOKEN( is_fbdoc_title )
		CHK_TOKEN( is_horzline )
		CHK_TOKEN( is_newline )

	else
		msg = PAGEINFO_HEADER_MSG_INVALID

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

	f = app_opt.cache_dir + sPages(j).sName + ".wakka"

	print ".";

	sBody = LoadFileAsString( f )
	if sBody > "" then
		wiki->Parse( sPages(j).sName, sBody )
		Links_LoadFromPage_Scan( j, exflags, wiki, sPageTitle )
		sPages(j).header_msg = Links_LoadFromPage_ScanHeader( sPages(j).sName, wiki )
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

'' ----------------------------------------------
'' CHECKS
'' ----------------------------------------------

'':::::
sub Check_Filenames()

	/' looking for 
	   - duplicate wiki pagenames
	   - duplicate cache filenames
	   - cache filename exists but wiki pagename does not
	   - wiki pagename exists but cache filename does not
	'/

	logprint "Checking that wiki page names match cache filenames:"

	dim i as integer
	dim j as integer
	dim n as integer
	dim found as integer = 0

	'' test for duplicate filenames
	n = 0
	for i = 1 to nFiles
		j = cint( filehash_lcase.getinfo( lcase( sFiles(i).sFileName ) ) )
		if( j <> i ) then
			logprint "file name '" & sFiles(j).sFileName & "' is duplicate of '" & sFiles(i).sFileName
			n += 1
		end if
	next
	if( n = 0 ) then
		logprint "No duplicate *.wakka file names found in the cache directory"
	end if

	'' test for duplicate wiki page names
	n = 0
	for i = 1 to nPages
		j = cint( pagehash_lcase.getinfo( lcase( sPages(i).sName ) ) )
		if( j <> i ) then
			logprint "wiki page '" & sPages(j).sName & "' is duplicate of '" & sPages(i).sName
			n += 1
		end if
	next
	if( n = 0 ) then
		logprint "No duplicate page names found in the wiki page index"
	end if

	'' test for file names that exist, but wiki page is missing
	for i = 1 to nFiles
		if( pagehash.test( sFiles(i).sFileName ) = 0 ) then
			logprint "'" & sFiles(i).sFileName & "' exist in cache dir but not wiki index"
		end if
	next

	'' test for page names that exist, but cache dir filename is missing
	for i = 1 to nPages
		if( filehash.test( sPages(i).sName ) = 0 ) then
			logprint "'" & sPages(i).sName & "' is wiki page but does not exist in cache dir"
		end if
	next 

	logprint

end sub

'':::::
sub Check_DeletedPages()

	/' 
		we are looking for pages that have "!!! DELETE ME !!!"
		as the starting text.  If we find any, remove them
		from our list of pages to scan
	'/

	dim i as integer
	dim sBody as string
	dim f as string
	dim chk as string = "!!! DELETE ME !!!"

	dim keep_pages( 1 to 2, 1 to nPages + 1) as string
	dim n_keep_pages as integer = 0
	dim n_delete_pages as integer = 0
	dim n_empty_pages as integer = 0

	logprint "Checking for deleted pages (pages marked for removal !!! DELETE ME !!!):"

	Temps_Clear()

	for i = 1 to nPages
		f = app_opt.cache_dir + sPages(i).sName + ".wakka"
		sBody = LoadFileAsString( f )
		if( left( ucase( ltrim( sBody, any " " & chr(9))), len( chk ) ) = chk ) then
			n_delete_pages += 1
			Temps_Add( sPages(i).sName )
			logprint "marked for delete '" + sPages(i).sName + "'"
		elseif( trim( sBody, any chr(9, 10, 13, 32) ) = "" ) then
			n_empty_pages += 1
			Temps_Add( sPages(i).sName )
			logprint "empty page '" + sPages(i).sName + "'"
		else
			n_keep_pages += 1
			keep_pages( 1, n_keep_pages ) = sPages(i).sName
			keep_pages( 2, n_keep_pages ) = sPages(i).sTitle
		end if
	next

	if nTemps = 0 then
		logprint "No pages marked for delete and no pages empty"
	else
		logprint "Found " + str( n_delete_pages ) + " pages marked for delete, removed from scan"
		logprint "Found " + str( n_empty_pages ) + " empty pages, removed from scan"
	end if

	'' rebuild the pages list without the deleted pages
	Pages_Clear()

	for i = 1 to n_keep_pages
		Pages_Add( keep_pages(1, i), keep_pages(2, i) )
	next

	logprint str(n_keep_pages) + " pages to be scanned"
	logprint

end sub

'':::::
sub Check_MissingPages()

	/' 
		we are looking for pages (i.e. wanted pages) that have a
		link on (some) page, but do not exist as a topic
		- sometimes gives a false positives since the 
		  link name might be mispelled or incorrect, in 
		  that case, fix the link rather than add the
		  page
	'/

	dim i as integer

	logprint "Checking missing pages (links to non-existant page):"
	
	Temps_Clear()

	for i = 1 to nLinks
		if( (sLinks(i).flags and FLAG_LINK_URL ) = 0 ) then
			if Pages_Exists( sLinks(i).sLink, TRUE ) = FALSE then
				Temps_Add( sLinks(i).sLink, sLinks(i).sName )
			end if
		end if
	next

	if nTemps = 0 then
		logprint "No missing pages (links with no path)"
	else
		for i = 1 to nTemps
			logprint "Missing page '" + sTemps(i).text + "' (first occurance on '" & sTemps(i).extra & "')"
		next
		logprint "Found links to " + str(nTemps) + " missing pages"
	end if
	logprint

end sub

'':::::
sub Check_OrphanPages()

	/' 
		look for pages that are not linked from anywhere
	'/

	dim i as integer
	dim n_orphan as integer

	logprint "Checking orphan pages (pages with no links to them):"
	logprint "    these pages might be CamelCase only links on wiki"
	
	Temps_Clear()

	'' find all pages that are linked to
	for i = 1 to nLinks
		if( (sLinks(i).flags and (FLAG_LINK_LINK or FLAG_LINK_KEYWORD)) <> 0 ) then
			Temps_Add( sLinks(i).sLink )
		end if
	next

	for i = 1 to nPages
		if( temphash.test( sPages(i).sName ) = 0 ) then
			n_orphan += 1
			logprint "orphan page '" + sPages(i).sName + "'"
		end if
	next

	if n_orphan = 0 then
		logprint "No orphan pages"
	else
		logprint "Found links to " + str(n_orphan) + " orphan pages"
	end if
	logprint

end sub

'':::::
sub Check_NameCase( byref outfile as string )

	/'
		we are checking that the link name as it appears in
		the topic matches the case of the topic as it is saved in the
		database.  Mismatched name case can cause problems for html
		links on systems where case of file name is important.
	'/

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
			print #h, sTemps(i).text
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

	/'
		report the results of Links_LoadFromPage_ScanHeader()
		check is not actually made here, we are just reporting the
		results from what was discovered when the page was loaded
		and scanned.
	'/

	dim as integer i, j, msg, c

	Temps_Clear()

	logprint "Checking topic headers:"

	for j = 1 to nPages
		
		select case sPages(j).header_msg
		case PAGEINFO_HEADER_MSG_NO_TITLE
			logprint "'" + sPages(j).sName + "' has invalid title"
			c += 1
		case PAGEINFO_HEADER_MSG_NO_HORZLINE
			logprint "'" + sPages(j).sName + "' has invalid horzline"
			c += 1
		case PAGEINFO_HEADER_MSG_NO_NEWLINE
			logprint "'" + sPages(j).sName + "' has invalid newline"
			c += 1
		case PAGEINFO_HEADER_MSG_NO_INTRO_TEXT
			logprint "'" + sPages(j).sName + "' has invalid starting text"
			c += 1
		case PAGEINFO_HEADER_MSG_INVALID
			Temps_Add( sPages(j).sName )
		end select

	next

	logprint "Found " + str(c) + " invalid headers"
	logprint

	if( app_opt.verbose ) then
		logprint "Pages not checked for valid topic headers"
		if nTemps > 0 then
			for i = 1 to nTemps
				logprint "'" + sTemps(i).text + "'"
			next
		end if
		logprint str(nTemps) + " pages(s) not checked."
		logprint
	end if

end sub


'':::::
sub Check_DuplicateSampleFilenames()

	/'
		report the results of duplicate sample filesname
		check is not acutally done here, we are just reporting
		the results of what was found through Samps_Add()
		and Links_LoadFromPage_Scan()
	'/

	dim as integer j, msg, c

	logprint "Checking for duplicate sample filenames:"

	c = 0
	for j = 1 to nSamps
		if( ( sSamps( j ).flags and FLAG_FILE_DUPLICATE ) <> 0 ) then
			logprint "'" & sSamps(j).sPage & "' has duplicate file name '" & sSamps(j).sFile & "'"
			c += 1
		end if
	next

	if c = 0 then
		logprint "No duplicate sample file names"
	else
		logprint "Found " + str(c) + " pages with duplicate sample file names"
	end if
	logprint

end sub

'':::::
sub Check_ImageFilenames( byref image_path as string )

	/'
		scan through all of the image links found on pages
		and check that we have the image file stored
		in the image_path - report any image files that
		are missing
	'/

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

	/'
		check that the index topics:

		CatPgFullIndex 
		  - has a link to all KeyPg* pages
		  - do not report pages already linked from CatPgOp*

		CatPgFunctIndex
		  - has a link to all KeyPg* pages
		  - do not report pages already linked from CatPgOp*

		CatPgOpIndex
		  - links to CatPgOp* pages that link to KeyPgOp* pages
	'/
	
	dim as integer i
	dim pg as string
	dim opsonly as integer = false
	Temps_Clear()

	select case mode
	case "full"
		pg = "CatPgFullIndex"
	case "func"
		pg = "CatPgFunctIndex"
	case "ops"
		pg = "CatPgOpIndex"
		opsonly = true
	case else
		logprint "Internal error: invalid Check_IndexLinks(""" & mode & """)"
		end 1
	end select

	logprint "Checking '" + pg + "':"

	if( opsonly ) then

		logprint "    Ignoring anything but 'KeyPgOp[A-Z]*' pages"

		for i = 1 to nPages
			if( (sPages(i).flags and FLAG_PAGE_KEYPG) <> 0 ) then
				if( lcase(left(sPages(i).sName,7)) = "keypgop" ) then
					select case mid(sPages(i).sName,8,1)
					case "A" to "Z"
						if( Links_Exists( pg, sPages(i).sName, "" ) = FALSE ) then
							Temps_Add( sPages(i).sName )
						endif
					end select
				end if
			end if
		next

	else

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

	end if

	if nTemps = 0 then
		logprint "All keypages on '" + pg + "'"
	else
		for i = 1 to nTemps
			logprint "'" + pg + "' is missing '" + sTemps(i).text + "'"
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
				if left(pg, 5) = "catpg" or pg = "doctoc" or pg = "catpgprogrammer" or pg = "devtoc" then
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

					'' if it's a Dev* page, always allow backlinks to DevToc and DocToc
					elseif( lcase(left(pg,3)) = "dev" ) then
						if( lcase(sLinks(i).sLink) = lcase("DocToc") ) then
						elseif( lcase(sLinks(i).sLink) = lcase("DevToc") ) then
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

	f = app_opt.cache_dir + "PrintToc.wakka"
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

'':::::
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

'':::::
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

'':::::
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

'':::::
sub Check_TokenUnescapedCamelCase()

	dim i as integer
	dim f as string
	dim sBody as string
	dim text as string
	dim wiki as CWiki Ptr
	dim token as WikiToken ptr
	dim wikipage as string
	
	const PATTERN = $"\b([A-Z]+[a-z]+[A-Z0-9][A-Za-z0-9]*)\b"

	dim re as CRegex ptr = new CRegex( PATTERN, REGEX_OPT_DOTALL )
	
	logprint "Checking DocPages for unescaped camel case links to missing pages:"

	Temps_Clear()

	wiki = new CWiki

	for i = 1 to nPages

		if( ( sPages(i).flags and FLAG_PAGE_DOCPAGE ) <> 0 ) then

			f = app_opt.cache_dir + sPages(i).sName + ".wakka"
			sBody = LoadFileAsString( f )
			wiki->Parse( sPages(i).sName, sBody )

			token = wiki->GetTokenList()->GetHead()
			do while( token <> NULL )

				select case as const token->id
				case WIKI_TOKEN_TEXT

					'' Search text for CamelCase words
					
					dim text as zstring ptr = strptr( token->text )
					if( re->Search( text ) ) then
						dim as integer ofs = 0
						do
							wikipage = *re->GetStr( 0 )
							Temps_Add( wikipage )
							if( Pages_Exists( wikipage, TRUE ) = false ) then
								logprint "'" & sPages(i).sName & "' has """ & *re->GetStr( 0 ) & """"
							end if
						loop while re->SearchNext()
					end if
				end select


				token = wiki->GetTokenList()->GetNext( token )
			loop

		end if

	next

	if( nTemps = 0 ) then
		logprint "No pages with unescaped CamelCase links to missing pages"
	else
		logprint "Found " + str(nTemps) + " pages with unescaped CamelCase links to missing pages"
	end if
	logprint


	delete re
	delete wiki
	wiki = NULL

	logprint "Wiki pages linked only by CamelCase wiki links"

	for i = 1 to nTemps
		logprint "'" + sTemps(i).text + "'"
	next

	if( nTemps = 0 ) then
		logprint "No wiki pages linked only by CamelCase wiki links"
	else
		logprint "Found " + str(nTemps) + " wiki pages linked only by CamelCase wiki links"
	end if
	logprint

end sub

'':::::
function TestForUnescapedHtml _
	( _
		byref text as const string _
	) as boolean

	'' Search text for unescaped html
	'' &amp; &gt; &lt; &quot; &#000 

	dim as string HtmlCodes(0 to ...) = { "amp", "quot", "lt", "gt" } 
	dim i as integer = 1

	do
		i = instr(i, text, "&") 
		if i = 0 then
			return false
		end if

		if( asc( text , i + 1 ) = asc( "#" ) ) then
			dim as integer j = i + 2
			dim as integer c = 0
			do
				select case asc( text, j )
				case asc("0") to asc("9")
					if( c <= 255 ) then c = c * 10 + asc( text, j ) - asc("0")
				case else
					exit do
				end select
				j += 1
			loop
			if c > 0 then
				return true
			end if
		else
			for q as integer = 0 to ubound(HtmlCodes) step 2
				if( mid( text, i + 1, len( HtmlCodes(q) )) = HtmlCodes(q) ) then
					dim as integer j = i + len( HtmlCodes(q) ) + 1
					if( mid( text, j, 1) = ";" ) then 
						return true
					end if
					i += len( HtmlCodes(q+1) ) - 1
					exit for
				end if
			next
		end if

		i += 1
	loop

	return false

end function

'':::::
sub Check_TokenHtml()

	dim i as integer
	dim f as string
	dim sBody as string
	dim text as string
	dim wiki as CWiki Ptr
	dim token as WikiToken ptr
	
	logprint "Checking pages for unescaped HTML:"

	Temps_Clear()

	wiki = new CWiki

	for i = 1 to nPages

		'' if( ( sPages(i).flags and FLAG_PAGE_DOCPAGE ) <> 0 ) then

			f = app_opt.cache_dir + sPages(i).sName + ".wakka"
			sBody = LoadFileAsString( f )
			wiki->Parse( sPages(i).sName, sBody )

			token = wiki->GetTokenList()->GetHead()
			do while( token <> NULL )

				select case as const token->id
				case WIKI_TOKEN_TEXT, WIKI_TOKEN_RAW

					if( TestForUnescapedHtml( token->text ) ) then
						Temps_Add( sPages(i).sName )
						logprint "'" & sPages(i).sName & "'"
						exit do
					end if
				end select

				token = wiki->GetTokenList()->GetNext( token )
			loop

		'' end if

	next

	if( nTemps = 0 ) then
		logprint "No pages with unescaped HTML"
	else
		logprint "Found " + str(nTemps) + " pages with some unescaped HTML"
	end if
	logprint


end sub

'':::::
sub Report_TokenCounts()

	logprint "Token Counts"

	for i as integer = 0 to WIKI_TOKENS-1
		print left( *token_names(i) & space(30), 30 ) & token_counts(i)
	next

	logprint

end sub


'' ----------------------------------------------
'' MAIN
'' ----------------------------------------------

enum OPTIONS
	OPT_NONE = 0

	OPT_MISSING_PAGES    = 1 shl 0
	OPT_FULL_INDEX       = 1 shl 1
	OPT_FUNCT_INDEX      = 1 shl 2
	OPT_LINK_NAME_CASE   = 1 shl 3
	OPT_MISSING_BACKLINK = 1 shl 4
	OPT_INVALID_BACKLINK = 1 shl 5
	OPT_NO_BACKLINK      = 1 shl 6
	OPT_HEADERS          = 1 shl 7
	OPT_NOT_LINKED       = 1 shl 8
	OPT_PRINT_TOC        = 1 shl 9
	OPT_LOAD_FROM_FILE   = 1 shl 10
	OPT_TIMER_LOG        = 1 shl 11
	OPT_NO_TITLE         = 1 shl 12
	OPT_DUP_SAMPLE_FILE  = 1 shl 13
	OPT_IMAGES           = 1 shl 14
	OPT_OPS_INDEX        = 1 shl 15
	OPT_TOKEN_COUNTS     = 1 shl 16
	OPT_TOKEN_CAMEL_CASE = 1 shl 17
	OPT_TOKEN_HTML       = 1 shl 18
	OPT_DELETED_PAGES    = 1 shl 19
	OPT_ORPHAN_PAGES     = 1 shl 20
	OPT_FILENAMES        = 1 shl 21

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
		or OPT_IMAGES _
		or OPT_OPS_INDEX

	OPT_ALL_TOKEN = _
		OPT_HEADERS _
		or OPT_DUP_SAMPLE_FILE _
		or OPT_TOKEN_CAMEL_CASE _
		or OPT_TOKEN_HTML

	OPT_ALL = _
		OPT_ALL_LINKS _
		or OPT_DELETED_PAGES _
		or OPT_ORPHAN_PAGES _
		or OPT_FILENAMES _
		or OPT_ALL_TOKEN

end enum

'' private options
dim opt as OPTIONS = OPT_NONE

'' enable cache
cmd_opts_init( CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_IMAGE or CMD_OPTS_ENABLE_AUTOCACHE )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		cmd_opts_unrecognized_die( i )
	else
		select case lcase(command(i))
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
		case "del"
			opt or= OPT_DELETED_PAGES
		case "o"
			opt or= OPT_ORPHAN_PAGES
		case "full"
			opt or= OPT_FULL_INDEX
		case "func"
			opt or= OPT_FUNCT_INDEX
		case "ops"
			opt or= OPT_OPS_INDEX
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
			opt or= OPT_DUP_SAMPLE_FILE
		case "i"
			opt or= OPT_IMAGES
		case "tc"
			opt or= OPT_TOKEN_COUNTS
		case "cc"
			opt or= OPT_TOKEN_CAMEL_CASE
		case "html"
			opt or= OPT_TOKEN_HTML

		case else
			print "option '"; command(i); "' ignored"
		end select
	end if
	i += 1
wend	

if( app_opt.help ) then
	print "chkdocs [options]"
	print
	print "options:"
	print "   z       load links from files instead of scanning pages"
	print
	print "   a       perform all link checks ( m full func ops n b k q c p d f i )"
	print "   m       check missing pages"
	print "   full    check CatPgFullIndex links"
	print "   func    check CatPgFunctIndex links"
	print "   ops     check CatPgOpIndex links"
	print "   b       check missing backlinks"
	print "   k       check invalid backlinks"
	print "   q       check KeyPg, CatPg, ProPg, no back link at all"
	print "   c       check KeyPg, CatPg, ProPg, not linked from any CatPg"
	print "   p       check missing pages from PrintToc"
	print "   d       doc pages with no title"
	print "   f       check duplicate file names"
	print "   i       check image file names"
	print
	print "   t       perform all token checks ( h n cc html)"
	print "   h       check page headers"
	print "   n       check name case in links"
	print "   tc      report token counts"
	print "   cc      report unescaped camel case word"
	print "   html    report unescaped html in normal text"
	print
	print "   del     check deleted pages"
	print "   o       check orphaned pages"
	print
	print "   e       check everything! ( a t del o )"
	print
	cmd_opts_show_help( "check" )
	print
	end 0
end if

cmd_opts_resolve()
cmd_opts_check_cache()
cmd_opts_check_url()

if( (opt and OPT_ALL) = 0 ) then
	print "No options specified"
	end 1
end if

'' ----------------------------------------------

Timer_Begin()

logopen()
logprint "chkdocs: " + format( now(), "yyyy/mm/dd hh:mm:ss" )
logprint "cache: " & app_opt.cache_dir
logprint

Timer_Mark("Startup")

''
Pages_Clear
Files_Clear
Samps_Clear

Files_LoadFromCache( app_opt.cache_dir )
Pages_LoadFromFile( PageIndex_File )

logprint

if( (opt and OPT_FILENAMES) <> 0 ) then
	Check_FileNames()
	Timer_Mark("Check_Cache_FileNames()")
end if

if( (opt and OPT_DELETED_PAGES) <> 0 ) then
	Check_DeletedPages()
	Timer_Mark("Check_DeletedPages()")
end if

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

if( (opt and OPT_ORPHAN_PAGES) <> 0 ) then
	Check_OrphanPages()
	Timer_Mark("Check_OrpanPages()")
end if

if( (opt and OPT_FULL_INDEX) <> 0 ) then
	Check_IndexLinks("full")
	Timer_Mark("Check_IndexLinks(""full"")")
end if

if( (opt and OPT_FUNCT_INDEX) <> 0 ) then
	Check_IndexLinks("func")
	Timer_Mark("Check_IndexLinks(""func"")")
end if

if( (opt and OPT_OPS_INDEX) <> 0 ) then
	Check_IndexLinks("ops")
	Timer_Mark("Check_IndexLinks(""ops"")")
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

if( (opt and OPT_DUP_SAMPLE_FILE) <> 0 ) then
	'' duplicated sample file names
	Check_DuplicateSampleFilenames()
	Timer_Mark("Check_DuplicateSampleFilenames()")
end if

if( (opt and OPT_IMAGES) <> 0 ) then
	'' Image file names
	Check_ImageFilenames( app_opt.image_dir )
	Timer_Mark("Check_ImageFilenames()")
end if

if( (opt and OPT_TOKEN_COUNTS) <> 0 ) then
	'' token counts
	Report_TokenCounts()
	Timer_Mark("Report_TokenCounts()")
end if

if( (opt and OPT_TOKEN_CAMEL_CASE) <> 0 ) then
	'' find unescaped camel case words
	Check_TokenUnescapedCamelCase()
	Timer_Mark("Check_TokenUnescapedCamelCase()")
end if

if( (opt and OPT_TOKEN_HTML) <> 0 ) then
	'' find html escapes in text
	Check_TokenHtml()
	Timer_Mark("Check_TokenHtml()")
end if

logprint
logprint "Execution time: " + str(cint(timer - timers(1).value)) + " seconds."

logclose()

Timer_Mark("Cleanup")

Timer_End()

if( (opt and OPT_TIMER_LOG) <> 0 ) then
	Timer_Dump()
end if

