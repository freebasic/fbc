'' examples/manual/gfx/screenlist.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenlist
'' --------

Dim As Integer mode, w, h

Print "Resolutions supported at 8 bits per pixel:"

mode = ScreenList(8)
While (mode <> 0)
	w = HiWord(mode)
	h = LoWord(mode)
	Print w & "x" & h
	mode = ScreenList()
Wend
