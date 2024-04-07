#include once "Fl_Image.bi"


extern "c++"
type Fl_Menu_Item_ as Fl_Menu_Item

type Fl_Bitmap extends Fl_Image
private:
	declare operator let (byref w as const Fl_Bitmap)
	declare constructor (byref w as const Fl_Bitmap)

public:

	array as const ubyte ptr
	alloc_array as long
  
private:
	declare function start(XP as long, YP as long, WP as long, HP as long, byref cx as long, byref cy as long,byref X as long, byref Y as long,byref W as long,byref H as long) as long
	id_ as unsigned long
public: 
	declare constructor (bits as const ubyte ptr, W as long, H as long)
	declare constructor (bits as const byte ptr, W as long, H as long)

	declare virtual destructor()
	declare virtual function copy(W as long, H as long) as Fl_Image ptr
	declare function copy() as Fl_Image ptr
	declare virtual sub draw(X as long, Y as long, W as long, H as long, cx as long=0, cy as long=0)
	declare sub  draw(X as long, Y as long)
	declare virtual sub label(w as Fl_Widget ptr)
	declare virtual sub label(m as Fl_Menu_Item_ ptr)
	declare virtual sub uncache()

end type

end extern

private function Fl_Bitmap.copy() as Fl_Image ptr
	return copy(w(), h())
end function

private sub Fl_Bitmap.draw(X as long, Y as long)
	draw(X, Y, w(), h(), 0, 0)
end sub

