''
'' Pointers to variables:
''
	dim as integer i = 5
	dim as integer ptr p

	p = @i
	print i, *p

''
'' Procedure pointers:
''
	sub sayhi( )
		print "hi"
	end sub

	sayhi( )

	dim psayhi as sub( ) = @sayhi
	psayhi( )


	function add( byval a as integer, byval b as integer ) as integer
		return a + b
	end function

	print add( 1, 2 )

	type AddFn as function( byval as integer, byval as integer ) as integer
	dim padd as AddFn = @add
	print padd( 1, 2 )

''
'' Pointer indexing (very similar to arrays):
''
	'' Allocate memory for 3 integers
	p = callocate( sizeof(integer) * 3 )

	p[0] = 123
	p[1] = 456
	p[2] = 789
	print p[0], p[1], p[2]

	deallocate( p )

''
'' Oldschool peek():
''
	dim as any ptr address
	dim as byte dat(0 to 3) = { 123, 123, 123, 123 }
	dim as integer j = 12345

	address = @dat(0)
	print peek( address )

	address = @j
	print peek( integer, address )

''
'' Pointers to UDTs:
''
	type MyVector
		as integer x, y, z
	end type

	dim as MyVector v
	dim as MyVector ptr pv = @v
	pv->x = 1
	pv->y = 2
	pv->z = 3

	print pv->x, pv->y, pv->z
	print (*pv).x, (*pv).y, (*pv).z
	with *pv
		print .x, .y, .z
	end with
