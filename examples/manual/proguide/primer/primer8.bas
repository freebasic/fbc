'' examples/manual/proguide/primer/primer8.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPrimer1
'' --------

Dim total As Integer
Dim number As Integer
total = 0
For number = 1 To 100
  total = total + number
Next
Print "The sum of number from 1 to 100 is "; total
