# include once "fbcunit.bi"

'//
'//	Test app for console mode
'//
'//	Draws the first 127 ascii characters on the screen
'//

#include once "common.bi"

'' TODO: change to SUITE() & TEST() 
''   after improving fbcunit API (see below)

namespace fbc_tests.console.ascii

'':::::
private sub test_1 cdecl ()
	dim as integer w, h, x, y, c

	w = loword(width())
	h = hiword(width())

	cls
	locate ,,0
	
	draw_rect 1, 1, w, h
	
	for y = 0 to 7
		for x = 0 to 15
			locate ((h - 16) \ 2) + y + 1, ((w - 16) \ 2) + x + 1
			print chr((x * 16) + y);
		next x
	next y
	
	sleep 1000

end sub

private sub ctor () constructor

'// fbcunit should handle this internally ...
'// need to add capability to fbcunit
# if ENABLE_CONSOLE_OUTPUT
	fbcu.add_suite("fbc_tests.console.ascii")
	fbcu.add_test("test 1", @test_1)
# endif

end sub

end namespace
