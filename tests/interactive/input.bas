#include "fbcunit.bi"
#include once "../console/common.bi"

SUITE( fbc_tests.interactive.input_ )

	''
	''	Test app for console mode
	''
	''	User input methods test

	declare sub inkey_test( byref title as string )

	dim shared as integer w, h

	private sub test_proc

		using fbc_tests.console
		
		dim as integer x, y, i, l
		dim as string s

		w = loword(width())
		h = hiword(width())

		cls
		locate ,,0
		
	  fbc_tests.console.draw_rect 1, 1, w, h
	  fbc_tests.console.center 2, "INPUT test"
		
		locate 5, 3, 1: input ">", s
		
		inkey_test "INKEY test (ESC to exit)"
		
		while multikey(1): wend
		cls
		locate ,,0
		
	  fbc_tests.console.draw_rect 1, 1, w, h
	  fbc_tests.console.center 2, "MULTIKEY test (ESC to exit)"
		
		do
			for x = 0 to 127
				locate 5 + (x / 128), ((w - 64) / 2) + (x and &h3F) + 1
				if multikey(x) then print "1"; else print "0";
			next x
		
		loop until multikey(1)
		while inkey <> "": wend

		inkey_test "INKEY test again, after MULTIKEY usage (ESC to exit)"

		cls
		locate ,,0
		
	  fbc_tests.console.draw_rect 1, 1, w, h
	  fbc_tests.console.center 2, "GETMOUSE test (ESC to exit)"
		
		do
			getmouse x, y
			locate 5, 3
			print "Position: ";
			if x < 0 then
				print "unavailable"
			else
				print using "##:##      "; x; y
			end if
		loop until multikey(1)
		
		while multikey(1): wend
		while inkey <> "": wend
		cls
		locate ,,0
		
	  fbc_tests.console.draw_rect 1, 1, w, h
	  fbc_tests.console.center 2, "All together! (ESC to exit)"
		
		l = 10
		do
			getmouse x, y
			locate 5, 3
			print "Mouse position: ";
			if x < 0 then
				print "unavailable"
			else
				print using "##:##      "; x; y
			end if
			
			for i = 0 to 127
				locate 7 + (i / 128), ((w - 64) / 2) + (i and &h3F) + 1
				if multikey(i) then print "1"; else print "0";
			next i

			s = inkey
			if s <> "" then
				view print 10 to h - 5
				locate l, 3: print s & " (ascii " & asc(s) & ")"
				l = csrlin
				view print
				'locate h - 5, 1: print chr(179);
				'locate h - 5, w: print chr(179);
			end if
			
		loop until multikey(1)
		
	end sub

	sub inkey_test( byref title as string )
		using fbc_tests.console
		
		dim as string s
		dim as integer y
		
		cls
	  fbc_tests.console.draw_rect 1, 1, w, h
	  fbc_tests.console.center 2, title
		
		view print 5 to h - 5
		do
			s = inkey: while s = "": s = inkey: wend
			locate , 3: print s & " (ascii " & asc(s) & ")"
			y = csrlin
			locate h - 5, 1: print chr(179);
			locate h - 5, w: print chr(179);
			locate y
		loop while s <> chr(27)
		view print
		
	end sub

	'// !!! TODO !!! improve fbcunit API (see below)
	'// we want to compile the test and only run it if an option is given
	'// fbcunit should handle this internally ...
	'// need to add capability to fbcunit
	#if ENABLE_INTERACTIVE
	TEST( default )
		test_proc
	END_TEST
	#endif

END_SUITE
