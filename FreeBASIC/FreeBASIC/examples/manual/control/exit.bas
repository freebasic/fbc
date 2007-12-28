'' examples/manual/control/exit.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExit
'' --------

'e.g. the print command will not be seen

Do
	Exit Do ' Exit the Do...Loop and continues to run the code after Loop
	Print "I will never be shown"
Loop
