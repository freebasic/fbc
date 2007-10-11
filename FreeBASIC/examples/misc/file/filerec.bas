type testrecord field=1
   namefield  as string * 20
   scorefield as single
end type

	dim filebuffer as testrecord
	
	open "testdat.dat" for random as #1 len = len(filebuffer)
	
	dim i as integer
	for i = 1 to 10
	   filebuffer.namefield = "name" + ltrim(str(i))
	   filebuffer.scorefield = i
	   put #1, i, filebuffer
	next i
	
	print i; " records written."

	close #1



	open "testdat.dat" for random as #1 len = len(filebuffer)
	
	for i = 1 to 10
	   get #1, i, filebuffer
	   print i, filebuffer.namefield, str( filebuffer.scorefield ), filebuffer.scorefield
	next i
	
	close #1
	
