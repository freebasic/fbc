'' examples/manual/fileio/openlpt.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenLpt
'' --------

'This simple program will print a PostScript file to a PostScript compatible printer.
Dim As UByte FFI, PPO
Dim As String temp

FFI = FreeFile()
Open "sample.ps" For Input Access Read As #FFI
PPO = FreeFile()
Open Lpt "LPT1:" For Output As #PPO
While (EOF(FFI) = 0)
Line Input #FFI, temp
Print #PPO, temp
Wend

Close #FFI
Close #PPO

Print "Printing Completed!"
