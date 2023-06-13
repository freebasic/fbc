#include once "Fl_Widget.bi"

extern "c++"
type Fl_Positioner extends Fl_Widget 
private:
	as double xmin, ymin
	as double xmax, ymax
	as double xvalue_, yvalue_
	as double xstep_, ystep_
protected:

	declare constructor (byref b as const Fl_Positioner)
	declare operator let (byref b as const Fl_Positioner)

	declare sub draw(as long, as long, as long, as long)
	declare function handle(as long, as long, as long, as long, as long) as long
	declare sub draw()
public:
	declare virtual function handle(as long) as long

	declare constructor(x as long, y as long, w as long, h as long, l as const zstring ptr=0)

	declare const function xvalue() as double
	declare const function yvalue() as double
	declare function xvalue(as double) as long
	declare function yvalue(as double) as long
	declare function value(as double, as double) as long
	declare sub xbounds(as double, as double)
	declare const function xminimum() as double
	declare sub xminimum(a as double)
	declare const function xmaximum() as double
	declare sub xmaximum(a as double)
	declare sub ybounds(as double, as double)
	declare const function yminimum() as double
	declare sub yminimum(a as double)
	declare const function ymaximum() as double
	declare sub ymaximum(a as double)
	declare sub xstep(a as double)
	declare sub ystep(a as double)



end type
end extern

private function Fl_Positioner.xvalue() as double
	return xvalue_
end function

private function Fl_Positioner.yvalue() as double
	return yvalue_
end function

private function Fl_Positioner.xminimum() as double 
	return xmin
end function

private sub Fl_Positioner.xminimum(a as double)
	xbounds(a,xmax)
end sub

private function Fl_Positioner.xmaximum() as double
	return xmax
end function

private sub Fl_Positioner.xmaximum(a as double)
	xbounds(xmin,a)
end sub

private function Fl_Positioner.yminimum() as double 
	return ymin
end function

private sub Fl_Positioner.yminimum(a as double)
	ybounds(a,ymax)
end sub

private function Fl_Positioner.ymaximum() as double
	return ymax
end function

private sub Fl_Positioner.ymaximum(a as double)
	ybounds(ymin,a)
end sub

private sub Fl_Positioner.xstep(a as double)
	xstep_ = a
end sub

private sub Fl_Positioner.ystep(a as double)
	ystep_ = a
end sub
