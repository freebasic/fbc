''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)
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

'' common command line options for fbchkdoc utilities

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWikiCon.bi"
#include once "COptions.bi"

using fb
using fbdoc

#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"

'' ------------------------------------
'' command line options
'' ------------------------------------

'' scan the command line options: we need to save these for later.
'' we might have '-ini FILE' option on the command line which we
'' need to know first, because we are going to 1) read the ini
'' file, then 2) override the values with any other options given
'' on the command line

dim shared cmd_opt_help as boolean
dim shared cmd_opt_verbose as boolean

'' ------------------------------------
'' resolved options
'' ------------------------------------

dim shared wiki_url as string
dim shared cache_dir as string
dim shared ca_file as string
dim shared wiki_username as string
dim shared wiki_password as string
dim shared image_dir as string
dim shared manual_dir as string

dim shared webPageCount as integer
dim shared webPageList() as string
dim shared webPageComments() as string

'' ------------------------------------
'' private options
'' ------------------------------------

type CMD_OPTS_PRIVATE

	enable_url as boolean        '' enable use of url to connect to or choose location of a wiki
	enable_cache as boolean      '' enable use of a cache (local file location)
	enable_login as boolean      '' enable user and password options
	enable_image as boolean      '' enable the image dir option
	enable_autocache as boolean  '' automatically select a cache if none given on the command line
	enable_pagelist as boolean   '' enable reading in a text file with a list of page names
	enable_manual as boolean     '' enable the manual dir option

	print as boolean             '' -printopts option on command line

	web as boolean               '' -web or -web+ given on command line
	dev as boolean               '' -dev or -dev+ given on command line
	alt as boolean               '' -web+ or -dev+ given on command line

	cache as boolean             '' -cache DIR option on command line
	cache_dir as string          '' value of '-cache DIR' given on command line

	url as boolean               '' -url given on command line
	url_name as string           '' value of '-url URL' given on command line

	ini as boolean               '' -ini FILE option on command line
	ini_file as string           '' value of '-ini FILE' given on command line

	ca as boolean                '' -certificate given on command line
	ca_file as string            '' value of '-certificate FILE' given on command line 

	user as boolean              '' -u given on command line
	username as string           '' value of -u NAME given on command line

	pass as boolean              '' -p given on command line
	password as string           '' value of -p WORD given on command line

	image as boolean             '' -image_dir given on command line
	image_dir as string          '' value of '-image_dir DIR' given on command line

	page as boolean              '' @FILE option given on command line 
	pagefile as string           '' value of filename for '@FILE' given on command line

	manual as boolean            '' -manual_dir given on command line
	manual_dir as string         '' value of '-manual_dir DIR' given on command line

end type

dim shared cmd_opt as CMD_OPTS_PRIVATE

'' ------------------------------------
'' API
'' ------------------------------------

''
sub cmd_opts_init( byval opts_flags as const CMD_OPTS_ENABLE_FLAGS ) 

	cmd_opt.enable_url = cbool( opts_flags and CMD_OPTS_ENABLE_URL )
	cmd_opt.enable_cache = cbool( opts_flags and CMD_OPTS_ENABLE_CACHE )
	cmd_opt.enable_login = cbool( opts_flags and CMD_OPTS_ENABLE_LOGIN )
	cmd_opt.enable_image = cbool( opts_flags and CMD_OPTS_ENABLE_IMAGE )
	cmd_opt.enable_autocache = cbool( opts_flags and CMD_OPTS_ENABLE_AUTOCACHE )
	cmd_opt.enable_pagelist = cbool( opts_flags and CMD_OPTS_ENABLE_PAGELIST )
	cmd_opt.enable_manual = cbool( opts_flags and CMD_OPTS_ENABLE_MANUAL )

	'' general options

	cmd_opt_help = false     '' -h, -help given on command line
	cmd_opt_verbose = false  '' -v given on command line
	cmd_opt.print = false    '' -printopts options given
	cmd_opt.ini = false      '' -ini given on command line
	cmd_opt.ini_file = ""    '' value of '-ini FILE' given on command line

	'' url & cache options

	cmd_opt.web = false	     '' -web or -web+ given on command line
	cmd_opt.dev = false      '' -dev or -dev+ given on command line
	cmd_opt.alt = false      '' -web+ or -dev+ given on command line

	cmd_opt.cache = false    '' -cache given on command line
	cmd_opt.cache_dir = ""   '' value of '-cache DIR' given on command line

	cmd_opt.url = false      '' -url given on command line
	cmd_opt.url_name = ""    '' value of '-url URL' given on command line

	cmd_opt.ca = false       '' -certificate given on command line
	cmd_opt.ca_file = ""     '' value of '-certificate FILE' given on command line 

	'' login options

	cmd_opt.user = false     '' -u given on command line
	cmd_opt.username = ""    '' value of -u NAME given on command line

	cmd_opt.pass = false     '' -p given on command line
	cmd_opt.password = ""    '' value of -p WORD given on command line

	cmd_opt.image = false    '' -image_dir given on command line
	cmd_opt.image_dir = ""   '' value of '-image_dir DIR' given on command line

	cmd_opt.manual = false   '' -manual_dir given on command line
	cmd_opt.manual_dir = ""  '' value of '-manual_dir DIR' given on command line

	'' resolved options

	wiki_url = ""        '' export: resolved wiki url
	cache_dir = ""       '' export: resolved cache directory
	ca_file = ""         '' export: resolved certificate _file
	wiki_username = ""   '' export: resolved user
	wiki_password = ""   '' export: resolved pass
	image_dir = ""       '' export: image directory
	manual_dir = ""      '' export: manual directory

	webPageCount = 0
	redim webPageList(1 to 1) as string
	redim webPageComments(1 to 1) as string

	if( command(1) = "" ) then
		cmd_opt_help = true
	end if

end sub

''
sub cmd_opts_die( byref msg as const string )
	print msg
	end 1
end sub

''
sub cmd_opts_duplicate_die( byval i as const integer )
	cmd_opts_die( "'" & command(i) + "' option can only be specified once" )
end sub

''
sub cmd_opts_unrecognized_die( byval i as const integer )
	cmd_opts_die( "Unrecognized option '" + command(i) + "'" )
end sub

''
sub cmd_opts_unexpected_die( byval i as const integer )
	cmd_opts_die( "Unrecognized option '" + command(i) + "'" )
end sub

''
function cmd_opts_read( byref i as integer ) as boolean

	'' return true if we processed the option
	'' return false if we did not

	if( left( command(i), 1 ) = "-" ) then

		select case lcase(command(i))
		case "-h", "-help"
			cmd_opt_help = true

		case "-v"
			cmd_opt_verbose = true

		case "-printopts"
			cmd_opt.print = true

		case "-web", "-dev", "-web+", "-dev+"
	
			if( cmd_opt.enable_url or cmd_opt.enable_cache ) then

				if( cmd_opt.dev or cmd_opt.web ) then
					print "-web, -web+, -dev, -dev+ option can only be specified once"
					end 1
				end if

				select case lcase(command(i))
				case "-dev"
					cmd_opt.dev = true
				case "-web"
					cmd_opt.web = true
				case "-dev+"
					cmd_opt.dev = true
					cmd_opt.alt = true
				case "-web+"
					cmd_opt.web = true
					cmd_opt.alt = true
				end select

			else
				return false
			end if

		case "-url"

			if( cmd_opt.enable_url ) then

				if( cmd_opt.url ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.url = true
				i += 1
				cmd_opt.url_name = command(i)

			else
				return false
			end if

		case "-certificate"

			if( cmd_opt.enable_url ) then

				if( cmd_opt.ca ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.ca = true
				i += 1
				cmd_opt.ca_file = command(i)

			else
				return false
			end if

		case "-cache"

			if( cmd_opt.enable_cache ) then

				if( cmd_opt.cache ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.cache = true
				i += 1
				cmd_opt.cache_dir = command(i)

			else
				return false
			end if

		case "-u"

			if( cmd_opt.enable_login ) then
				
				if( cmd_opt.user ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.user = true
				i += 1
				cmd_opt.username = command(i)

			else
				return false
			end if

		case "-p"

			if( cmd_opt.enable_login ) then
				
				if( cmd_opt.pass ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.pass = true
				i += 1
				cmd_opt.password = command(i)

			else
				return false
			end if

		case "-image_dir"

			if( cmd_opt.enable_image ) then
				
				if( cmd_opt.image ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.image = true
				i += 1
				cmd_opt.image_dir = command(i)

			else
				return false
			end if

		case "-manual_dir"

			if( cmd_opt.enable_manual ) then
				
				if( cmd_opt.manual ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.manual = true
				i += 1
				cmd_opt.manual_dir = command(i)

			else
				return false
			end if

		case "-ini"
			if( cmd_opt.ini ) then
				cmd_opts_duplicate_die( i )
			end if
			cmd_opt.ini = true
			i += 1
			cmd_opt.ini_file = command(i)

		case else
			return false
		end select

	else
		if( cmd_opt.enable_pagelist ) then
			if left( command(i), 1) = "@" then
				scope
					dim h as integer, x as string, cmt as string
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
									redim preserve webPageComments(1 to Ubound(webPageComments) * 2)
								end if
								webPageList(webPageCount) = x
								webPageComments(webPageCount) = cmt
							end if
						wend
						close #h
					end if
				end scope
			else
				webPageCount += 1
				if( webPageCount > ubound(webPageList) ) then
					redim preserve webPageList(1 to Ubound(webPageList) * 2)
					redim preserve webPageComments(1 to Ubound(webPageComments) * 2)
				end if
				webPageList(webPageCount) = command(i)		
				webPageComments(webPageCount) = ""
			end if

		else
			return false

		end if

	end if

	i += 1

	return true

end function

''
function cmd_opts_resolve() as boolean

	'' resolved values for options will be, in order of priority:
	'' 1) what was given on the command line, or else
	'' 2) what was found in the ini file, or else
	'' 3) hard coded default value

	'' load the hard-coded values first
	dim as string ini_file = hardcoded.default_ini_file
	dim as string web_wiki_url = hardcoded.default_web_wiki_url
	dim as string dev_wiki_url = ""
	dim as string web_ca_file = ""
	dim as string dev_ca_file = ""
	dim as string def_cache_dir = hardcoded.default_def_cache_dir
	dim as string web_cache_dir = hardcoded.default_web_cache_dir
	dim as string dev_cache_dir = hardcoded.default_dev_cache_dir
	dim as string web_user = ""
	dim as string web_pass = ""
	dim as string dev_user = ""
	dim as string dev_pass = ""
	dim as string def_image_dir = hardcoded.default_image_dir
	dim as string def_manual_dir = hardcoded.default_manual_dir

	'' -ini FILE on the command line overrides the hardcoded value
	if( cmd_opt.ini ) then
		ini_file = cmd_opt.ini_file
	end if

	'' read defaults from the configuration file (if it exists)
	'' they can override the hard coded values
	scope
		dim as COptions ptr opts = new COptions( ini_file )
		if( opts <> NULL ) then
			web_wiki_url = opts->Get( "web_wiki_url", web_wiki_url )
			dev_wiki_url = opts->Get( "dev_wiki_url", dev_wiki_url )
			web_ca_file = opts->Get( "web_certificate", web_ca_file )
			dev_ca_file = opts->Get( "dev_certificate", dev_ca_file )
			def_cache_dir = opts->Get( "cache_dir", def_cache_dir )
			web_cache_dir = opts->Get( "web_cache_dir", web_cache_dir )
			dev_cache_dir = opts->Get( "dev_cache_dir", dev_cache_dir )
			web_user = opts->Get( "web_username" )
			web_pass = opts->Get( "web_password" )
			dev_user = opts->Get( "dev_username" )
			dev_pass = opts->Get( "dev_password" )
			def_image_dir = opts->Get( "image_dir" )
			def_manual_dir = opts->Get( "manual_dir" )
			delete opts
		elseif( cmd_opt.ini ) then
			'' if we explicitly gave the -ini FILE option, report the error
			cmd_opts_die( "Warning: unable to load options file '" + ini_file + "'" )
		end if
	end scope

	'' now apply the command line overrides
	if( cmd_opt.web ) then
		if( cmd_opt.alt ) then
			cache_dir = web_cache_dir
		else
			cache_dir = def_cache_dir
		end if
		wiki_url = web_wiki_url
		ca_file = web_ca_file
		wiki_username = web_user
		wiki_password = web_pass
	end if

	if( cmd_opt.dev ) then
		if( cmd_opt.alt ) then
			cache_dir = dev_cache_dir
		else
			cache_dir = def_cache_dir
		end if
		wiki_url = dev_wiki_url
		ca_file = dev_ca_file
		wiki_username = dev_user
		wiki_password = dev_pass
	end if

	if( cmd_opt.cache ) then
		cache_dir = cmd_opt.cache_dir
	end if

	if( cache_dir = "" and cmd_opt.enable_autocache ) then
		cache_dir = def_cache_dir
	end if

	if( cmd_opt.url ) then
		wiki_url = cmd_opt.url_name
	end if

	if( cmd_opt.ca ) then
		ca_file = cmd_opt.ca_file
	end if

	if( cmd_opt.user ) then
		wiki_username = cmd_opt.username
	end if

	if( cmd_opt.pass ) then
		wiki_password = cmd_opt.password
	end if

	if( cmd_opt.image ) then
		image_dir = cmd_opt.image_dir
	else
		image_dir = def_image_dir
	end if

	if( cmd_opt.manual ) then
		manual_dir = cmd_opt.manual_dir
	else
		manual_dir = def_manual_dir
	end if

	if( cmd_opt.print ) then
		
		print "ini_file = " & ini_file
		print
		print "web_wiki_url = " & web_wiki_url
		print "dev_wiki_url = " & dev_wiki_url
		print "web_cache_dir = " & web_cache_dir
		print "dev_cache_dir = " & dev_cache_dir
		print "web_ca_file = " & web_ca_file
		print "dev_ca_file = " & dev_ca_file
		print "web_username = " & web_user
		print "web_password = " & "*****"
		print "dev_username = " & dev_user
		print "dev_password = " & "*****"
		print "def_image_dir = " & def_image_dir
		print "def_manual_dir = " & def_manual_dir
		print
		print "wiki_url = " & wiki_url
		print "cache_dir = " & cache_dir
		print "ca_file = " & ca_file
		print "wiki_username = " & wiki_username
		print "wiki_password = " & "*****"
		print "image_dir = " & image_dir
		print "manual_dir = " & manual_dir
		print

		end 1

	end if

	function = true

end function

''
function cmd_opts_check() as boolean

	if( cmd_opt.enable_cache ) then
		'' check that we have the values we need
		if( cache_dir = "" ) then
			cmd_opts_die( "no cache directory specified" )
		end if
	end if

	if( cmd_opt.enable_url ) then
		if( wiki_url = "" ) then
			cmd_opts_die( "no url specified" )
		end if
	end if

	function = true

end function

''
sub cmd_opts_show_help_item _
	( _
		byref opt_name as const string, _
		byref opt_desc as const string _
	)

	const indent as integer = 3
	const col1 as integer = 20

	if( (len(opt_name) + indent) > col1 - 2 ) then
		print space(indent); opt_name
		print space(col1); opt_desc
	else
		print space(indent); opt_name; space( col1 - len(opt_name) - indent ); opt_desc
	end if

end sub

''
sub cmd_opts_show_help( byref action as const string = "", locations as boolean = true )

	dim a as string = "use"

	if( action <> "" ) then
		a = action
	end if

		print "general options:"
		print "   -h, -help        show the help information"
		print "   -ini FILE        set ini file name (instead of '" & hardcoded.default_ini_file & "')"
		print "   -printopts       print active options and quit"
		print "   -v               be verbose"
		print

	if( cmd_opt.enable_pagelist ) then
		print "   pages            list of wiki pages on the command line"
		print "   @pagelist	       text file with a list of pages, one per line"
		print
	end if

	if( locations ) then

	if( cmd_opt.enable_url and cmd_opt.enable_cache ) then
		print "   -web             " & a & " web server url and cache_dir files"
		print "   -web+            " & a & " web server url and web_cache_dir files"
		print "   -dev             " & a & " development server url and cache_dir files"
		print "   -dev+            " & a & " development server url and dev_cache_dir files"
		print
	elseif( cmd_opt.enable_url ) then
		print "   -web             " & a & " web server url"
		print "   -web+            " & a & " web server url"
		print "   -dev             " & a & " development server url"
		print "   -dev+            " & a & " development server url"
		print
	elseif( cmd_opt.enable_cache ) then
		print "   -web             " & a & " cache_dir files"
		print "   -web+            " & a & " web_cache_dir files"
		print "   -dev             " & a & " cache_dir files"
		print "   -dev+            " & a & " dev_cache_dir files"
		print
	end if

	end if

	if( cmd_opt.enable_url ) then
		print "   -url URL         get pages from URL (overrides other options)"
		print "   -certificate FILE"
		print "                    certificate to use to authenticate server (.pem)"
	end if

	if( cmd_opt.enable_login ) then
		print "   -u user          specifiy wiki account username"
		print "   -p pass          specifiy wiki account password"
	end if

	if( cmd_opt.enable_cache ) then
		print "   -cache DIR       override the cache directory location"
	end if

	if( cmd_opt.enable_image) then
		print "   -image_dir DIR   override the image directory location"
	end if

	if( cmd_opt.enable_manual ) then
		print "   -manual_dir DIR  override the manual directory location"
	end if


end sub