#include once "Fl_Valuator.bi"

#define FL_VERT_SLIDER_		0
#define FL_HOR_SLIDER_		1
#define FL_VERT_FILL_SLIDER_	2
#define FL_HOR_FILL_SLIDER_	3
#define FL_VERT_NICE_SLIDER_	4
#define FL_HOR_NICE_SLIDER_	5

extern "c++"
type Fl_Slider extends Fl_Valuator
private:
	slider_size_ as single
	slider_ as unsigned byte
	declare constructor()
	declare sub draw_bg(as long, as long, as long, as long)
protected:
	declare constructor (byref b as const Fl_Slider)
	declare operator let (byref b as const Fl_Slider)
	declare sub draw(as long, as long, as long, as long)
	declare function handle(as long, as long, as long, as long, as long) as long
	declare sub draw()

public:
	declare function handle(as long) as long
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare constructor(t as unsigned byte, x as long, y as long, w as long, h as long, title as const zstring ptr=0)

	declare function scrollvalue(pos as long, size as long, first as long, total as long) as long
	declare sub bounds(a as double, b as double)

	declare const function slider_size() as single
	declare sub slider_size(v as double)
	declare const function slider() as Fl_Boxtype
	declare sub slider(c as Fl_Boxtype)
end type

end extern

private const function Fl_Slider.slider_size() as single
	return slider_size_
end function

private const function Fl_Slider.slider() as Fl_Boxtype
	return cast (Fl_Boxtype, slider_)
end function

private sub Fl_Slider.slider(c as Fl_Boxtype)
	slider_=c
end sub

