#include once "Fl_Paged_Device.bi"
#include once "fl_draw.bi"
#include once "crt/stdio.bi"

extern "c" 
type Fl_PostScript_Close_Command as function(as FILE ptr) as long
end extern

extern "c++"
type Clip_
public:
	as long x, y, w, h
	prev as Clip_ ptr
end type

type Fl_PostScript_Graphics_Driver extends Fl_Graphics_Driver 
private:
	declare sub transformed_draw_extra(str_ as const zstring ptr, n as long, x as double, y as double, w as long, rtl as boolean)
	declare function prepare_rle85() as any ptr
	declare sub write_rle85(b as ubyte, data_ as any ptr)
	declare sub close_rle85(data_ as any ptr)
	declare function prepare85() as any ptr
	declare sub write85(data_ as any ptr, p as const ubyte ptr, len_ as long)
	declare sub close85(data_ as any ptr)
public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr
	declare constructor()
	enum SHAPE
		NONE=0
		LINE_
		LOOP__
		POLYGON_
		POINTS
	end enum
	clip__ as Clip_ ptr
  
	lang_level_ as long
	gap_ as long
	pages_ as long
  
	width__ as double
	height_ as double
  
	shape_ as long
	linewidth_ as long
	linestyle_ as long
	interpolate_ as long
	as ubyte cr_,cg_,cb_
	linedash_(255) as byte
	declare sub concat()
	declare sub reconcat()
	declare sub recover()
	declare sub reset()
  
	mask as ubyte ptr
	mx as long
	my as long
	close_cmd_ as Fl_PostScript_Close_Command
	page_policy_ as long
	nPages as long
	orientation_ as long
  
	scale_x as single
	scale_y as single
	angle as single
	left_margin as long
	top_margin as long
 
	output as FILE ptr
	as double pw_, ph_
  
	as ubyte bg_r, bg_g, bg_b
	declare function start_postscript (pagecount as long, format as Fl_Paged_Device.Page_Format, layout as Fl_Paged_Device.Page_Layout) as long
	declare sub transformed_draw(s as const zstring ptr, n as long, x as double, y as double)
	declare sub transformed_draw(s as const zstring ptr, x as double, y as double)
	declare function alpha_mask(data_ as const ubyte ptr, w as long, h as long, D as long, LD as long=0) as long
  
	page_format_ as long'Fl_Paged_Device.Page_Format
	ps_filename_ as zstring ptr
 
	declare sub page_policy(p as long)
	declare function page_policy() as long
	declare sub close_command(cmd as Fl_PostScript_Close_Command)
	declare function file_() as FILE ptr
	declare sub interpolate(i as long)
	declare function interpolate() as long
  
	declare sub page(pw as double, ph as double, media as long = 0)
	declare sub page(format as long)

	declare sub color(c as Fl_Color)
	declare sub color(r as ubyte, g as ubyte, b as ubyte)
  
	declare sub push_clip(x as long, y as long, w as long, h as long)
	declare function clip_box(x as long, y as long, w as long, h as long, byref X1 as long, byref Y1 as long, byref W1 as long, byref H1 as long) as long
	declare function not_clipped(x as long, y as long, w as long, h as long) as long
	declare sub push_no_clip()
	declare sub pop_clip()
  
	declare sub line_style(style as long, width_ as long=0, dashes as zstring ptr=0)
  
	declare sub rect(x as long, y as long, w as long, h as long)
	declare sub rectf(x as long, y as long, w as long, h as long)
  
	declare sub xyline(x as long, y as long, x1 as long)
	declare sub xyline(x as long, y as long, x1 as long, y2 as long)
	declare sub xyline(x as long, y as long, x1 as long, y2 as long, x3 as long)
  
	declare sub yxline(x as long, y as long, y1 as long)
	declare sub yxline(x as long, y as long, y1 as long, x2 as long)
	declare sub yxline(x as long, y as long, y1 as long, x2 as long, y3 as long)
  
	declare sub line(x1 as long, y1 as long, x2 as long, y2 as long)
	declare sub line(x1 as long, y1 as long, x2 as long, y2 as long, x3 as long, y3 as long)
  
	declare sub loop_ alias "loop"(x0 as long, y0 as long, x1 as long, y1 as long, x2 as long, y2 as long)
	declare sub loop_ alias "loop"(x0 as long, y0 as long, x1 as long, y1 as long, x2 as long, y2 as long, x3 as long, y3 as long)
	declare sub polygon(x0 as long, y0 as long, x1 as long, y1 as long, x2 as long, y2 as long)
	declare sub polygon(x0 as long, y0 as long, x1 as long, y1 as long, x2 as long, y2 as long, x3 as long, y3 as long)
	declare sub point(x as long, y as long)

	declare sub begin_points()
	declare sub begin_line()
	declare sub begin_loop()
	declare sub begin_polygon()
	declare sub vertex(x as double, y as double)
	declare sub curve(x as double, y as double, x1 as double, y1 as double, x2 as double, y2 as double, x3 as double, y3 as double)
	declare sub circle(x as double, y as double, r as double)
	declare sub arc(x as double, y as double, r as double, start as double, a as double)
	declare sub arc(x as long, y as long, w as long, h as long, a1 as double, a2 as double)
	declare sub pie(x as long, y as long, w as long, h as long, a1 as double, a2 as double)
	declare sub end_points()
	declare sub end_line()
	declare sub end_loop()
	declare sub end_polygon()
	declare sub begin_complex_polygon()
	declare sub gap()
	declare sub end_complex_polygon()
	declare sub transformed_vertex(x as double, y as double)
    
	declare sub draw_image(d as const ubyte ptr, x as long, y as long, w as long, h as long, delta as long=3, ldelta as long=0)
	declare sub draw_image_mono(d as const ubyte ptr, x as long, y as long, w as long, h as long, delta as long=1, ld as long=0)
	declare sub draw_image(call_ as Fl_Draw_Image_Cb, data_ as any ptr, x as long, y as long, w as long, h as long, delta as long=3)
	declare sub draw_image_mono(call_ as Fl_Draw_Image_Cb, data_ as any ptr, x as long, y as long, w as long, h as long, delta as long=1)
      
	declare sub draw(s as const zstring ptr, nBytes as long, x as long, y as long)

	declare sub draw(angle as long, str_ as const zstring ptr, n as long, x as long, y as long)
	declare sub rtl_draw(s as const zstring ptr, n as long, x as long, y as long)
	declare sub font(face as long, size as long)
	declare function width_ alias "width"(as const zstring ptr, as long) as double
	declare function width_ alias "width"(u as unsigned long) as double
	declare sub text_extents(c as const zstring ptr, n as long, byref dx as long, byref dy as long, byref w as long, byref h as long)
	declare function height() as long
	declare function descent() as long
	declare sub draw(pxm as Fl_Pixmap ptr, XP as long, YP as long, WP as long, HP as long, cx as long, cy as long)
	declare sub draw(bitmap as Fl_Bitmap ptr, XP as long, YP as long, WP as long, HP as long, cx as long, cy as long)
	declare sub draw(rgb as Fl_RGB_Image ptr, XP as long, YP as long, WP as long, HP as long, cx as long, cy as long)
	declare function draw_scaled(img as Fl_Image ptr, XP as long, YP as long, WP as long, HP as long) as long
	declare function clocale_printf(format as const zstring ptr, ...) as long
	declare destructor()
end type
end extern

private function Fl_PostScript_Graphics_Driver.class_name() as const zstring ptr
	return class_id
end function

private function Fl_PostScript_Graphics_Driver.page_policy() as long
	return page_policy_
end function

private sub Fl_PostScript_Graphics_Driver.close_command(cmd as Fl_PostScript_Close_Command)
	close_cmd_=cmd
end sub

private function Fl_PostScript_Graphics_Driver.file_() as FILE ptr
	return output
end function

private sub Fl_PostScript_Graphics_Driver.interpolate(i as long)
	interpolate_=i
end sub

private function Fl_PostScript_Graphics_Driver.interpolate() as long
	return interpolate_
end function

private sub Fl_PostScript_Graphics_Driver.begin_complex_polygon()
	begin_polygon()
end sub

private sub Fl_PostScript_Graphics_Driver.gap()
	gap_=1
end sub

private sub Fl_PostScript_Graphics_Driver.end_complex_polygon()
	end_polygon()
end sub

private sub Fl_PostScript_Graphics_Driver.draw(s as const zstring ptr, nBytes as long, x as long, y as long)
	transformed_draw(s,nBytes,x,y)
end sub

extern "c++"
type Fl_PostScript_File_Device extends Fl_Paged_Device
#ifdef __FB_APPLE__
private:
	qc as CGContextRef
#endif
protected:
	declare function driver() as Fl_PostScript_Graphics_Driver ptr
	declare constructor (byref b as const Fl_PostScript_File_Device)
	declare operator let (byref b as const Fl_PostScript_File_Device)
public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr
	declare constructor()
	declare destructor()
	declare function start_job(pagecount as long, from as long ptr, to_ as long ptr) as long
	declare function start_job(pagecount as long, format as Fl_Paged_Device.Page_Format = Fl_Paged_Device.A4, layout as Fl_Paged_Device.Page_Layout = Fl_Paged_Device.PORTRAIT) as long
	declare function start_job(ps_output as FILE ptr, pagecount as long, format as Fl_Paged_Device.Page_Format = Fl_Paged_Device.A4, layout as Fl_Paged_Device.Page_Layout = Fl_Paged_Device.PORTRAIT) as long
	declare function start_page () as long
	declare function printable_rect(w as long ptr, h as long ptr) as long
	declare sub margins(left_  as long ptr, top as long ptr, right_ as long ptr, bottom as long ptr)
	declare sub origin(x as long ptr, y as long ptr)
	declare sub origin(x as long, y as long)
	declare sub scale (scale_x as single, scale_y as single = 0.)
	declare sub rotate(angle as single)
	declare sub translate(x as long, y as long)
	declare sub untranslate()
	declare function end_page () as long
	declare sub end_job()
#ifdef __FB_APPLE__
  void set_current() { fl_gc = gc; Fl_Paged_Device::set_current(); }
#endif
  
	static file_chooser_title as const zstring ptr 
end type
end extern

private function Fl_PostScript_File_Device.class_name() as const zstring ptr
	return class_id
end function