'' examples/manual/gfx/cls.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCls
'' --------

#include "crt.bi"
Const x_res = 640, y_res = 480, bpp = 32
Dim scrbuf As Any Ptr, scrsize As Integer
Dim i As Integer, j As Integer

ScreenRes x_res, y_res, bpp, 2
ScreenSet 1, 0
scrbuf = ScreenPtr
scrsize = x_res * y_res * bpp / 8

i=1: j=1
Do
	ScreenLock
	memset scrbuf, 0, scrsize
	ScreenUnlock
	Circle (320, 240), i
	Flip
	If j = 1 Then
	    i = i + 1
	    If i >= 100 Then j = 2
	ElseIf j = 2 Then
	    i = i - 1
	    If i <= 0 Then j = 1
	End If
Loop While Inkey=""
