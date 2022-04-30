'' examples/manual/strings/instr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INSTR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInstr
'' --------

' It will return 4
Print InStr("abcdefg", "de")

' It will return 0
Print InStr("abcdefg", "h")

' It will search for any of the characters "f", "b", "c", and return 2 as "b" is encountered first
Print InStr("abcdefg", Any "fbc")
