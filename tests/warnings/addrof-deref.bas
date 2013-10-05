type DerivedUdt extends object
end type

dim as any ptr pany
dim as integer ptr pinteger
dim as DerivedUdt ptr pderived

#print "resulting types should be 3 * INTEGER PTR and 3 * DerivedUdt PTR"
#print typeof( @( peek( integer, pany ) ) )
#print typeof( @( peek( integer, pinteger ) ) )
#print typeof( @( peek( integer, pderived ) ) )
#print typeof( @( peek( DerivedUdt, pany ) ) )
#print typeof( @( peek( DerivedUdt, pinteger ) ) )
#print typeof( @( peek( DerivedUdt, pderived ) ) )

#print

dim s as string
dim i as integer

#print "should all be UBYTE PTR:"
#print typeof( @s[0] )
#print typeof( @s[1] )
#print typeof( @s[i] )
