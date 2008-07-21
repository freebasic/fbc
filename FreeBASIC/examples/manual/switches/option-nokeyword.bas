'' examples/manual/switches/option-nokeyword.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionnokeyword
'' --------

'' Compile with the "-lang fblite" compiler switch

#lang "fblite"

Option NoKeyword Int        ' remove the keyword 'int' from the internal
	                        ' symbol table

Dim Int As Integer          ' declare a variable with the name 'int'
