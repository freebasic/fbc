''
'' IIF test
''

	randomize timer
	
	a = rnd * 10
	b = rnd * 10
	
	print "a ="; a; "; b ="; b
	print "a * 2 > b? ("; iif( a * 2 > b, -1, 0 ); ")"
	print "(0=false; -1=true)"
	
	sleep