''
'' simple function-overloading test
'' 

enum barenum
	enum0, enum1, enum2
end enum

'' note: the first overloaded function must be explicitly declared as such, 
'' otherwise the compiler -to be backward compatible with QB -, would "see" 
'' the other prototypes as duplicated definitions
declare sub foo overload ( byval bar as integer )
declare sub foo 		 ( byval bar as uinteger )
declare sub foo 		 ( byval bar as single )
declare sub foo 		 ( byval bar as double )
declare sub foo 		 ( byval bar as longint )
declare sub foo 		 ( byval bar as barenum )
declare sub foo 		 ( byval bar as integer ptr )
declare sub foo 		 ( byval bar as uinteger ptr )
declare sub foo 		 ( byval bar as single ptr )
declare sub foo 		 ( byval bar as double ptr )
declare sub foo 		 ( byval bar as longint ptr )
declare sub foo 		 ( byval bar as barenum ptr )

	dim intvar as integer
	dim uintvar as uinteger
	dim fltvar as single
	dim dblvar as double
	dim lngvar as longint
	dim enumvar as barenum
	
	foo( intvar )
	foo( uintvar )
	foo( fltvar )
	foo( dblvar )
	foo( lngvar )
	foo( enumvar ) 
	
	print "---"
	
	dim intptrvar as integer ptr
	dim uintptrvar as uinteger ptr
	dim fltptrvar as single ptr
	dim dblptrvar as double ptr
	dim lngptrvar as longint ptr
	dim enumptrvar as barenum ptr
	
	foo( intptrvar )
	foo( uintptrvar )
	foo( fltptrvar )
	foo( dblptrvar )
	foo( lngptrvar )
	foo( enumptrvar )
	
	print "---"
	
	foo( cdbl( intvar ) )
	foo( intvar + dblvar )
	
	sleep
	
'':::::
private sub foo ( byval bar as integer )

	print "foo.int     called"

end sub

'':::::
private sub foo ( byval bar as uinteger )

	print "foo.uint    called"

end sub

'':::::
private sub foo ( byval bar as single )

	print "foo.single  called"

end sub

'':::::
private sub foo ( byval bar as double )

	print "foo.double  called"

end sub

'':::::
private sub foo ( byval bar as longint )

	print "foo.lngint  called"

end sub
		

'':::::
private sub foo ( byval bar as integer ptr )

	print "foo.intptr  called"

end sub

'':::::
private sub foo ( byval bar as uinteger ptr )

	print "foo.uintptr called"

end sub

'':::::
private sub foo ( byval bar as single ptr )

	print "foo.sngptr  called"

end sub

'':::::
private sub foo ( byval bar as double ptr )

	print "foo.dblptr  called"

end sub

'':::::
private sub foo ( byval bar as longint ptr )

	print "foo.lngptr  called"

end sub

'':::::
private sub foo ( byval bar as barenum )

	print "foo.enum    called"

end sub

'':::::
private sub foo ( byval bar as barenum ptr )

	print "foo.enumptr called"

end sub
