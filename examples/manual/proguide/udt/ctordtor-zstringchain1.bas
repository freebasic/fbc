'' examples/manual/proguide/udt/ctordtor-zstringchain1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #1)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors
'' --------

Type ZstringChain                                '' implement a zstring chain
	Dim As ZString Ptr pz                        '' define a pointer to the chain
	Declare Constructor ()                       '' declare the explicit default constructor
	Declare Constructor (ByVal size As Integer)  '' declare the explicit constructor with as parameter the chain size
	Declare Destructor ()                        '' declare the explicit destructor
End Type

Constructor ZstringChain ()
	This.pz = 0  '' reset the chain pointer
End Constructor

Constructor ZstringChain (ByVal size As Integer)
	This.pz = CAllocate(size + 1, SizeOf(ZString))  '' allocate memory for the chain
End Constructor

Destructor ZstringChain ()
	If This.pz <> 0 Then
		Deallocate This.pz  '' free the allocated memory if necessary
	This.pz = 0         '' reset the chain pointer
	End If
End Destructor


Dim As ZstringChain zc1  '' instantiate a non initialized chain : useless

Dim As ZstringChain zc2 = ZstringChain(9)  '' instantiate a szstring chain of 9 useful characters
'                                          '' shortcut: Dim As ZstringChain zc2 = 9
*zc2.pz = "FreeBASIC"                      '' fill up the chain with 9 characters
Print "zc2 chain:"
Print "'" & *zc2.pz & "'"                  '' print the chain

Sleep
			
