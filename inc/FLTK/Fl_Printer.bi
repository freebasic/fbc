#include once "Fl_Paged_Device.bi"
#include once "fl_draw.bi"
#include once "Fl_Pixmap.bi"
#include once "Fl_RGB_Image.bi"
#include once "Fl_Bitmap.bi"

#if not(defined(__FB_APPLE__) orelse defined(__FB_WIN32__))
#include once "Fl_PostScript.bi"
#elseif defined(__FB_WIN32__)
#include once "win\commdlg.bi"
#endif

#if defined(__FB_APPLE__) orelse defined(__FB_WIN32__)
extern "c++"
type Fl_System_Printer extends Fl_Paged_Device
private:
	gc as any ptr
	declare sub set_current()
#ifdef __FB_APPLE__
	scale_x as single
	scale_y as single
	angle as single
	printSession as PMPrintSession
	pageFormat as PMPageFormat
	printSettings PMPrintSettings
#elseif defined(__FB_WIN32__)
	abortPrint as long
	pd as PRINTDLG
	hPr as HDC
	prerr as long
	left_margin as long
	top_margin as long
	declare sub absolute_printable_rect(x as long ptr, y as long ptr, w as long ptr, h as long ptr)
#endif
protected:
	declare constructor()
	declare constructor (byref b as const Fl_System_Printer)
	declare operator let (byref b as const Fl_System_Printer)
public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr
	declare function start_job(pagecount as long, frompage as long ptr = NULL, topage as long ptr = NULL) as long
	declare function start_page () as long
	declare function printable_rect(w as long ptr, h as long ptr) as long
	declare sub margins(left_ as long ptr, top as long ptr, right_ as long ptr, bottom as long ptr)
	declare sub origin(x as long ptr, y as long ptr)
	declare sub origin(x as long, y as long)
	declare sub scale (scale_x as single, scale_y as single = 0.)
	declare sub rotate(angle as single)
	declare sub translate(x as long, y as long)
	declare sub untranslate()
	declare function end_page () as long
	declare sub end_job ()
#ifdef __FB_APPLE__
	declare sub print_window_part(win as Fl_Window ptr, x as long, y as long, w as long, h as long, delta_x as long, delta_y as long)
#endif
	declare destructor()
end type
end extern

private function Fl_System_Printer.class_name() as const zstring ptr
	return class_id
end function

#else

extern "c++"
type Fl_PostScript_Printer extends Fl_PostScript_File_Device
protected:
	declare constructor()
	declare constructor (byref b as const Fl_PostScript_Printer)
	declare operator let (byref b as const Fl_PostScript_Printer)
public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr
	declare function start_job(pages as long, firstpage as long ptr = NULL, lastpage as long ptr = NULL) as long
end type
end extern

private constructor Fl_PostScript_Printer
end constructor

private function Fl_PostScript_Printer.class_name() as const zstring ptr
	return class_id
end function
#endif



extern "c++"
type Fl_Printer extends Fl_Paged_Device
public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr

	declare constructor()
	declare function start_job(pagecount as long, frompage as long ptr = NULL, topage as long ptr = NULL) as long
	declare function start_page() as long
	declare function printable_rect(w as long ptr, h as long ptr) as long
	declare sub margins(left_ as long ptr, top as long ptr, right_ as long ptr, bottom as long ptr)
	declare sub origin(x as long ptr, y as long ptr)
	declare sub origin(x as long, y as long)
	declare sub scale(scale_x as single, scale_y as single = 0.)
	declare sub rotate(angle as single)
	declare sub translate(x as long, y as long)
	declare sub untranslate()
	declare function end_page () as long
	declare sub end_job ()
	declare sub print_widget(widget as Fl_Widget ptr, delta_x as long=0, delta_y as long=0)
	declare sub print_window_part(win as Fl_Window ptr, x as long, y as long, w as long, h as long, delta_x as long=0, delta_y as long=0)
	declare sub set_current()
	declare function driver() as Fl_Graphics_Driver ptr

	declare destructor()
 
	static dialog_title as const zstring ptr
	static dialog_printer as const zstring ptr
	static dialog_range as const zstring ptr
	static dialog_copies as const zstring ptr
	static dialog_all as const zstring ptr
	static dialog_pages as const zstring ptr
	static dialog_from as const zstring ptr
	static dialog_to as const zstring ptr
	static dialog_properties as const zstring ptr
	static dialog_copyNo as const zstring ptr
	static dialog_print_button as const zstring ptr
	static dialog_cancel_button as const zstring ptr
	static dialog_print_to_file as const zstring ptr
	static property_title as const zstring ptr
	static property_pagesize as const zstring ptr
	static property_mode as const zstring ptr
	static property_use as const zstring ptr
	static property_save as const zstring ptr
	static property_cancel as const zstring ptr
protected:
	declare constructor (byref b as const Fl_Printer)
	declare operator let (byref b as const Fl_Printer)

private:
#if defined(__FB_WIN32__) orelse defined(__FB_APPLE__)
	printer as Fl_System_Printer ptr
#else
	printer as Fl_PostScript_Printer ptr
#endif
end type

end extern

function Fl_Printer.class_name() as const zstring ptr
	return class_id
end function