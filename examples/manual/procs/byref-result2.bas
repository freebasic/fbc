'' examples/manual/procs/byref-result2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BYREF (function results)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefFunction
'' --------

Dim Shared As String s

Function f1( ) ByRef As String
   '' This variable-length string will be returned by reference, no copy will be created.
   Function = s
End Function

Function f2( ByRef _s As String ) ByRef As String
   '' This variable-length string will transit by reference (input and output), no copy will be created.
   Function = _s
End Function

s = "abcd"
Print s

f1( ) = f1( ) & "efgh"
Print s

'' The enclosing parentheses are required here on the left-hand side.
( f2( s ) ) = f2( s ) & "ijkl"
Print s

'' The enclosing parentheses are not required here on the left-hand side.
f2( s ) => f2( s ) & "mnop"
Print s
