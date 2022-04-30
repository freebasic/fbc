'' examples/manual/gfx/screen-func1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREEN (Console)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenCons
'' --------

'' open a graphics screen with 4 bits per pixel
'' (alternatively, omit this line to use the console)
ScreenRes 320, 200, 4

'' print a character
Color 7, 1
Print "A"

Dim As ULong char, col, fg, bg

'' get the ASCII value of the character we've just printed
char = Screen(1, 1, 0)

''get the color attributes
col = Screen(1, 1, 1)
fg = col And &HF
bg = (col Shr 4) And &HF

Print Using "ASCII value: ### (""!"")"; char; Chr(char)
Print Using "Foreground color: ##"; fg
Print Using "Background color: ##"; bg
Sleep
