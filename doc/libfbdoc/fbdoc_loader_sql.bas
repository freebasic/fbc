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


'' fbdoc_loader_sql
''
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "mysql/mysql.bi"
#include once "fbdoc_loader_sql.bi"

#include once "fbdoc_cache.bi"

#include once "printlog.bi"

namespace fb.fbdoc

	dim shared as mysql  db

	'' --------------------------------------------------------------------------
	'' MySQL Database Connection and Page Loader
	'' --------------------------------------------------------------------------

	function Fetch_Pages_From_Database _
		( _
			byval db_host as zstring ptr, _
			byval db_user as zstring ptr, _
			byval db_pass as zstring ptr, _
			byval db_name as zstring ptr, _
			byval db_port as integer _
		) as integer

		dim as string sql
		dim as MYSQL_RES ptr res
		dim as MYSQL_ROW row
		dim as string sName, sBody
		dim as CWikiCache ptr wikicache = LocalCache_Get()

		printlog "Connecting to database: " + *db_name + " on " + *db_host + ":" + str(db_port)

		if( NULL = mysql_init( @db )) then
			printlog "Error " + str(mysql_errno(@db)) + ": " + *mysql_error(@db)
			printlog "Unable to initialize mysql"
			return FALSE
		end if

		if( NULL = mysql_real_connect(@db, db_host, db_user, db_pass, db_name, db_port, NULL, 0)) then
			printlog "Unable to connect to database"
			return FALSE
		end if

		if( mysql_select_db( @db, db_name ) <> 0 ) then
			printlog "Unable to use database " + *db_name
			mysql_close( @db )
			return FALSE
		end if

		sql = "SELECT tag, CAST(CONVERT(body USING utf8) AS binary) FROM wikka_pages WHERE ( latest = 'Y' )"

		if( 0 <> mysql_real_query( @db, sql, len(sql)) ) then
			printlog "Unable to query wikka_pages"
			mysql_close( @db )
			return FALSE
		end if

		res = mysql_use_result( @db )
		if( NULL = res ) then
			printlog "Unable to use result set"
			mysql_close( @db )
			return FALSE
		end if

		printlog "Fetching pages "
		do
			row = mysql_fetch_row( res )
			if( NULL = row ) then
				exit do
			end if
			wikicache->SavePage( row[0], row[1] )
			printlog ".", TRUE
		loop
		printlog ""

		mysql_free_result( res )
		mysql_close( @db )

		return TRUE

	end function

end namespace
