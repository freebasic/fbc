''
'' full array saving and loading, as in VB
''


sub test	

const ENTRIES = 10
	
	'' save array
	dim outarray(0 to ENTRIES-1) as byte
	
	#f = freefile
	open "test.dat" for binary as #f
	
	for i = 0 to ENTRIES-1
		outarray(i) = i
	next i
	
	put #f, , outarray()
	
	close #f
	
	'' load array
	dim inarray(0 to ENTRIES-1) as byte
	
	#f = freefile
	open "test.dat" for binary as #f
	
	get #f, , inarray()
	
	for i = 0 to ENTRIES-1
		print inarray(i); outarray(i)
	next i
	
	close #f	

end sub

	test

