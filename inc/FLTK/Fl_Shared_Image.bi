#include once "Fl_Image.bi"

#inclib "fltk_images"
#inclib "fltk_jpeg"
#inclib "fltk_png"
#inclib "fltk_z"


extern "c++"
type Fl_Shared_Handler as function(name as const zstring ptr, header as unsigned byte ptr, headerlen as long) as Fl_Image ptr

type Fl_Shared_Image extends Fl_Image
private:
	static scaling_algorithm_ as Fl_RGB_Scaling

	declare operator let (byref w as const Fl_Shared_Image)
	declare constructor (byref w as const Fl_Shared_Image)
protected:

	static images_ as Fl_Shared_Image ptr ptr
	static num_images_ as long
	static alloc_images_ as long
	static handlers_ as Fl_Shared_Handler ptr
	static num_handlers_ as long
	static alloc_handlers_ as long

	name_ as const zstring ptr
	original_ as long
	refcount_ as long
	image_ as Fl_Image ptr
	alloc_image_ as long

	declare static function compare(i0 as Fl_Shared_Image ptr ptr, i1 as Fl_Shared_Image ptr ptr) as long

	declare constructor()
	declare constructor(n as const zstring ptr, img as Fl_Image ptr = 0)
	declare virtual destructor()
	declare sub add()
	declare sub update()
public:
	declare function name() as const zstring ptr
	declare function refcount() as long
	declare function original() as long

	declare sub release()
	declare sub reload()

	declare virtual function copy(W as long, H as long) as Fl_Image ptr
	declare function copy() as Fl_Image ptr
	declare virtual sub color_average(c as Fl_Color, t as single)
	declare virtual sub desaturate()
	declare virtual sub draw(X as long, Y as long, W as long, H as long, cx as long, cy as long)
	declare sub draw(X as long, Y as long)
	declare sub scale(width_ as long, height as long, proportional as long = 1, can_expand as long= 0)
	declare virtual sub uncache()

	declare static function find(name as const zstring ptr, W as long = 0, H as long = 0) as Fl_Shared_Image ptr
	declare static function get(name as const zstring ptr, W as long = 0, H as long = 0) as Fl_Shared_Image ptr
	declare static function get(rgb as Fl_RGB_Image ptr, own_it as long = 1) as Fl_Shared_Image ptr
	declare static function images() as Fl_Shared_Image ptr ptr
  	declare static function num_images() as long
	declare static sub add_handler(f as Fl_Shared_Handler)
	declare static sub remove_handler(r as Fl_Shared_Handler)

	declare static sub scaling_algorithm(algorithm as Fl_RGB_Scaling)
end type

declare sub fl_register_images()
end extern


private function Fl_Shared_Image.name() as const zstring ptr
	return name_
end function

private function Fl_Shared_Image.refcount() as long
	return refcount_
end function

private function Fl_Shared_Image.original() as long
	return original_
end function

private function Fl_Shared_Image.copy() as Fl_Image ptr
	return copy(w(), h())
end function

private sub Fl_Shared_Image.draw(X as long, Y as long)
	 draw(X, Y, w(), h(), 0, 0)
end sub

private sub Fl_Shared_Image.scaling_algorithm(algorithm as Fl_RGB_Scaling)
	 scaling_algorithm_ = algorithm
end sub
