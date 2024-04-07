'' examples/manual/casting/cast2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CAST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCast
'' --------

'' macro sizeofDerefPtr(): returns the size of the dereferenced pointer
#define sizeofDerefPtr(ptrToDeref) SizeOf(*Cast(TypeOf(ptrToDeref), 0))

'' macro typeofDerefPtr(): returns the type of the dereferenced pointer
#define typeofDerefPtr(ptrToDeref) TypeOf(*Cast(TypeOf(ptrToDeref), 0))


' Allocate dynamically memory for a Double by New
Dim As Double Ptr pd
pd = New typeofDerefPtr(pd)
*pd = 3.14159
Print *pd

' Allocate dynamically memory for a Zstring*10 by Callocate
Dim As ZString Ptr pz
pz = CAllocate(10, sizeofDerefPtr(pz))
*pz = "FreeBASIC"
Print *pz

Sleep
Delete pd
Deallocate(pz)
