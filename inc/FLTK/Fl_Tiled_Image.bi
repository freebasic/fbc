#include once "Fl_Image.bi"

extern "c++"
type Fl_Tiled_Image extends Fl_Image 
private:
	declare operator let (byref w as const Fl_Tiled_Image)
	declare constructor (byref w as const Fl_Tiled_Image)
protected:

	image_ as Fl_Image ptr
	alloc_image_ as long

public:
	declare constructor( i as Fl_Image ptr, W as long= 0, H as long= 0)
	declare virtual destructor()

	declare virtual function copy(W as long, H as long) as Fl_Image ptr
	declare function copy() as Fl_Image ptr
	declare virtual sub color_average(c as Fl_Color, i as single)
	declare virtual sub desaturate()
	declare virtual sub draw(X as long, Y as long, W as long, H as long, cx as long, cy as long)
	declare sub draw(X as long, Y as long)
	declare function image() as Fl_Image ptr

end type

end extern

private function Fl_Tiled_Image.copy() as Fl_Image ptr
	return copy(w(), h())
end function

private sub Fl_Tiled_Image.draw(X as long, Y as long)
	draw(X, Y, w(), h(), 0, 0)
end sub

private function Fl_Tiled_Image.image() as Fl_Image ptr 
	return image_
end function
