#include once "Fl.bi"
#include once "Fl_Browser_.bi"

extern "c++"
type Fl_Check_Browser extends Fl_Browser_
private:
	declare const function item_first() as any ptr
	declare const function item_next(item as any ptr) as any ptr
	declare const function item_prev(item as any ptr) as any ptr
	declare const function item_height(item as any ptr) as long
	declare const function item_width(item as any ptr) as long
	declare const sub item_draw(as any ptr, as long, as long, as long, as long)
	declare sub item_select(as any ptr, as long)
	declare const function item_selected(as any ptr) as long

	type cb_item_
		next_ as cb_item_ ptr
		prev as cb_item_ ptr
		checked as byte
		selected as byte
		text as zstring ptr
	end type

	first as cb_item_ ptr
	last as cb_item_ ptr
	cache as cb_item_ ptr
	cached_item as long
	nitems_ as long
	nchecked_ as long
	declare const function find_item(as long) as cb_item_ ptr
	declare const function lineno(as cb_item_ ptr) as long

protected:
	declare constructor (byref b as const Fl_Check_Browser)
	declare operator let (byref b as const Fl_Check_Browser)
public:
	declare constructor(x as long, y as long, w as long, h as long, l as const zstring ptr=0)
	declare destructor()
	declare sub add(s as zstring ptr)
	declare sub add(s as zstring ptr, b as long)
	declare function remove(item as long) as long
	declare sub clear()
	declare const function nitems() as long
	declare const function nchecked() as long
	declare const function checked(item as long) as long
	declare sub checked(item as long, b as long)
	declare sub set_checked(item as long)
	declare sub check_all()
	declare sub check_none()
	declare const function value() as long
	declare const function text(item as long) as zstring ptr

protected:
	declare function handle(as long) as long
end type
end extern

private destructor Fl_Check_Browser
	clear()
end destructor

private function Fl_Check_Browser.nitems() as long
	return nitems_
end function

private function Fl_Check_Browser.nchecked() as long
	return nchecked_
end function

private sub Fl_Check_Browser.set_checked(item as long)
	checked(item, 1)
end sub