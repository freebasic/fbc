'' FOR..NEXT iterator example

type Alphabet
	declare constructor( byval r as zstring ptr )

	declare operator for ( )
	declare operator step( )
	declare operator next( byref end_cond as Alphabet ) as integer

	declare operator cast( ) as string

	private:
		value as string
end type

constructor Alphabet( byval r as zstring ptr )
	value = *r
end constructor

operator Alphabet.cast( ) as string
	return value
end operator

operator Alphabet.for( )
end operator

operator Alphabet.step( )
	value[0] += 1
end operator 

operator Alphabet.next( byref end_cond as Alphabet ) as integer
	return this.value <= end_cond.value
end operator

	for i as Alphabet = "a" to "z"
		print i; " ";
	next
	print
