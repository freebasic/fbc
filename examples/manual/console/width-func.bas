'' examples/manual/console/width-func.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWidth
'' --------

Dim As Integer w
w = Width
Print "rows: " & HiWord(w)
Print "cols: " & LoWord(w)
