''
'' PostgreSQL (www.postgresql.org) example, translated from C by dr0p (dr0p[-at-]perfectbg.com)
''

#include "postgresql/libpq-fe.bi"

'' main
    dim as string conninfo 
    dim as PGconn ptr conn 
    dim as PGresult ptr res 
    dim as integer nFields, i, j
	
	conninfo = "dbname=postgres user=postgres password=12345678"
	
    conn = PQconnectdb(conninfo)
	
    if (PQstatus(conn) <> CONNECTION_OK) then
        print "Connection to database failed: "; *PQerrorMessage(conn)
        PQfinish(conn)
    	end 1
    end if
	
	
    res = PQexec(conn, "SELECT * FROM pg_database")
    ? PQresultStatus(res)
    if (PQresultStatus(res) <> PGRES_TUPLES_OK) then
        print "Command failed: "; *PQerrorMessage(conn)
        PQclear(res)
        PQfinish(conn)
        end 1
	end if
	
	nFields = PQnfields(res)-1
	for i = 0 to nFields
		print *PQfname(res, i),
	next
	print
	print
	
	for i = 0 to PQntuples(res)-1
		for j = 0 to nFields
			print *PQgetvalue(res, i, j),
		next
		print
	next
	
    PQclear(res)
    
    PQfinish(conn)
	end 0
