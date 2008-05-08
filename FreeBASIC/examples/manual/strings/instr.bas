'' examples/manual/strings/instr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInstr
'' --------

' It will return 4
Print InStr("abcdefg", "de")

' It will return 0
Print InStr("abcdefg", "h")

' It will search for any of the characters "f", "b", "c", and return 2 as "b" is encountered first
Print InStr("abcdefg", Any "fbc")
