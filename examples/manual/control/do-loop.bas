'' examples/manual/control/do-loop.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DO...LOOP'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDoloop
'' --------

Dim As Integer n = 1                            '' number to check
Dim As Integer total_odd = 0                    '' running total of odd numbers
Do Until( n > 10 )
  If( ( n Mod 2 ) > 0 ) Then total_odd += 1    '' add to total if n is odd (has remainder from division by 2)
  n += 1
Loop
Print "total odd numbers: " ; total_odd         '' prints '5'

End 0
