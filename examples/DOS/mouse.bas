''
'' simple DOS text-mode mouse example to demonstrate DOS-specific features
''



#include "dos/dpmi.bi"

#define MOUSE &H33

dim regs as __dpmi_regs
dim x as integer, y as integer, b as integer

width 80, 25

for y = 1 to 25
	for x = 1 to 80
		locate y, x
		color int(rnd * 16)
		print chr(176);
	next x
next y

' turn off text cursor
locate , , 0

' initialize mouse
regs.x.ax = 0
__dpmi_int(MOUSE, @regs)

' show mouse
regs.x.ax = 1
__dpmi_int(MOUSE, @regs)

do until len(inkey)
	' get mouse position
	regs.x.ax = 3
	__dpmi_int(MOUSE, @regs)
	x = regs.x.cx \ 8 ' divide by 8 - char width = 8
	y = regs.x.dx \ 8 ' divide by 8 - char height = 8
	b = regs.x.bx
	locate 1, 1
	print using "### ### //"; x, y, bin(b)
loop

' hide mouse
regs.x.ax = 2
__dpmi_int(MOUSE, @regs)

color 7, 0

cls
