#include once "Fl_Widget.bi"

#define FL_BAR_CHART		0
#define FL_HORBAR_CHART		1
#define FL_LINE_CHART		2
#define FL_FILL_CHART		3
#define FL_SPIKE_CHART		4
#define FL_PIE_CHART		5
#define FL_SPECIALPIE_CHART	6

#define FL_FILLED_CHART  FL_FILL_CHART

#define FL_CHART_MAX		128
#define FL_CHART_LABEL_MAX	18

type FL_CHART_ENTRY
	val_ as single
	col as unsigned long
	str_ as zstring*(FL_CHART_LABEL_MAX+1)
end type

extern "c++"
type Fl_Chart extends Fl_Widget
private:
	numb as long
	maxnumb as long
	sizenumb as long
	entries as FL_CHART_ENTRY ptr
	as double min,max
	autosize_ as ubyte
	textfont_ as Fl_Font
	textsize_ as Fl_Fontsize
	textcolor_ as Fl_Color

protected:
	declare constructor (byref b as const Fl_Chart)
	declare operator let (byref b as const Fl_Chart)
	declare sub draw()
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
	declare destructor()
	declare sub clear()
	declare sub add(val_ as double, str_ as const zstring ptr = 0, col as unsigned long = 0)
	declare sub insert(ind as long, val_ as double, str_ as const zstring ptr = 0, col as unsigned long = 0)
	declare sub replace(ind as long, val_ as double, str_ as const zstring ptr = 0, col as unsigned long = 0)
	declare const sub bounds(a as double ptr, b as double ptr) 
	declare sub bounds(a as double, b as double)
	declare const function size() as long
	declare sub size(W as long, H as long)
	declare const function maxsize() as long
	declare sub maxsize(m as long)
	declare const function textfont() as Fl_Font
	declare sub textfont(s as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(n as Fl_Color)
	declare const function autosize() as ubyte
	declare sub autosize(n as ubyte)
end type
end extern

private sub Fl_Chart.bounds(a as double ptr, b as double ptr)
	*a = min: *b = max
end sub

private function Fl_Chart.size() as long
	return numb
end function

private sub Fl_Chart.size(W as long, H as long)
	base.size(W, H)
end sub

private function Fl_Chart.maxsize() as long
	return maxnumb
end function

private function Fl_Chart.textfont() as Fl_Font
	return textfont_
end function

private sub Fl_Chart.textfont(s as Fl_Font)
	textfont_=s
end sub

private function Fl_Chart.textsize() as Fl_Fontsize
	return textsize_
end function

private sub Fl_Chart.textsize(s as Fl_Fontsize)
	textsize_=s
end sub

private function Fl_Chart.textcolor() as Fl_Color
	return textcolor_
end function

private sub Fl_Chart.textcolor(n as Fl_Color)
	textcolor_=n
end sub

private function Fl_Chart.autosize() as ubyte
	return autosize_
end function

private sub Fl_Chart.autosize(n as ubyte)
	autosize_=n
end sub

