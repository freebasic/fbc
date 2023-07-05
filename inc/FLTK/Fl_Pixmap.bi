#include once "Fl_Image.bi"


extern "c++"
type Fl_Menu_Item_ as Fl_Menu_Item

type Fl_Pixmap extends Fl_Image
private:
	declare sub copy_data()
	declare sub delete_data()
	declare sub set_data(p as const byte ptr const ptr)		'??
	declare function prepare(XP as long, YP as long, WP as long, HP as long,  byref cx as long, byref cy as long, byref X as long, byref Y as long, byref W as long, byref H as long) as long

	declare operator let (byref w as const Fl_Pixmap)
	declare constructor (byref w as const Fl_Pixmap)

protected:
	declare sub measure()

public:

	alloc_data as long
  
private:

	id_ as unsigned long
	mask_ as unsigned long
public: 
	declare constructor (D as byte ptr const ptr)
	declare constructor (D as ubyte ptr const ptr)
	declare constructor (D as const byte ptr const ptr)
	declare constructor (D as const ubyte ptr const ptr)

	declare virtual destructor()
	declare virtual function copy(W as long, H as long) as Fl_Image ptr
	declare function copy() as Fl_Image ptr
	declare virtual sub color_average(c as Fl_Color, i as single)
	declare virtual sub desaturate()
	declare virtual sub draw(X as long, Y as long, W as long, H as long, cx as long=0, cy as long=0)
	declare sub  draw(X as long, Y as long)
	declare virtual sub label(w as Fl_Widget ptr)
	declare virtual sub label(m as Fl_Menu_Item_ ptr)
	declare virtual sub uncache()

end type

end extern

private function Fl_Pixmap.copy() as Fl_Image ptr
	return copy(w(), h())
end function

private sub Fl_Pixmap.draw(X as long, Y as long)
	draw(X, Y, w(), h(), 0, 0)
end sub

