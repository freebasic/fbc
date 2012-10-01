''
'' Procedure overloading:
''

'' At least the first one must be marked as Overload
declare sub foo overload ( byval bar as integer )
declare sub foo          ( byval bar as uinteger )
declare sub foo          ( byval bar as single )
declare sub foo          ( byval bar as double )
declare sub foo          ( byval bar as longint )

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

foo( cdbl( intvar ) )
foo( intvar + dblvar )

private sub foo( byval bar as integer )
	print "foo(integer) called"
end sub

private sub foo( byval bar as uinteger )
	print "foo(uinteger) called"
end sub

private sub foo( byval bar as single )
	print "foo(single) called"
end sub

private sub foo( byval bar as double )
	print "foo(double) called"
end sub

private sub foo( byval bar as longint )
	print "foo(longint) called"
end sub

''
'' Operator Overloading for User Defined Types:
''
'' - All binary operators can be overloaded, except the relational ones
''
'' - Self-operators (op=) can be handled separately for better performance
''
'' - Most unary operators can be overloaded, including casting, address-of (@),
''   pointer dereference (*) and UDT member pointer dereference (->)
''
'' - The assignment operator can also be overloaded (operator Let)
''

type MyInteger
	i as integer
	declare constructor( as integer )
	declare operator cast( ) as string
end type

constructor MyInteger( i as integer )
	this.i = i
end constructor

operator MyInteger.cast( ) as string
	return str( this.i )
end operator

operator + ( byref l as MyInteger, byref r as MyInteger ) as MyInteger
	return MyInteger( l.i + r.i )
end operator

dim as MyInteger x = MyInteger( 3 ), y = MyInteger( 4 )
print x + y

sleep
