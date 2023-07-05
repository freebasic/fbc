#include once "Fl_Image.bi"
#include once "Fl_Bitmap.bi"
#include once "Fl_Pixmap.bi"

extern "c++"
#define FL_REGION_STACK_SIZE 10
#define FL_MATRIX_STACK_SIZE 32

type Fl_Draw_Image_Cb as sub (data_ as any ptr, x as long, y as long, w as long, buf as ubyte ptr)

type COORD_T as single
type _XRegion
	dummy as any ptr
end type
type Fl_Offscreen as uinteger

type Fl_Region as _Xregion ptr

type Fl_Device extends object
public:
	static class_id as const zstring ptr

	declare virtual function class_name() as const zstring ptr

	declare virtual destructor()

end type


type Fl_Graphics_Driver extends Fl_Device
	type matrix
		as double a, b, c, d, x, y
	end type

private:
	static m0 as const matrix
	font_ as Fl_Font
	size_ as Fl_Fontsize
	color_ as Fl_Color 
	sptr as long
	static matrix_stack_size as const long' = FL_MATRIX_STACK_SIZE
	stack(FL_MATRIX_STACK_SIZE - 1) as matrix
	m as matrix
	as long n, p_size, gap_
	p as any ptr 'XPOINT ptr
	what as long
	fl_clip_state_number as long
	rstackptr as long
	static region_stack_max as const long
	rstack(FL_REGION_STACK_SIZE-1) as Fl_Region
#ifdef WIN32
	numcount as long
	counts(19) as long
#endif

	font_descriptor_ as any ptr 'Fl_Font_Descriptor ptr
	declare sub transformed_vertex0(x as COORD_T, y as COORD_T)
	declare sub fixloop()

protected:
	fl_matrix as matrix ptr
	public:
	declare constructor()
	declare virtual sub rect(x as long, y as long, w as long, h as long)
	declare virtual sub rectf(x as long, y as long, w as long, h as long)
	declare virtual sub line_style(style as long, width as long=0, dashes as zstring ptr=0)
	declare virtual sub xyline(x as long, y as long, x1 as long)
	declare virtual sub xyline(x as long, y as long, x1 as long, y2 as long)
	declare virtual sub xyline(x as long, y as long, x1 as long, y2 as long, x3 as long)
	declare virtual sub yxline(x as long, y as long, x1 as long)
	declare virtual sub yxline(x as long, y as long, x1 as long, y2 as long)
	declare virtual sub yxline(x as long, y as long, x1 as long, y2 as long, x3 as long)
	declare virtual sub line(x as long, y as long, x1 as long, y1 as long)
	declare virtual sub line(x as long, y as long, x1 as long, y1 as long, x2 as long, y2 as long)
	declare virtual sub draw(s as const zstring ptr, n as long, x as long, y as long)
	declare virtual sub draw(angle as long, s as const zstring ptr, n as long, x as long, y as long)
	declare virtual sub rtl_draw(s as const zstring ptr, n as long, x as long, y as long)
	declare virtual sub color(c as Fl_Color)
	declare virtual sub color(r as unsigned byte, g  as unsigned byte, b  as unsigned byte)
	declare virtual sub point(x as long, y as long)
	declare virtual sub loop_ alias "loop" (x0 as long, y0 as long, x1 as long, y1 as long, x2 as long, y2 as long)
	declare virtual sub loop_ alias "loop" (x0 as long, y0 as long, x1 as long, y1 as long, x2 as long, y2 as long, x3 as long, y3 as long)
	declare virtual sub polygon(x0 as long, y0 as long, x1 as long, y1 as long, x2 as long, y2 as long)
	declare virtual sub polygon(x0 as long, y0 as long, x1 as long, y1 as long, x2 as long, y2 as long, x3 as long, y3 as long)
	declare virtual sub begin_points()
	declare virtual sub begin_line()
	declare virtual sub begin_loop()
	declare virtual sub begin_polygon()
	declare virtual sub vertex(x as double, y as double)
	declare virtual sub curve(x0 as double, y0 as double, x1 as double, y1 as double, x2 as double, y2 as double, x3 as double, y3 as double)
	declare virtual sub circle(x as double, y as double, r as double)
	declare virtual sub arc(x as double, y as double, r as double, start as double, end_ as double)
	declare virtual sub arc(x as long, y as long, w as long, h as long, a1 as double, a2 as double)
	declare virtual sub pie(x as long, y as long, w as long, h as long, a1 as double, a2 as double)
	declare virtual sub end_points()
	declare virtual sub end_line()
	declare virtual sub end_loop()
	declare virtual sub end_polygon()
	declare virtual sub begin_complex_polygon()
	declare virtual sub gap()
	declare virtual sub end_complex_polygon()
	declare virtual sub transformed_vertex(xf as double, yf as double)
	declare virtual sub push_clip(x as long, y as long, w as long, h as long)
	declare virtual function clip_box(x as long, y as long, w as long, h as long, byref x1 as long, byref y1 as long, byref w1 as long, byref h1 as long) as long
	declare virtual function not_clipped(x as long, y as long, w as long, h as long) as long
	declare virtual sub push_no_clip()
	declare virtual sub pop_clip()

	declare sub push_matrix()
	declare sub pop_matrix()
	declare sub mult_matrix(a as double, b as double, c as double, d as double, x as double, y as double)
	declare sub scale(x as double, y as double)
	declare sub scale(x as double)
	declare sub translate(x as double, y as double)
	declare sub rotate(d as double)
	declare function transform_x(x as double, y as double) as double
	declare function transform_y(x as double, y as double) as double
	declare function transform_dx(x as double, y as double) as double
	declare function transform_dy(x as double, y as double) as double
	declare function clip_region() as Fl_Region
	declare sub clip_region(r as Fl_Region)
	declare sub restore_clip()

	declare virtual sub draw_image(buf as const ubyte ptr, X as long, Y as long, W as long, H as long, D as long=3, L as long=0) 
	declare virtual sub draw_image_mono(buf as const ubyte ptr, X as long, Y as long, W as long, H as long, D as long=1, L as long=0) 
	declare virtual sub draw_image(cb as Fl_Draw_Image_Cb, data_ as any ptr, X as long, Y as long, W as long, H as long, D as long=3) 
	declare virtual sub draw_image_mono(cb as Fl_Draw_Image_Cb, data_ as any ptr, X as long, Y as long, W as long, H as long, D as long=1) 

	declare virtual sub draw(rgb_ as Fl_RGB_Image ptr, XP as long, YP as long, WP as long, HP as long, cx as long, cy as long) 
	declare virtual sub draw(pxm as Fl_Pixmap ptr, XP as long, YP as long, WP as long, HP as long, cx as long, cy as long) 
	declare virtual sub draw(bm as Fl_Bitmap ptr, XP as long, YP as long, WP as long, HP as long, cx as long, cy as long) 

	declare virtual sub copy_offscreen(x as long, y as long, w as long, h as long, pixmap as Fl_Offscreen, srcx as long, srcy as long)
public:
	static class_id as const zstring ptr 
	declare virtual function class_name() as const zstring ptr
	declare virtual sub font(face as Fl_Font, fsize as Fl_Fontsize)
	declare virtual function font() as Fl_Font
	declare virtual function size() as Fl_Fontsize
	declare virtual function width(s as const zstring ptr, n as long) as double
	declare virtual function width(c as unsigned long) as double
	declare virtual sub text_extents(as const zstring ptr, n as long, byref dx as long, byref dy as long, byref w as long, byref h as long)
	declare virtual function height() as long
	declare virtual function descent() as long
	declare virtual function color() as Fl_Color
	declare function font_descriptor() as any ptr
	declare sub font_descriptor(d as any ptr)
	declare virtual function draw_scaled(img as Fl_Image ptr, X as long, Y as long, W as long, H as long) as long
	declare virtual destructor

end type


end extern

private function Fl_Device.class_name() as const zstring ptr
	return class_id
end function


extern "c"	'empty destructor
extern fl_graphics_driver_ alias "fl_graphics_driver"  as Fl_Graphics_Driver ptr 
sub _ZN9Fl_DeviceD0Ev (d as Fl_Device)
end sub
end extern 

destructor Fl_Device()
end destructor 

private sub Fl_Graphics_Driver.color(c as Fl_Color)
	color_= c
end sub

private sub Fl_Graphics_Driver.color(r as unsigned byte, g  as unsigned byte, b  as unsigned byte)
end sub

private sub Fl_Graphics_Driver.scale(x as double, y as double)
	mult_matrix(x,0,0,y,0,0)
end sub

private sub Fl_Graphics_Driver.scale(x as double)
	mult_matrix(x,0,0,x,0,0)
end sub

private sub Fl_Graphics_Driver.translate(x as double, y as double)
	mult_matrix(1,0,0,1,x,y)
end sub

private virtual function Fl_Graphics_Driver.class_name() as const zstring ptr
	return class_id
end function

private virtual sub Fl_Graphics_Driver.font(face as Fl_Font, fsize as Fl_Fontsize)
	font_ = face: size_ = fsize
end sub

private virtual function Fl_Graphics_Driver.font() as Fl_Font
	return font_
end function

private virtual function Fl_Graphics_Driver.size() as Fl_Fontsize
	return size_
end function

private virtual function Fl_Graphics_Driver.width(s as const zstring ptr, n as long) as double
	return 0
end function

private virtual function Fl_Graphics_Driver.width(c as unsigned long) as double
	dim ch as byte=cast(byte,c)
	return width(@ch, 1)
end function

private virtual function Fl_Graphics_Driver.height() as long
	return size()
end function

private virtual function Fl_Graphics_Driver.descent() as long
	return 0
end function

private virtual function Fl_Graphics_Driver.color() as Fl_Color
	return color_
end function

private function Fl_Graphics_Driver.font_descriptor() as any ptr
	return font_descriptor_
end function

private sub Fl_Graphics_Driver.font_descriptor(d as any ptr)
	font_descriptor_= d
end sub

private virtual destructor Fl_Graphics_Driver()
	deallocate (p)
end destructor

extern "c++"
type Fl_Surface_Device extends Fl_Device
	_driver as Fl_Graphics_Driver ptr
	static _surface as Fl_Surface_Device ptr
	declare static function default_surface() as Fl_Surface_Device ptr
protected:
	declare constructor (graphics_driver as Fl_Graphics_Driver ptr) 
public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr
	declare virtual sub set_current()
	declare sub driver(graphics_driver as Fl_Graphics_Driver ptr)
	declare function driver() as Fl_Graphics_Driver ptr
	declare static function surface() as Fl_Surface_Device ptr
	declare virtual destructor()
	
end type

end extern

private constructor Fl_Surface_Device(graphics_driver as Fl_Graphics_Driver ptr)
	_driver = graphics_driver
end constructor

private function Fl_Surface_Device.class_name() as const zstring ptr
	return class_id
end function

private sub Fl_Surface_Device.driver(graphics_driver as Fl_Graphics_Driver ptr)
	_driver = graphics_driver
end sub

private function Fl_Surface_Device.driver() as Fl_Graphics_Driver ptr
	return _driver
end function

private function Fl_Surface_Device.surface() as Fl_Surface_Device ptr
	return iif (_surface , _surface , default_surface())
end function



extern "c++"
type Fl_Display_Device extends Fl_Surface_Device
	static _display as Fl_Display_Device ptr
protected:
	declare constructor (byref b as const Fl_Display_Device)
public:
	static class_id as const zstring ptr
	declare function class_name() as  const zstring ptr
	declare constructor (graphics_driver as Fl_Graphics_Driver ptr)
	declare static function display_device() as Fl_Display_Device ptr


end type

end extern

private function Fl_Display_Device.class_name() as const zstring ptr
	return class_id
end function

