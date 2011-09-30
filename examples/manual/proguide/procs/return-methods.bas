'' examples/manual/proguide/procs/return-methods.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgReturnValue
'' --------

'' Using the name of the function to set the return value and continue executing the function:
Function myfunc1() As Integer
   myfunc1 = 1
End Function

'' Using the keyword 'Function' to set the return value and continue executing the function:
Function myfunc2() As Integer
   Function = 2
End Function

'' Using the keyword 'Return' to set the return value and immediately exit the function:
Function myfunc3() As Integer
   Return 3
End Function
