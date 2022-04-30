'' examples/manual/console/screen-func.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenCons
'' --------

Dim character_ascii_value As ULong
Dim attribute As ULong
Dim background As ULong
Dim cell_color As ULong
Dim row As Long, col As Long

character_ascii_value = Screen( row, col )
attribute = Screen( row, col, 1 )
background = attribute Shr 4
cell_color = attribute And &hf
