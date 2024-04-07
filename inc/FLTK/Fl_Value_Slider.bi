#include once "Fl_Slider.bi"

extern "c++"
type Fl_Value_Slider extends Fl_Slider
private:
	textfont_ as Fl_Font
	textsize_ as Fl_Fontsize
	textcolor_ as Fl_Color

protected:
	declare constructor (byref b as const Fl_Value_Slider)
	declare operator let (byref b as const Fl_Value_Slider)

	declare virtual sub draw()
public:
	declare virtual function handle(h as long) as long
	declare constructor(x as long, y as long, w as long, h as long, l as const zstring ptr=0)

	declare function textfont() as Fl_Font
	declare sub textfont(s as Fl_Font)
	declare function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare function textcolor() as Fl_Color
	declare sub textcolor(s as Fl_Color)

end type

end extern

private function Fl_Value_Slider.textfont() as Fl_Font
	return textfont_
end function

private sub Fl_Value_Slider.textfont(s as Fl_Font)
	textfont_=s
end sub

private function Fl_Value_Slider.textsize() as Fl_Fontsize
	return textsize_
end function

private sub Fl_Value_Slider.textsize(s as Fl_Fontsize)
	textsize_=s
end sub

private function Fl_Value_Slider.textcolor() as Fl_Color
	return textcolor_
end function

private sub Fl_Value_Slider.textcolor(s as Fl_Color)
	textcolor_=s
end sub

