#print "resulting types should be 3 * INTEGER PTR and 3 * DerivedUdt PTR"
type DerivedUdt extends object
end type
scope
	dim as any ptr pany
	dim as integer ptr pinteger
	dim as DerivedUdt ptr pderived
	#print typeof( @( peek( integer, pany ) ) )
	#print typeof( @( peek( integer, pinteger ) ) )
	#print typeof( @( peek( integer, pderived ) ) )
	#print typeof( @( peek( DerivedUdt, pany ) ) )
	#print typeof( @( peek( DerivedUdt, pinteger ) ) )
	#print typeof( @( peek( DerivedUdt, pderived ) ) )
end scope

#print
#print "should all be UBYTE PTR:"
scope
	dim s as string
	dim i as integer
	#print typeof( @s[0] )
	#print typeof( @s[1] )
	#print typeof( @s[i] )
end scope

'' ADDROF( NOCONVCAST( DEREF( ptr ) ) ) -> cast( typeAddrOf( NOCONVCAST's type ), cast( typeAddrOf( DEREF's type ), ptr ) )
#print
#print "should be ULONG PTR:"
scope
	dim as long ptr pl
	#print typeof( @culng( *pl )  )
end scope

#print
#print "should all be UINTEGER PTR:"
dim shared as integer globali
scope
	static as integer statici
	dim as integer i
	#print typeof( @cuint( globali ) )
	#print typeof( @cuint( statici ) )
	#print typeof( @cuint( i ) )
end scope
