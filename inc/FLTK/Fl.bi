#ifdef FLTK_HAVE_CAIRO
#include once "Fl_Cairo.bi"
#endif

#include once "Enumerations.bi"


#ifdef __FB_DOS__
	#inclib "NX11"
	#inclib "freetype"
	#inclib "nano-X"
	#inclib "mwin"
	#inclib "stdcxx"
	#inclib "fltk"
#else
'FLTK is written in C++, so we need to include C++ runtime as well
#inclib "stdc++"


#inclib "fltk"

#ifndef __FB_WIN32__
	#inclib "X11"
	#inclib "Xrender"
	#inclib "Xext"
#endif
#endif

#define FL_SOCKET long

type Fl_Widget_ as Fl_Widget
type Fl_Window_ as Fl_Window
type Fl_Image_ as  Fl_Image
type Fl_Label_ as  Fl_Label



extern fl_local_ctrl alias "fl_local_ctrl" as zstring ptr
extern fl_local_meta alias "fl_local_meta" as zstring ptr
extern fl_local_alt alias "fl_local_alt" as zstring ptr
extern fl_local_shift alias "fl_local_shift" as zstring ptr


extern "c++"
type Fl_Label_Draw_F as sub(label as const Fl_Label_ ptr, x as long, y as long, w as long, h as long, align as Fl_Align)
type Fl_Label_Measure_F as sub(label as const Fl_Label_ ptr, byref width_ as long, byref height as long)
type Fl_Box_Draw_F as sub(x as long, y as long, w as long, h as long, color_ as  Fl_Color)
type Fl_Timeout_Handler as sub(as any ptr) 
type Fl_Awake_Handler as sub(as any ptr)
type Fl_Idle_Handler as sub(as any ptr)
type Fl_Old_Idle_Handler as sub()
type Fl_FD_Handler as sub(fd as FL_SOCKET, as any ptr)
type Fl_Event_Handler as sub(event as long)
type Fl_System_Handler as function (event as any ptr, as any ptr) as long
type Fl_Abort_Handler as sub(format as const zstring ptr,...)
type Fl_Atclose_Handler as sub(window as Fl_Window_ ptr, as any ptr)
type Fl_Args_Handler as function(argc as long, argv as zstring ptr ptr, byref i as long) as long
type Fl_Event_Dispatch as function(event as long, w as Fl_Window_ ptr) as long
type Fl_Clipboard_Notify_Handler as sub (source as long, as any ptr)


type Fl extends object
private:
	static use_high_res_GL_ as long
public:
	static e_number as long
	static e_x as long
	static e_y as long
	static e_x_root as long
	static e_y_root as long
	static e_dx as long
	static e_dy as long
	static e_state as long
	static e_clicks as long
	static e_is_click as long
	static e_keysym as long
	static e_text as zstring ptr
	static e_length as long
	static e_clipboard_data as any ptr
	static e_clipboard_type as const zstring ptr
	static e_dispatch as Fl_Event_Dispatch
	static belowmouse_ as Fl_Widget_ ptr
	static pushed_ as Fl_Widget_ ptr
	static focus_ as Fl_Widget_ ptr
	static damage_ as long
	static selection_owner_ as Fl_Widget_ ptr
	static modal_ as Fl_Window_ ptr
	static grab_ as Fl_Window_ ptr
	static compose_state as long
	declare static sub call_screen_init()
#ifdef __FB_APPLE__
	declare static sub reset_marked_text()
	declare static sub insertion_point_location(x as long, y as long, height as long)
#endif
	declare static sub damage(d as long)

	enum Fl_Option
		OPTION_ARROW_FOCUS = 0
		OPTION_VISIBLE_FOCUS
		OPTION_DND_TEXT
		OPTION_SHOW_TOOLTIPS
		OPTION_FNFC_USES_GTK
		OPTION_LAST
	end enum
private:  
	static options_(OPTION_LAST-1) as ubyte
	static options_read_ as ubyte
  
public:  

	declare static function option(opt as Fl_Option) as boolean
	declare static sub option(opt as Fl_Option, val_ as boolean)

	static idle as sub()

	static awake_ring_ as Fl_Awake_Handler ptr
	static awake_data_ as any ptr ptr
	static awake_ring_size_ as long
	static awake_ring_head_ as long
	static awake_ring_tail_ as long
	static scheme_ as const zstring ptr
	static scheme_bg_ as Fl_Image_ ptr

	static e_original_keysym as long
	static scrollbar_size_ as long

	declare static function add_awake_handler_(as Fl_Awake_Handler, as any ptr) as long
	declare static function get_awake_handler_(byref as Fl_Awake_Handler, byref as any ptr) as long

	declare static function version() as double
	declare static function api_version() as long
	declare static function abi_version() as long

	declare static function abi_check(val_ as const long) as long

	declare static function arg(argc as long, argv as zstring ptr ptr, byref i as long) as long
	declare static function args(argc as long, argv as zstring ptr ptr, byref i as long, cb as Fl_Args_Handler = 0) as long
	declare static sub args(argc as long, argv as zstring ptr ptr)

	static help as const zstring const ptr

	declare static sub display(as const zstring ptr)
	declare static function visual(as long) as long

	declare static function gl_visual(as long, alist as long ptr=0) as long
	declare static sub own_colormap()
	declare static sub get_system_colors()
	declare static sub foreground(as ubyte, as ubyte, as ubyte)
	declare static sub background(as ubyte, as ubyte, as ubyte)
	declare static sub background2(as ubyte, as ubyte, as ubyte)


	declare static function scheme(_name as const zstring ptr) as long
	declare static function scheme() as const zstring ptr
	declare static function is_scheme(_name as const zstring ptr) as long

	declare static function reload_scheme() as long
	declare static function scrollbar_size() as long
	declare static sub scrollbar_size(W as long)


	declare static function wait_ alias "wait"() as long
	declare static function wait_ alias "wait"(t as double) as double
	declare static function check() as long
	declare static function ready() as long
	declare static function run_ alias "run"() as double
	declare static function readqueue() as Fl_Widget_ ptr

	declare static sub add_timeout(t as double, as Fl_Timeout_Handler, as any ptr = 0)
	declare static sub repeat_timeout(t as double, as Fl_Timeout_Handler, as any ptr = 0)
	declare static function has_timeout(as Fl_Timeout_Handler, as any ptr = 0) as long
	declare static sub remove_timeout(as Fl_Timeout_Handler, as any ptr=0)
	declare static sub add_check(as Fl_Timeout_Handler, as any ptr = 0)
	declare static function has_check(as Fl_Timeout_Handler, as any ptr = 0) as long
	declare static sub remove_check(as Fl_Timeout_Handler, as any ptr)

	declare static sub add_fd(fd as long, when as long, cb as Fl_FD_Handler, as any ptr = 0)
	declare static sub add_fd(fd as long, cb as Fl_FD_Handler, as any ptr = 0)
	declare static sub remove_fd(as long, when as long)
	declare static sub remove_fd(as long)

	declare static sub add_idle(cb as Fl_Idle_Handler, data_ as any ptr = 0)
	declare static function has_idle(cb as Fl_Idle_Handler, data_ as any ptr = 0) as long
	declare static sub remove_idle(cb as Fl_Idle_Handler, data_ as any ptr = 0)

	declare static function damage() as long
	declare static sub redraw()
	declare static sub flush()

	static warning as sub(as const zstring ptr, ...)
	static error_ alias "error" as sub(as const zstring ptr, ...)
	static fatal as sub(as const zstring ptr, ...)
	declare static function first_window() as Fl_Window_ ptr
	declare static sub first_window(as Fl_Window_ ptr)
	declare static function next_window(as const Fl_Window_ ptr) as Fl_Window_ ptr

	declare static function modal() as Fl_Window_ ptr
	declare static function grab() as Fl_Window_ ptr
	declare static sub grab(as Fl_Window_ ptr)
	declare static function event() as long
	declare static function event_x() as long
	declare static function event_y() as long
	declare static function event_x_root() as long
	declare static function event_y_root() as long
	declare static function event_dx() as long
	declare static function event_dy() as long
	declare static sub get_mouse(byval as long,byval as long)
	declare static function event_clicks() as long
	declare static sub event_clicks(i as long)
	declare static function  event_is_click() as long
	declare static sub event_is_click(i as long)
	declare static function event_button() as long
	declare static function event_state() as long
	declare static function event_state(mask as long) as long
	declare static function event_key() as long
	declare static function event_original_key() as long
	declare static function event_key(key as long) as long
	declare static function get_key(key as long) as long
	declare static function event_text() as const zstring ptr
	declare static function event_length() as long
	declare static function event_clipboard() as any ptr
	declare static function event_clipboard_type() as const zstring ptr


	declare static function compose(byref del as long) as long
	declare static sub compose_reset()
	declare static function event_inside( as long, as long, as long, as long) as long
	declare static function event_inside(as const Fl_Widget_ ptr) as long
	declare static function test_shortcut(as unsigned long) as long

	declare static sub enable_im()
	declare static sub disable_im()
	declare static function handle(as long, as Fl_Window_ ptr) as long
	declare static function handle_(as long, as Fl_Window_ ptr) as long
	declare static function belowmouse() as  Fl_Widget_ ptr
	declare static sub belowmouse(as Fl_Widget_ ptr)
	declare static function pushed() as  Fl_Widget_ ptr
	declare static sub pushed(as Fl_Widget_ ptr)
	declare static function focus() as Fl_Widget_ ptr
	declare static sub focus(as Fl_Widget_ ptr)
	declare static sub add_handler(h as Fl_Event_Handler)
	declare static sub remove_handler(h as Fl_Event_Handler)
	declare static sub add_system_handler(h as Fl_System_Handler, data_ as any ptr)
	declare static sub remove_system_handler(h as Fl_System_Handler)
	declare static sub event_dispatch(d as Fl_Event_Dispatch)
	declare static function event_dispatch() as Fl_Event_Dispatch
	declare static sub copy(stuff as const zstring ptr, len_ as long, destination as long, type_ as const zstring ptr)
	declare static sub copy(stuff as const zstring ptr, len_ as long, destination as long = 0)

	declare static sub copy_image(data_ as const unsigned byte ptr, W as long, H as long, destination as long = 0)
	declare static sub paste(byref receiver as Fl_Widget_, source as long, type_ as const zstring ptr)
	declare static sub paste(byref receiver as Fl_Widget_, source as long)

	declare static sub add_clipboard_notify(h as Fl_Clipboard_Notify_Handler, data_ as any ptr = 0)
	declare static sub remove_clipboard_notify(h as Fl_Clipboard_Notify_Handler)
	declare static function clipboard_contains(type_ as const zstring ptr) as long
	static clipboard_plain_text as const zstring const ptr
	static clipboard_image as const zstring const ptr

	declare static function dnd() as long

	declare static function selection_owner() as Fl_Widget_ ptr
	declare static sub selection_owner(as Fl_Widget_ ptr)
	declare static sub selection(byref owner as Fl_Widget_, as const zstring ptr, len_ as long)
	declare static sub paste(byref receiver as Fl_Widget_)
	declare static function x() as long
	declare static function y() as long
	declare static function w() as long
	declare static function h() as long
	declare static function screen_count() as long
	declare static sub screen_xywh(byref X as long, byref Y as long, byref W as long, byref H as long)
	declare static sub screen_xywh(byref X as long, byref Y as long, byref W as long, byref H as long, mx as long, my as long)
	declare static sub screen_xywh(byref X as long, byref Y as long, byref W as long, byref H as long, n as long)
	declare static sub screen_xywh(byref X as long, byref Y as long, byref W as long, byref H as long, mx as long, my as long, mw as long, mh as long)
	declare static function screen_num(x as long, y as long) as long
	declare static function screen_num(x as long, y as long, w as long, h as long) as long
	declare static sub screen_dpi(byref h as single, byref v as single, n as long=0)
	declare static sub screen_work_area(byref X as long, byref Y as long, byref W as long, byref H as long, mx as long, my as long)
	declare static sub screen_work_area(byref X as long, byref Y as long, byref W as long, byref H as long, n as long)
	declare static sub screen_work_area(byref X as long, byref Y as long, byref W as long, byref H as long)
	declare static sub set_color(as Fl_Color, as ubyte, as ubyte, as ubyte)
	declare static sub set_color(i as Fl_Color, c as unsigned long)
	declare static function get_color(i as Fl_Color) as unsigned long
	declare static sub get_color(i as Fl_Color, byref red as ubyte, byref green as ubyte, byref blue as ubyte)
	declare static sub free_color(i as Fl_Color, overlay as long = 0)
	declare static function get_font(as Fl_Font) as const zstring ptr
	declare static function get_font_name(as Fl_Font, attributes as long ptr = 0) as const zstring ptr
	declare static function get_font_sizes(as Fl_Font, byref sizep as long ptr) as long
	declare static sub set_font(as Fl_Font, as const zstring ptr)
	declare static sub set_font(as Fl_Font, as Fl_Font)
	declare static function set_fonts(as const zstring ptr = 0) as Fl_Font
	declare static sub set_labeltype(as Fl_Labeltype, as Fl_Label_Draw_F ptr,as Fl_Label_Measure_F ptr)
	declare static sub set_labeltype(as Fl_Labeltype, from as Fl_Labeltype)

	declare static function get_boxtype(as Fl_Boxtype) as Fl_Box_Draw_F ptr
	declare static sub set_boxtype(as Fl_Boxtype, as Fl_Box_Draw_F ptr, as ubyte, as ubyte, as ubyte, as ubyte)
	declare static sub set_boxtype(as Fl_Boxtype, from as Fl_Boxtype)
	declare static function box_dx(as Fl_Boxtype) as long
	declare static function box_dy(as Fl_Boxtype) as long
	declare static function box_dw(as Fl_Boxtype) as long
	declare static function box_dh(as Fl_Boxtype) as long

	declare static function draw_box_active() as long
	declare static function box_color(as Fl_Color) as Fl_Color
	declare static sub set_box_color(as Fl_Color)

	declare static sub set_abort(f as Fl_Abort_Handler)
	static atclose as sub(as Fl_Window_ ptr, as any ptr)
	declare static sub default_atclose(as Fl_Window_ ptr, as any ptr)
	declare static sub set_atclose(f as Fl_Atclose_Handler)
	declare static function event_shift() as long
	declare static function event_ctrl() as long
	declare static function event_command() as long
	declare static function event_alt() as long
	declare static function event_buttons() as long
	declare static function event_button1() as long
	declare static function event_button2() as long
	declare static function event_button3() as long
	declare static sub set_idle(cb as Fl_Old_Idle_Handler)
	declare static sub grab(byref win as Fl_Window_)
	declare static sub release()
	declare static sub visible_focus(v as long)
	declare static function visible_focus() as long
	declare static sub dnd_text_ops(v as long)
	declare static function dnd_text_ops() as long
	declare static function lock() as long
	declare static sub unlock()
	declare static sub awake(message as any ptr = 0)
	declare static function awake(cb as Fl_Awake_Handler, message as any ptr = 0) as long
	declare static function thread_message() as any ptr

	declare static sub delete_widget(w as Fl_Widget_ ptr)
	declare static sub do_widget_deletion()
	declare static sub watch_widget_pointer(byref w as Fl_Widget_ ptr)
	declare static sub release_widget_pointer(byref w as Fl_Widget_ ptr)
	declare static sub clear_widget_pointer(w as const Fl_Widget_ ptr)
	declare static sub use_high_res_GL(val_ as long)
	declare static function use_high_res_GL() as long

#ifdef FLTK_HAVE_CAIRO

public:
	declare static function cairo_make_current(w as Fl_Window_ ptr) as cairo_t ptr
	declare static sub cairo_autolink_context(alink as boolean)
	declare static function cairo_autolink_context() as boolean
	declare static function cairo_cc() as cairo_t ptr
	declare static sub cairo_cc(c as cairo_t ptr, own as boolean=false)

private:
	declare static function cairo_make_current(gc as any ptr) as cairo_t ptr
	declare static function cairo_make_current(gc as any ptr, W as long, H as long) as cairo_t ptr
	static cairo_state_ as Fl_Cairo_State
public:
#endif
end type

end extern

private sub Fl.damage(d as long)
	damage_=d
end sub

private function Fl.abi_check(val_ as const long) as long
	return val_ = abi_version()
end function

private function Fl.scheme() as const zstring ptr
	return scheme_
end function

private function Fl.is_scheme(_name as const zstring ptr) as long
	return scheme_ andalso _name andalso *_name<>*scheme_
end function

private function Fl.damage() as long
	return damage_
end function

private function Fl.modal() as Fl_Window_ ptr
	return modal_
end function

private function Fl.grab() as Fl_Window_ ptr
	return grab_
end function

private function Fl.event() as long
	return e_number
end function

private function Fl.event_x() as long
	return e_x
end function

private function Fl.event_y() as long
	return e_y
end function

private function Fl.event_x_root() as long
	return e_x_root
end function

private function Fl.event_y_root() as long
	return e_y_root
end function

private function Fl.event_dx() as long
	return e_dx
end function

private function Fl.event_dy() as long
	return e_dy
end function

private function Fl.event_clicks() as long
	return e_clicks
end function

private sub Fl.event_clicks(i as long)
	e_clicks=i
end sub

private function Fl.event_is_click() as long
	return e_is_click
end function

private sub Fl.event_is_click(i as long)
	e_is_click=i
end sub

private function Fl.event_button() as long
	return e_keysym-_FL_Button
end function

private function Fl.event_state() as long
	return e_state
end function

private function Fl.event_state(mask as long) as long
	return e_state and mask
end function

private function Fl.event_key() as long
	return e_keysym
end function

private function Fl.event_original_key() as long
	return e_original_keysym
end function

private function Fl.event_text() as const zstring ptr
	return e_text
end function

private function Fl.event_length() as long
	return e_length
end function

private function Fl.event_clipboard() as any ptr
	return e_clipboard_data
end function

private function Fl.event_clipboard_type() as const zstring ptr
	return e_clipboard_type
end function

private function Fl.belowmouse() as  Fl_Widget_ ptr
	return belowmouse_
end function

private function Fl.pushed() as  Fl_Widget_ ptr
	return pushed_
end function

private function Fl.focus() as  Fl_Widget_ ptr
	return focus_
end function

private function Fl.selection_owner() as Fl_Widget_ ptr
	return selection_owner_
end function

private sub Fl.screen_xywh(byref X__ as long, byref Y__ as long, byref W__ as long, byref H__ as long)
	dim as long mx, my
	Fl.get_mouse(mx, my)
	screen_xywh(X__, Y__, W__, H__, mx, my)
end sub

private sub Fl.screen_work_area(byref X__ as long, byref Y__ as long, byref W__ as long, byref H__ as long)
	dim as long mx, my
	Fl.get_mouse(mx, my)
	screen_work_area(X__, Y__, W__, H__, mx, my)
end sub

private sub Fl.set_abort(f as Fl_Abort_Handler)
	fatal = f
end sub

private sub Fl.set_atclose(f as Fl_Atclose_Handler)
	atclose = f
end sub

private function Fl.event_shift() as long
	return e_state and __FL_SHIFT
end function

private function Fl.event_ctrl() as long
	return e_state and __FL_CTRL
end function

private function Fl.event_command() as long
	return e_state and __FL_COMMAND
end function

private function Fl.event_alt() as long
	return e_state and __FL_ALT
end function

private function Fl.event_buttons() as long
	return e_state and &h7f000000
end function

private function Fl.event_button1() as long
	return e_state and __FL_BUTTON1
end function

private function Fl.event_button2() as long
	return e_state and __FL_BUTTON2
end function

private function Fl.event_button3() as long
	return e_state and __FL_BUTTON3
end function

private sub Fl.set_idle(cb as Fl_Old_Idle_Handler)
	idle = cb
end sub

'private sub Fl.grab(byref win as Fl_Window_)	'moved to 
'	grab(@win)
'end sub

private sub Fl.release()
	grab(cast(Fl_Window_ ptr,0))
end sub

private sub Fl.visible_focus(v as long)
	Fl.option(OPTION_VISIBLE_FOCUS, (v<>0))
end sub

private function Fl.visible_focus() as long
	return Fl.option(OPTION_VISIBLE_FOCUS)
end function

private sub Fl.dnd_text_ops(v as long)
	Fl.option(OPTION_DND_TEXT, (v<>0))
end sub

private function Fl.dnd_text_ops() as long
	return Fl.option(OPTION_DND_TEXT)
end function

private sub Fl.use_high_res_GL(val_ as long)
	use_high_res_GL_ = val_
end sub

private function Fl.use_high_res_GL() as long
	return use_high_res_GL_
end function

#ifdef FLTK_HAVE_CAIRO

private sub Fl.cairo_autolink_context(alink as boolean)
	cairo_state_.autolink(alink)
end sub

private function Fl.cairo_autolink_context() as boolean
	return cairo_state_.autolink()
end function

private function Fl.cairo_cc() as cairo_t ptr
	return cairo_state_.cc()
end function

private sub Fl.cairo_cc(c as cairo_t ptr, own as boolean=false)
	cairo_state_.cc(c, own)
end sub

#endif


extern "c++"
type Fl_Widget_Tracker

	wp_ as Fl_Widget_ ptr

public:

	declare constructor(w1 as Fl_Widget_ ptr)
	declare destructor()

	declare function widget() as Fl_Widget_ ptr
	declare function deleted() as long
	declare function exists() as long

end type
end extern

private function Fl_Widget_Tracker.widget() as Fl_Widget_ ptr
	return wp_
end function

private function Fl_Widget_Tracker.deleted() as long
	return wp_ = 0
end function

private function Fl_Widget_Tracker.exists() as long
	return wp_ <> 0
end function
