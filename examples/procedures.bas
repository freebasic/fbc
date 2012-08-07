function AddNumbers( a as integer, b as integer ) as integer
	return a + b
end function

sub hello( )
	print "hello"
end sub

declare sub myprint( num as integer )

	'' Code outside any procedures is the main part of the program
	hello( )
	print AddNumbers( 1, 1 )
	myprint 5

sub myprint( num as integer )
	print num
end sub
