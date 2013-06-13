#print "no warning:"

'' Forward reference
type UDT as UDT_

'' Parameter that is a pointer to the forward reference, with initializer
'' The initializer will be packed in a TYPEINI() with the same type as the
'' parameter symbol. When that is updated to the real type, the types on its
'' initializer ASTNODEs should be updated too, otherwise astNewARG() would
'' show "different pointer types" warnings when using the initializer.
declare sub f( byval p as UDT ptr = 0 )

type UDT_
	i as integer
end type

sub f( byval p as UDT ptr )
end sub

'' Use the parameter's initializer
f( )
