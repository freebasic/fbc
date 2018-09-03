'' examples/manual/datatype/funcptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunctionPtr
'' --------

Function ConcatSelf( x As String ) As String
	Return x & x
End Function

Dim x As Function( x As String ) As String = ProcPtr( ConcatSelf )

Print x( "Hello" )
