'' examples/manual/gfx/cls-memset.bas
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

ScreenRes x_res, y_res, bpp
scrbuf = ScreenPtr
scrsize = x_res * y_res * bpp / 8

Do
	ScreenLock
	    memset scrbuf, 0, scrsize
	    Circle (320, 240), i
	ScreenUnlock
   
	If j = 0 Then
	    i = i + 1
	    If i >= 100 Then j = 1
	ElseIf j = 1 Then
	    i = i - 1
	    If i <= 0 Then j = 0
	End If
   
	Sleep 1, 1
Loop While Inkey=""
