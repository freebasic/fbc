'' examples/manual/control/ongosub.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ON...GOSUB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOngosub
'' --------

'' Compile with -lang qb

'$lang: "qb"

choice = 3
On choice GoSub labela, labelb, labelc
Print "Good bye."
End

labela:
Print "choice a"
Return

labelb:
Print "choice b"
Return

labelc:
Print "choice c"
Return
