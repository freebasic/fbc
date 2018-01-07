'' examples/manual/proguide/procptrs/typing-rule.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

'Example of assigning to a function pointer a function with a contravariant parameter and a covariant result.

Type A
	Dim As Integer I
End Type

Type B Extends A
	Dim As Integer J
End Type

Function f (ByRef a0 As A) As B Ptr
	Print "instance of B created"
	Return New B(a0)
End Function

Dim As Function (ByRef As B) As A Ptr pf = @f

Dim As B b0
Dim As A Ptr pab = pf(b0)

Sleep
Delete CPtr(B Ptr, pab)
