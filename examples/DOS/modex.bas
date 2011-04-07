''
'' DOS example utilizing tweaked VGA mode 320x240x8bpp (Mode X)
''



#include "dos/dpmi.bi"
#include "dos/go32.bi"
#include "dos/pc.bi"
#include "dos/sys/farptr.bi"

#define SC_INDEX	&H3C4
#define CRTC_INDEX	&H3D4
#define MISC_OUTPUT	&H3C2

modex:
data &H0D06 '/* vertical total */
data &H3E07 '/* overflow (bit 8 of vertical counts) */
data &H4109 '/* cell height (2 to double scan) */
data &HEA10 '/* v sync start */
data &HAC11 '/* v sync end and protect cr0-cr7 */
data &HDF12 '/* vertical displayed */
data &H0014 '/* turn off dword mode */
data &HE715 '/* v blank start */
data &H0616 '/* v blank end */
data &HE317 '/* turn on byte mode */
data 0

Dim regs As __dpmi_regs

Dim buffer(320 * 240 - 1) As UByte

Dim i As Integer

sub linear_to_modex(byval src as ubyte ptr)
	dim plane as integer, scr as ubyte ptr, buf as ubyte ptr
	dim x as integer, y as integer
	_farsetsel(_dos_ds)
	for plane = 0 to 3
		buf = src + plane
		outportw(SC_INDEX, (&H100 shl plane) or &H02)		' set write plane
		scr = &HA0000
		for y = 0 to 240 - 1
			for x = 0 to 320 - 1 step 4
				_farnspokeb(scr, buf[x])
				scr += 1
			next x
			buf += 320
		next y
	next plane
end sub

regs.x.ax = &H13
__dpmi_int(&H10, @regs)

' tweak to Mode X
outportw(SC_INDEX, &H0604)   ' disable chain4

outportw(SC_INDEX, &H0100)   ' synchronous reset
outportb(MISC_OUTPUT, &HE3)  ' select 25 MHz dot clock & 60 Hz scanning rate
outportw(SC_INDEX, &H0300)   ' undo reset (restart sequencer)

outportb(CRTC_INDEX, &H11)   ' VSync End reg contains register write protect bit
outportb(CRTC_INDEX+1, inportb(CRTC_INDEX+1) and &H7F) 	' remove write protect on various CRTC registers

restore modex
do
	read i
	outportw(CRTC_INDEX, i)
loop until i = 0


Do While Len(InKey) = 0
	
	__dpmi_yield
	
	For i = @buffer(0) To @buffer(320 * 240 - 1)
		Poke i, Int(Rnd * 256)
	Next i
	
	linear_to_modex(@buffer(0))
	
Loop

' set a standard text mode
regs.x.ax = &H03
__dpmi_int(&H10, @regs)
