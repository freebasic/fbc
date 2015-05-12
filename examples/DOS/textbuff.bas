''
'' simple DOS text-mode example to demonstrate DOS-specific features
''



#include "dos/go32.bi"
#include "dos/pc.bi"
#include "dos/sys/movedata.bi"

Sub TextBufferToScreen(buffer() As UByte, size As Integer)
	
	Do Until inportb(&H3DA) And 8: Loop	' wait for vertical blank
	
	dosmemput(@buffer(0), size, ScreenPrimary)
	
End Sub

Const ScreenWidth As Integer = 80
Const ScreenHeight As Integer = 50
Const ScreenBytes As Integer = ScreenWidth * ScreenHeight * 2

Dim buffer(ScreenBytes - 1) As UByte
Dim i As Integer

Width ScreenWidth, ScreenHeight

Locate , , 0	' turn off cursor

Do Until Len(Inkey)

	For i = 0 To ScreenBytes - 1 Step 2
		buffer(i) = Int(Rnd * 3) + 176
	Next i
	
	For i = 1 To ScreenBytes - 1 Step 2
		buffer(i) = Int(Rnd * 16)
	Next i
	
	TextBufferToScreen buffer(), ScreenWidth * ScreenHeight * 2
	
Loop

Cls
