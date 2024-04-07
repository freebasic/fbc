'' examples/manual/fileio/openlpt1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPEN LPT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenLpt
'' --------

' Send some text to the Windows printer on LPT1:, using driver text imaging.
Open Lpt "LPT1:EMU=TTY" For Output  As #1
Print #1, "Testing!" 
Close
