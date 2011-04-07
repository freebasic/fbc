'' examples/manual/strings/chr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgChr
'' --------

Print "the character represented by";
Print " the ASCII code of 97 is: "; Chr(97)

Print Chr(97, 98, 99) ' prints abc

' s initially has the value "abc"
Dim s As String = Chr(97, 98, 99)

Print s
