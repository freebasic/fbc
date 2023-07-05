#include once "Fl_Browser_.bi"
#include once "Fl_Image.bi"

type FL_BLINE_ as FL_BLINE

extern "c++"
type Fl_Browser extends Fl_Browser_ 
private:
	first as FL_BLINE_ ptr
	last as FL_BLINE_ ptr
	cache as FL_BLINE_ ptr
	cacheline as long
	lines as long
	full_height_ as long
	column_widths_ as const long ptr
	format_char_ as byte
	column_char_ as byte
protected:
	declare const function item_first() as any ptr
	declare const function item_next(item as any ptr) as any ptr
	declare const function  item_prev(item as any ptr) as any ptr
	declare const function  item_last() as any ptr
	declare const function  item_selected(item as any ptr) as long
	declare sub item_select(item as any ptr, val_ as long)
	declare const function  item_height(item as any ptr) as long
	declare const function  item_width(item as any ptr) as long
	declare const sub item_draw(item as any ptr, X as long, Y as long, W as long, H as long)
	declare const function full_height() as long
	declare const function incr_height() as long
	declare const function item_text(item as any ptr) as const zstring ptr
	declare sub item_swap(a as any ptr, b as any ptr)
	declare const function item_at(line_ as long) as any ptr

	declare const function find_line(line_ as long) as FL_BLINE_ ptr
	declare function _remove(line_ as long) as FL_BLINE_ ptr
	declare sub insert(line_ as long, item as FL_BLINE_ ptr)
	declare const function lineno(item as any ptr) as long
	declare sub swap_ alias "swap"(a as FL_BLINE_ ptr, b as FL_BLINE_ ptr)

	declare constructor (byref b as const Fl_Browser)
	declare operator let (byref b as const Fl_Browser)
public:
	declare sub remove(line_ as long)
	declare sub add(newtext as const zstring ptr, d as any ptr = 0)
	declare sub insert(line_ as long, newtext as const zstring ptr, d as any ptr = 0)
	declare sub move(to_ as long, from as long)
	declare function load(filename as const zstring ptr) as long
	declare sub swap_ alias "swap" (a as long, b as long)
	declare sub clear()

	declare const function size() as long
	declare sub size(W as long, H as long)

	declare const function textsize() as Fl_Fontsize
	declare sub textsize(newSize as Fl_Fontsize)

	declare const function topline() as long
	enum Fl_Line_Position
		TOP
		BOTTOM
		MIDDLE
	end enum
	declare sub lineposition(line_ as long, pos_ as Fl_Line_Position)
	declare sub topline(line_ as long)
	declare sub bottomline(line_ as long)
	declare sub middleline(line_ as long)

	declare function select_ alias "select"(line_ as long, val_ as long=1) as long
	declare const function selected(line_ as long) as long

	declare sub show(line_ as long)
	declare sub show()
	declare sub hide(line_ as long)
	declare sub hide()
	declare const function visible(line as long) as long

	declare const function value() as long
	declare sub value(line_ as long)
	declare const function text(line_ as long) as const zstring ptr
	declare sub text(line_ as long, newtext as const zstring ptr)
	declare const function data_ alias "data"(line_ as long) as any ptr
	declare sub data_ alias "data" (line_ as long, d as any ptr)

	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
	declare destructor()

	declare const function format_char() as byte
	declare sub format_char(c as byte)
	declare const function column_char() as byte
	declare sub column_char(c as byte)
	declare const function column_widths() as const long ptr
	declare sub column_widths(arr as const long ptr)
	declare const function  displayed(line_ as long) as long
	declare sub make_visible(line_ as long)

	declare sub  icon(line_ as long, icon as Fl_Image ptr)
	declare const function icon(line_ as long) as  Fl_Image ptr
	declare sub remove_icon(line_ as long)

	declare sub replace(a as long, b as const zstring ptr)
	declare sub display(line_ as long, val_ as long=1)

end type

end extern

private sub Fl_Browser.item_swap(a as any ptr, b as any ptr)
	swap_(cast(FL_BLINE_ ptr,a), cast(FL_BLINE_ ptr,b))
end sub

private function Fl_Browser.item_at(line_ as long) as any ptr 
	return cast(any ptr, find_line(line_))
end function

private function Fl_Browser.size() as long
	return lines
end function

private sub Fl_Browser.size(W as long, H as long)
	base.base.base.size(W,H)
end sub

private function Fl_Browser.textsize() as Fl_Fontsize
	return base.textsize()
end function

private sub Fl_Browser.topline(line_ as long)
	lineposition(line_, TOP)
end sub

private sub Fl_Browser.bottomline(line_ as long)
	lineposition(line_, BOTTOM)
end sub

private sub Fl_Browser.middleline(line_ as long)
	lineposition(line_, MIDDLE)
end sub

private sub Fl_Browser.show()
	base.base.base.show()
end sub

private sub Fl_Browser.hide()
	base.base.base.hide()
end sub

private sub Fl_Browser.value(line_ as long)
	select_(line_)
end sub

private destructor Fl_Browser
	clear()
end destructor

private function Fl_Browser.format_char() as byte
	return format_char_
end function

private sub Fl_Browser.format_char(c as byte)
	format_char_=c
end sub

private function Fl_Browser.column_char() as byte
	return column_char_
end function

private sub Fl_Browser.column_char(c as byte)
	column_char_=c
end sub

private function Fl_Browser.column_widths() as const long ptr
	return column_widths_
end function

private sub Fl_Browser.column_widths(arr as const long ptr)
	column_widths_ = arr
end sub

private function Fl_Browser.displayed(line_ as long) as long
	return base.displayed(find_line(line_))
end function

private sub Fl_Browser.make_visible(line_ as long)
	if line_ < 1 then
		 base.display(find_line(1))
	elseif line_ > lines then
		base.display(find_line(lines))
	else 
		base.display(find_line(line_))
	end if
end sub

private sub Fl_Browser.replace(a as long, b as const zstring ptr)
	text(a, b)
end sub

