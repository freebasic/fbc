'' examples/manual/console/pos.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPos
'' --------

Dim As Integer p

'' print starting column position
p = Pos()
Print "position: "; p

'' print a string, without a new-line
Print "ABCDEF";

'' print new column position:
p = Pos()
Print: Print "position: "; p
Print

''position changes after each Print:
Print "Column numbers: "
Print Pos(), Pos(), Pos(), Pos(), Pos()
