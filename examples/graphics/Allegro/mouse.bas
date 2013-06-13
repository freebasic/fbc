'' Mouse input example by Shawn Hargreaves.

#include "allegro.bi"

	dim mickeyx as integer
	dim mickeyy as integer
	dim custom_cursor as BITMAP ptr
	dim c as integer

	allegro_init()
	install_keyboard()
	install_timer()
	if (set_gfx_mode(GFX_SAFE, 320, 240, 0, 0) <> 0) then
		end 1 
	end if

	set_palette( @desktop_palette(0) )
	text_mode(makecol(255, 255, 255))
	clear_to_color(screen, makecol(255, 255, 255))

	'' Detect mouse presence
	if( install_mouse() < 0 ) then
		textout_centre(screen, font, "No mouse detected, but you need one!", _
		               SCREEN_W\2, SCREEN_H\2, makecol(0, 0, 0))
		readkey()
		end 1
	end if

	do
		'' On most platforms (eg. DOS) things will still work correctly
		'' without this call, but it is a good idea to include it in any
		'' programs that you want to be portable, because on some platforms
		'' you may not be able to get any mouse input without it.
		poll_mouse()

		acquire_screen()

		'' the mouse position is stored in the variables mouse_x and mouse_y
		textout(screen, font, "mouse_x =" + str(mouse_x) + "    ", 16, 48, makecol(0, 0, 0))
		textout(screen, font, "mouse_y =" + str(mouse_y) + "    ", 16, 64, makecol(0, 0, 0))

		'' or you can use this function to measure the speed of movement.
		'' Note that we only call it every fourth time round the loop: 
		'' there's no need for that other than to slow the numbers down 
		'' a bit so that you will have time to read them...
		c = c + 1
		if ((c and 3) = 0) then
			get_mouse_mickeys(@mickeyx, @mickeyy)
		end if

		textout(screen, font, "mickey_x =" + str(mickeyx) + "    ", 16, 88, makecol(0, 0, 0))
		textout(screen, font, "mickey_y =" + str(mickeyy) + "    ", 16, 104, makecol(0, 0, 0))

		'' the mouse button state is stored in the variable mouse_b
		if (mouse_b and 1) then
			textout(screen, font, "left button is pressed ", 16, 128, makecol(0, 0, 0))
		else
			textout(screen, font, "left button not pressed", 16, 128, makecol(0, 0, 0))
		end if

		if (mouse_b and 2) then
			textout(screen, font, "right button is pressed ", 16, 144, makecol(0, 0, 0))
		else
			textout(screen, font, "right button not pressed", 16, 144, makecol(0, 0, 0))
		end if

		if (mouse_b and 4) then
			textout(screen, font, "middle button is pressed ", 16, 160, makecol(0, 0, 0))
		else
			textout(screen, font, "middle button not pressed", 16, 160, makecol(0, 0, 0))
		end if

		'' the wheel position is stored in the variable mouse_z
		textout(screen, font, "mouse_z =" + str(mouse_z) + "    ", 16, 184, makecol(0, 0, 0))

		release_screen()

		vsync()
	loop while( keypressed() = 0 )

	clear_keybuf()

	''  To display a mouse pointer, call show_mouse(). There are several 
	''  things you should be aware of before you do this, though. For one,
	''  it won't work unless you call install_timer() first. For another,
	''  you must never draw anything onto the screen while the mouse
	''  pointer is visible. So before you draw anything, be sure to turn 
	''  the mouse off with show_mouse(NULL), and turn it back on again when
	''  you are done.
	clear_to_color(screen, makecol(255, 255, 255))
	textout_centre(screen, font, "Press a key to change cursor", _
	               SCREEN_W\2, SCREEN_H\2, makecol(0, 0, 0))
	show_mouse(screen)
	readkey()
	show_mouse(NULL)

	'' create a custom mouse cursor bitmap...
	custom_cursor = create_bitmap(32, 32)
	clear_to_color(custom_cursor, bitmap_mask_color(screen))
	for c= 0 to 8-1
		circle(custom_cursor, 16, 16, c*2, palette_color[c])
	next c

	'' select the custom cursor and set the focus point to the middle of it
	set_mouse_sprite(custom_cursor)
	set_mouse_sprite_focus(16, 16)

	clear_to_color(screen, makecol(255, 255, 255))
	textout_centre(screen, font, "Press a key to quit", SCREEN_W\2, _
				   SCREEN_H\2, makecol(0, 0, 0))
	show_mouse(screen)
	readkey()
	show_mouse(NULL)

	destroy_bitmap(custom_cursor)

	END_OF_MAIN()
