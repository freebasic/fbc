'' examples/manual/gfx/pcopy.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPcopy
'' --------

ScreenRes 320, 240, 32, 2    'Sets up the screen to be 320x240 in 32-bit color with 2 video pages.
Dim As Integer max_x_value = 270, x_value = 50    'Dimension our working variables.

Do While x_value < max_x_value     'Loop while x_value is less than the max
	ScreenSet 2,1     'Sets the working page to 2 and the displayed page to 1
	Cls    'Clears the screen so we can start fresh
	Circle (x_value,50),50,&h00FFFF00     'Draws a circle with a 50 pixel radius in yellow on page 2
	ScreenSet 1,1    'Sets the working page to 1 and the displayed page to 1
	ScreenSync    'Waits for vertical refresh
	PCopy 2,1    'Copies our circle from page 2 to page 1
	x_value += 1     'Increments x_value so it will move.
	Sleep 25     'Waits for 25 milliseconds.
Loop     'Goes back to do as long as x_value is less than x_max_value

Sleep   'Waits for any key to be pressed so you can see the work done.
