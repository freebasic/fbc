'' Allegro5 example, based on the Allegro5 documentation

#include "allegro5/allegro.bi"
#include "allegro5/allegro_font.bi"
#include "allegro5/allegro_ttf.bi"

var TTF_FONT = exepath() + "/../SDL/data/Vera.ttf"

al_init()
al_init_font_addon()
al_init_ttf_addon()

var display = al_create_display(640, 480)
if display = NULL then
	print "al_create_display() failed"
	end 1
end if

var font = al_load_ttf_font(TTF_FONT, 24, 0)
if font = NULL then
	print "al_load_ttf_font() failed"
	end 1
end if

var eventqueue = al_create_event_queue()
al_install_keyboard()
al_register_event_source(eventqueue, al_get_display_event_source(display))
al_register_event_source(eventqueue, al_get_keyboard_event_source())

do
	al_clear_to_color(al_map_rgb(0,0,255))
	al_draw_text(font, al_map_rgb(255,255,255), 100, 100, 0, "Hello!")
	al_draw_text(font, al_map_rgb(0,255,0), 100, 200, 0, "Press any key to exit.")

	al_flip_display()

	dim event as ALLEGRO_EVENT
	al_wait_for_event(eventqueue, @event)

	select case event.type
	case ALLEGRO_EVENT_KEY_DOWN, ALLEGRO_EVENT_DISPLAY_CLOSE
		exit do
	end select
loop

al_destroy_event_queue(eventqueue)
al_destroy_display(display)
