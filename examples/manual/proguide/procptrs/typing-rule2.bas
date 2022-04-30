'' examples/manual/proguide/procptrs/typing-rule2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

'Example of assigning to a function pointer a function with:
'   - a contravariant parameter by reference,
'   - and a covariant result by reference.

Type A Extends Object
	Dim As Integer I
	Declare Constructor ()
	Declare Virtual Destructor ()
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
	Declare Virtual Destructor ()
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

Function f (ByRef a0 As A) ByRef As B
	Return *New B(a0)
End Function

Scope
	Dim As Function (ByRef As B) ByRef As A pf = @f
	Print "'Scope : Dim As B b0':"
	Dim As B b0
	Print
	Print "'Dim Byref As A rab = pf(b0)':"
	Dim ByRef As A rab = pf(b0)
	Print
	Print "'Delete @rab':"
	Delete @rab
	Print
	Print "'End Scope':"
End Scope

Sleep
		
