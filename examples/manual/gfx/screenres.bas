'' examples/manual/gfx/screenres.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenres
'' --------

' Set the screen mode to 320*200, with 8 bits per pixel
ScreenRes 320, 200, 8

' Draw color bands in a diagonal pattern over the whole screen
For y As Integer = 0 To 200-1
	For x As Integer = 0 To 320-1
	    PSet (x,y),(x + y) And 255
	Next x
Next y

' Display the text "Hello World!!" over the lines we've drawn, in the top-left hand corner
Print "Hello world!!"

' Keep the window open until the user presses a key
Sleep
