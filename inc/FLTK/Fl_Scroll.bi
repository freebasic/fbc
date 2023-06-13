#include once "Fl_Group.bi"
#include once "Fl_Scrollbar.bi"

extern "c++"
type Fl_Scroll extends Fl_Group
private:
	as long xposition_, yposition_
	as long oldx, oldy
	scrollbar_size_ as long
	declare static sub hscrollbar_cb(as Fl_Widget ptr, as any ptr)
	declare static sub scrollbar_cb(as Fl_Widget ptr, as any ptr)
	declare sub fix_scrollbar_order()
	declare static sub draw_clip(as any ptr, as long, as long, as long, as long)
protected:
	declare constructor (byref b as const Fl_Scroll)
	declare operator let (byref b as const Fl_Scroll)

private:
	type ScrollInfo
		type Fl_Region_XYWH
			as long x,y,w,h
		end type
		type Fl_Region_LRTB
			l as long
			r as long
			t as long
			b as long
		end type
		type Fl_Scrollbar_Data
			as long x,y,w,h
			pos as long
			size as long
			first as long
			total as long
		end type
		scrollsize as long
		innerbox as Fl_Region_XYWH
		innerchild as Fl_Region_XYWH
		child as Fl_Region_LRTB
		hneeded as long
		vneeded as long
		hscroll as Fl_Scrollbar_Data
		vscroll as Fl_Scrollbar_Data
	end type	  
	declare sub recalc_scrollbars(byref si as ScrollInfo)
protected:


	declare sub bbox(byref as long, byref as long, byref as long, byref as long)
	declare sub draw()
public:
	scrollbar as Fl_Scrollbar=any
	hscrollbar as Fl_Scrollbar=any

	declare sub resize(X as long, Y as long, W as long, H as long)
	declare function handle(as long) as long

	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)

	enum
		HORIZONTAL = 1
		VERTICAL = 2
		BOTH = 3
		ALWAYS_ON = 4
		HORIZONTAL_ALWAYS = 5
		VERTICAL_ALWAYS = 6
		BOTH_ALWAYS = 7
	end enum

	declare const function xposition() as long
	declare const function yposition() as long
	declare sub scroll_to(as long, as long)
	declare sub clear()

	declare const function scrollbar_size() as long
	declare sub scrollbar_size(newSize as long)
end type
end extern

private function Fl_Scroll.xposition() as long
	return xposition_
end function

private function Fl_Scroll.yposition() as long
	return yposition_
end function

private function Fl_Scroll.scrollbar_size() as long
	return scrollbar_size_
end function

private sub Fl_Scroll.scrollbar_size(newSize as long)
	if newSize <> scrollbar_size_ then redraw()
	scrollbar_size_ = newSize
end sub
