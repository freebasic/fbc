''
'' implicit conversion between types test
''
		
	dim ub as ubyte
	dim us as ushort
	dim ui as uinteger
	dim ul as ulongint
	
	dim sb as byte
	dim ss as short
	dim si as integer
	dim sl as longint
	
	dim d as double
	
	''------------------
	ub = 255
	
	us = ub
	ui = us	
	
	print ub, us, ui,
	
	ui = ub
	ul = ui
	
	print ui, ul
	
	''------------------
	sb = -1
	
	ss = sb
	si = ss

	print sb, ss, si,

	si = sb
	sl = si
	
	print si, sl
		
	''------------------
	sb = -1
	
	us = sb
	ui = ss
	
	print ub, us, ui,

	ui = sb
	ul = ss
	
	print ui, ul
	
	''------------------
	ub = 255

	ss = ub
	si = us
	
	print sb, ss, si,
	
	si = ub
	sl = us
	
	print si, sl

	''------------------
	d = (2 ^ 32) - 1
	ui = d
	d = ui
	
	print ui, d,
	
	d = -1
	si = d
	d = si
	
	print si, d
	
	sleep
