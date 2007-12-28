'' examples/manual/gfx/screenres.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenres
'' --------

Dim a As Integer, b As Integer

ScreenRes 640, 480, 8       'This line will set the screen mode to 640x480x8.
	                        'The following code block will draw diagonal lines over the whole screen.
For a = 1 To 640
	For b = 1 To 480
	    PSet (a,b),(a + b) And 255
	Next b
Next a
	                        'The following line will print "Hello World!" over the lines we've drawn.
Print "Hello world!!"

Sleep
End
