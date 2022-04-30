'' examples/manual/fileio/opencom.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPEN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpen
'' --------

'OPEN A COM PORT
Open Com "COM1:9600,N,8,1" As #1
If Err>0 Then Print "The port could not be opened."

'COM1, 9600 BAUD, NO PARITY BIT, EIGHT DATA BITS, ONE STOP BIT
