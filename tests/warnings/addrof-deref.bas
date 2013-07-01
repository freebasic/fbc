type DerivedUdt extends object
end type

dim as any ptr pany
dim as integer ptr pinteger
dim as DerivedUdt ptr pderived

'' resulting types should be 3 * INTEGER PTR and 3 * DerivedUdt PTR
#print typeof( @( peek( integer, pany ) ) )
#print typeof( @( peek( integer, pinteger ) ) )
#print typeof( @( peek( integer, pderived ) ) )
#print typeof( @( peek( DerivedUdt, pany ) ) )
#print typeof( @( peek( DerivedUdt, pinteger ) ) )
#print typeof( @( peek( DerivedUdt, pderived ) ) )
