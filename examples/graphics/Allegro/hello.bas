' "Hello, world!" example program by Shawn Hargreaves.
' This is a very simple program showing how to get into graphics
' mode and draw text onto the screen.

#include "allegro.bi"

	' you should always do this at the start of Allegro programs
	allegro_init()

	' set up the keyboard handler
	install_keyboard()

	' set a graphics mode sized 320x200
	if (set_gfx_mode(GFX_SAFE, 320, 200, 0, 0) <> 0) then
		set_gfx_mode(GFX_TEXT, 0, 0, 0, 0)
		allegro_message("Unable to set any graphic mode" + chr(13) + allegro_error + chr(13))
		end 1
	end if

	' set the color palette
	set_palette(@desktop_palette(0))

	' clear the screen to white
	clear_to_color(screen, makecol(255, 255, 255))

	' you don't need to do this, but on some platforms (eg. Windows) things
	' will be drawn more quickly if you always acquire the screen before
	' trying to draw onto it.
	acquire_screen()

	' set transparent text
	text_mode(-1)

	' write some text to the screen with black letters
	textout_centre(screen, font, "Hello, world!", SCREEN_W\2, SCREEN_H\2, makecol(0,0,0))

	' you must always release bitmaps before calling any input functions
	release_screen()

	' wait for a keypress
	readkey()

	END_OF_MAIN()
