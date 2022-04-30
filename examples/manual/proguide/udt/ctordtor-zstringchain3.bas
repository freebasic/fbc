'' examples/manual/proguide/udt/ctordtor-zstringchain3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #1)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors
'' --------

Type ZstringChain                                    '' implement a zstring chain
	Dim As ZString Ptr pz                            '' define a pointer to the chain
	Declare Constructor ()                           '' declare the explicit default constructor
	Declare Constructor (ByVal size As Integer)      '' declare the explicit constructor with as parameter the chain size
	Declare Constructor (ByRef zc As ZstringChain)   '' declare the explicit copy constructor
	Declare Operator Let (ByRef zc As ZstringChain)  '' declare the explicit copy assignment operator
	Declare Destructor ()                            '' declare the explicit destructor
End Type

Constructor ZstringChain ()
	This.pz = 0  '' reset the chain pointer
End Constructor

Constructor ZstringChain (ByVal size As Integer)
	This.pz = CAllocate(size + 1, SizeOf(ZString))  '' allocate memory for the chain
End Constructor

Constructor ZstringChain (ByRef zc As ZstringChain)
	This.pz = CAllocate(Len(*zc.pz) + 1, SizeOf(ZString))  '' allocate memory for the new chain
	*This.pz = *zc.pz                                      '' initialize the new chain
End Constructor

Operator ZstringChain.Let (ByRef zc As ZstringChain)
	If @zc <> @This Then                                       '' avoid self assignment destroying the chain
		If This.pz <> 0 Then
			Deallocate This.pz                                 '' free the allocated memory if necessary
		End If
		This.pz = CAllocate(Len(*zc.pz) + 1, SizeOf(ZString))  '' allocate memory for the new chain
		*This.pz = *zc.pz                                      '' initialize the new chain
	End If
End Operator

Destructor ZstringChain ()
	If This.pz <> 0 Then
		Deallocate This.pz  '' free the allocated memory if necessary
		This.pz = 0         '' reset the chain pointer
	End If
End Destructor


Dim As ZstringChain zc1  '' instantiate a non initialized chain : useless

Dim As ZstringChain zc2 = ZstringChain(9)           '' instantiate a szstring chain of 9 useful characters
'                                                   '' shortcut: Dim As ZstringChain zc2 = 9
*zc2.pz = "FreeBASIC"                               '' fill up the chain with 9 characters
Print "zc2 chain:"
Print "'" & *zc2.pz & "'"                           '' print the chain
Print
Dim As ZstringChain zc3 = zc2                       '' instantiate a new szstring chain by copy construction
Print "zc3 chain (zc3 copy constructed from zc2):"
Print "'" & *zc3.pz & "'"                           '' print the chain
Print
*zc3.pz = "modified"                                '' modify the new chain
Print "zc3 chain (modified):"
Print "'" & *zc3.pz & "'"                           '' print the new chain
Print
Print "zc2 chain:"
Print "'" & *zc2.pz & "'"                           '' print the copied chain (not modified)
Print
zc3 = zc2
Print "zc3 chain (zc3 copy assigned from zc2):"
Print "'" & *zc3.pz & "'"                           '' print the new chain
Print
*zc3.pz = "changed"                                 '' modify the new chain
Print "zc3 chain (changed):"
Print "'" & *zc3.pz & "'"                           '' print the new chain
Print
Print "zc2 chain:"
Print "'" & *zc2.pz & "'"                           '' print the copied chain (not modified)

Sleep
			
