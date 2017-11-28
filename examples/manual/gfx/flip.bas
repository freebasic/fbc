'' examples/manual/gfx/flip.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFlip
'' --------

ScreenRes 320, 240, 32, 2    'Sets up the screen to be 320x240 in 32-bit color with 2 video pages.
ScreenSet 1,0                'Sets the working page to 1 and the displayed page to 0


For n As Integer = 50 To 270

	Cls
	Circle (n, 50),50 ,RGB(255,255,0) 'Draws a circle with a 50 pixel radius in yellow on page 1
	Flip 1,0    'Copies our circle from page 1 to page 0

	Sleep 25
Next

Print "Now wasn't that neat!"
Print "Push any key."
Flip 1,0    'Copies our text from page 1 to page 0
Sleep
