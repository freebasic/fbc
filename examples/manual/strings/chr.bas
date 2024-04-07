'' examples/manual/strings/chr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CHR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgChr
'' --------

Print "the character represented by";
Print " the ASCII code of 97 is: "; Chr(97)

Print Chr(97, 98, 99) ' prints abc

' s initially has the value "abc"
Dim s As String = Chr(97, 98, 99)

Print s
