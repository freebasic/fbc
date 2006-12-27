''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006, 2007 Jeffery R. Marshall (coder[at]execulink.com)
''  and the FreeBASIC development team.
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


'' fbdoc - freebasic user's manual converter/generator main module
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"

#include once "CWiki2Chm.bi"
#include once "CWiki2fbhelp.bi"
#include once "CWiki2txt.bi"
#include once "COptions.bi"

#include once "fbdoc_lang.bi"
#include once "fbdoc_cache.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_loader_web.bi"
#include once "fbdoc_loader_sql.bi"
#include once "fbdoc_buildtoc.bi"
#include once "fbdoc_templates.bi"
#include once "fbdoc_keywords.bi"
#include once "fbdoc_string.bi"
#include once "fbdoc_misc.bi"

#include once "vbcompat.bi"

using fb
using fbdoc

const default_wiki_url = "http://www.freebasic.net/wiki/wikka.php"
const default_CacheDir = "cache/"


'' --------------------------------------------------------------------------
'' main
'' --------------------------------------------------------------------------

	dim as integer CacheRefreshMode = CWikiCache.CACHE_REFRESH_IFMISSING
	dim as string sCacheDir = default_CacheDir
	dim as string sOutputDir = ""
	dim as string sConnFile, sLangFile, sTocTitle, sDocToc, sTemplateDir
	dim as integer i = 1, h
	dim as integer bMakeTitles = FALSE
	dim as COptions ptr connopts = NULL

	dim as integer bShowHelp = FALSE, bShowVersion = FALSE
	dim as integer bUseWeb = FALSE, bUseSql = FALSE, bMakeIni = FALSE
	dim as integer bEmitChm = FALSE
	dim as integer bEmitfbhelp = FALSE
	dim as integer bEmitTxt = FALSE
	dim as string SinglePage = ""
	dim as integer bSinglePage = FALSE
	redim as string webPageList(1 to 10)
	dim as integer webPageCount = 0, bWebPages = FALSE

	if( len(command(1)) = 0 ) then
		bShowHelp = TRUE
	else
		while( len( command(i) ) > 0 )
			select case lcase(command(i))
			case "-version"
				bShowVersion = TRUE
			case "-h", "-help", "/?", "/h", "/help"
				bShowHelp = TRUE
			end select
			i += 1
		wend

	end if

	if( bShowHelp ) then
		? "fbdoc options
		? ""
		? "options:"
		? "   -makeini       create the default ini file if it does not exist and exit"
		? "   -useweb        load pages from wiki web"
		? "   -usesql        load pages from sql database"
		? "   -usecache      use cache as only source"
		? "   -refresh       refresh all pages"
		? "   -chm           generate html and chm output"
		? "   -fbhelp        generate output for fbhelp viewer"
		? "   -txt           generate ascii text output"
		? "   -version       show version"
		? "   -getpage page1 [page2 [ ... pageN ]]]"
		? "                  get specified pages from web and store in the cache"
		? "   -getpage @listfile"
		? "                  get specified pages using a list file from web and 
		? "                  store in the cache"
		? "   -makepage pagename"
		? "                  process a single page (and links on page) only"
		? "   -maketitles    generate titles.txt
		? ""
		end 1
	end if

	if( bShowVersion ) then
		? "FreeBASIC User's Manual Converter/Generator - Version 0.1b"
		? "Copyright (C) 2006, 2007 Jeffery R. Marshall (coder[at]execulink[dot]com)"
		end 1
	end if

	i = 1
	while( len( command(i) ) > 0 )

		if( bWebPages ) then
			if left( command(i), 1) = "-" then
				bWebPages = FALSE
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
								x = trim(x, any " " + chr(9))
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
		end if

		if( bSinglePage ) then
			if left( command(i), 1) = "-" then
				bSinglePage = FALSE
			else
				SinglePage = command(i)
			end if
		end if

		if(( bWebPages = FALSE ) and ( bSinglePage = FALSE )) then

			select case lcase(command(i))
			case "-makeini"
				bMakeIni = TRUE
			case "-r", "-refresh"
				CacheRefreshMode = CWikiCache.CACHE_REFRESH_ALL
			case "-n", "-usecache"
				CacheRefreshMode = CWikiCache.CACHE_REFRESH_NONE
			case "-useweb"
				bUseWeb = TRUE
			case "-usesql"
				bUseSql = TRUE
			case "-maketitles"
				bMakeTitles = TRUE
			case "-chm"
				bEmitChm = TRUE
			case "-fbhelp"
				bEmitfbhelp = TRUE
			case "-txt"
				bEmitTxt = TRUE
			case "-getpage"
				bWebPages = TRUE
			case "-makepage"
				bSinglePage = TRUE
			case else
				? "Unrecognized option '" + command(i) + "'"
				end 1
			end select
		
		end if

		i += 1
	wend

	'' If no connection is set, use cache only
	if( (bUseSQL = FALSE) and (bUseWeb = FALSE)) then
		CacheRefreshMode = CWikiCache.CACHE_REFRESH_NONE
	end if
	
	if sConnFile = "" then
		sConnFile = ExePath & "/fbdoc.ini"
	end if

	if( bMakeIni ) then
		print "Making default connection ini file '" + sConnFile + "'"
		h = FreeFile
		if( open( sConnFile for input as #h ) = 0 ) then
			close #h
			print "ini file already exists."
		else
			if( open( sConnFile for output as #h ) = 0 ) then
				print #h, "[Wiki Connection]"
				print #h, "wiki_url = http://www.freebasic.net/wiki/wikka.php"
				print #h,

				print #h, "[MySql Connection]"
				print #h, "db_host = localhost"
				print #h, "db_user = user"
				print #h, "db_pass = password"
				print #h, "db_name = test"
				print #h, "db_port = 3306"
				print #h,

				close #h

			else
				print "Unable to create '" + sConnFile + "'"
			end if
		end if
		end 0
	end if

	'' Load connection options from the ini file
	connopts = new COptions( sConnFile )
	if( connopts = NULL ) then
		? "Unable to load connection options file '" + sConnFile + "'"
		end 1
	end if

	'' Load language options
	sLangFile = "templates/default/lang/en/common.ini"
	if( Lang_LoadOptions( sLangFile ) = FALSE ) then
		? "Unable to load language file '" + sLangFile + "'"
		end 1
	end if

	Lang_SetOption("fb_docinfo_date", Format( Now(), Lang_GetOption("fb_docinfo_dateformat")))
	Lang_SetOption("fb_docinfo_time", Format( Now(), Lang_GetOption("fb_docinfo_timeformat")))

	'' Initialize the cache
	sCacheDir = connopts->Get( "cache_dir", default_CacheDir )
	if LocalCache_Create( sCacheDir, CacheRefreshMode ) = FALSE then
		? "Unable to use local cache dir " + sCacheDir
		end 1
	end if

	'' Initialize the wiki connection - in case its needed
	Connection_SetUrl( connopts->Get( "wiki_url", default_wiki_url) )

	'' If using SQL, get all the pages in to the cache now.
	if( bUseSql ) then
		
		dim as string  db_host = connopts->Get( "db_host")
		dim as string  db_user = connopts->Get( "db_user")
		dim as string  db_pass = connopts->Get( "db_pass")
		dim as string  db_name = connopts->Get( "db_name")
		dim as integer db_port = CInt(Val(connopts->Get( "db_port")))
		
		bUseWeb = FALSE
		CacheRefreshMode = CWikiCache.CACHE_REFRESH_NONE

		if( Fetch_Pages_From_Database( db_host, db_user, db_pass, db_name, db_port ) = FALSE ) then
			print "Aborting."
			end 1
		end if
	end if

	
	'' Build up an index to all pages
	dim as CPageList ptr paglist, toclist

	'' TODO: make this an option
	'' SinglePage = "KeyPgScreenGraphics"
	'' SinglePage = "CptAscii"

	if( webPageCount > 0 ) then
		dim as integer i
		dim as string ret
		for i = 1 to webPageCount
			ret = LoadPage( webPageList(i), FALSE, TRUE )
		next i
		end 0
	end if

	if( len(SinglePage) > 0 ) then
		FBDoc_BuildSinglePage( SinglePage, SinglePage, @paglist, @toclist )

	else

		sDocToc = "DocToc"
		sTocTitle = Lang_GetOption( "fb_toc_title", "Table of Contents" )

		FBDoc_BuildTOC( sDocToc, sTocTitle, @paglist, @toclist )

	end if

	'' Load Keywords
	fbdoc_loadkeywords( "templates/default/keywords.lst" )

	if( bMakeTitles = TRUE ) then
		'misc_dump_keypageslist( paglist, "keypages.txt" )
		misc_dump_titles( paglist, "titles.txt" )
	end if

	'' Check output format is set
	if( (bEmitChm = FALSE) and (bEmitfbhelp = FALSE) and (bEmitTxt = FALSE) ) then
		print "Warning: No output format was set."
	end if

	'' Emit formats
			
	if( bEmitChm )then

		'' Generate CHM
		sOutputDir = "html/"
		sTemplateDir = "templates/default/code/"

		Templates_Clear()
		Templates_LoadFile( "chm_idx", sTemplateDir + "chm_idx.tpl.html" )
		Templates_LoadFile( "chm_prj", sTemplateDir + "chm_prj.tpl.html" )
		Templates_LoadFile( "chm_toc", sTemplateDir + "chm_toc.tpl.html" )
		Templates_LoadFile( "chm_def", sTemplateDir + "chm_def.tpl.html" )
		Templates_LoadFile( "htm_toc", sTemplateDir + "htm_toc.tpl.html" )
		Templates_LoadFile( "chm_doctoc", sTemplateDir + "chm_doctoc.tpl.html" )

		dim as CWiki2Chm ptr chm
		chm = new CWiki2Chm( @"", 1, sOutputDir, paglist, toclist )
		chm->Emit()
		delete chm

	end if

	if( bEmitfbhelp )then

		'' Generate fbhelp output for fbhelp console viewer
		sOutputDir = "fbhelp/"
		sTemplateDir = "templates/default/code/"

		Templates_Clear()
		Templates_LoadFile( "fbhelp_doctoc", sTemplateDir + "fbhelp_doctoc.tpl.txt" )

		dim as CWiki2fbhelp ptr fbhelp
		fbhelp = new CWiki2fbhelp( @"", 1, sOutputDir, paglist, toclist )
		fbhelp->Emit()
		delete fbhelp

	end if

	if( bEmitTxt )then

		'' Generate ascii Txt output for single txt file
		sOutputDir = "txt/"
		sTemplateDir = "templates/default/code/"

		Templates_Clear()
		Templates_LoadFile( "txt_doctoc", sTemplateDir + "txt_doctoc.tpl.txt" )

		dim as CWiki2txt ptr txt
		txt = new CWiki2txt( @"", 1, sOutputDir, paglist, toclist )
		txt->Emit()
		delete txt

	end if

	delete toclist
	delete paglist

	Connection_Destroy()
	LocalCache_Destroy()

	delete connopts

	end
