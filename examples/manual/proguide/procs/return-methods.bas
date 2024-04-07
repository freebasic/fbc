'' examples/manual/proguide/procs/return-methods.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Returning Values'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReturnValue
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
