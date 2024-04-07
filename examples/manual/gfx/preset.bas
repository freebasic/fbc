'' examples/manual/gfx/preset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PRESET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPreset
'' --------

Screen 13

'Set background color to 15
Color , 15

'Draw a pixel with the background color at 10, 10
PReset (10,10)

'Draw a pixel with the background color at Last x cord +10, Last y cord +10
PReset Step (10,10)
Sleep
