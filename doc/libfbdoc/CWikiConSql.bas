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


'' CWikiConSql
''
'' chng: may/2019 written [coderJeff]
''

#include once "CWikiConSql.bi"
#include once "fbdoc_string.bi"
#include once "mysql/mysql.bi"
#include once "printlog.bi"

namespace fb.fbdoc

	type CMySqlCon

		db as MYSQL ptr
		connected as boolean

		declare constructor _
			( _
			)

		declare destructor _
			( _
			)

		declare function Connect _
			( _
				byval db_host as zstring ptr, _
				byval db_user as zstring ptr, _
				byval db_pass as zstring ptr, _
				byval db_name as zstring ptr, _
				byval db_port as integer _
			) as boolean

		declare sub Disconnect _
			( _
			)

	end type

	''
	constructor CMySqlCon _
		( _
		)

		db = NULL
		connected = FALSE

	end constructor

	''
	destructor CMySqlCon _
		( _
		)
		if( connected ) then
			Disconnect()
		end if
		db = NULL

	end destructor

	''
	function CMySqlCon.Connect _
		( _
			byval db_host as zstring ptr, _
			byval db_user as zstring ptr, _
			byval db_pass as zstring ptr, _
			byval db_name as zstring ptr, _
			byval db_port as integer _
		) as boolean

		function = FALSE

		if( connected = TRUE ) then
			return TRUE
		end if

		if( db_host = NULL ) then
			exit function
		end if

		if( db_user = NULL ) then
			exit function
		end if

		if( db_pass = NULL ) then
			exit function
		end if

		if( db_name = NULL ) then
			exit function
		end if

		printlog "Connecting to database: " + *db_name + " on " + *db_host + ":" + str(db_port)

		'' we must let mysql_init() allocate; mysql/mysql.bi is
		'' too out of date to trust the sizeof( MYSQL )
		db = mysql_init( NULL )

		if( NULL = db ) then
			printlog "Error " + str(mysql_errno(db)) + ": " + *mysql_error(db)
			printlog "Unable to initialize mysql"
			return FALSE
		end if

		if( NULL = mysql_real_connect(db, db_host, db_user, db_pass, db_name, db_port, NULL, 0)) then
			mysql_close( db )
			printlog "Unable to connect to database"
			return FALSE
		end if

		if( mysql_select_db( db, db_name ) <> 0 ) then
			mysql_close( db )
			printlog "Unable to use database " + *db_name
			return FALSE
		end if

		connected = TRUE

		function = TRUE

	end function

	''
	sub CMySqlCon.Disconnect _
		( _
		)

		if( connected ) then
			if( db ) then
				mysql_close( db )
			end if
			connected = FALSE
		end if
		
	end sub


	type CWikiConSqlCtx_
		as CMySqlCon ptr    db_conn

		as zstring ptr      db_host
		as zstring ptr      db_user
		as integer          db_port

		as zstring ptr      db_pass
		as zstring ptr      db_name

		as zstring ptr      pagename
		as integer          pageid
	end type

	const cache_ext = ".wakka"

	dim shared mysql_is_initialized as boolean = FALSE

	'':::::
	static sub CWikiConSql.GlobalInit()
		'' !!! TODO !!! - need updated mysql.bi
		'' mysql_server_init( 0, NULL, NULL )
		mysql_is_initialized = TRUE
	end sub

	'':::::
	static sub CWikiConSql.GlobalExit()
		if( mysql_is_initialized ) then
			'' !!! TODO !!! - need updated mysql.bi
			'' mysql_server_end()
			mysql_is_initialized = FALSE
		end if
	end sub

	'':::::
	constructor CWikiConSql _
		( _
			byval db_host as zstring ptr, _
			byval db_user as zstring ptr, _
			byval db_pass as zstring ptr, _
			byval db_name as zstring ptr, _
			byval db_port as integer _
		)

		ctx = new CWikiConSqlCtx
		ctx->db_conn = new CMySqlCon
		ZSet @ctx->db_host, db_host
		ZSet @ctx->db_user, db_user
		ZSet @ctx->db_pass, db_pass
		ZSet @ctx->db_name, db_name
		ctx->db_port = db_port
		ctx->pagename = NULL
		ctx->pageid = -1

	end constructor

	'':::::
	destructor CWikiConSql _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if
		ZFree @ctx->db_host
		ZFree @ctx->db_user
		ZFree @ctx->db_pass
		ZFree @ctx->db_name
		ZFree @ctx->pagename
		if( ctx->db_conn ) then
			delete ctx->db_conn
		end if
		delete ctx

	end destructor

	'':::::
	function CWikiConSql.Connect _
		( _
		) as boolean

		function = FALSE
		
		if( ctx = NULL ) then
			exit function
		end if

		if( ctx->db_conn = NULL )  then
			exit function
		end if

		function = ctx->db_conn->Connect( ctx->db_host, ctx->db_user, ctx->db_pass, ctx->db_name, ctx->db_port )

	end function

	'':::::
	sub CWikiConSql.Disconnect _
		( _
		)

		ctx->db_conn->Disconnect()

	end sub

	'':::::
	function CWikiConSql.LoadPage _
		( _
			byval pagename as zstring ptr, _
			byref body as string _
		) as boolean

		function = FALSE
		body = ""

		if( ctx = NULL ) then
			exit function
		end if

		if( pagename = NULL ) then
			exit function
		end if

		ZSet @ctx->pagename, pagename
		ctx->pageid = -1

		scope
			dim as string sql
			dim as MYSQL_RES ptr res
			dim as MYSQL_ROW row
			dim as string sName, sBody

			if( Connect() = FALSE ) then
				return FALSE
			end if

			sql = "SELECT id, tag, CAST(CONVERT(body USING utf8) AS binary) FROM wikka_pages WHERE ( latest = 'Y' AND tag = '" & *pagename & "' )"

			if( 0 <> mysql_real_query( ctx->db_conn->db, sql, len(sql)) ) then
				return FALSE
			end if

			res = mysql_use_result( ctx->db_conn->db )
			if( NULL = res ) then
				return FALSE
			end if

			row = mysql_fetch_row( res )
			if( NULL = row ) then
				return FALSE
			end if

			ctx->pageid = cint( *row[0] )
			body = *row[2]

			mysql_free_result( res )

			function = TRUE
		end scope

	end function

	'':::::
	function CWikiConSql.LoadIndex _
		( _
			byval page as zstring ptr, _
			byref body as string, _
			byval format as CWikiCon.IndexFormat _
		) as boolean

		function = FALSE
		body = ""

		if( ctx = NULL ) then
			exit function
		end if

		if( page = NULL ) then
			exit function
		end if

		ZSet @ctx->pagename, page
		ctx->pageid = -1

		scope
			dim as string sql
			dim as MYSQL_RES ptr res
			dim as MYSQL_ROW row
			dim as string sName, sBody

			if( Connect() = FALSE ) then
				return FALSE
			end if

			'' !!! TODO : add revision number for tracking

			sql = "SELECT tag FROM wikka_pages WHERE ( latest = 'Y' ) ORDER BY tag"

			if( 0 <> mysql_real_query( ctx->db_conn->db, sql, len(sql)) ) then
				return FALSE
			end if

			res = mysql_use_result( ctx->db_conn->db )
			if( NULL = res ) then
				return FALSE
			end if

			do
				row = mysql_fetch_row( res )
				if( NULL = row ) then
					exit do
				end if
				body &= *row[0] & nl
			loop

			mysql_free_result( res )

			function = TRUE
		end scope

		function = TRUE

	end function

	'':::::
	function CWikiConSql.StorePage _
		( _
			byval body as zstring ptr, _
			byval note as zstring ptr _
		) as boolean

		function = FALSE

	end function

	'':::::
	function CWikiConSql.StoreNewPage _
		( _
			byval body as zstring ptr, _
			byval pagename as zstring ptr _
		) as boolean

		function = FALSE

	end function

	'':::::
	function CWikiConSql.GetPageID _
		( _
		) as integer

		if( ctx = NULL ) then
			return 0
		end if

		return ctx->pageid

	end function

end namespace
