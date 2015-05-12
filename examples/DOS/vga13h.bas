''
'' simple DOS graphics example to demonstrate DOS-specific features
''



#include "dos/dpmi.bi"
#include "dos/go32.bi"
#include "dos/sys/farptr.bi"


Dim regs As __dpmi_regs

Dim buffer(320 * 200 - 1) As UByte

Dim i As Integer


' set VGA mode 13h
'  320x200x8bpp
'  chain4 (linear)

regs.x.ax = &H13
__dpmi_int(&H10, @regs)

Do While Len(InKey) = 0
	
	__dpmi_yield
	
	For i = @buffer(0) To @buffer(320 * 200 - 1)
		Poke i, Int(Rnd * 256)
	Next i
	
	dosmemput @buffer(0), 320 * 200, &HA0000
	
Loop

' set a standard text mode
regs.x.ax = &H03
__dpmi_int(&H10, @regs)
