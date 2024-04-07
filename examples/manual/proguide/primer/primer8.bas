'' examples/manual/proguide/primer/primer8.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FreeBASIC Primer #1'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPrimer1
'' --------

Dim total As Integer
Dim number As Integer
total = 0
For number = 1 To 100
  total = total + number
Next
Print "The sum of number from 1 to 100 is "; total
