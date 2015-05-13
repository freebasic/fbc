'' Cairo clock. Translated from the C example written by Writser Cleveringa
'' Details: http://cairographics.org/documentation/

#include once "cairo/cairo.bi"
#include once "datetime.bi"

Const SCREEN_W = 400
Const SCREEN_H = 300

Const PI = 3.14159265358979323846#

ScreenRes SCREEN_W, SCREEN_H, 32

''
'' Create a cairo drawing context, using the FB screen as surface.
''
Dim As cairo_surface_t Ptr surface = _
	cairo_image_surface_create_for_data(ScreenPtr(), _
		CAIRO_FORMAT_ARGB32, SCREEN_W, SCREEN_H, _
		SCREEN_W * SizeOf(Integer))

Dim As cairo_t Ptr c = cairo_create(surface)
cairo_scale(c, SCREEN_W, SCREEN_H)

'' Translate to the center of the rendering context
cairo_translate(c, 0.5, 0.5)

Do
	ScreenLock()

	''
	'' Draw a clock
	''

	'' compute the angles for the indicators of our clock
	Dim As Double minutes = Minute(Now()) * PI / 30
	Dim As Double hours = Hour(Now()) * PI / 6
	Dim As Double seconds = Second(Now()) * PI / 30

	'' Draw the entire context white.
	cairo_set_source_rgba(c, 1, 1, 1, 1)
	cairo_paint(c)

	'' Who doesn't want all those nice line settings :)
	cairo_set_line_cap(c, CAIRO_LINE_CAP_ROUND)
	cairo_set_line_width(c, 0.1)

	'' Draw a black clock outline
	cairo_set_source_rgba(c, 0, 0, 0, 1)
	cairo_arc(c, 0, 0, 0.4, 0, PI * 2)
	cairo_stroke(c)

	'' Draw a white dot on the current second.
	cairo_set_source_rgba(c, 1, 1, 1, 0.6)
	cairo_arc(c, Sin(seconds) * 0.4, -Cos(seconds) * 0.4, 0.05, 0, PI * 2)
	cairo_fill(c)

	'' Draw the minutes indicator
	cairo_set_source_rgba(c, 0.2, 0.2, 1, 0.6)
	cairo_move_to(c, 0, 0)
	cairo_line_to(c, Sin(minutes) * 0.4, -Cos(minutes) * 0.4)
	cairo_stroke(c)

	'' Draw the hours indicator
	cairo_move_to(c, 0, 0)
	cairo_line_to(c, Sin(hours) * 0.2, -Cos(hours) * 0.2)
	cairo_stroke(c)

	ScreenUnlock()

	Sleep 1000
Loop While (Len(Inkey()) = 0)

'' Clean up the cairo context
cairo_destroy(c)
