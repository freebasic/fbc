'' examples/manual/procs/byref-result2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefFunction
'' --------

Dim Shared As String s

Function f1( ) ByRef As String
   '' This variable-length string will be returned by reference, no copy will be created.
   Function = s
End Function

Function f2( ByRef _s As String ) ByRef As String
   '' This variable-length string will be returned by reference, no copy will be created.
   Function = _s
End Function

s = "abcd"
Print s

f1( ) &= "efgh"
Print s

'' At time of writing, the enclosing parentheses are required here.
( f2( s ) ) &= "ijkl"
Print s
