#include once "Fl_Widget.bi"

#define FL_VERTICAL	0 
#define FL_HORIZONTAL	1 

extern "c++"
type Fl_Valuator extends Fl_Widget field=4
private:
	as double value_
	as double previous_value_
	as double min, max
	as double A
	as long B

protected:
	declare constructor (byref b as const Fl_Valuator)
	declare operator let (byref b as const Fl_Valuator)

	declare const function horizontal() as long
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr)
	declare const function previous_value() as double
	declare sub handle_push()
	declare function softclamp(as double) as double
	declare sub handle_drag(newvalue as double)
	declare sub handle_release()
	declare virtual sub value_damage()
	declare sub set_value(v as double)
public:
	declare sub bounds(a as double, b as double)
 	declare const function minimum() as double
	declare sub minimum(a as double)
	declare const function maximum() as double
	declare sub maximum(a as double)

	declare sub range(a as double, b as double)
	declare sub step_(a_ as long)
	declare sub step_(a_ as double, b_ as long)
	declare sub step_ alias "step" (s as double)
	declare const function step_() as double
	declare sub precision(digits as long)

	declare const function value() as double
	declare function value(as double) as integer

	declare virtual function format(as zstring ptr) as long
	declare function round(as double) as double
	declare function clamp(as double) as double
	declare function increment(as double, as long) as double
end type
end extern

private const function Fl_Valuator.horizontal() as long
	return type_() and FL_HORIZONTAL
end function

private const function Fl_Valuator.previous_value() as double
	return previous_value_
end function

private sub Fl_Valuator.handle_push()
	previous_value_=value_
end sub

private sub Fl_Valuator.set_value(v as double)
	value_=v
end sub

private sub Fl_Valuator.bounds(a as double, b as double)
	 min=a: max=b
end sub

private const function Fl_Valuator.minimum() as double
	return min
end function

private sub Fl_Valuator.minimum(a as double)
	min=a
end sub

private const function Fl_Valuator.maximum() as double
	return max
end function

private sub Fl_Valuator.maximum(a as double)
	max=a
end sub

private sub Fl_Valuator.range(a as double, b as double)
	 min=a: max=b
end sub

private sub Fl_Valuator.step_(a_ as long)
	 A=a_: B=1
end sub

private sub Fl_Valuator.step_(a_ as double, b_ as long)
	 A=a_: B=b:
end sub

private const function Fl_Valuator.step_() as double
	 return A/B
end function

private const function Fl_Valuator.value() as double
	 return value_
end function


