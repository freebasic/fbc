#include once "Fl_Window.bi"

#inclib "fltk_gl"
#inclib "GL"

extern "c++"

#ifndef GLContext
type GLContext as any ptr
#endif

type Fl_Gl_Choice_ as Fl_Gl_Choice

type Fl_Gl_Window extends Fl_Window
private:
	mode_ as long
	alist as const long ptr
	g as Fl_Gl_Choice_ ptr
	context_ as GLContext
	valid_f_ as byte
	damage1_ as byte
	declare virtual sub draw_overlay()
	declare sub init()

	overlay as any ptr
	declare sub make_overlay()

	declare static function can_do(as long, as const long ptr) as long
	declare function mode(as long, as const long ptr) as long
	declare static function gl_plugin_linkage() as long

protected:
	declare constructor (byref b as const Fl_Gl_Window)
	declare operator let (byref b as const Fl_Gl_Window)

	declare virtual sub draw()
public:
	declare sub show()
	declare sub show(a as long, b as zstring ptr ptr)
	declare sub flush()
	declare sub resize(as long, as long, as long, as long)
	declare sub hide()
	declare function handle(as long) as long

	declare const function valid() as byte
	declare sub valid(v as byte)
	declare sub invalidate()

	declare const function context_valid() as byte
	declare sub context_valid(v as byte)

	declare static function can_do(m as long) as long
	declare static function can_do(m as const long ptr) as long
	declare function can_do() as long
	declare const function mode() as Fl_Mode
	declare function mode(a as long) as long
	declare function mode(a as const long ptr) as long
	declare const function context() as any ptr
	declare sub context(as any ptr, destroy_flag as long = 0)
	declare sub make_current()
	declare sub swap_buffers()
	declare sub ortho()

	declare function can_do_overlay() as long
	declare sub redraw_overlay()
	declare sub hide_overlay()
	declare sub make_overlay_current()

	declare virtual function as_gl_window() as Fl_Gl_Window_ ptr
  
	declare function pixels_per_unit() as single

	declare function pixel_w() as long
	declare function pixel_h() as long
  
	declare destructor()


	declare constructor(W as long, H as long, l as const zstring ptr=0)

	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)


end type

end extern

private sub Fl_Gl_Window.show(a as long, b as zstring ptr ptr)
	base.show(a,b)
end sub

private function Fl_Gl_Window.valid() as byte
	return valid_f_ and 1
end function

private sub Fl_Gl_Window.valid(v as byte)
	if v then valid_f_ or= 1 else valid_f_ and= &hfe
end sub

private function Fl_Gl_Window.context_valid() as byte
	return valid_f_ and 2
end function

private sub Fl_Gl_Window.context_valid(v as byte)
	if v then valid_f_ or= 2 else valid_f_ and= &hfd
end sub

private function Fl_Gl_Window.can_do(m as long) as long
	return can_do(m,0)
end function

private function Fl_Gl_Window.can_do(m as const long ptr) as long
	return can_do(0, m)
end function

private function Fl_Gl_Window.can_do() as long
	return can_do(mode_,alist)
end function

private function Fl_Gl_Window.mode() as Fl_Mode
	return cast(Fl_Mode,mode_)
end function

private function Fl_Gl_Window.mode(a as long) as long
	return mode(a,0)
end function

private function Fl_Gl_Window.mode(a as const long ptr) as long
	return mode(0, a)
end function

private function Fl_Gl_Window.context() as any ptr
	return context_
end function

private function Fl_Gl_Window.as_gl_window() as Fl_Gl_Window_ ptr
	return @this
end function

private function Fl_Gl_Window.pixel_w() as long
	return int(pixels_per_unit() * w() + 0.5)
end function

private function Fl_Gl_Window.pixel_h() as long
	return int(pixels_per_unit() * h() + 0.5)
end function

private constructor Fl_Gl_Window(W as long, H as long, l as const zstring ptr=0)
	base(W,H,l)
	init()
end constructor

private constructor Fl_Gl_Window(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
	base(X,Y,W,H,l)
	init()
end constructor