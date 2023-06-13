#include once "Fl_Device.bi"
#include once "Fl_Window.bi"
#define NO_PAGE_FORMATS 30

extern "c++"
type page_format_
	width_ as long
	height as long
	name as const zstring ptr
end type


type Fl_Paged_Device extends Fl_Surface_Device
public:
	enum Page_Format
		A0 = 0
		A1
		A2
		A3
		A4
		A5
		A6
		A7
		A8
		A9
		B0
		B1
		B2
		B3
		B4
		B5
		B6
		B7
		B8
		B9
		B10
		C5E
		DLE
		EXECUTIVE
		FOLIO
		LEDGER
		LEGAL
		LETTER
		TABLOID
		ENVELOPE
		MEDIA = &H1000
	end enum
	enum Page_Layout
		PORTRAIT = 0
		LANDSCAPE = &H100
		REVERSED = &H200
		ORIENTATION = &H300
	end enum
	static page_formats(NO_PAGE_FORMATS-1) as const page_format_
private:
	declare sub traverse(widget as Fl_Widget ptr)
protected:
	x_offset as long
	y_offset as long
	declare constructor()
	declare virtual destructor()

	declare constructor (byref b as const Fl_Paged_Device)
	declare operator let (byref b as const Fl_Paged_Device)
public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr
	declare virtual function start_job(pagecount as long, frompage as long ptr = 0, topage as long ptr = 0) as long
	declare virtual function start_page() as long
	declare virtual function printable_rect(w as long ptr, h as long ptr) as long
	declare virtual sub margins(left as long ptr, top as long ptr, right_ as long ptr, bottom as long ptr)
	declare virtual sub origin(x as long, y as long)
	declare virtual sub origin(x as long ptr, y as long ptr)
	declare virtual sub scale(scale_x as single, scale_y as single = 0.)
	declare virtual sub rotate(angle as single)
	declare virtual sub translate(x as long, y as long)
	declare virtual sub untranslate()
	declare virtual sub print_widget(widget as Fl_Widget ptr, delta_x as long = 0, delta_y as long = 0)
	declare sub print_window(win as Fl_Window ptr, x_offset as long = 0, y_offset as long = 0)
	declare virtual sub print_window_part(win as Fl_Window ptr, x as long, y as long, w as long, h as long, delta_x as long = 0, delta_y as long = 0)
	declare virtual function end_page () as long
	declare virtual sub end_job ()

end type
end extern

private constructor Fl_Paged_Device()
	base(0)
end constructor

private destructor Fl_Paged_Device()
end destructor

private function Fl_Paged_Device.class_name() as const zstring ptr
	return class_id
end function