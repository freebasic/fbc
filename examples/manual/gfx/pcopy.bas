'' examples/manual/gfx/pcopy.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PCOPY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPcopy
'' --------

'Sets up the screen to be 320x200 in 8-bit color with 2 video pages.
ScreenRes 320, 200, 8, 2

'Sets the working page to 1 and the displayed page to 0
ScreenSet 1, 0

'Draws a circle moving across the top of the screen
For x As Integer = 50 To 269
	Cls                    'Clears the screen so we can start fresh
	Circle (x, 50), 50, 14 'Draws a yellow circle with a 50 pixel radius on page 1
	PCopy 1, 0             'Copies our image from page 1 to page 0
	Sleep 25               'Waits for 25 milliseconds.
Next x

'Wait for a keypress before the screen closes
Sleep
