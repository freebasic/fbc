'' examples/manual/gfx/color.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgColor
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
