''
'' SQLite test, translated by Nex/marzec
''

#include once "sqlite3.bi" 

declare sub showusage( )

declare function callback cdecl (byval NotUsed as any ptr, _
								 byval argc as integer, byval argv as zstring ptr ptr, _
						 		 byval azColName as zstring ptr ptr)

	dim rc as integer 
	dim db as sqlite3 ptr 
	dim zErrMsg as zstring ptr 
	zErrMsg = 0 

	dim query as string, database_name as string 

	database_name = command$(1)
	if( len( database_name ) = 0 ) then
		showusage
		end 1
	end if
	
	rc = sqlite3_open(database_name, @db) 

	if rc then 
  		print "Can't open database: "; *sqlite3_errmsg(db) 
  		sqlite3_close (db) 
  		end 
	end if 

	query = command$(2)
	if( len( query ) = 0 ) then
		showusage
		end 1
	end if

	rc = sqlite3_exec(db, query, @callback, 0, @zErrMsg) 
	if rc <> SQLITE_OK then 
  		print "SQL error: "; *zErrMsg
	end if 

	sqlite3_close(db) 

'':::::
function callback cdecl (byval NotUsed as any ptr, _
						 byval argc as integer, byval argv as zstring ptr ptr, _
						 byval azColName as zstring ptr ptr) 
  dim i as integer 

  for i = 0 to argc - 1 
    if *argv[i] <> 0 then 
      print *azColName[i]; " = "; *argv[i]
    else 
      print *azColName[i]; " = NULL" 
    end if 
  next 

  callback = 0 
end function 

'':::::
sub showusage( )
	print "Usage: "; command$(0); " database ""query"""
end sub