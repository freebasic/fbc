'' examples/manual/gfx/drawstring.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDrawString
'' --------

Const w = 320, h = 200 '' screen dimensions

Dim x As Integer, y As Integer, s As String

'' Open a graphics window
ScreenRes w, h

'' Draw a string in the centre of the screen:

s = "Hello world"
x = (w - Len(s) * 8) \ 2
y = (h - 1 * 8) \ 2

Draw String (x, y), s

'' Wait for a keypress before ending the program
Sleep
