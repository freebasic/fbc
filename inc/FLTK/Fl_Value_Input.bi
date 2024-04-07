#include once "Fl_Valuator.bi"
#include once "Fl_Input.bi"


extern "c++"
type Fl_Value_Input extends Fl_Valuator 
	input as Fl_Input = any
private:
	declare constructor (byref b as const Fl_Value_Input)
	declare operator let (byref b as const Fl_Value_Input)

	soft_ as byte
	declare static sub input_cb(as Fl_Widget ptr, as any ptr)
	declare virtual sub value_damage()
public:
	declare function handle(as long) as long
protected:
	declare sub draw()
public:
	declare sub resize(as long,as long,as long,as long)
	declare constructor(as long,as long,as long,as long,as const zstring ptr = 0)
	declare destructor()

	declare sub soft(s as byte)
	declare const function soft() as byte
	declare const function shortcut() as long
	declare sub shortcut(s as long)
	declare const function textfont() as Fl_Font
	declare sub textfont(s as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(n as Fl_Color)
	declare const function cursor_color() as Fl_Color
	declare sub cursor_color(n as Fl_Color)

end type
end extern

private sub Fl_Value_Input.soft(s as byte)
	soft_=s
end sub

private function Fl_Value_Input.soft() as byte
	return soft_
end function

private function Fl_Value_Input.shortcut() as long
	return input.shortcut()
end function

private sub Fl_Value_Input.shortcut(s as long)
	input.shortcut(s)
end sub

private function Fl_Value_Input.textfont() as Fl_Font
	return input.textfont()
end function

private sub Fl_Value_Input.textfont(s as Fl_Font)
	input.textfont(s)
end sub

private function Fl_Value_Input.textsize() as Fl_Fontsize
	return input.textsize()
end function

private sub Fl_Value_Input.textsize(s as Fl_Fontsize)
	input.textsize(s)
end sub

private function Fl_Value_Input.textcolor() as Fl_Color
	return input.textcolor()
end function

private sub Fl_Value_Input.textcolor(n as Fl_Color)
	input.textcolor(n)
end sub

private function Fl_Value_Input.cursor_color() as Fl_Color
	return input.cursor_color()
end function

private sub Fl_Value_Input.cursor_color(n as Fl_Color)
	input.cursor_color(n)
end sub


