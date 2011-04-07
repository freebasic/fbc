'' examples/manual/gfx/flip.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFlip
'' --------

ScreenRes 320, 240, 32, 2    'Sets up the screen to be 320x240 in 32-bit color with 2 video pages.


For n As Integer = 50 To 270

	ScreenSet 2,1     'Sets the working page to 2 and the displayed page to 1
	Cls
	Circle (n, 50),50 ,RGB(255,255,0) 'Draws a circle with a 50 pixel radius in yellow on page 2
	ScreenSet 1,1    'Sets the working page to 1 and the displayed page to 1
	ScreenSync    'Waits for vertical refresh
	Flip 2,1    'Copies our circle from page 2 to page 1

	Sleep 25
Next

Print "Now wasn't that neat!"
Print "Push any key."
Sleep
