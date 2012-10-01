cls

dim as integer x = 0, y = 0, new_x, new_y

locate , , 1

while inkey() <> chr(27)
	getmouse new_x, new_y
	if( new_x <> x or new_y <> y ) then
		locate y+1, x+1: print " ";
		x = new_x
		y = new_y
		locate 1,1: print x, y,""
		locate y+1, x+1: print "X";
	end if
wend

cls
