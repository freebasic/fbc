'' examples/manual/operator/placement_new.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Placement New'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPlacementNew
'' --------

'' "placement new" example

Type Rational
	As Integer    numerator, denominator
	Declare Constructor ( ByVal n As Integer, ByVal d As Integer )
	As String ratio = "/"
End Type

Constructor Rational ( ByVal n As Integer, ByVal d As Integer )
	This.numerator = n
	This.denominator = d
End Constructor

Scope
   
	'' allocate some memory to construct as a Rational
	Dim As Any Ptr ap = CAllocate(Len(Rational))
   
	'' make the placement new call
	Dim As Rational Ptr r = New (ap) Rational( 3, 4 )
   
	'' you can see, the addresses are the same, just having different types in the compiler
	Print ap, r
   
	'' confirm all is okay
	Print r->numerator & r->ratio & r->denominator
	
	'' delete must not be used with placement new
	'' destroying must be done explicitly if a destructor exists (implicitly or explicitly)
	''   (in this example, the var-string member induces an implicit destructor)
	r->Destructor( )
	
	'' we explicitly allocated, so we explicitly deallocate
	Deallocate( ap )
	
End Scope
