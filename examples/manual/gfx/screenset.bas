'' examples/manual/gfx/screenset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREENSET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenset
'' --------

' Open graphics screen (320*200, 8bpp) with 2 pages
ScreenRes 320, 200, 8, 2

' Work on page 1 while displaying page 0
ScreenSet 1, 0

Dim As Integer x = -40

Do
	'' Clear the screen, draw a box, update x
	Cls
	Line (x, 80)-Step(39, 39), 4, BF
	x += 1: If (x > 319) Then x = -40
	
	' Wait for vertical sync: only used to control refresh rate, can be put anywhere in the Do loop
	ScreenSync
	
	' Copy work page to visible page
	ScreenCopy
	
Loop While Inkey = ""
