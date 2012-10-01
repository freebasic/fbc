'' examples/manual/operator/placement_new.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPlacementNew
'' --------

'' "placement new" example

Type Rational
	As Integer	numerator, denominator
End Type

Scope
	
	'' allocate some memory to construct as a Rational
	Dim As Any Ptr ap = CAllocate(Len(Rational))
	
	'' make the placement new call
	Dim As Rational Ptr r = New (ap) Rational( 3, 4 )
	
	'' you can see, the addresses are the same, just having different types in the compiler
	Print ap, r
	
	'' confirm all is okay
	Print r->numerator & "/" & r->denominator

	'' destroying must be done explicitly, because delete will automatically free the memory
	'' and that isn't always okay when using placement new. ALWAYS explicitly call the destructor.
	r->Destructor( )
	
	'' we explicitly allocated, so we explicitly deallocate
	Deallocate( ap )

End Scope
