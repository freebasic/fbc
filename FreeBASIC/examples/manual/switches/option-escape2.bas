'' examples/manual/switches/option-escape2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionescape
'' --------

' Compile with -lang deprecated
Option Escape
Print $"This string doesn't have expanded escape sequences: \r\n\t"
