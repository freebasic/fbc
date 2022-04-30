'' examples/manual/gfx/screen-func2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREEN (Console)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenCons
'' --------

'' open a graphics screen with 8 bits per pixel
ScreenRes 320, 200, 8

'' print a character
Color 30, 16
Print "Z"

Dim As ULong char, col, fg, bg

'' get the ASCII value of the character we've just printed
char = Screen(1, 1, 0)

''get the color attributes
col = Screen(1, 1, 1)
fg = col And &HFF
bg = (col Shr 8) And &HFF

Print Using "ASCII value: ### (""!"")"; char; Chr(char)
Print Using "Foreground color: ###"; fg
Print Using "Background color: ###"; bg
Sleep
