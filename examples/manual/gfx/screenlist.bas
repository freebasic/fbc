'' examples/manual/gfx/screenlist.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREENLIST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenlist
'' --------

Dim As Long mode
Dim As UInteger w, h

Print "Resolutions supported at 8 bits per pixel:"

mode = ScreenList(8)
While (mode <> 0)
	w = HiWord(mode)
	h = LoWord(mode)
	Print w & "x" & h
	mode = ScreenList()
Wend
