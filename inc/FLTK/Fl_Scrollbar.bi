#include once "Fl_Slider.bi"

extern "c++"
type Fl_Scrollbar extends Fl_Slider
private:
	linesize_ as long
	pushed_ as long
	declare static sub timeout_cb(as any ptr)
	declare sub increment_cb()
protected:
	declare constructor (byref b as const Fl_Scrollbar)
	declare operator let (byref b as const Fl_Scrollbar)
	declare sub draw()

public:
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare destructor()
	declare function handle(as long) as long

	declare const function value() as long
	declare function value(p as long) as long
	declare function value(pos as long, windowSize as long, first as long, total as long) as long

	declare const function linesize() as long
	declare sub linesize(i as long)
end type

end extern

private const function Fl_Scrollbar.value() as long
	return cast(long, base.value())
end function

private function Fl_Scrollbar.value(p as long) as long
	return cast(long, base.value(cast(double, p)))
end function

private function Fl_Scrollbar.value(pos as long, windowSize as long, first as long, total as long) as long
	return scrollvalue(pos, windowSize, first, total)
end function

private const function Fl_Scrollbar.linesize() as long
	return linesize_
end function

private sub Fl_Scrollbar.linesize(i as long)
	linesize_=i
end sub


