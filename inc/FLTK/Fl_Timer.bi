#include once "Fl_Widget.bi"

#define FL_NORMAL_TIMER		0
#define FL_VALUE_TIMER		1
#define FL_HIDDEN_TIMER		2


extern "c++"
type Fl_Timer extends Fl_Widget
private:
	declare static sub stepcb(as any ptr)
	declare sub step_ alias "step"()
	as byte on, direction_
	as double delay, total
	as integer lastsec,lastusec
protected:
	declare constructor (byref b as const Fl_Timer)
	declare operator let (byref b as const Fl_Timer)
	declare sub draw()
public:
	declare function handle(as long) as long
	declare constructor(t as unsigned byte, x as long, y as long, w as long, h as long, l as const zstring ptr=0)
	declare destructor()

	declare sub value(as double)
	declare const function value() as double

	declare const function direction() as byte
	declare sub direction(d as byte)
	declare const function suspended() as byte
	declare sub suspended(d as byte alias "char")

end type
end extern

private function Fl_Timer.value() as double
	return iif(delay>0.0,delay,0.0)
end function

private function Fl_Timer.direction() as byte
	return direction_
end function

private sub Fl_Timer.direction(d as byte)
	direction_=d
end sub

private function Fl_Timer.suspended() as byte
	return not on
end function


