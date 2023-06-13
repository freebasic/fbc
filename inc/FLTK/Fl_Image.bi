type Fl_Menu_Item_ as Fl_Menu_Item
type Fl_Pixmap_ as Fl_Pixmap


enum Fl_RGB_Scaling 
	FL_RGB_SCALING_NEAREST = 0
	FL_RGB_SCALING_BILINEAR 
end enum

extern "c++"

type Fl_Image extends object
public:
	const ERR_NO_IMAGE    = -1
	const ERR_FILE_ACCESS = -2
	const ERR_FORMAT      = -3
private:
	w_ as long
	h_ as long
	d_ as long
	ld_ as long
	count_  as long
	data_ as const zstring ptr const ptr

	static RGB_scaling_ as Fl_RGB_Scaling

	declare operator let (byref w as const Fl_Image)
	declare constructor (byref w as const Fl_Image)
public:
	declare function w() as const long
	declare function h() as const long
	declare function d() as const long
	declare function ld() as const long
	declare function count() as const long
	declare function data() as const zstring ptr const ptr

	declare function fail() as long

	declare constructor(W as long, H as long, D as long)
	declare virtual destructor

	declare virtual function copy(W as long, H as long) as Fl_Image ptr
	declare function copy() as Fl_Image ptr

	declare virtual sub color_average(c as Fl_Color, i as single)
	declare sub inactive()

	declare virtual sub desaturate()
	declare virtual sub label(w as Fl_Widget ptr)
	declare virtual sub label(m as Fl_Menu_Item_ ptr)

	declare virtual sub draw(X as long, Y as long, W as long, H as long, cx as long=0, cy as long=0)
	declare sub draw(X as long, Y as long)
	declare virtual sub uncache()

	declare static sub RGB_scaling(s as Fl_RGB_Scaling)

	declare static function  RGB_scaling() as Fl_RGB_Scaling

end type

end extern

private function Fl_Image.w() as const long
	return w_
end function

private function Fl_Image.h() as const long
	return h_
end function

private function Fl_Image.d() as const long
	return d_
end function

private function Fl_Image.ld() as const long
	return ld_
end function

private function Fl_Image.count() as const long
	return count_
end function

private function Fl_Image.data() as const zstring ptr const ptr
	return data_
end function

private function Fl_Image.copy() as Fl_Image ptr
	return copy(w(),h())
end function

private sub Fl_Image.inactive()
	color_average(FL_GRAY, .33)
end sub

private sub Fl_Image.draw(X as long, Y as long)
	draw(X, Y, w(), h(), 0, 0)
end sub


extern "c++"

type Fl_RGB_Image extends Fl_Image
	static max_size_ as unsigned integer
public:
	array as const ubyte ptr
	alloc_array as long
private:
	id_ as unsigned long
	mask_ as unsigned long

	declare operator let (byref w as const Fl_RGB_Image)
	declare constructor (byref w as const Fl_RGB_Image)
public:
	declare constructor(bits as const ubyte ptr, W as long, H as long, D as long=3, LD as long=0)
	declare constructor(pxm as const Fl_Pixmap_ ptr, bg as Fl_Color=FL_GRAY)
	declare virtual destructor
	declare virtual function copy (W as long, H as long) as Fl_Image ptr
	declare function copy() as Fl_Image ptr

	declare virtual sub color_average(c as Fl_Color, i as single)
	declare virtual sub desaturate()
	declare virtual sub draw(X as long, Y as long, W as long, H as long, cx as long=0, cy as long=0)
	declare sub draw(X as long, Y as long)
	declare virtual sub label(w as Fl_Widget ptr)
	declare virtual sub label(m as Fl_Menu_Item_ ptr)
	declare virtual sub uncache()
	declare static sub max_size(size as unsigned integer)
	declare static function max_size() as unsigned integer

end type

end extern

private function Fl_RGB_Image.copy() as Fl_Image ptr
	return copy(w(),h())
end function

private sub Fl_RGB_Image.max_size(size as unsigned integer)
	max_size_=size
end sub

private function Fl_RGB_Image.max_size() as unsigned integer
	return max_size_
end function

