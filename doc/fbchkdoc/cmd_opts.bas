''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2019-2022 Jeffery R. Marshall (coder[at]execulink[dot]com)
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
#include once "fbdoc_trace.bi"

'' ------------------------------------
'' command line options
'' ------------------------------------

'' scan the command line options: we need to save these for later.
'' we might have '-ini FILE' option on the command line which we
'' need to know first, because we are going to 1) read the ini
'' file, then 2) override the values with any other options given
'' on the command line

dim shared app_opt as CMD_OPTS_GLOBAL

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
	enable_database as boolean   '' enable db_* options
	enable_trace as boolean      '' enable communication tracing (libcurl verbose)

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

	db_host_is_set as boolean    '' -db_host given on command line
	db_host as string            '' value of '-db_host TEXT' given on command line

	db_user_is_set as boolean    '' -db_user given on command line
	db_user as string            '' value of '-db_user TEXT' given on command line

	db_pass_is_set as boolean    '' -db_pass given on command line
	db_pass as string            '' value of '-db_pass TEXT' given on command line

	db_name_is_set as boolean    '' -db_name given on command line
	db_name as string            '' value of '-db_name TEXT' given on command line

	db_port_is_set as boolean    '' -db_port given on command line
	db_port as integer           '' value of '-db_port NUMBER' given on command line

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
	cmd_opt.enable_database = cbool( opts_flags and CMD_OPTS_ENABLE_DATABASE )
	cmd_opt.enable_trace = cbool( opts_flags and CMD_OPTS_ENABLE_TRACE )

	'' general options

	app_opt.help = false     '' -h, -help given on command line
	app_opt.verbose = false  '' -v given on command line
	app_opt.trace = false    '' -trace given on command line

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

	'' database options

	cmd_opt.db_host_is_set = false   '' -db_host given on command line
	cmd_opt.db_host = ""             '' value of '-db_host TEXT' given on command line

	cmd_opt.db_user_is_set = false   '' -db_user given on command line
	cmd_opt.db_user = ""             '' value of '-db_user TEXT' given on command line

	cmd_opt.db_pass_is_set = false   '' -db_pass given on command line
	cmd_opt.db_pass = ""             '' value of '-db_pass TEXT' given on command line

	cmd_opt.db_name_is_set = false   '' -db_name given on command line
	cmd_opt.db_name = ""             '' value of '-db_name TEXT' given on command line

	cmd_opt.db_port_is_set = false   '' -db_port given on command line
	cmd_opt.db_port = 0              '' value of '-db_port NUMBER' given on command line

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

	app_opt.wiki_url = ""        '' export: resolved wiki url
	app_opt.cache_dir = ""       '' export: resolved cache directory
	app_opt.ca_file = ""         '' export: resolved certificate _file
	app_opt.wiki_username = ""   '' export: resolved user
	app_opt.wiki_password = ""   '' export: resolved pass
	app_opt.image_dir = ""       '' export: image directory
	app_opt.manual_dir = ""      '' export: manual directory

	app_opt.db_host = ""         '' export: database host name
	app_opt.db_user = ""         '' export: database user name
	app_opt.db_pass = ""         '' export: database user password
	app_opt.db_name = ""         '' export: database name
	app_opt.db_port = 0          '' export: database port number

	app_opt.pageCount = 0
	redim app_opt.pageList(1 to 1) as string
	redim app_opt.pageComments(1 to 1) as string
	redim app_opt.pageRevision(1 to 1) as long

	if( command(1) = "" ) then
		app_opt.help = true
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
sub cmd_opts_missingarg_die( byval i as const integer )
	cmd_opts_die( "Missing argument after '" + command(i) + "'" )
end sub

''
sub cmd_opts_add_page( byref pagename as const string, byref cmt as const string, byval revision as long )
	with app_opt
		.pageCount += 1
		if( .pageCount > ubound(.pageList) ) then
			redim preserve .pageList(1 to Ubound(.pageList) * 2)
			redim preserve .pageComments(1 to Ubound(.pageComments) * 2)
			redim preserve .pageRevision(1 to Ubound(.pageRevision) * 2)
		end if
		.pageList(.pageCount) = pagename
		.pageComments(.pageCount) = cmt
		.pageRevision(.pageCount) = revision
	end with
end sub


''
function cmd_opts_read( byref i as integer ) as boolean

	'' return true if we processed the option
	'' return false if we did not

	if( left( command(i), 1 ) = "-" ) then

		select case lcase(command(i))
		case "-h", "-help", "--help"
			app_opt.help = true

		case "-v"
			app_opt.verbose = true

		case "-trace"
			if( cmd_opt.enable_trace ) then
				app_opt.trace = true
				fbdoc.set_trace( true )
			else
				return false
			end if

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

		case "-db_host"

			if( cmd_opt.enable_database ) then

				if( cmd_opt.db_host_is_set ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.db_host_is_set = true
				i += 1
				cmd_opt.db_host = command(i)

			else
				return false
			end if

		case "-db_user"

			if( cmd_opt.enable_database ) then

				if( cmd_opt.db_user_is_set ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.db_user_is_set = true
				i += 1
				cmd_opt.db_user = command(i)

			else
				return false
			end if

		case "-db_pass"

			if( cmd_opt.enable_database ) then

				if( cmd_opt.db_pass_is_set ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.db_pass_is_set = true
				i += 1
				cmd_opt.db_pass = command(i)

			else
				return false
			end if

		case "-db_name"

			if( cmd_opt.enable_database ) then

				if( cmd_opt.db_name_is_set ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.db_name_is_set = true
				i += 1
				cmd_opt.db_name = command(i)

			else
				return false
			end if

		case "-db_port"

			if( cmd_opt.enable_database ) then

				if( cmd_opt.db_port_is_set ) then
					cmd_opts_duplicate_die( i )
				end if
				cmd_opt.db_port_is_set = true
				i += 1
				cmd_opt.db_port = cint( command(i) )

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
					dim h as integer, x as string, cmt as string, rev as long
					h = freefile
					if open( mid(command(i),2) for input access read as #h ) <> 0 then
						print "Error reading '" + command(i) + "'"
					else
						while eof(h) = 0
							line input #h, x
							x = ParsePageName( x, cmt, rev )
							if( x > "" ) then 
								cmd_opts_add_page( x, cmt, rev )
							end if
						wend
						close #h
					end if
				end scope
			else
				cmd_opts_add_page( command(i), "", 0 )
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
	dim as string db_host = ""
	dim as string db_user = ""
	dim as string db_pass = ""
	dim as string db_name = ""
	dim as integer db_port = 3306

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
			db_host = opts->Get( "db_host" )
			db_user = opts->Get( "db_user" )
			db_pass = opts->Get( "db_pass" )
			db_name = opts->Get( "db_name" )
			db_port = cint( opts->Get( "db_port" ) )
			delete opts
		elseif( cmd_opt.ini ) then
			'' if we explicitly gave the -ini FILE option, report the error
			cmd_opts_die( "Warning: unable to load options file '" + ini_file + "'" )
		end if
	end scope

	'' now apply the command line overrides
	if( cmd_opt.web ) then
		if( cmd_opt.alt ) then
			app_opt.cache_dir = web_cache_dir
		else
			app_opt.cache_dir = def_cache_dir
		end if
		app_opt.wiki_url = web_wiki_url
		app_opt.ca_file = web_ca_file
		app_opt.wiki_username = web_user
		app_opt.wiki_password = web_pass
	end if

	if( cmd_opt.dev ) then
		if( cmd_opt.alt ) then
			app_opt.cache_dir = dev_cache_dir
		else
			app_opt.cache_dir = def_cache_dir
		end if
		app_opt.wiki_url = dev_wiki_url
		app_opt.ca_file = dev_ca_file
		app_opt.wiki_username = dev_user
		app_opt.wiki_password = dev_pass
	end if

	if( cmd_opt.cache ) then
		app_opt.cache_dir = cmd_opt.cache_dir
	end if

	if( app_opt.cache_dir = "" and cmd_opt.enable_autocache ) then
		app_opt.cache_dir = def_cache_dir
	end if

	if( cmd_opt.url ) then
		app_opt.wiki_url = cmd_opt.url_name
	end if

	if( cmd_opt.ca ) then
		app_opt.ca_file = cmd_opt.ca_file
	end if

	if( cmd_opt.user ) then
		app_opt.wiki_username = cmd_opt.username
	end if

	if( cmd_opt.pass ) then
		app_opt.wiki_password = cmd_opt.password
	end if

	if( cmd_opt.image ) then
		app_opt.image_dir = cmd_opt.image_dir
	else
		app_opt.image_dir = def_image_dir
	end if

	if( cmd_opt.manual ) then
		app_opt.manual_dir = cmd_opt.manual_dir
	else
		app_opt.manual_dir = def_manual_dir
	end if

	if( cmd_opt.db_host_is_set ) then
		app_opt.db_host = cmd_opt.db_host
	else
		app_opt.db_host = db_host
	end if

	if( cmd_opt.db_user_is_set ) then
		app_opt.db_user = cmd_opt.db_user
	else
		app_opt.db_user = db_user
	end if

	if( cmd_opt.db_pass_is_set ) then
		app_opt.db_pass = cmd_opt.db_pass
	else
		app_opt.db_pass = db_pass
	end if

	if( cmd_opt.db_name_is_set ) then
		app_opt.db_name = cmd_opt.db_name
	else
		app_opt.db_name = db_name
	end if

	if( cmd_opt.db_port_is_set ) then
		app_opt.db_port = cmd_opt.db_port
	else
		app_opt.db_port = db_port
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
		print "wiki_url = " & app_opt.wiki_url
		print "cache_dir = " & app_opt.cache_dir
		print "ca_file = " & app_opt.ca_file
		print "wiki_username = " & app_opt.wiki_username
		print "wiki_password = " & "*****"
		print "image_dir = " & app_opt.image_dir
		print "manual_dir = " & app_opt.manual_dir
		print "db_host = " & app_opt.db_host
		print "db_user = " & app_opt.db_user
		print "db_pass = " & app_opt.db_pass
		print "db_name = " & app_opt.db_name
		print "db_port = " & app_opt.db_port
		print

		end 1

	end if

	function = true

end function

''
function cmd_opts_check_cache() as boolean

	if( cmd_opt.enable_cache ) then
		'' check that we have the values we need
		if( app_opt.cache_dir = "" ) then
			cmd_opts_die( "no cache directory specified" )
		end if
	end if

	function = true

end function

''
function cmd_opts_check_url() as boolean

	if( cmd_opt.enable_url ) then
		if( app_opt.wiki_url = "" ) then
			cmd_opts_die( "no url specified" )
		end if
	end if

	function = true

end function

''
function cmd_opts_check_database() as boolean

	if( cmd_opt.enable_database ) then
		'' check that we have the values we need
		if( app_opt.db_host = "" ) then
			cmd_opts_die( "no database host specified" )
		elseif( app_opt.db_user = "" ) then
			cmd_opts_die( "no database user login name specified" )
		elseif( app_opt.db_pass = "" ) then
			cmd_opts_die( "no database user login password specified" )
		elseif( app_opt.db_name = "" ) then
			cmd_opts_die( "no database name specified" )
		elseif( app_opt.db_port = 0 ) then
			cmd_opts_die( "no database port specified" )
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

	if( cmd_opt.enable_database ) then
		print "   -db_host         database host name"
		print "   -db_user         database user login name"
		print "   -db_pass         database user login password"
		print "   -db_name         database name"
		print "   -db_port         database port number"
	end if

	if( cmd_opt.enable_trace ) then
		print "   -trace           enable tracing (libcurl verbose)"
	end if
end sub
