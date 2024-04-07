#include once "Fl_Paged_Device.bi"
#include once "Fl_Printer.bi"

extern "c++"
type Fl_Copy_Surface extends Fl_Surface_Device
private:
	width_ as long
	height as long
	helper as Fl_Paged_Device ptr

	platform_specific_data(2) as integer
protected:
	declare constructor (byref b as const Fl_Copy_Surface)
	declare operator let (byref b as const Fl_Copy_Surface)

public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr
	declare constructor(w as long, h as long)
	declare destructor
	declare sub set_current()
	declare sub draw(widget as Fl_Widget ptr, delta_x as long = 0, delta_y as long = 0)
	declare sub draw_decorated_window(win as Fl_Window ptr, delta_x as long = 0, delta_y as long = 0)
	declare function w() as long
	declare function h() as long

end type

end extern

private function Fl_Copy_Surface.class_name() as const zstring ptr
	return class_id
end function

private function Fl_Copy_Surface.w() as long
	return width_
end function

private function Fl_Copy_Surface.h() as long
	return height
end function
