'' examples/manual/datatype/funcptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FUNCTION Pointer'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunctionPtr
'' --------

Function ConcatSelf( x As String ) As String
	Return x & x
End Function

Dim x As Function( x As String ) As String = ProcPtr( ConcatSelf )

Print x( "Hello" )
