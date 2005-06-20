''
'' simple function-overloading test
'' 

option private

'' note: the first overloaded function must be explicitly declared as such, 
'' otherwise the compiler -to be backward compatible with QB -, would "see" 
'' the other prototypes as duplicated definitions
declare sub foo overload ( byval bar as integer )
declare sub foo ( byval bar as uinteger )
declare sub foo ( byval bar as single )
declare sub foo ( byval bar as double )
declare sub foo ( byval bar as longint )
declare sub foo ( byval bar as integer ptr )
declare sub foo ( byval bar as uinteger ptr )
declare sub foo ( byval bar as single ptr )
declare sub foo ( byval bar as double ptr )
declare sub foo ( byval bar as longint ptr )

	dim intvar as integer
	dim uintvar as uinteger
	dim fltvar as single
	dim dblvar as double
	dim lngvar as longint
	
	foo( intvar )
	foo( uintvar )
	foo( fltvar )
	foo( dblvar )
	foo( lngvar )
	
	print "---"
	
	dim intptrvar as integer ptr
	dim uintptrvar as uinteger ptr
	dim fltptrvar as single ptr
	dim dblptrvar as double ptr
	dim lngptrvar as longint ptr
	
	foo( intptrvar )
	foo( uintptrvar )
	foo( fltptrvar )
	foo( dblptrvar )
	foo( lngptrvar )
	
	print "---"
	
	foo( cdbl( intvar ) )
	foo( intvar + dblvar )
	
	sleep
	
'':::::
sub foo ( byval bar as integer )

	print "foo.int    called"

end sub

'':::::
sub foo ( byval bar as uinteger )

	print "foo.uint   called"

end sub

'':::::
sub foo ( byval bar as single )

	print "foo.single called"

end sub

'':::::
sub foo ( byval bar as double )

	print "foo.double called"

end sub

'':::::
sub foo ( byval bar as longint )

	print "foo.lngint called"

end sub
		

'':::::
sub foo ( byval bar as integer ptr )

	print "foo.intptr  called"

end sub

'':::::
sub foo ( byval bar as uinteger ptr )

	print "foo.uintptr called"

end sub

'':::::
sub foo ( byval bar as single ptr )

	print "foo.fltptr  called"

end sub

'':::::
sub foo ( byval bar as double ptr )

	print "foo.dblptr  called"

end sub

'':::::
sub foo ( byval bar as longint ptr )

	print "foo.lngptr  called"

end sub
