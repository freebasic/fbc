'' examples/manual/control/while-wend.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WHILE...WEND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWhilewend
'' --------

Dim As String sentence                          '' string to reverse
sentence = "The quick brown fox jumps over the lazy dog."

Dim As String ecnetnes
Dim As Integer index
index = Len( sentence ) - 1                     '' point to last character
While( index >= 0 )                             '' stop after first character
  ecnetnes += Chr( sentence[index] )           '' append character to new string
  index -= 1
Wend

Print "original: """ ; sentence ; """"
Print "reversed: """ ; ecnetnes ; """"

End 0
