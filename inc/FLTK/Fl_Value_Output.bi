#include once "Fl_Valuator.bi"


extern "c++"
type Fl_Value_Output extends Fl_Valuator
private:
	textfont_ as Fl_Font
	textsize_ as Fl_Fontsize
	soft_ as unsigned byte
	textcolor_ as Fl_Color
protected:
	declare constructor (byref b as const Fl_Value_Output)
	declare operator let (byref b as const Fl_Value_Output)

	declare sub draw()
public:
	declare function handle(as long) as long
	declare constructor(x as long, y as long, w as long, h as long, l as const zstring ptr=0)

	declare sub soft(s as unsigned byte)
	declare const function soft() as unsigned byte
	declare function textfont() as Fl_Font
	declare sub textfont(s as Fl_Font)
	declare function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare function textcolor() as Fl_Color
	declare sub textcolor(s as Fl_Color)

end type
end extern

private sub Fl_Value_Output.soft(s as unsigned byte)
	soft_=s
end sub

private function Fl_Value_Output.soft() as unsigned byte
	return soft_
end function

private sub Fl_Value_Output.textfont(s as Fl_Font)
	textfont_=s
end sub

private function Fl_Value_Output.textfont() as Fl_Font
	return textfont_
end function

private sub Fl_Value_Output.textsize(s as Fl_Fontsize)
	textsize_=s
end sub

private function Fl_Value_Output.textsize() as Fl_Fontsize
	return textsize_
end function

private sub Fl_Value_Output.textcolor(s as Fl_Color)
	textcolor_=s
end sub

private function Fl_Value_Output.textcolor() as Fl_Color
	return textcolor_
end function
