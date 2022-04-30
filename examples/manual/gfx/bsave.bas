'' examples/manual/gfx/bsave.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BSAVE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBsave
'' --------

' Set gfx mode
ScreenRes 320, 200, 32

' Clear with black on white
Color RGB(0, 0, 0), RGB(255, 255, 255)
Cls

Locate 13, 15: Print "Hello world!"

' Save screen as BMP
BSave "hello.bmp", 0
