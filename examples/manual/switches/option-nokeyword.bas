'' examples/manual/switches/option-nokeyword.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION NOKEYWORD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionnokeyword
'' --------

'' Compile with the "-lang fblite" compiler switch

#lang "fblite"

Option NoKeyword Int        ' remove the keyword 'int' from the internal
							' symbol table

Dim Int As Integer          ' declare a variable with the name 'int'
