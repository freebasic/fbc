''
''	Common routines for console tests
''


'':::::
sub draw_rect( byval x as integer, byval y as integer, byval w as integer, byval h as integer )
	dim i as integer
	
	locate y, x: print chr(218);
	locate y, x + w - 1: print chr(191);
	locate y + h - 1, x: print chr(192);
	locate y + h - 1, x + w - 1: print chr(217);
	
	for i = x + 1 to x + w - 2
		locate y, i: print chr(196);
		locate y + h - 1, i: print chr(196);
	next i
	
	for i = y + 1 to y + h - 2
		locate i, x: print chr(179);
		locate i, x + w - 1: print chr(179);
	next i
end sub


'':::::
sub center( byval y as integer, byval s as string )
	locate y, ((loword(width()) - len(s)) / 2) + 1
	print s;
end sub
