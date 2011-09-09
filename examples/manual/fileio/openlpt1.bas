'' examples/manual/fileio/openlpt1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenLpt
'' --------

' Send some text to the Windows printer on LPT1:, using driver text imaging.
Open Lpt "LPT1:EMU=TTY" For Output  As #1
Print #1, "Testing!" 
Close
