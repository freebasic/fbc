#include once "fbcunit.bi"

'//
'//	Common routines for console tests
'//

'' !!! TODO !!! these common functions need not follow the fbcunit suite naming
'' they just need to be callable - fix this when fixing ENABLE_CONSOLE_OUTPUT
'' See:
''  - console/ascii.bas
''  - interactive/input.bas

namespace tests.fbc_tests.console

	'':::::
	sub draw_rect( byval x as integer, byval y as integer, byval w as integer, byval h as integer )
		dim i as integer
 		
		locate y, x: print ".";
		locate y, x + w - 1: print ".";
		locate y + h - 1, x: print "`";
		locate y + h - 1, x + w - 1: print "'";
		
		for i = x + 1 to x + w - 2
			locate y, i: print "_";
			locate y + h - 1, i: print "~";
		next i
		
		for i = y + 1 to y + h - 2
			locate i, x: print "|";
			locate i, x + w - 1: print "|";
		next i
	end sub


	'':::::
	sub center( byval y as integer, byref s as string )
		locate y, ((loword(width()) - len(s)) \ 2) + 1
		print s;
	end sub

end namespace
