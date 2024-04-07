'' examples/manual/gfx/color.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'COLOR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgColor
'' --------

' Sets 320x240 in 32bpp color depth
Screen 14, 32

' Sets orange foreground and dark blue background color
Color RGB(255, 128, 0), RGB(0, 0, 64)

' Clears the screen to the background color
Cls                     

' Prints "Hello World!" in the middle of the screen
Locate 15, 14
Print "Hello World!"

Sleep
