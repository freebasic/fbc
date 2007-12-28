'' examples/manual/gfx/bsave.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBsave
'' --------

' Set gfx mode
ScreenRes 320, 200, 32

' Clear with black on white
Color RGB(0, 0, 0), RGB(255, 255, 255)
Cls

Locate 13, 15: Print "Hello world!"

' Save as BMP
BSave "hello.bmp", 0
