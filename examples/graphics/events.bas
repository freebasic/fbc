#include "fbgfx.bi"
using fb

function get_ascii(a as integer) as string
	if (a <> 0) then
		return "'" & chr(a) & "'"
	else
		return "unknown key"
	end if
end function

function get_button(b as integer) as string
	if (b = BUTTON_LEFT) then
		return "left"
	elseif (b = BUTTON_RIGHT) then
		return "right"
	else
		return "middle"
	end if
end function

screenres 640, 480, 32

dim e as EVENT
do
	while screenevent( @e ) <> 0
		select case as const e.type
		case EVENT_KEY_PRESS
			if e.scancode = SC_ESCAPE then
				exit do
			end if
			print get_ascii(e.ascii) & " was pressed (scancode " & e.scancode & ")"
		case EVENT_KEY_RELEASE
			print get_ascii(e.ascii) & " was released (scancode " & e.scancode & ")"
		case EVENT_KEY_REPEAT
			print get_ascii(e.ascii) & " is being repeated (scancode " & e.scancode & ")"
		case EVENT_MOUSE_MOVE
			print "mouse moved to " & e.x & "," & e.y & " (delta " & e.dx & "," & e.dy & ")"
		case EVENT_MOUSE_BUTTON_PRESS
			print get_button(e.button) & " mouse button pressed"
		case EVENT_MOUSE_BUTTON_RELEASE
			print get_button(e.button) & " mouse button released"
		case EVENT_MOUSE_DOUBLE_CLICK
			print get_button(e.button) & " mouse button double clicked"
		case EVENT_MOUSE_WHEEL
			print "mouse wheel moved to position " & e.z
		case EVENT_MOUSE_ENTER
			print "mouse moved into program window"
		case EVENT_MOUSE_EXIT
			print "mouse moved out of program window"
		case EVENT_WINDOW_GOT_FOCUS
			print "program window got focus"
		case EVENT_WINDOW_LOST_FOCUS
			print "program window lost focus"
		case EVENT_WINDOW_CLOSE
			exit do
		case fb.EVENT_MOUSE_HWHEEL
			print "horizontal mouse wheel moved to position " & e.w
		end select
	wend

	sleep 50, 1
loop
