'' examples/manual/control/on-goto.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ON...GOTO'
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
