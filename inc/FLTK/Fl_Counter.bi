#include once "Fl_Valuator.bi"

extern "c++"

type Fl_Counter extends Fl_Valuator
private:
	textfont_ as Fl_Font 
	textsize_ as Fl_Fontsize 
	textcolor_ as Fl_Color
	lstep_ as double
	mouseobj as unsigned byte
	declare static sub repeat_callback(as any ptr)
	declare function calc_mouseobj() as long
	declare sub increment_cb()
protected:
	declare constructor (byref b as const Fl_Counter)
	declare operator let (byref b as const Fl_Counter)

	declare sub draw()

public:
	declare function handle(as long) as long

	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
	declare destructor
	declare sub lstep(a as double)
	declare sub step_(a as double, b as double)
	declare sub step_(a as double)
	declare const function step_() as double

	declare const function textfont() as Fl_Font
	declare sub textfont(f as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(c as Fl_Color)

end type

end extern

private sub Fl_Counter.lstep(a as double)
	lstep_ = a
end sub

private sub Fl_Counter.step_(a as double, b as double)
	base.step_(a)
	lstep_ = b
end sub

private sub Fl_Counter.step_(a as double)
	base.step_(a)
end sub

private function Fl_Counter.step_() as double
	return base.step_()
end function

private function Fl_Counter.textfont() as Fl_Font
	return textfont_
end function

private sub Fl_Counter.textfont(f as Fl_Font)
	textfont_ = f
end sub

private function Fl_Counter.textsize() as Fl_Fontsize 
	return textsize_
end function

private sub Fl_Counter.textsize(s as Fl_Fontsize)
	textsize_ = s
end sub

private function Fl_Counter.textcolor() as Fl_Color
	return textcolor_
end function

private sub Fl_Counter.textcolor(c as Fl_Color)
	textcolor_ = c
end sub

