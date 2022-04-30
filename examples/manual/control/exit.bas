'' examples/manual/control/exit.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'EXIT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExit
'' --------

'e.g. the print command will not be seen

Do
	Exit Do ' Exit the Do...Loop and continues to run the code after Loop
	Print "I will never be shown"
Loop
