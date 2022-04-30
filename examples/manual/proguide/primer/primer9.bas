'' examples/manual/proguide/primer/primer9.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FreeBASIC Primer #1'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPrimer1
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
