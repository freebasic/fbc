'' examples/manual/gfx/screen-func3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREEN (Console)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenCons
'' --------

'' open a full-color graphics screen
ScreenRes 320, 200, 32

'' print a character
Color RGB(255, 255, 0), RGB(0, 0, 255) 'yellow on blue
Print "M"

Dim As ULong char, fg, bg

'' get the ASCII value of the character we've just printed
char = Screen(1, 1, 0)

''get the color attributes
fg = Screen(1, 1, 1)
bg = Screen(1, 1, 2)

Print Using "ASCII value: ### (""!"")"; char; Chr(char)
Print Using "Foreground color: &"; Hex(fg, 8)
Print Using "Background color: &"; Hex(bg, 8)
Sleep
