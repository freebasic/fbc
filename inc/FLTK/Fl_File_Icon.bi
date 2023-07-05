#include once "Fl.bi"

const FL_ICON_COLOR = &hffffffff

extern "c++"
type Fl_File_Icon
private:
	static first_ as Fl_File_Icon ptr
	next__ as Fl_File_Icon ptr
	pattern_ as const zstring ptr
	type__ as long
	num_data_ as long
	alloc_data_ as long
	data_ as short ptr
public:

	enum
		ANY_
		PLAIN
		FIFO
		DEVICE
		LINK
		DIRECTORY
	end enum

	enum
		END_
		COLOR_
		LINE_
		CLOSEDLINE
		POLYGON
		OUTLINEPOLYGON
		VERTEX
	end enum

	declare constructor(p as const zstring ptr, t as long, nd as long = 0, d as short ptr = 0)
	declare destructor()

	declare function add(d as short) as short ptr
	declare function add_color(c as Fl_Color) as short ptr

	declare function add_vertex(x as long, y as long) as short ptr
	declare function add_vertex(x as single, y as single) as short ptr

	declare sub clear()
	declare sub draw(x as long, y as long, w as long, h as long, ic as Fl_Color, active as long = 1)
	declare sub label(w as Fl_Widget ptr)

	declare static sub labeltype(o as const Fl_Label ptr, x as long, y as long, w as long, h as long, a as Fl_Align)
	declare sub load(f as const zstring ptr)
	declare function load_fti(fti as const zstring ptr) as long
	declare function load_image(i as const zstring ptr) as long

	declare function next_() as Fl_File_Icon ptr
	declare function pattern() as const zstring ptr
	declare function size() as long
	declare function type_() as long
	declare function value() as short ptr

	declare static function find(filename as const zstring ptr, filetype as long = ANY_) as Fl_File_Icon ptr

	declare static function first() as Fl_File_Icon ptr
	declare static sub load_system_icons()
end type
end extern

private function Fl_File_Icon.add_color(c as Fl_Color) as short ptr
	dim d as short ptr  = add(cast(short,COLOR_)): add(cast(short, c shr 16)): add(cast(short,c)): return (d)
end function

private function Fl_File_Icon.add_vertex(x as long, y as long) as short ptr
	dim d as short ptr  = add(cast(short,VERTEX)): add(cast(short, x)): add(cast(short,y)): return (d)
end function

private function Fl_File_Icon.add_vertex(x as single, y as single) as short ptr
	dim d as short ptr  = add(cast(short,VERTEX)): add(cast(short, x * 10000.0)): add(cast(short,y * 10000.0)): return (d)
end function

private sub Fl_File_Icon.clear()
	num_data_ = 0
end sub

private function Fl_File_Icon.next_() as Fl_File_Icon ptr
	return (next__)
end function

private function Fl_File_Icon.pattern() as const zstring ptr
	return (pattern_)
end function

private function Fl_File_Icon.size() as long
	return (num_data_)
end function

private function Fl_File_Icon.type_() as long
	return (type__)
end function

private function Fl_File_Icon.value() as short ptr
	return (data_)
end function

private function Fl_File_Icon.first() as Fl_File_Icon ptr
	return (first_)
end function
