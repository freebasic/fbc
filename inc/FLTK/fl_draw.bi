#include once "Enumerations.bi"
#include once "Fl_Window.bi"
#include once "Fl_Device.bi"
#include once "Fl_Image.bi"

extern fl_draw_shortcut alias "fl_draw_shortcut" as byte

private sub fl_color overload(c as Fl_Color)
	fl_graphics_driver_->color(c)
end sub

private sub fl_color overload(c as long)
	fl_color(cast (Fl_Color, c))
end sub

private sub fl_color overload(r as ubyte, g as ubyte, b as ubyte)
	fl_graphics_driver_->color(r, g, b)
end sub

private function fl_color overload()as Fl_Color
	return fl_graphics_driver_->color()
end function

private sub fl_push_clip(x as long, y as long, w as long, h as long)
	fl_graphics_driver_->push_clip(x,y,w,h)
end sub

private sub fl_push_no_clip()
	fl_graphics_driver_->push_no_clip()
end sub

private sub fl_pop_clip()
	fl_graphics_driver_->pop_clip()
end sub

private function fl_not_clipped(x as long, y as long, w as long, h as long) as long
	return fl_graphics_driver_->not_clipped(x,y,w,h)
end function

private function fl_clip_box(x as long, y as long, w as long, h as long, byref x1 as long,  byref y1 as long, byref w1 as long,  byref h1 as long) as long
	return fl_graphics_driver_->clip_box(x,y,w,h, x1, y1, w1, h1)
end function

private sub fl_restore_clip()
	fl_graphics_driver_->restore_clip()
end sub

private sub fl_clip_region overload(r as Fl_Region)
	fl_graphics_driver_->clip_region(r)
end sub

private function fl_clip_region overload() as Fl_Region
	return fl_graphics_driver_->clip_region()
end function

private sub fl_point(x as long, y as long)
	fl_graphics_driver_->point(x,y)
end sub

private sub fl_line_style(style as long, width_ as long=0, dashes as zstring ptr=0)
	fl_graphics_driver_->line_style(style,width_,dashes)
end sub

enum 
	FL_SOLID	= 0,		'< line style: <tt>___________</tt>
	FL_DASH	= 1,			'< line style: <tt>_ _ _ _ _ _</tt>
	FL_DOT	= 2,			'< line style: <tt>. . . . . .</tt>
	FL_DASHDOT	= 3,		'< line style: <tt>_ . _ . _ .</tt>
	FL_DASHDOTDOT	= 4,		'< line style: <tt>_ . . _ . .</tt>
	FL_CAP_FLAT	= &H100,	'< cap style: end is flat
	FL_CAP_ROUND	= &H200,	'< cap style: end is round
	FL_CAP_SQUARE	= &H300,	'< cap style: end wraps end point

	FL_JOIN_MITER	= &H1000,	'< join style: line join extends to a point
	FL_JOIN_ROUND	= &H2000,	'< join style: line join is rounded
	FL_JOIN_BEVEL	= &H3000	'< join style: line join is tidied
end enum

private sub fl_rect overload(x as long, y as long, w as long, h as long)
	fl_graphics_driver_->rect(x,y,w,h)
end sub

private sub fl_rect overload(x as long, y as long, w as long, h as long, c as Fl_Color)
	fl_color(c)
	fl_graphics_driver_->rect(x,y,w,h)
end sub

private sub fl_rectf overload(x as long, y as long, w as long, h as long)
	fl_graphics_driver_->rectf(x,y,w,h)
end sub

private sub fl_rectf overload(x as long, y as long, w as long, h as long, c as Fl_Color)
	fl_color(c)
	fl_graphics_driver_->rectf(x,y,w,h)
end sub

extern "c++"
declare sub fl_rectf overload(x as long, y as long, w as long, h as long, r as ubyte, g as ubyte, b as ubyte)
end extern

private sub fl_line overload(x as long, y as long, x1 as long, y1 as long)
	fl_graphics_driver_->line(x,y,x1,y1)
end sub

private sub fl_line overload(x as long, y as long, x1 as long, y1 as long, x2 as long, y2 as long)
	fl_graphics_driver_->line(x,y,x1,y1,x2,y2)
end sub

private sub fl_loop overload(x as long, y as long, x1 as long, y1 as long, x2 as long, y2 as long)
	fl_graphics_driver_->loop_(x,y,x1,y1,x2,y2)
end sub

private sub fl_loop overload(x as long, y as long, x1 as long, y1 as long, x2 as long, y2 as long, x3 as long, y3 as long)
	fl_graphics_driver_->loop_(x,y,x1,y1,x2,y2,x3,y3)
end sub

private sub fl_polygon overload(x as long, y as long, x1 as long, y1 as long, x2 as long, y2 as long)
	fl_graphics_driver_->polygon(x,y,x1,y1,x2,y2)
end sub

private sub fl_polygon overload(x as long, y as long, x1 as long, y1 as long, x2 as long, y2 as long, x3 as long, y3 as long)
	fl_graphics_driver_->polygon(x,y,x1,y1,x2,y2,x3,y3)
end sub

private sub fl_xyline overload(x as long, y as long, x1 as long)
	fl_graphics_driver_->xyline(x,y,x1)
end sub

private sub fl_xyline overload(x as long, y as long, x1 as long, y2 as long)
	fl_graphics_driver_->xyline(x,y,x1,y2)
end sub

private sub fl_xyline overload(x as long, y as long, x1 as long, y2 as long, x3 as long)
	fl_graphics_driver_->xyline(x,y,x1,y2,x3)
end sub

private sub fl_yxline overload(x as long, y as long, y1 as long)
	fl_graphics_driver_->yxline(x,y,y1)
end sub

private sub fl_yxline overload(x as long, y as long, y1 as long, x2 as long)
	fl_graphics_driver_->yxline(x,y,y1,x2)
end sub

private sub fl_yxline overload(x as long, y as long, y1 as long, x2 as long, y3 as long)
	fl_graphics_driver_->yxline(x,y,y1,x2,y3)
end sub

private sub fl_arc overload(x as long, y as long, w as long, h as long, a1 as double, a2 as double)
	fl_graphics_driver_->arc(x,y,w,h,a1,a2)
end sub

private sub fl_pie (x as long, y as long, w as long, h as long, a1 as double, a2 as double)
	fl_graphics_driver_->pie(x,y,w,h,a1,a2)
end sub

extern "c++"
declare sub fl_chord (x as long, y as long, w as long, h as long, a1 as double, a2 as double)
end extern

private sub fl_push_matrix ()
	fl_graphics_driver_->push_matrix
end sub

private sub fl_pop_matrix ()
	fl_graphics_driver_->pop_matrix
end sub

private sub fl_scale overload (x as double, y as double)
	fl_graphics_driver_->scale(x,y)
end sub

private sub fl_scale overload (x as double)
	fl_graphics_driver_->scale(x, x)
end sub

private sub fl_translate (x as double, y as double)
	fl_graphics_driver_->translate(x,y)
end sub

private sub fl_rotate (d as double)
	fl_graphics_driver_->rotate(d)
end sub

private sub fl_mult_matrix (a as double, b as double, c as double, d as double, x as double, y as double)
	fl_graphics_driver_->mult_matrix(a,b,c,d,x,y)
end sub

private sub fl_begin_points ()
	fl_graphics_driver_->begin_points
end sub

private sub fl_begin_line ()
	fl_graphics_driver_->begin_line
end sub

private sub fl_begin_loop ()
	fl_graphics_driver_->begin_loop
end sub

private sub fl_begin_polygon ()
	fl_graphics_driver_->begin_polygon
end sub

private sub fl_vertex (x as double, y as double)
	fl_graphics_driver_->vertex(x,y)
end sub

private sub fl_curve (X0 as double, Y0 as double, X1 as double, Y1 as double, X2 as double, Y2 as double, X3 as double, Y3 as double)
	fl_graphics_driver_->curve(X0,Y0,X1,Y1,X2,Y2,X3,Y3)
end sub

private sub fl_arc overload(x as double, y as double, r as double, start as double, end_ as double)
	fl_graphics_driver_->arc(x,y,r,start,end_)
end sub

private sub fl_circle (x as double, y as double, r as double)
	fl_graphics_driver_->circle(x,y,r)
end sub

private sub fl_end_points ()
	fl_graphics_driver_->end_points
end sub

private sub fl_end_line ()
	fl_graphics_driver_->end_line
end sub

private sub fl_end_loop ()
	fl_graphics_driver_->end_loop
end sub

private sub fl_end_polygon ()
	fl_graphics_driver_->end_polygon
end sub

private sub fl_begin_complex_polygon ()
	fl_graphics_driver_->begin_complex_polygon
end sub

private sub fl_gap ()
	fl_graphics_driver_->gap
end sub

private sub fl_end_complex_polygon ()
	fl_graphics_driver_->end_complex_polygon
end sub

private function fl_transform_x (x as double, y as double) as double
	return fl_graphics_driver_->transform_x(x,y)
end function

private function fl_transform_y (x as double, y as double) as double
	return fl_graphics_driver_->transform_y(x,y)
end function

private function fl_transform_dx (x as double, y as double) as double
	return fl_graphics_driver_->transform_dx(x,y)
end function

private function fl_transform_dy (x as double, y as double) as double
	return fl_graphics_driver_->transform_dy(x,y)
end function

private sub fl_transformed_vertex (xf as double, yf as double)
	fl_graphics_driver_->transformed_vertex(xf,yf)
end sub

private sub fl_font overload(face as Fl_Font, fsize as Fl_Fontsize)
	fl_graphics_driver_->font(face,fsize)
end sub

private function fl_font overload() as Fl_Font
	return fl_graphics_driver_->font()
end function

private function fl_size () as Fl_Fontsize
	return fl_graphics_driver_->size()
end function

private function fl_height overload () as long
	return fl_graphics_driver_->height()
end function

extern "c++"
declare function fl_height overload (font as long, size as long) as long
end extern

private function fl_descent () as long
	return fl_graphics_driver_->descent()
end function

extern "c++"
declare function fl_width overload (txt as const zstring ptr) as double
end extern

private function fl_width overload (txt as const zstring ptr, n as long) as double
	return fl_graphics_driver_->width(txt, n)
end function

private function fl_width overload (c as unsigned long) as double
	return fl_graphics_driver_->width(c)
end function

extern "c++"
declare sub fl_text_extents overload (as const zstring ptr, byref dx as long, byref dy as long, byref w as long, byref h as long)
end extern

sub fl_text_extents overload (t as const zstring ptr, n as long, byref dx as long, byref dy as long, byref w as long, byref h as long)
	fl_graphics_driver_->text_extents(t, n, dx, dy, w, h)
end sub

extern "c++"
declare function fl_latin1_to_local (as const zstring ptr, n as long=-1) as const zstring ptr
declare function fl_local_to_latin1 (as const zstring ptr, n as long=-1) as const zstring ptr
declare function fl_mac_roman_to_local (as const zstring ptr, n as long=-1) as const zstring ptr
declare function fl_local_to_mac_roman (as const zstring ptr, n as long=-1) as const zstring ptr

declare sub fl_draw overload(str_ as const zstring ptr, x as long, y as long)
declare sub fl_draw overload(angle as long, str_ as const zstring ptr, x as long, y as long)
end extern

private sub fl_draw overload(str_ as const zstring ptr, n as long, x as long, y as long)
	fl_graphics_driver_->draw(str_,n,x,y)
end sub

private sub fl_draw overload(angle as long, str_ as const zstring ptr, n as long, x as long, y as long)
	fl_graphics_driver_->draw(angle,str_,n,x,y)
end sub

private sub fl_rtl_draw overload(str_ as const zstring ptr, n as long, x as long, y as long)
	fl_graphics_driver_->rtl_draw(str_,n,x,y)
end sub

extern "c++"
declare sub fl_measure overload(str_ as const zstring ptr, byval x as long, byval y as long, draw_symbols as long = 1)
declare sub fl_draw overload(str_ as const zstring ptr, x as long, y as long, w as long, h as long, align as Fl_Align, img as Fl_Image ptr=0, draw_symbols as long = 1)
declare sub fl_draw overload(str_ as const zstring ptr, x as long, y as long, w as long, h as long, align as Fl_Align, callthis as sub(as const zstring ptr,as long,as long,as long), img as Fl_Image ptr=0, draw_symbols as long= 1)

declare sub fl_frame(s as const zstring ptr, x as long, y as long, w as long, h as long)
declare sub fl_frame2(s as const zstring ptr, x as long, y as long, w as long, h as long)
declare sub fl_draw_box(as Fl_Boxtype, x as long, y as long, w as long, h as long, as Fl_Color)
end extern

private sub fl_draw_image overload(buf as const ubyte ptr, X as long, Y as long, W as long, H as long, D as long=3, L as long=0)
	fl_graphics_driver_->draw_image(buf, X, Y, W, H, D, L)
end sub

private sub fl_draw_image_mono overload(buf as const ubyte ptr, X as long, Y as long, W as long, H as long, D as long=1, L as long=0)
	fl_graphics_driver_->draw_image_mono(buf, X, Y, W, H, D, L)
end sub

private sub fl_draw_image overload(cb as Fl_Draw_Image_Cb, data_ as any ptr, X as long, Y as long, W as long, H as long, D as long=3)
	fl_graphics_driver_->draw_image(cb, data_, X, Y, W, H, D)
end sub

private sub fl_draw_image_mono overload(cb as Fl_Draw_Image_Cb, data_ as any ptr, X as long, Y as long, W as long, H as long, D as long=1)
	fl_graphics_driver_->draw_image_mono(cb, data_, X, Y, W, H, D)
end sub

extern "c++"
declare function fl_can_do_alpha_blending() as byte
declare function fl_read_image(p as ubyte ptr, X as long, Y as long, W as long, H as long, alpha as long=0) as ubyte ptr

declare function fl_draw_pixmap overload(data_ as zstring const ptr const ptr, x as long , y as long, as Fl_Color=FL_GRAY) as long
declare function fl_draw_pixmap overload(cdata as const zstring const ptr const ptr, x as long , y as long, as Fl_Color=FL_GRAY) as long
declare function fl_measure_pixmap overload(data_ as zstring const ptr const ptr, byref w as long , byref h as long) as long
declare function fl_measure_pixmap overload(cdata as const zstring const ptr const ptr, byref w as long , byref h as long) as long

declare sub fl_scroll_ alias "fl_scroll"(X as long, Y as long, W as long, H as long, dx as long, dy as long, draw_area as sub(as any ptr, as long, as long, as long, as long), data_ as any ptr)

declare function  fl_shortcut_label overload(shortcut as unsigned long) as const zstring ptr
declare function  fl_shortcut_label overload (shortcut as unsigned long, eom as const zstring ptr ptr)as const zstring ptr
'declare function  fl_old_shortcut overload(s as const zstring ptr) as unsigned long

declare sub fl_overlay_rect(x as long, y as long, w as long, h as long)
declare sub fl_overlay_clear()
declare sub fl_cursor_ overload alias "fl_cursor" (as Fl_Cursor)
declare sub fl_cursor_ overload alias "fl_cursor" (as Fl_Cursor, fg as Fl_Color, bg as Fl_Color=FL_WHITE)
declare function fl_expand_text(from as const zstring ptr, buf as zstring ptr, maxbuf as long, maxw as double, byref n as long, byref width_ as double, wrap as long, draw_symbols as long = 0) as const zstring ptr


declare sub fl_set_status(X as long, Y as long, W as long, H as long)
declare sub fl_set_spot(font as long, size as long, X as long, Y as long, W as long, H as long, win as Fl_Window ptr=0)
declare sub fl_reset_spot()



declare function fl_draw_symbol(label as const zstring ptr, x as long, y as long, w as long, h as long, as Fl_Color) as long
declare function fl_add_symbol(name as const zstring ptr, drawit as sub (as Fl_Color), scalable as long) as long
end extern

