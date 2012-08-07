type testrecord field=1
	namefield  as string * 20
	scorefield as single
end type

dim filebuffer as testrecord

'' Write out some test data
open "testdat.dat" for random as #1 len = len(filebuffer)
for i as integer = 1 to 10
	filebuffer.namefield = "name" + ltrim(str(i))
	filebuffer.scorefield = i
	put #1, i, filebuffer
next
close #1

'' Read it back in
open "testdat.dat" for random as #1 len = len(filebuffer)
for i as integer = 1 to 10
	get #1, i, filebuffer
	print i, filebuffer.namefield, str( filebuffer.scorefield ), filebuffer.scorefield
next
close #1
