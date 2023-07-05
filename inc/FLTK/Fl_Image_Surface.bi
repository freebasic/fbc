#include once "Fl_Copy_Surface.bi"
#include once "Fl_Image.bi"
#include once "Fl_Shared_Image.bi"

extern "c++"
type Fl_Image_Surface extends Fl_Surface_Device 
private:
	declare sub prepare_(w as long, h as long, highres as long)
	offscreen as Fl_Offscreen
	width_ as long
	height as long
	helper as Fl_Paged_Device ptr

	platform_specific_data(3) as integer
protected:
	declare constructor (byref b as const Fl_Image_Surface)
	declare operator let (byref b as const Fl_Image_Surface)

public:
	static class_id as const zstring ptr
	declare function class_name() as const zstring ptr

	declare constructor(w as long, h as long, highres as long)
	declare constructor(w as long, h as long)
	declare destructor

	declare sub set_current()
	declare sub draw(widget as Fl_Widget ptr, delta_x as long = 0, delta_y as long = 0)
	declare sub draw_decorated_window(win as Fl_Window ptr, delta_x as long = 0, delta_y as long = 0)

	declare function image() as Fl_RGB_Image ptr
	declare function highres_image() as Fl_Shared_Image ptr
end type
end extern

private function Fl_Image_Surface.class_name() as const zstring ptr
	return class_id
end function
