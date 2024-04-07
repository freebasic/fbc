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

'' samps.bas - manage wiki example source files

'' chng: written [jeffm]

'' fb headers
#include once "dir.bi"

'' fbdoc headers
#include once "hash.bi"
#include once "CWiki.bi"
#include once "CWikiCache.bi"
#include once "COptions.bi"

'' fbchkdoc headers
#include once "buffer.bi"
#include once "funcs.bi"
#include once "samps_logfile.bi"
#include once "samps_file.bi"
#include once "samps_wiki.bi"
#include once "fbchkdoc.bi"
#include once "fbdoc_keywords.bi"

#inclib "fbdoc"
#inclib "pcre"

using fb
using fbdoc

type REFTYPE
	filename as string
	id as string
	pagename as string
	codeidx as integer
end type

enum COMMAND_OPTION
	opt_do_scan          = 1
	opt_do_refids        = 2
	opt_do_pageids       = 4
	opt_get_pages        = 8
	opt_do_scan_incoming = 16
end enum

type COMMAND_TYPE
	name as zstring ptr
	opts as COMMAND_OPTION
	cmdproc as function() as integer
	helpopts as zstring ptr
	helpdesc as zstring ptr
end type

enum COMMAND_ID
	cmd_none
	cmd_help
	cmd_list
	cmd_pagelist
	cmd_check
	cmd_checkex
	cmd_lf
	cmd_crlf
	cmd_insert
	cmd_extract
	cmd_update
	cmd_set_fb
	cmd_set_getex
	cmd_namefix
	cmd_killref
	cmd_move
	cmd_addlang

	cmd_count
end enum

declare function cmd_none_proc() as integer
declare function cmd_help_proc() as integer
declare function cmd_list_proc() as integer
declare function cmd_pagelist_proc() as integer
declare function cmd_check_proc() as integer
declare function cmd_checkex_proc() as integer
declare function cmd_lf_proc() as integer
declare function cmd_crlf_proc() as integer
declare function cmd_insert_proc() as integer
declare function cmd_extract_proc() as integer
declare function cmd_update_proc() as integer
declare function cmd_set_fb_proc() as integer
declare function cmd_getex_proc() as integer
declare function cmd_namefix_proc() as integer
declare function cmd_killref_proc() as integer
declare function cmd_move_proc() as integer
declare function cmd_addlang_proc() as integer

dim shared commands( 0 to cmd_count - 1 ) as COMMAND_TYPE = { _
	( @"",         0                            , @cmd_none_proc,      @""                      , @"" ), _
	( @"help",     0                            , @cmd_help_proc,      @""                      , @"displays help"  ), _
	( @"list",     opt_do_scan or opt_do_pageids, @cmd_list_proc,      @"[dirs...]"             , @"lists files in source directory"  ), _
	( @"pagelist", opt_do_scan or opt_do_pageids, @cmd_pagelist_proc,  @"[dirs...]"             , @"lists pages referenced by sources"  ), _
	( @"check",    opt_get_pages                , @cmd_check_proc,     @"[pages...] [@pagelist]", @"checks for differences between pages and files" ), _
	( @"checkex",  opt_do_scan or opt_do_pageids, @cmd_checkex_proc,   @"[dirs...]"             , @"checks for dropped example files" ), _
	( @"lf",       opt_do_scan                  , @cmd_lf_proc,        @"[dirs...]"             , @"rewrites files with LF line endings" ), _
	( @"crlf",     opt_do_scan                  , @cmd_crlf_proc,      @"[dirs...]"             , @"rewrites files with CRLF line endings" ), _
	( @"insert",   opt_do_scan or opt_do_refids , @cmd_insert_proc,    @"[dirs...]"             , @"inserts *old* sources to pages" ), _
	( @"extract",  opt_get_pages                , @cmd_extract_proc,   @"[pages...] [@pagelist]", @"extracts sample files from pages (optional --force)" ), _
	( @"update",   opt_get_pages                , @cmd_update_proc,    @"[pages...] [@pagelist]", @"updates pages with sample files" ), _
	( @"setfb",    opt_get_pages                , @cmd_set_fb_proc,    @"[pages...] [@pagelist]", @"set freebasic code tags" ), _
	( @"getex",    opt_get_pages                , @cmd_getex_proc,     @"[pages...] [@pagelist]", @"extract unnamed examples (optional --force)" ), _
	( @"namefix",  opt_do_scan                  , @cmd_namefix_proc,   @"[dirs...]"             , @"fix embedded filenames" ), _
	( @"killref",  opt_do_scan                  , @cmd_killref_proc,   @"[dirs...]"             , @"delete embedded $$REF: magic" ), _
	( @"move",     opt_do_scan_incoming         , @cmd_move_proc,      @""                      , @"move files from incoming to other path/name" ), _
	( @"addlang",  opt_do_scan or opt_do_pageids, @cmd_addlang_proc,   @"[dirs...]"             , @"add #lang (optional --force)" ) _
}

'' !!! FIXME !!! - these should not be fixed size
dim shared dirs() as string, ndirs as integer
dim shared files(1 to 4000) as string, nfiles as integer = 0
dim shared filters(1 to 400) as string, nfilters as integer = 0
dim shared exfilters(1 to 400) as string, nexfilters as integer = 0
dim shared refs( 1 to 4000 ) as REFTYPE

dim shared as string sample_dir
dim shared as string base_dir
dim shared as string manual_dir
dim shared as string wiki_cache_dir

dim shared as integer pageCount
dim shared pageList() as string
dim shared wikicache as CWikiCache ptr = NULL

dim shared opt_force as boolean = false

'' ==========
'' COMMANDS
'' ==========

function cmd_none_proc() as integer
	logprint "This should never be called!!! INTERNAL ERROR."
	function = FALSE
end function

function cmd_help_proc() as integer
	dim i as integer = any
	print "samps command [options]"
	print
	for i = 1 to cmd_count - 1
		print *commands(i).name & " " & *commands(i).helpopts
		print "    (" + *commands(i).helpdesc + ")"
		print
	next
	function = TRUE
end function

function cmd_list_proc() as integer
	dim i as integer = any
	for i = 1 to nfiles
		'' logprint files(i) & "," & refs(i).filename & "," & refs(i).pagename
		logprint sample_dir & files(i)
	next
	function = TRUE
end function

function cmd_pagelist_proc() as integer
	dim pagelist(1 to nfiles) as string
	dim as integer i,j,n = 0
	for i = 1 to nfiles
		for j = 1 to n
			if( pagelist(j) = refs(i).pagename ) then
				exit for
			end if
		next
		if( j > n ) then
			n += 1
			pagelist(n) = refs(i).pagename
		end if
	next
	dim h as integer = freefile
	open "exlist.txt" for output as #h
	for i = 1 to n
		logprint pagelist(i)
		print #h,pagelist(i)
	next
	close #h
	function = TRUE
end function

function cmd_check_proc() as integer

	dim i as integer = any
	dim as string sPage, sBody, filename, text
	dim as buffer b1, b2

	dim as string ret
	for i = 1 to pageCount

		sPage = pageList(i)

		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			logprint "Error while loading '" + sPage + "'"
		else
			dim as CWiki Ptr wiki = new CWiki
			wiki->Parse( sPage, sBody )
			dim wikiex as WikiExample ptr = new WikiExample( wiki )
			while( wikiex->FindNext() )
				if( wikiex->filename > "" ) then
					text = ReadExampleFile( base_dir, wikiex->filename, TRUE, TRUE )
					if( text = "" ) then
						logprint sPage & " : " & wikiex->filename & " : MISSING"
					else
						b1.text = text
						b2.text = wikiex->text
						if( CompareBuffersEqual( b1, b2 ) = FALSE ) then
							logprint sPage & " : " & wikiex->filename & " : CHANGED"
						end if
					end if
				end if
			wend
			delete wikiex
			delete wiki
		end if

	next

	function = TRUE

end function

function cmd_checkex_proc() as integer

	dim i as integer = any
	dim as string sPage, sBody
	dim as integer bFound

	for i = 1 to nfiles

		'' Open the sample file and test that the filename still exists on the the page

		bFound = FALSE

		sPage = refs(i).pagename

		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			logprint "Error while loading '" + sPage + "' from " + refs(i).filename
		else
			dim as CWiki Ptr wiki = new CWiki
			wiki->Parse( sPage, sBody )
			dim wikiex as WikiExample ptr = new WikiExample( wiki )
			while( wikiex->FindNext() )
				if( wikiex->filename > "" ) then
					if( wikiex->filename = "examples/manual/" & refs(i).filename ) then
						bFound = TRUE
						exit while
					end if
				end if
			wend
			delete wikiex
			delete wiki

			if( bFound = FALSE ) then
				print sPage & " does not have: "; refs(i).filename
			end if

		end if


	next

	function = TRUE

end function

function cmd_lf_proc() as integer
	dim i as integer = any
	for i = 1 to nfiles
		logprint "Rewriting '" & files(i) & "'"
		RewriteFileEOL( base_dir & sample_dir, files(i), chr(10) )
	next 
	function = TRUE	
end function

function cmd_crlf_proc() as integer
	dim i as integer = any
	for i = 1 to nfiles
		logprint "Rewriting '" & files(i) & "'"
		RewriteFileEOL( base_dir & sample_dir, files(i), chr(13,10) )
	next 
	function = TRUE
end function

function cmd_insert_proc() as integer
	dim x as string, b1 as buffer, b2 as buffer
	dim i as integer = any
	dim sPage as string
	dim sBody as string
	
	for i = 1 to nfiles

		'' Only insert files that have a $$REFID
		if( refs(i).codeidx > 0 ) then

			logprint refs(i).filename & " => " & refs(i).pagename & "(" & refs(i).codeidx & ") : ", TRUE

			x = ReadExampleFile( base_dir & sample_dir, refs(i).filename, TRUE )
			b1.text = x

			if( b1.item(1) <> "" ) then
				b1.insert(1 , "" )
			end if

			x = b1.text_lf

			dim as CWiki Ptr wiki = new CWiki
			sPage = refs(i).PageName

			if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
				logprint "Error loading '" + sPage + "'"
			else
				wiki->Parse( sPage, sBody )
				dim wikiex as WikiExample ptr = new WikiExample( wiki )
				if( wikiex->Find( refs(i).codeidx ) ) then
					b2.text = wikiex->text
					if(( sample_dir & refs(i).filename <> wikiex->filename ) _
						or ( CompareBuffersEqual( b1, b2 ) = FALSE )) then

						wikiex->filename = sample_dir & refs(i).filename
						wikiex->text = b1.text_lf()
						if( right( refs(i).filename, 4 ) = ".bas" ) then
							wikiex->lang = "freebasic"
						elseif( right( refs(i).filename, 2 ) = ".c" ) then
							wikiex->lang = "c"
						else
							wikiex->lang = ""
						end if

						sBody = wiki->Build()
						logprint "Writing " & sample_dir & refs(i).filename & " to " & sPage
						if( WriteFileAsText( wiki_cache_dir & sPage & ".wakka", sBody, TRUE ) = FALSE ) then
							logprint "Error writing " & wiki_cache_dir & sPage & ".wakka"
						end if

					else
						logprint "SKIPPED: already added"
					end if
				else
					logprint "ERROR: Could not find code example #" & refs(i).codeidx
				end if
			end if
		end if

	next

	function = TRUE

end function

function cmd_extract_proc() as integer

	dim i as integer = any
	dim as string sPage, sBody, filename

	dim as string ret
	for i = 1 to pageCount

		sPage = pageList(i)

		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			logprint "Error loading '" + sPage + "'"
		else
			dim as CWiki Ptr wiki = new CWiki
			wiki->Parse( sPage, sBody )
			dim wikiex as WikiExample ptr = new WikiExample( wiki )
			while( wikiex->FindNext() )
				if( wikiex->filename > "" ) then
				'' !!! FIXME !!! - only allow "examples/manual/"
					if( left( wikiex->filename, len( sample_dir ) ) = sample_dir ) then
						if( WriteExampleFile( sPage, base_dir, wikiex->filename, wikiex->text, TRUE, "", opt_force, wiki->GetPageTitle( ) ) ) then
							''
						end if
					else
						logprint "Invalid path/filename for example"
					end if
				end if
			wend
			delete wikiex
			delete wiki
		end if

	next

	function = TRUE

end function

function cmd_update_proc() as integer
	dim i as integer = any
	dim as string sPage, sBody, filename, text
	dim as buffer b1, b2
	dim as string changes(1 to 1000)
	dim as integer nchanges = 0

	dim as string ret
	for i = 1 to pageCount

		sPage = pageList(i)

		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			logprint "Error while loading '" + sPage + "'"
		else
			dim as CWiki Ptr wiki = new CWiki
			wiki->Parse( sPage, sBody )
			dim wikiex as WikiExample ptr = new WikiExample( wiki )
			while( wikiex->FindNext() )
				if( wikiex->filename > "" ) then
					text = ReadExampleFile( base_dir, wikiex->filename, TRUE )
					b1.text = text
					b2.text = wikiex->text
					if( CompareBuffersEqual( b1, b2 ) = FALSE ) then
						wikiex->text = b1.text_lf()
						sBody = wiki->Build()
						logprint "Writing " & wikiex->filename & " to " & sPage
						if( WriteFileAsText( wiki_cache_dir & sPage & ".wakka", sBody, TRUE ) = FALSE ) then
							logprint "Error writing " & wiki_cache_dir & sPage & ".wakka"
						else
							nchanges += 1
							changes(nchanges) = sPage
						end if
					end if
				end if
			wend
			delete wikiex
			delete wiki
		end if

	next

	dim h as integer
	h = freefile
	open "changed.txt" for output as #h
	for i = 1 to nchanges
		print #h, " - " & changes(i) & " ? [example updated from repo]"
	next
	close #h

	function = TRUE

end function

function cmd_set_fb_proc() as integer
	dim i as integer = any
	dim as string sPage, sBody
	dim as string ret

	for i = 1 to pageCount

		sPage = pageList(i)

		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			logprint "Error while loading '" + sPage + "'"
		else
			dim as CWiki Ptr wiki = new CWiki
			wiki->Parse( sPage, sBody )
			dim wikiex as WikiExample ptr = new WikiExample( wiki )
			while( wikiex->FindNext() )
					wikiex->lang = "freebasic"
			wend
			sBody = wiki->Build()
			wikicache->SavePage( sPage, sBody )
			delete wikiex
			delete wiki
		end if

	next

	function = TRUE

end function

function cmd_getex_proc() as integer

	dim i as integer = any
	dim as string sPage, sBody
	dim as string ret

	for i = 1 to pageCount

		sPage = pageList(i)

'		if( lcase( left( spage, 3 )) <> "tut" ) then
'		if( lcase( left( spage, 5 )) <> "propg" ) then

		if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
			logprint "Error while loading '" + sPage + "'"
		else
			dim as CWiki Ptr wiki = new CWiki
			wiki->Parse( sPage, sBody )
			dim wikiex as WikiExample ptr = new WikiExample( wiki )
			while( wikiex->FindNext() )
				if( wikiex->filename = "" ) then
					WriteExampleFile( sPage, base_dir, sample_dir & "incoming/" & wikiex->refid & ".bas", wikiex->text, FALSE, wikiex->refid, opt_force, wiki->GetPageTitle( ) )
				end if
			wend
			delete wikiex
			delete wiki
		end if

'		end if
'		end if

	next

	function = TRUE

end function

sub DoFileNameFix( byref basedir as string, byref filename as string )

	dim i as integer, j as integer, x as string, c as integer = FALSE
	dim b as buffer

	x = ReadFileAsText( basedir & filename )	

	if( x > "" ) then
		b.text = x

		for i = 1 to b.count
			j = instr( b.item(i), "examples/manual/" )
			if( j > 0 ) then
				exit for
			end if
		next

		if( i > b.count ) then
			logprint "ERROR: '" & filename & "': no embedded file name"
		else
			x = "'' examples/manual/" & filename
			if( b.item(i) <> x ) then
				b.item(i) = x
				logprint "Writing '" & basedir & filename & "': ", TRUE

				if( WriteFileAsText( basedir & filename, b.text, TRUE ) ) then
					logprint "OK"
				else
					logprint "Failed"
				end if

			end if
		end if

	end if
	
end sub

function cmd_namefix_proc() as integer

	dim i as integer = any
	dim as string sPage, sBody
	dim as string ret

	for i = 1 to nfiles
		DoFileNameFix( base_dir & sample_dir, files(i) )
	next

	function = TRUE

end function

sub DoDeleteRefID( byref basedir as string, byref filename as string )

	dim i as integer, j as integer, x as string, c as integer = FALSE
	dim b as buffer, n as integer

	x = ReadFileAsText( basedir & filename )	

	if( x > "" ) then
		b.text = x

		n = b.count
		for i = n to 1 step -1
			j = instr( b.item(i), "$$REF:" )
			if( j > 0 ) then
				b.remove(i)
			end if
		next

		if( n <> b.count ) then
			logprint "Writing '" & basedir & filename & "': ", TRUE
			if( WriteFileAsText( basedir & filename, b.text, TRUE ) ) then
				logprint "OK"
			else
				logprint "Failed"
			end if

		end if

	end if
	
end sub

function cmd_killref_proc() as integer

	dim i as integer = any

	for i = 1 to nfiles
		DoDeleteRefID( base_dir & sample_dir, files(i) )
	next

	function = TRUE

end function

sub DoMove( byref src_basedir as string, byref filename as string, byref dst_basedir as string )

	dim x as string, s as string
	dim b as buffer
	dim i as integer

	x = ReadFileAsText( src_basedir & filename )

	b.text = x

	print "------------------------------------------------------------"

	for i = 1 to b.count
		print b.item(i)
	next

	print
	print "File: "; filename

	do
		print "    : examples/manual/";

		line input s

		if( s > "" ) then

			if( instr(s, "." ) = 0 ) then
				s &= ".bas"
			end if

			print "Writing '" & dst_basedir & s & "': ";
			if( WriteFileAsText( dst_basedir & s, b.text ) ) then
				print "OK"
				kill src_basedir & filename
				exit do
			else
				print "Failed"
			end if
		else
			print "SKIPPED"
			exit do

		end if

	loop

end sub

function cmd_move_proc() as integer

	dim i as integer = any
	dim as string sPage, sBody
	dim as string ret

	for i = 1 to nfiles
		DoMove( base_dir & sample_dir, files(i), base_dir & sample_dir )
	next

	function = TRUE

end function

function cmd_addlang_proc() as integer

	dim i as integer = any, j as integer = any
	dim as string text, x
	dim as buffer b1


	for i = 1 to nfiles
		
		dim docheck as integer = TRUE
		dim changed as integer = FALSE

		x = ReadExampleFile( base_dir & sample_dir, refs(i).filename, TRUE )

		b1.text = x

		if( x > "" ) then
			'' have #lang/$lang already?

			for j = 1 to b1.count
				x = b1.item(j)

				if( instr( x, "$lang" ) > 0 ) then
					docheck = FALSE
					if( trim( b1.item(j+1) ) <> "" ) then
						b1.insert( j + 1, "" )
						changed = TRUE
					end if
					exit for
				end if

				if( instr( x, "#lang" ) > 0 ) then
					docheck = FALSE
					if( trim( b1.item(j+1) ) <> "" ) then
						b1.insert( j + 1, "" )
						changed = TRUE
					end if
					exit for
				end if

			next
		end if

		if( docheck ) then

			for j = 1 to b1.count
				x = b1.item(j)

				if instr( lcase(x), "-lang deprecated" ) > 0 then
					changed = TRUE
					b1.insert( j + 1, "#lang ""deprecated""" )
					b1.insert( j + 1, "" )
					exit for

				elseif instr( lcase(x), "-lang fblite" ) > 0 then
					changed = TRUE
					b1.insert( j + 1, "#lang ""fblite""" )
					b1.insert( j + 1, "" )
					exit for

				elseif instr( lcase(x), "-lang qb" ) > 0 then
					changed = TRUE
					b1.insert( j + 1, "'$lang: ""qb""" )
					b1.insert( j + 1, "" )
					exit for

				end if

			next

		end if

		if( changed ) then
			text = b1.text()
			if( WriteExampleFile( refs(i).pagename, base_dir, sample_dir & refs(i).filename, text, TRUE, "", opt_force, "" ) ) then
				''
			end if
		end if

	next

	function = TRUE

end function


'' ==========
'' MAIN
'' ==========

dim i as integer, bAbort as integer = FALSE
dim cmd as COMMAND_ID = cmd_none
dim opt as COMMAND_OPTION

sample_dir = "examples/manual/"

'' read defaults from the configuration file (if it exists)
scope
	'' !!! FIXME !!! - this should use cmd_opts.bas
	dim as COptions ptr opts = new COptions( hardcoded.default_ini_file )
	if( opts <> NULL ) then
		manual_dir = opts->Get( "manual_dir", hardcoded.default_manual_dir )
		wiki_cache_dir = opts->Get( "cache_dir", hardcoded.default_def_cache_dir )
		base_dir = opts->Get( "fb_dir", hardcoded.default_fb_dir )
		delete opts
	else
		manual_dir = hardcoded.default_manual_dir
		wiki_cache_dir = hardcoded.default_def_cache_dir
		base_dir = hardcoded.default_fb_dir
	end if
end scope

'' Which command?
for i = 0 to cmd_count - 1
	if( *commands(i).name = lcase(command(1)) ) then
		cmd = i
		opt = commands(i).opts
		exit for
	end if
next

if( i > cmd_count - 1 ) then
	print "invalid command"
	end 1
end if

if( cmd = cmd_none or cmd = cmd_help ) then
	commands(cmd_help).cmdproc()
	end 0
end if

'' ==========

logopen()

	logprint "base_dir: " & base_dir
	logprint "manual_dir: " & manual_dir
	logprint "cache: " & wiki_cache_dir

	FormatFbCodeLoadKeywords( manual_dir & "templates/default/keywords.lst" )

if( (opt and opt_do_scan) <> 0 or (opt and opt_do_scan_incoming) <> 0 ) then

	if( (opt and opt_do_scan_incoming) <> 0 ) then
		nfilters = 1
		filters(nfilters) = "incoming/"
	else
		nexfilters = 0
		nexfilters += 1 : exfilters(nexfilters) = "incoming/"
		nexfilters += 1 : exfilters(nexfilters) = "remove/"
		nexfilters += 1 : exfilters(nexfilters) = "fail/"
	end if

	i = 2
	while( command(i) > "" )
		nfilters += 1
		'' !!! FIXME !!! - do check for "/"
		filters(nfilters) = command(i) & "/"
		i += 1
	wend

	logprint "Scanning directories..."
	ScanSourceDirsAndFiles( base_dir & sample_dir, dirs(), ndirs, files(), nfiles, filters(), nfilters, exfilters(), nexfilters )
end if

if( (opt and opt_do_refids) <> 0 ) then

	dim x as string, b as buffer
	
	logprint "Getting $$REFIDS..."

	for i = 1 to nfiles

		refs(i).filename = files(i)

		x = ReadFileAsText( base_dir & sample_dir & files(i) )	
		if( x > "" ) then
			b.text = x
			refs(i).id = GetRefID( b )
			SplitRefID( refs(i).id, refs(i).pagename, refs(i).codeidx )
		else
			refs(i).id = ""
			refs(i).pagename = ""
			refs(i).codeidx = -1
		end if

	next
end if

if( (opt and opt_do_pageids) <> 0 ) then

	dim x as string, b as buffer
	
	logprint "Getting Page Ids..."

	for i = 1 to nfiles

		refs(i).filename = files(i)

		x = ReadFileAsText( base_dir & sample_dir & files(i) )	
		if( x > "" ) then
			b.text = x
			refs(i).id = GetPageID( b )
			refs(i).pagename = refs(i).id
			refs(i).codeidx = -1
		else
			refs(i).id = ""
			refs(i).pagename = ""
			refs(i).codeidx = -1
		end if

	next
end if

if( (opt and opt_get_pages) <> 0 ) then

	pageCount = 0
	redim pageList(1 to 1) as string
	dim as string cmt
	dim as long rev
	i = 2
	while command(i) > ""
		if left( command(i), 1) = "@" then
			scope
				dim h as integer, x as string
				h = freefile
				if open( mid(command(i),2) for input access read as #h ) <> 0 then
					logprint "Error reading '" + command(i) + "'"
				else
					while eof(h) = 0
						line input #h, x
						x = ParsePageName( x, cmt, rev )
						if( x > "" ) then 
							pageCount += 1
							if( pageCount > ubound(pageList) ) then
								redim preserve pageList(1 to Ubound(pageList) * 2)
							end if
							pageList(pageCount) = x
						end if
					wend
					close #h
				end if
			end scope
		elseif left( command(i), 2) = "--" then
			select case lcase(command(i))
			case "--force"
				opt_force = true
			case else
				logprint "Unrecognized option '" + command(i) + "'"
			end select
		else
			pageCount += 1
			if( pageCount > ubound(pageList) ) then
				redim preserve pageList(1 to Ubound(pageList) * 2)
			end if
			pageList(pageCount) = command(i)		
		end if

		i += 1
	wend

	if( pageCount = 0 ) then
		logprint "warning: no pages specified."
		bAbort = TRUE
	end if

end if

'' Initialize the cache
wikicache = new CWikiCache( wiki_cache_dir, CWikiCache.CACHE_REFRESH_NONE )
if wikicache = NULL then
	logprint "Unable to use local cache dir " + wiki_cache_dir
	bAbort = TRUE
end if

if( bAbort = FALSE ) then
	if( commands(cmd).cmdproc ) then
		commands(cmd).cmdproc()
	end if
end if

logclose()

if( wikicache ) then
	delete wikicache
end if
