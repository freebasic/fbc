''
'' IIF test
''

	randomize timer
	
	dim as integer a = rnd * 10
	dim as integer b = rnd * 10
	
	print "a ="; a; "; b ="; b
	print "a * 2 > b? ("; iif( a * 2 > b, -1, 0 ); ")"
	print "(0=false; -1=true)"
	
	sleep
