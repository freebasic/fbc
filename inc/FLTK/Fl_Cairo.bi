#include once "cairo/cairo.bi"

extern "c++"
type Fl_Cairo_State
public:
	declare constructor()

	declare const function cc() as cairo_t ptr
	declare const function autolink() as boolean

	declare sub cc(c as cairo_t ptr, own as boolean=true)  
	declare sub autolink(b as boolean)
	declare sub window(w as any ptr)
	declare const function window() as any ptr
	declare sub gc(c as any ptr)
	declare const function gc() as any ptr

private:
	cc_ as cairo_t ptr
	own_cc_ as boolean
	autolink_ as boolean

	window_ as any ptr
	gc_ as any ptr ptr

end type
end extern

private constructor Fl_Cairo_State
end constructor

private function Fl_Cairo_State.cc() as cairo_t ptr
	return cc_
end function

private function Fl_Cairo_State.autolink() as boolean
	return autolink_
end function

private sub Fl_Cairo_State.cc(c as cairo_t ptr, own as boolean=true)  
	if cc_<>0 andalso own_cc_<>0 then cairo_destroy(cc_)
	cc_=c
	if cc_=0 then window_=0
	own_cc_=own
end sub

private sub Fl_Cairo_State.window(w as any ptr)
	window_=w
end sub

private function Fl_Cairo_State.window() as any ptr
	return window_
end function

private sub Fl_Cairo_State.gc(c as any ptr)
	gc_=c
end sub

private function Fl_Cairo_State.gc() as any ptr
	return gc_
end function
