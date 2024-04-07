#include once "Enumerations.bi"
#include once "GL/gl.bi"
#inclib "fltk_gl"

extern "c++"
declare sub gl_start()
declare sub gl_finish()

declare sub gl_color_ alias "gl_color"(i as Fl_Color)

declare sub gl_rect(x as long, y as long, w as long, h as long)
private sub gl_rectf(x as long, y as long, w as long, h as long)
	glRecti(x,y,x+w,y+h)
end sub

declare sub gl_font(fontid as long, size as long)
declare function  gl_height() as long
declare function gl_descent() as long
declare function gl_width overload(as const zstring ptr) as double
declare function gl_width overload(as const zstring ptr, n as long) as double
declare function gl_width overload(as ubyte) as double

declare sub gl_draw overload(as const zstring ptr)
declare sub gl_draw overload(as const zstring ptr, n as long)
declare sub gl_draw overload(as const zstring ptr, x as long, y as long)
declare sub gl_draw overload(as const zstring ptr, x as single, y as single)
declare sub gl_draw overload(as const zstring ptr, n as long, x as long, y as long)
declare sub gl_draw overload(as const zstring ptr, n as long, x as single, y as single)
declare sub gl_draw overload(as const zstring ptr, x as long, y as long, w as long, h as long, as Fl_Align)
declare sub gl_measure(as const zstring ptr, byref x as long, byref y as long)
#ifdef __FB_APPLE__
declare sub gl_texture_pile_height(max as long);
declare function gl_texture_pile_height() as long
#endif
declare sub gl_draw_image(as const ubyte ptr, x as long, y as long, w as long, h as long, d as long=3, ld as long=0)

end extern