'' examples/manual/operator/placement_new.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPlacementNew
'' --------

'' "placement new" example

type Rational
	as integer	numerator, denominator
end type

scope
	
	'' allocate some memory to construct as a Rational
	dim as any ptr ap = callocate(len(Rational))
	
	'' make the placement new call
	dim as Rational ptr r = new (ap) Rational( 3, 4 )
	
	'' you can see, the addresses are the same, just having different types in the compiler
	print ap, r
	
	'' confirm all is okay
	print r->numerator & "/" & r->denominator

	'' destroying must be done explicitly, because delete will automatically free the memory
	'' and that isn't always okay when using placement new. ALWAYS explicitly call the destructor.
	r->destructor( )
	
	'' we explicitly allocated, so we explicitly deallocate
	deallocate( ap )

end scope
