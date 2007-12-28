'' examples/manual/proguide/primer/primer10.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPrimer1
'' --------

Dim total As Single, count As Single, number As Single
Dim text As String

Print "This program will calculate the sum and average for a"
Print "list of numbers.  Enter an empty value to end."
Print

Do
  Input "Enter a number : ", text
  If text = "" Then
	Exit Do
  End If

  count = count + 1
  total = total + Val(text)

Loop

Print
Print "You entered "; count; " numbers"
Print "The sum is "; total
If count <> 0 Then
  Print "The average is "; total / count
End If
