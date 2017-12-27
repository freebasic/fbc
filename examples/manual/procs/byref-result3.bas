'' examples/manual/procs/byref-result3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefFunction
'' --------

Function power2( ByRef _I As Integer ) ByRef As Integer
   _I *= _I
   '' This integer will be returned by reference, no copy will be created.
   Function = _I
End Function

Dim As Integer I = 2
power2( power2( power2( I ) ) )  '' Function return-byref cascading is equivalent to ((I*I)*(I*I))*((I*I)*(I*I)) = I^8
Print I
