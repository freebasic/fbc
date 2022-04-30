'' examples/manual/fileio/openlpt.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPEN LPT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenLpt
'' --------

'This simple program will print a PostScript file to a PostScript compatible printer.
Dim As Long FFI, PPO
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
