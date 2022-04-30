'' examples/manual/proguide/procptrs/method-ptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

/''
 ' This example shows how you can simulate getting a class method pointer, 
 ' until support is properly implemented in the compiler.
 '
 ' When this is supported, you will only need to remove the static wrapper
 ' function presented here, to maintain compatibility. 
 '/

Type T
	Declare Function test(ByVal number As Integer) As Integer
	Declare Static Function test(ByRef This As T, ByVal number As Integer) As Integer
	Dim As Integer i = 420
End Type

Function T.test(ByVal number As Integer) As Integer
	Return i + number
End Function

Function T.test(ByRef This As T, ByVal number As Integer) As Integer
	Return this.test(number)
End Function

Dim p As Function(ByRef As T, ByVal As Integer) As Integer
p = @T.test

Dim As T obj

Print p(obj, 69) '' prints 489
	
