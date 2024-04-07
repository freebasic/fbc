'' examples/manual/control/do-loop2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DO...LOOP'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDoloop
'' --------

   Dim As Integer n = 1                            '' number to check
   Dim As Integer total_even = 0                   '' running total of even numbers
   Do
	  If( n > 10 ) Then Exit Do                    '' exit if we've scanned our 10 numbers
   
	  If( ( n Mod 2 ) = 0 ) Then total_even += 1   '' add to total if n is even (no remainder from division by 2)
	  n += 1
   Loop
   Print "total even numbers: " ; total_even       '' prints '5'

   End 0
