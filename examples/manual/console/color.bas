'' examples/manual/console/color.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'COLOR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgColor
'' --------

Dim c As ULong

'retrieve current color values
c = Color()

'extract color values from c using LOWORD and HIWORD
Print "Console colors:"
Print "Foreground: " & LoWord(c)
Print "Background: " & HiWord(c)
