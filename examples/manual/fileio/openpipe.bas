'' examples/manual/fileio/openpipe.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenPipe
'' --------

Dim text As String
Open Pipe "fbc.exe" For Input As #1
Print "Output of fbc:"
Do While Not EOF(1)
   Line Input #1, text
   Print text
Loop
Close #1
