option explicit

#include once "sqlite3.bi"


	dim info as string
	
	info = *sqlite3_libversion( )
	
	print info