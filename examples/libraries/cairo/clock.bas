
'' Cairo clock. Translated from the "C" example written by Writser Cleveringa

#include once "cairo/cairo.bi"
#include once "datetime.bi"

const SCR_W = 640
const SCR_H = 480

const PI = 3.14159265358979323846#

declare sub drawScreen()

'' main	
	screenRes SCR_W, SCR_H, 32

	do
		drawScreen()
		sleep(1000)
	loop until (len(inkey()) > 0)
	

'' Draws a clock on a normalized Cairo context
sub drawClock(cr as cairo_t ptr)

	'' compute the angles for the indicators of our clock
	dim as double minutes = Minute(Now()) * PI / 30
	dim as double hours = Hour(Now()) * PI / 6
	dim as double seconds = Second(Now()) * PI / 30

	'' draw the entire context white.
	cairo_set_source_rgba(cr, 1, 1, 1, 1)
	cairo_paint(cr)

	'' who doesn't want all those nice line settings :)
	cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND)
	cairo_set_line_width(cr, 0.1)

	'' translate to the center of the rendering context and draw a black
	'' clock outline
	cairo_set_source_rgba(cr, 0, 0, 0, 1)
	cairo_translate(cr, 0.5, 0.5)
	cairo_arc(cr, 0, 0, 0.4, 0, PI * 2)
	cairo_stroke(cr)

	'' draw a white dot on the current second.
	cairo_set_source_rgba(cr, 1, 1, 1, 0.6)
	cairo_arc(cr, sin(seconds) * 0.4, -cos(seconds) * 0.4, 0.05, 0, PI * 2)
	cairo_fill(cr)

	'' draw the minutes indicator
	cairo_set_source_rgba(cr, 0.2, 0.2, 1, 0.6)
	cairo_move_to(cr, 0, 0)
	cairo_line_to(cr, sin(minutes) * 0.4, -cos(minutes) * 0.4)
	cairo_stroke(cr)

	'' draw the hours indicator     
	cairo_move_to(cr, 0, 0)
	cairo_line_to(cr, sin(hours) * 0.2, -cos(hours) * 0.2)
	cairo_stroke(cr)

end sub

'' Shows how to draw with Cairo
sub drawScreen()
	
	screenLock
	
	dim as cairo_surface_t ptr cairo_surface = _
	    cairo_image_surface_create_for_data(screenPtr, _
											CAIRO_FORMAT_ARGB32, SCR_W, _
											SCR_H, SCR_W*len(integer))
	
	'' Create a cairo drawing context, normalize it and draw a clock.
	'' Delete the context afterwards.
	dim as cairo_t ptr cr = cairo_create(cairo_surface)
	cairo_scale(cr, SCR_W, SCR_H)
	drawClock(cr)
	cairo_destroy(cr)
	
	screenUnlock
	
end sub

