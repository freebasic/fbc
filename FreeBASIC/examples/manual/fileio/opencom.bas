'' examples/manual/fileio/opencom.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpen
'' --------

'OPEN A COM PORT
Open Com "COM1:9600,N,8,1" As #1
If Err>0 Then Print "The port could not be opened."

'COM1, 9600 BAUD, NO PARITY BIT, EIGHT DATA BITS, ONE STOP BIT
