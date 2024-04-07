'' examples/manual/console/width-func.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WIDTH'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWidth
'' --------

Dim As Long w
w = Width
Print "rows: " & HiWord(w)
Print "cols: " & LoWord(w)
