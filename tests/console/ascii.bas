#include once "fbcunit.bi"

'//
'//	Test app for console mode
'//
'//	Draws the first 127 ascii characters on the screen
'//

#include once "common.bi"

SUITE( fbc_tests.console.ascii )

	'':::::
	private sub test_proc( )
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

	'// !!! TODO !!! fbcunit should handle this internally ...
	'// need to add capability to fbcunit

	#if ENABLE_CONSOLE_OUTPUT
	TEST( default )
		test_proc
	END_TEST
	#endif

END_SUITE
