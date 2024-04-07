#include once "Fl_Widget.bi"

extern "c++"
type Fl_Progress extends Fl_Widget
private:
	value_ as single
	minimum_ as single
	maximum_ as single
protected:
	declare constructor (byref b as const Fl_Progress)
	declare operator let (byref b as const Fl_Progress)
	declare virtual sub draw()
public:
	declare constructor(x as long, y as long, w as long, h as long, l as const zstring ptr=0)

	declare sub maximum(v as single)
	declare function maximum() as single

	declare sub minimum(v as single)
	declare function minimum() as single

	declare sub value(v as single)
	declare function value() as single
end type
end extern

private sub Fl_Progress.maximum(v as single)
	maximum_=v
	redraw()
end sub

private function Fl_Progress.maximum() as single
	return maximum_
end function

private sub Fl_Progress.minimum(v as single)
	minimum_=v
	redraw()
end sub

private function Fl_Progress.minimum() as single
	return minimum_
end function

private sub Fl_Progress.value(v as single)
	value_=v
	redraw()
end sub

private function Fl_Progress.value() as single
	return value_
end function
