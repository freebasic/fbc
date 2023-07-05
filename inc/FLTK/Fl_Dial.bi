#include once "Fl_Valuator.bi"

#define FL_NORMAL_DIAL	0
#define FL_LINE_DIAL_	1
#define FL_FILL_DIAL_	2

extern "c++"
type Fl_Dial extends Fl_Valuator
private:
	as short a1, a2
protected:
	declare sub draw(X as long, Y as long, W as long, H as long)
	declare function handle(event as long, X as long, Y as long, W as long, H as long) as long
	declare sub draw()

	declare constructor (byref b as const Fl_Dial)
	declare operator let (byref b as const Fl_Dial)
public:
	declare function handle(as long) as long
	declare constructor(x as long, y as long, w as long, h as long, l as const zstring ptr=0)

	declare const function angle1() as short
	declare sub angle1(a as short)
	declare const function angle2() as short
	declare sub angle2(a as short)
	declare sub angles(a as short, b as short)
end type
end extern

private function Fl_Dial.angle1() as short
	return a1
end function

private sub Fl_Dial.angle1(a as short)
	a1 = a
end sub

private function Fl_Dial.angle2() as short
	return a2
end function

private sub Fl_Dial.angle2(a as short)
	a2 = a
end sub

private sub Fl_Dial.angles(a as short, b as short)
	a1 = a: a2=b
end sub
