'' examples/manual/procs/declare.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDeclare
'' --------

'' declare the function sum which takes two integers and returns an integer
Declare Function sum( As Integer, As Integer ) As Integer

   Print "the sum of 420 and 69 is: " & sum( 420, 69 )    '' call the function sum

'' define the function sum which takes two integers and returns an integer
Function sum( a As Integer, b As Integer ) As Integer
   Return a + b
End Function
