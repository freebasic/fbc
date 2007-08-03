'' examples/manual/proguide/primer/primer9.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPrimer1
'' --------

Dim number As Integer
Input "Enter a number : ", number
Print "Your number is ";
If number < 0 Then
  Print "negative"
ElseIf number > 0 Then
  Print "positive"
Else
  Print "zero"
End If
