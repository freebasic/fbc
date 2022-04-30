'' examples/manual/proguide/procptrs/typing-rule1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

'Example of assigning to a function pointer a function with:
'   - a contravariant parameter by pointer,
'   - and a covariant result by pointer.

Type A
	Dim As Integer I
	Declare Constructor ()
	Declare Destructor ()
End Type
Constructor A ()
	Print "    A instance constructed", @This
End Constructor
Destructor A ()
	Print "    A instance destroyed", @This
End Destructor

Type B Extends A
	Dim As Integer J
	Declare Constructor ()
	Declare Constructor (ByRef a0 As A)
	Declare Destructor ()
End Type
Constructor B ()
	Print "    B instance constructed", @This
End Constructor
Constructor B (ByRef a0 As A)
	Cast(A, This) = a0
	Print "    B instance constructed", @This
End Constructor
Destructor B ()
	Print "    B instance destroyed", @This
End Destructor

Function f (ByVal pa0 As A Ptr) As B Ptr
	Return New B(*pa0)
End Function

Scope
	Dim As Function (ByVal As B Ptr) As A Ptr pf = @f
	Print "'Scope : Dim As B b0':"
	Dim As B b0
	Print
	Print "'Dim As A Ptr pab = pf(@b0)':"
	Dim As A Ptr pab = pf(@b0)
	Print
	Print "'Delete CPtr(B Ptr, pab)':"
	Delete CPtr(B Ptr, pab)
	Print
	Print "'End Scope':"
End Scope

Sleep
		
