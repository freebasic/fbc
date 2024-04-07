#include once "Fl_Single_Window.bi"

extern "c++"
type Fl_Menu_Window extends Fl_Single_Window
protected:
	declare constructor (byref b as const Fl_Menu_Window)
	declare operator let (byref b as const Fl_Menu_Window)
public:
	declare sub show()
	declare sub erase()
	declare sub flush()
	declare sub hide()

	declare function overlay() as unsigned long

	declare sub set_overlay()
	declare sub clear_overlay()

	declare destructor()
	declare constructor(W as long, H as long, l as const zstring ptr=0)
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
end type
end extern

private function Fl_Menu_Window.overlay() as unsigned long
	return not (flags()and NO_OVERLAY_)
end function

private sub Fl_Menu_Window.set_overlay()
	clear_flag(NO_OVERLAY_)
end sub

private sub Fl_Menu_Window.clear_overlay()
	set_flag(NO_OVERLAY_)
end sub
