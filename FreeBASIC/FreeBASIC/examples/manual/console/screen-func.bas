'' examples/manual/console/screen-func.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenCons
'' --------

Dim character_ascii_value As Integer
Dim attribute As Integer
Dim background As Integer
Dim cell_color As Integer
Dim row As Integer, col As Integer

character_ascii_value = Screen( row, col )
attribute = Screen( row, col, 1 )
background = attribute Shr 4
cell_color = attribute And &hf
