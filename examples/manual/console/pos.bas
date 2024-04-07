'' examples/manual/console/pos.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'POS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPos
'' --------

Dim As Long p

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
