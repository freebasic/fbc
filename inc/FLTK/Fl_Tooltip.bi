#include once "Fl.bi"
#include once "Fl_Widget.bi"

extern "c++"
type Fl_Tooltip extends object
	declare static function delay() as single
	declare static sub delay(f as single)
	declare static function hoverdelay() as single
	declare static sub hoverdelay(f as single)
	declare static function enabled() as long
	declare static sub enable(b as long = 1)
	declare static sub disable()
	static enter as sub(w as Fl_Widget ptr)
	declare static sub enter_area(w as Fl_Widget ptr, X as long, Y as long, W as long, H as long, tip as const zstring ptr)
	static exit_ alias "exit" as sub(w as Fl_Widget ptr)
	declare static function current() as Fl_Widget ptr
	declare static sub current(as Fl_Widget ptr)
	declare static function font() as Fl_Font
	declare static sub font(i as Fl_Font)
	declare static function size() as Fl_Fontsize
	declare static sub size(s as Fl_Fontsize)
	declare static function color() as Fl_Color
	declare static sub color(c as Fl_Color)
	declare static function textcolor() as Fl_Color
	declare static sub textcolor(c as Fl_Color)
	declare static function margin_width() as long
	declare static function margin_height() as long
	declare static function wrap_width() as long
private:
	declare static sub enter_(w as Fl_Widget ptr)
	declare static sub exit__ alias "exit_" (w as Fl_Widget ptr)
	declare static sub set_enter_exit_once_()
private:
	static delay_ as single
	static hoverdelay_ as single
	static color_ as Fl_Color
	static textcolor_ as Fl_Color
	static font_ as Fl_Font
	static size_ as Fl_Fontsize
	static widget_ as  Fl_Widget ptr
end type
end extern

private function Fl_Tooltip.delay() as single
	return delay_
end function

private sub Fl_Tooltip.delay(f as single)
	delay_=f
end sub

private function Fl_Tooltip.hoverdelay() as single
	return hoverdelay_
end function

private sub Fl_Tooltip.hoverdelay(f as single)
	hoverdelay_=f
end sub

private function Fl_Tooltip.enabled() as long
	return Fl.option(Fl.OPTION_SHOW_TOOLTIPS)
end function

private sub Fl_Tooltip.enable(b as long = 1)
	Fl.option(Fl.OPTION_SHOW_TOOLTIPS, (b<>0))
end sub

private sub Fl_Tooltip.disable()
	enable(0)
end sub

private function Fl_Tooltip.current() as Fl_Widget ptr
	return widget_
end function

private function Fl_Tooltip.font() as Fl_Font
	return font_
end function

private sub Fl_Tooltip.font(i as Fl_Font)
	font_=i
end sub

private function Fl_Tooltip.size() as Fl_Fontsize
	return iif(size_ = -1, FL_NORMAL_SIZE, size_)
end function

private sub Fl_Tooltip.size(s as Fl_Fontsize)
	size_=s
end sub

private function Fl_Tooltip.color() as Fl_Color
	return color_
end function

private sub Fl_Tooltip.color(c as Fl_Color)
	color_=c
end sub

private function Fl_Tooltip.textcolor() as Fl_Color
	return textcolor_
end function

private sub Fl_Tooltip.textcolor(c as Fl_Color)
	textcolor_=c
end sub

private function Fl_Tooltip.margin_width() as long
	return 3
end function

private function Fl_Tooltip.margin_height() as long
	return 3
end function

private function Fl_Tooltip.wrap_width() as long
	return 400
end function


