''
'' SQLite test, translated by Nex/marzec
''



#include once "sqlite3.bi" 

const DEFAULT_DATABASE = "sqlite3_test.db"
const DEFAULT_QUERY	   = "select * from features"

declare sub showusage( )

declare function callback cdecl _
	( _
		byval NotUsed as any ptr, _
		byval argc as long, _
		byval argv as zstring ptr ptr, _
		byval colName as zstring ptr ptr _
	) as long

	dim as sqlite3 ptr db
	dim as zstring ptr errMsg 
	dim as string database_name, query

	if( __FB_ARGC__ > 3 ) then
		showusage
		end 1
	end if
	
	if( __FB_ARGC__ = 2 ) then
		database_name = command( 1 )
	else
		database_name = DEFAULT_DATABASE
	end if
	
	if( __FB_ARGC__ = 3 ) then
		query = command( 2 )
	else
		query = DEFAULT_QUERY
	end if
	
	if sqlite3_open( database_name, @db ) then 
  		print "Can't open database: "; *sqlite3_errmsg( db )
  		sqlite3_close( db ) 
  		end 1
	end if 
	
	print "Using database: "; database_name
	print

	if sqlite3_exec( db, query, @callback, 0, @errMsg ) <> SQLITE_OK then 
  		print "SQL error: "; *errMsg
	end if 

	sqlite3_close(db) 

'':::::
function callback cdecl _
	( _
		byval NotUsed as any ptr, _
		byval argc as long, _
		byval argv as zstring ptr ptr, _
		byval colName as zstring ptr ptr _
	) as long
  
	dim as integer i 
	dim as string text

	for i = 0 to argc - 1
		text = "NULL"
		if( argv[i] <> 0 ) then
			if *argv[i] <> 0 then 
				text = *argv[i]
			end if
		end if
			
		print *colName[i], " = '"; text; "'"
	next 
	
	print

	function = 0
   
end function 

'':::::
sub showusage( )
	print "Usage: "; command( 0 ); " database ""query"""
end sub
