''
'' full array saving and loading, as in VB
''


sub test	

const ENTRIES = 10
	
	'' save array
	dim as byte outarray(0 to ENTRIES-1)
	
	dim as integer f = freefile
	open "test.dat" for binary as #f
	
	dim as integer i
	for i = 0 to ENTRIES-1
		outarray(i) = i
	next i
	
	put #f, , outarray()
	
	close #f
	
	'' load array
	dim as byte inarray(0 to ENTRIES-1) 
	
	f = freefile
	open "test.dat" for binary as #f
	
	get #f, , inarray()
	
	for i = 0 to ENTRIES-1
		print inarray(i); outarray(i)
	next i
	
	close #f	

end sub

	test

