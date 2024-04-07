'' examples/manual/proguide/procptrs/method-ptr2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

/''
 ' This example shows, since fbc 1.10.0, how to directly obtain a class method pointer,
 '/

Type T
	Declare Function test(ByVal number As Integer) As Integer
	Dim As Integer i = 420
End Type

Function T.test(ByVal number As Integer) As Integer
	Return i + number
End Function

Dim p As Function(ByRef As T, ByVal As Integer) As Integer
p = ProcPtr(T.test)  '' or 'p = @T.test'

Dim As T obj

Print p(obj, 69) '' prints 489
	
