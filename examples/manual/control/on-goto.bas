'' examples/manual/control/on-goto.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOngoto
'' --------

Dim choice As Integer

Input "Enter a number: ", choice

On choice Goto labela, labelb, labelc

labela:
Print "choice a"
End

labelb:
Print "choice b"
End

labelc:
Print "choice c"
End
