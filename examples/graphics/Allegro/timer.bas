'' Example by Shawn Hargreaves.
'' This program demonstrates how to use the timer routines.
'' These can be a bit of a pain, because you have to be sure you lock 
'' all the memory that is used inside your interrupt handlers.

#include "allegro.bi"

dim shared as integer x, y, z

'' timer interrupt handler
sub inc_x cdecl ()
	x += 1
end sub

'' timer interrupt handler
sub inc_y cdecl ()
   	y += 1
end sub

'' timer interrupt handler
sub inc_z cdecl ()
   	z += 1
end sub

	allegro_init()
	install_keyboard()
	install_timer()

	if( set_gfx_mode(GFX_AUTODETECT_WINDOWED, 320, 200, 0, 0) <> 0 ) then
		set_gfx_mode(GFX_TEXT, 0, 0, 0, 0)
		end 1
	end if

	set_palette(@desktop_palette(0))
	clear_to_color(screen, makecol(255, 255, 255))
	text_mode(makecol(255, 255, 255))

	'' the speed can be specified in milliseconds (this is once a second)
	install_int(@inc_x, 1000)

	'' or in beats per second (this is 10 ticks a second)
	install_int_ex(@inc_y, BPS_TO_TIMER(10))

	'' or in seconds (this is 10 seconds a tick)
	install_int_ex(@inc_z, SECS_TO_TIMER(10))

	'' the interrupts are now active...
	do while (keypressed() = 0)
		textout_centre( screen, font, "x=" + str(x) + ", y=" + str(y) + ", z=" + str(z), _
		                SCREEN_W\2, 176, makecol(0, 0, 0) )
	loop

	END_OF_MAIN()
