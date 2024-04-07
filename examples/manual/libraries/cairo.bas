'' examples/manual/libraries/cairo.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Cairo'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibcairo
'' --------

'' Example showing cairo being used to draw into the FB graphics window
#include Once "cairo/cairo.bi"

Const SCREEN_W = 400
Const SCREEN_H = 300

ScreenRes SCREEN_W, SCREEN_H, 32

'' Create a cairo drawing context, using the FB screen as surface.
Var surface = cairo_image_surface_create_for_data(ScreenPtr(), CAIRO_FORMAT_ARGB32, SCREEN_W, SCREEN_H, SCREEN_W * SizeOf(ULong))

Var c = cairo_create(surface)

ScreenLock()

'' Draw the entire context white.
cairo_set_source_rgba(c, 1, 1, 1, 1)
cairo_paint(c)

'' Draw a red line
cairo_set_line_width(c, 1)
cairo_set_source_rgba(c, 1, 0, 0, 1)
cairo_move_to(c, 0, 0)
cairo_line_to(c, SCREEN_W - 1, SCREEN_H - 1)
cairo_stroke(c)

ScreenUnlock()

Sleep

'' Clean up the cairo context
cairo_destroy(c)
