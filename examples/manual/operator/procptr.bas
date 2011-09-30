'' examples/manual/operator/procptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpProcptr
'' --------

' This example uses ProcPtr to demonstrate function pointers
Declare Function Subtract( x As Integer, y As Integer) As Integer
Declare Function Add( x As Integer, y As Integer) As Integer
Dim myFunction As Function( x As Integer, y As Integer) As Integer

' myFunction will now be assigned to Add
myFunction = ProcPtr( Add )
Print myFunction(2, 3)

' myFunction will now be assigned to Subtract.  Notice the different output.
myFunction = ProcPtr( Subtract )
Print myFunction(2, 3)

Function Add( x As Integer, y As Integer) As Integer
	Return x + y
End Function

Function Subtract( x As Integer, y As Integer) As Integer
	Return x - y
End Function
