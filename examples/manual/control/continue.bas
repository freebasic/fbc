'' examples/manual/control/continue.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONTINUE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgContinue
'' --------

Dim As Integer n

Print "Here are odd numbers between 0 and 10!"
Print
For n = 0 To 10

  If ( n Mod 2 ) = 0 Then 
	Continue For
  End If
  
  Print n
  
Next n
