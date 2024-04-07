'' examples/manual/proguide/constants/constants.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constants'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgConstants
'' --------

Declare Sub PrintConstants ()

Const FirstNumber = 1
Const SecondNumber = 2
Const FirstString = "First string."
Const FirstBoolean = False
Const SecondBoolean = True

Print FirstNumber, SecondNumber 'This will print 1      2
Print FirstString 'This will print First string.
Print FirstBoolean, SecondBoolean 'This will print false      true
Print

PrintConstants ()

Sub PrintConstants ()
	Print FirstNumber, SecondNumber 'This will also print 1        2
	Print FirstString 'This will also print First string.
	Print FirstBoolean, SecondBoolean 'This will also print false      true
End Sub
