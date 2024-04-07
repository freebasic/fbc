'' examples/manual/gfx/screenres.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREENRES'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenres
'' --------

' Set the screen mode to 320*200, with 8 bits per pixel
ScreenRes 320, 200, 8

' Draw color bands in a diagonal pattern over the whole screen
For y As Long = 0 To 200-1
	For x As Long = 0 To 320-1
		PSet (x,y),(x + y) And 255
	Next x
Next y

' Display the text "Hello World!!" over the lines we've drawn, in the top-left hand corner
Print "Hello world!!"

' Keep the window open until the user presses a key
Sleep
