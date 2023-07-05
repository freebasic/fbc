#include once "Fl_Group.bi"
#include once "Fl_Scrollbar.bi"
#include once "Fl.bi"

#define FL_NORMAL_BROWSER	0
#define FL_SELECT_BROWSER_	1
#define FL_HOLD_BROWSER_	2
#define FL_MULTI_BROWSER_	3
#define FL_SORT_ASCENDING	0
#define FL_SORT_DESCENDING	1

extern "c++"
type Fl_Browser_ extends Fl_Group
private:
	position_ as long
	real_position_ as long
	hposition_ as long
	real_hposition_ as long
	offset_ as long
	max_width as long
	has_scrollbar_ as ubyte
	textfont_ as Fl_Font
	textsize_ as Fl_Fontsize
	textcolor_ as Fl_Color
	top_ as any ptr
	selection_ as any ptr
	as any ptr redraw1, redraw2
	max_width_item as any ptr
	scrollbar_size_ as long

	declare sub update_top()

protected:
	declare const abstract function item_first() as any ptr
	declare const abstract function item_next(item as any ptr) as any ptr
	declare const abstract function item_prev(item as any ptr) as any ptr
	declare const virtual function item_last() as any ptr
	declare const abstract function item_height(item as any ptr) as long
	declare const abstract function item_width(item as any ptr) as long
	declare const virtual function item_quick_height(item as any ptr) as long
	declare const abstract sub item_draw(item as any ptr, X as long, Y as long, W as long, H as long)
	declare const virtual function item_text(item as any ptr) as const zstring ptr
	declare virtual sub item_swap(a as any ptr, b as any ptr)
	declare const virtual function item_at(index as long) as any ptr
	declare const virtual function full_width() as long
	declare const virtual function full_height() as long
	declare const virtual function incr_height() as long
	declare virtual sub item_select(item as any ptr,val_ as long=1)
	declare const virtual function item_selected(item as any ptr) as long
	declare const function top() as any ptr

	declare const function selection() as any ptr
	declare sub new_list()
	declare sub deleting(item as any ptr)
	declare sub replacing(a as any ptr, b as any ptr)
	declare sub swapping(a as any ptr, b as any ptr)
	declare sub inserting(a as any ptr, b as any ptr)
	declare const function displayed(item as any ptr) as long
	declare sub redraw_line(item as any ptr)
	declare sub redraw_lines()
	declare const sub bbox(byref X as long, byref Y as long, byref W as long, byref H as long)
	declare const function leftedge() as long
	declare function find_item(ypos as long) as any ptr


	declare constructor (byref b as const Fl_Browser_)
	declare operator let (byref b as const Fl_Browser_)
	declare sub draw()
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
public:
	scrollbar as Fl_Scrollbar=any
	hscrollbar as Fl_Scrollbar=any

	declare function handle(event as long) as long
	declare sub resize(X as long, Y as long, W as long, H as long)

	declare function select_ alias "select"(item as any ptr, val_  as long=1, docallbacks as long=0) as long
	declare function select_only(item as any ptr, docallbacks as long=0) as long
	declare function deselect(docallbacks as long=0) as long
	declare const function position() as long
	declare sub position(pos_ as long)
	declare const function hposition() as long
	declare sub hposition(as long)
	declare sub display(item as any ptr)

	enum
		HORIZONTAL = 1
		VERTICAL = 2
		BOTH = 3
		ALWAYS_ON = 4
		HORIZONTAL_ALWAYS = 5
		VERTICAL_ALWAYS = 6
		BOTH_ALWAYS = 7
	end enum

	declare const function has_scrollbar() as ubyte
	declare sub has_scrollbar(mode as ubyte)
	declare const function textfont() as Fl_Font
	declare sub textfont(font as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(newSize as Fl_Fontsize)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(col as Fl_Color)
	declare const function scrollbar_size() as long
	declare sub scrollbar_size(newSize as long)
	declare const function scrollbar_width() as long
	declare sub scrollbar_width(width_ as long)
	declare sub scrollbar_right() 
	declare sub scrollbar_left()
	declare sub sort(flags as long=0)


end type

end extern

private function Fl_Browser_.item_last() as any ptr 
	return 0
end function

private function Fl_Browser_.item_text(item as any ptr) as const zstring ptr
	return 0
end function

private sub Fl_Browser_.item_swap(a as any ptr, b as any ptr)
end sub

private function Fl_Browser_.item_at(index as long) as any ptr
	return 0
end function

private function Fl_Browser_.top() as any ptr
	return top_
end function

private function Fl_Browser_.selection() as any ptr
	return selection_
end function

private sub Fl_Browser_.redraw_lines()
	damage(FL_DAMAGE_SCROLL)
end sub

private function Fl_Browser_.position() as long
	return position_
end function

private function Fl_Browser_.hposition() as long
	return hposition_
end function

private function Fl_Browser_.has_scrollbar() as ubyte
	return has_scrollbar_
end function

private sub Fl_Browser_.has_scrollbar(mode as ubyte)
	has_scrollbar_=mode
end sub

private function Fl_Browser_.textfont() as Fl_Font
	return textfont_
end function

private sub Fl_Browser_.textfont(font as Fl_Font)
	textfont_=font
end sub

private function Fl_Browser_.textsize() as Fl_Fontsize
	return textsize_
end function

private sub Fl_Browser_.textsize(newSize as Fl_Fontsize)
	textsize_=newSize
end sub

private function Fl_Browser_.textcolor() as Fl_Color
	return textcolor_
end function

private sub Fl_Browser_.textcolor(col as Fl_Color)
	textcolor_ = col
end sub

private function Fl_Browser_.scrollbar_size() as long
	return scrollbar_size_
end function

private sub Fl_Browser_.scrollbar_size(newSize as long)
	scrollbar_size_=newSize
end sub

private function Fl_Browser_.scrollbar_width() as long
	return Fl.scrollbar_size()
end function

private sub Fl_Browser_.scrollbar_width(width_ as long)
	Fl.scrollbar_size(width_)
	scrollbar_size_=0
end sub

private sub Fl_Browser_.scrollbar_right()
	scrollbar.align(FL_ALIGN_RIGHT)
end sub

private sub Fl_Browser_.scrollbar_left()
	scrollbar.align(FL_ALIGN_LEFT)
end sub

