''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2022 The FreeBASIC development team.
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


'' fbdoc - freebasic user's manual converter/generator main module
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"

#include once "CWiki2Chm.bi"
#include once "CWiki2fbhelp.bi"
#include once "CWiki2txt.bi"
#include once "CWiki2texinfo.bi"
#include once "COptions.bi"

#include once "fbdoc_lang.bi"
#include once "fbdoc_cache.bi"
#include once "fbdoc_loader.bi"
#include once "fbdoc_loader_web.bi"
#if defined(HAVE_MYSQL)
#include once "fbdoc_loader_sql.bi"
#endif
#include once "fbdoc_buildtoc.bi"
#include once "fbdoc_templates.bi"
#include once "fbdoc_keywords.bi"
#include once "fbdoc_string.bi"
#include once "fbdoc_misc.bi"

#include once "vbcompat.bi"

using fb
using fbdoc

const default_ManualDir = "../manual/"
const default_wiki_url = "https://www.freebasic.net/wiki/wikka.php"
const default_ca_file = ""
const default_CacheDir = default_ManualDir + "cache/"
const default_TocPage = "DocToc"

enum OUTPUT_FORMATS
	OUT_NONE     = 0
	OUT_CHM      = 1
	OUT_TXT		 = 2
	OUT_FBHELP	 = 4
	OUT_TEXINFO	 = 8
end enum

private sub hMkdir( byref path as string )
	if( mkdir( path ) ) then
	end if
end sub

'' --------------------------------------------------------------------------
'' main
'' --------------------------------------------------------------------------

	dim as integer CacheRefreshMode = CWikiCache.CACHE_REFRESH_IFMISSING
	dim as string sManualDir = default_ManualDir
	dim as string sCacheDir = default_CacheDir
	dim as string sOutputDir = ""
	dim as string sConnFile, sLangFile, sTocTitle, sDocToc, sTemplateDir
	dim as string sCertificateFile = default_ca_file
	dim as integer i = 1, h
	dim as integer bMakeTitles = FALSE
	dim as COptions ptr connopts = NULL

	dim as integer bShowHelp = FALSE, bShowVersion = FALSE, bNoScan = FALSE
	dim as integer bUseWeb = FALSE, bUseSql = FALSE, bMakeIni = FALSE
	dim as OUTPUT_FORMATS bEmitFormats

	dim as string SinglePage = ""
	dim as integer bSinglePage = FALSE
	redim as string pageList(1 to 10)
	dim as integer pageCount = 0, bPages = FALSE

	dim as string sTocPage = default_TocPage

	if( len(command(1)) = 0 ) then
		bShowHelp = TRUE
	else
		while( len( command(i) ) > 0 )
			select case lcase(command(i))
			case "-version"
				bShowVersion = TRUE
			case "-h", "-help"
				bShowHelp = TRUE
			end select
			i += 1
		wend

	end if

	if( bShowHelp ) then
		print "fbdoc options"
		print ""
		print "options:"
		print "   -makeini       create the default ini file if it does not exist and exit"
		print "   -useweb        load pages from wiki web"
#if defined(HAVE_MYSQL)
		print "   -usesql        load pages from sql database"
#endif
		print "   -usecache      use cache as only source"
		print "   -cachedir      set the location of the cache directory"
		print "   -refresh       refresh all pages"
		print "   -chm           generate html and chm output"
		print "   -fbhelp        generate output for fbhelp viewer"
		print "   -txt           generate ascii text output"
		print "   -texinfo       generate texinfo output"
		print "   -version       show version"
		print "   -getpage page1 [page2 [ ... pageN ]]]"
		print "                  get specified pages from web and store in the cache"
		print "   -getpage @listfile"
		print "                  get specified pages using a list file from web and"
		print "                  store in the cache"
		print "   -makepage pagename"
		print "                  process a single page (and links on page) only"
		print "   -maketitles    generate titles.txt"
		print "   -certificate file"
		print "              certificate to use to authenticate server (.pem)"
		print ""
		end 1
	end if

	if( bShowVersion ) then
		print "FreeBASIC User's Manual Converter/Generator - Version 1.00"
		print "Copyright (C) 2006-2022 The FreeBASIC development team."
		end 1
	end if

	i = 1
	while( len( command(i) ) > 0 )

		if( bPages ) then
			if left( command(i), 1) = "-" then
				bPages = FALSE
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
				else
					pageCount += 1
					if( pageCount > ubound(pageList) ) then
						redim preserve pageList(1 to Ubound(pageList) * 2)
					end if
					pageList(pageCount) = command(i)
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

		if(( bPages = FALSE ) and ( bSinglePage = FALSE )) then

			select case lcase(command(i))
			case "-makeini"
				bMakeIni = TRUE
			case "-r", "-refresh"
				CacheRefreshMode = CWikiCache.CACHE_REFRESH_ALL
			case "-n", "-usecache"
				CacheRefreshMode = CWikiCache.CACHE_REFRESH_NONE
			case "-useweb"
				bUseWeb = TRUE
#if defined(HAVE_MYSQL)
			case "-usesql"
				bUseSql = TRUE
#endif
			case "-maketitles"
				bMakeTitles = TRUE
			case "-chm"
				bEmitFormats or= OUT_CHM
			case "-fbhelp"
				bEmitFormats or= OUT_FBHELP
			case "-txt"
				bEmitFormats or= OUT_TXT
			case "-texinfo"
				bEmitFormats or= OUT_TEXINFO
			case "-getpage"
				bPages = TRUE
			case "-makepage"
				bSinglePage = TRUE
			case "-noscan"
				bNoScan = TRUE
			case "-cachedir"
				i += 1
				sCacheDir = command(i)
				if sCacheDir = "" then
					print "Cache directory not specified"
					end 1
				end if
				if right(sCacheDir, 1) <> "/" then
					sCacheDir += "/"
				end if
			case "-doctoc"
				i += 1
				if( command(i) > "" ) then
					sTocPage = command(i)
				end if
			case "-certificate"
				i += 1
				if( command(i) > "" ) then
					sCertificateFile = command(i)
				end if

			case else
				print "Unrecognized option '" + command(i) + "'"
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
				print #h, "wiki_url = https://www.freebasic.net/wiki/wikka.php"
				print #h,
				print #h, "[dirs]"
				print #h, "manual_dir = ./"

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
		print "Unable to load connection options file '" + sConnFile + "'"
		end 1
	end if

	'' if 'manual_dir' exists in the options, let it override any default set
	sManualDir = connopts->Get( "manual_dir", sManualDir )
	
	'' if 'certificate' exists in the options, let it override any default set
	sCertificateFile =  connopts->Get( "certificate", sCertificateFile ) 

	'' Load language options
	sLangFile = sManualDir + "templates/default/lang/en/common.ini"
	if( Lang.LoadOptions( sLangFile ) = FALSE ) then
		print "Unable to load language file '" + sLangFile + "'"
		end 1
	end if

	Lang.SetOption("fb_docinfo_date", Format( Now(), Lang.GetOption("fb_docinfo_dateformat")))
	Lang.SetOption("fb_docinfo_time", Format( Now(), Lang.GetOption("fb_docinfo_timeformat")))

	'' Initialize the cache
	sCacheDir = connopts->Get( "cache_dir", sCacheDir )
	if LocalCache_Create( sCacheDir, CacheRefreshMode ) = FALSE then
		print "Unable to use local cache dir " + sCacheDir
		end 1
	else
		print "Using local cache dir " + sCacheDir
	end if

	'' Initialize the wiki connection - in case its needed
	Connection_SetUrl( connopts->Get( "wiki_url", default_wiki_url ), sCertificateFile )

#if defined(HAVE_MYSQL)
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
#endif
	
	dim as CPageList ptr paglist, toclist, lnklist

	if( pageCount > 0 ) then
		dim as integer i
		dim as string ret
		for i = 1 to pageCount
			ret = LoadPage( pageList(i), FALSE, TRUE )
		next
		end 0
	end if

	'' Build up an index to all pages
	if( len(SinglePage) > 0 ) then
		FBDoc_BuildSinglePage( SinglePage, SinglePage, @paglist, @toclist, FALSE )

	else

		sDocToc = sTocPage
		sTocTitle = Lang.GetOption( "fb_toc_title", "Table of Contents" )

		if( bNoScan ) then
			paglist = new CPageList
			toclist = new CPageList
			lnklist = new CPageList
		else
			FBDoc_BuildTOC( sDocToc, sTocTitle, @paglist, @toclist, @lnklist )
		endif

	end if

	'' Load Keywords
	fbdoc_loadkeywords( sManualDir + "templates/default/keywords.lst" )

	if( bMakeTitles ) then
		'misc_dump_keypageslist( paglist, "keypages.txt" )
		misc_dump_titles( paglist, "titles.txt" )
	end if

	'' Check output format is set
	if( bEmitFormats = OUT_NONE ) then
		print "Warning: No output format was set."
	end if

	'' Emit formats
			
	if( ( bEmitFormats and OUT_CHM ) <> 0 )then

		'' Generate CHM
		sOutputDir = sManualDir + "html/"
		sTemplateDir = sManualDir + "templates/default/code/"

		hMkdir( sOutputDir )

		Templates.Clear()
		Templates.LoadFile( "chm_idx", sTemplateDir + "chm_idx.tpl.html" )
		Templates.LoadFile( "chm_prj", sTemplateDir + "chm_prj.tpl.html" )
		Templates.LoadFile( "chm_toc", sTemplateDir + "chm_toc.tpl.html" )
		Templates.LoadFile( "chm_def", sTemplateDir + "chm_def.tpl.html" )
		Templates.LoadFile( "chm_doctoc", sTemplateDir + "chm_doctoc.tpl.html" )
		Templates.LoadFile( "htm_toc", sTemplateDir + "htm_toc.tpl.html" )

		dim as CWiki2Chm ptr chm
		chm = new CWiki2Chm( @"", 1, sOutputDir, paglist, toclist, lnklist )
		chm->Emit()
		delete chm

	end if

	if( ( bEmitFormats and OUT_FBHELP ) <> 0 )then

		'' Generate fbhelp output for fbhelp console viewer
		sOutputDir = sManualDir + "fbhelp/"
		sTemplateDir = sManualDir + "templates/default/code/"

		hMkdir( sOutputDir )

		Templates.Clear()
		Templates.LoadFile( "fbhelp_doctoc", sTemplateDir + "fbhelp_doctoc.tpl.txt" )

		dim as CWiki2fbhelp ptr fbhelp
		fbhelp = new CWiki2fbhelp( @"", 1, sOutputDir, paglist, toclist )
		fbhelp->Emit()
		delete fbhelp

	end if

	if( ( bEmitFormats and OUT_TXT ) <> 0 )then

		'' Generate ascii Txt output for single txt file
		sOutputDir = sManualDir + "txt/"
		sTemplateDir = sManualDir + "templates/default/code/"

		hMkdir( sOutputDir )

		Templates.Clear()
		Templates.LoadFile( "txt_doctoc", sTemplateDir + "txt_doctoc.tpl.txt" )

		dim as CWiki2txt ptr txt
		txt = new CWiki2txt( @"", 1, sOutputDir, paglist, toclist )
		txt->Emit()
		delete txt

	end if

	if( ( bEmitFormats and OUT_TEXINFO ) <> 0 )then

		'' Generate ascii Txt output for single txt file
		sOutputDir = sManualDir + "texinfo/"
		sTemplateDir = sManualDir + "templates/default/code/"

		hMkdir( sOutputDir )

		Templates.Clear()
		Templates.LoadFile( "texinfo_def", sTemplateDir + "texinfo_def.tpl.texinfo" )
		Templates.LoadFile( "texinfo_doctoc", sTemplateDir + "texinfo_doctoc.tpl.texinfo" )
		Templates.LoadFile( "texinfo_toc", sTemplateDir + "texinfo_toc.tpl.texinfo" )

		dim as CWiki2texinfo ptr tex
		tex = new CWiki2texinfo( @"", 1, sOutputDir, paglist, toclist )
		tex->Emit()
		delete tex

	end if

	delete lnklist
	delete toclist
	delete paglist

	Connection_Destroy()
	LocalCache_Destroy()

	delete connopts
