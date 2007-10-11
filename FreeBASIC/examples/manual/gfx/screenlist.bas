'' examples/manual/gfx/screenlist.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenlist
'' --------

Dim As Integer mode, w, h
'' Find which 8bit resolutions are supported
mode = ScreenList(8)
While (mode)
	w = HiWord(mode)
	h = LoWord(mode)
	Print Str(w) + "x" + Str(h)
	mode = ScreenList
Wend
