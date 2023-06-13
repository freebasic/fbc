#include once "Fl_Group.bi"

extern "c++"

type Fl_Tabs extends Fl_Group
private:
	value_ as Fl_Widget ptr

	push_ as Fl_Widget ptr
	tab_pos as long ptr
	tab_width as long ptr
	tab_count as long
	declare function tab_positions() as long
	declare sub clear_tab_positions()
	declare function tab_height() as long
	declare sub draw_tab(x1 as long, x2 as long, W as long, H as long, o as Fl_Widget ptr, sel as long=0)
protected:
	declare constructor (byref b as const Fl_Tabs)
	declare operator let (byref b as const Fl_Tabs)

	declare sub redraw_tabs()
	declare sub draw()

public:
	declare function handle(as long) as long
	declare function value() as Fl_Widget ptr
	declare function value(as Fl_Widget ptr) as long

	declare const function push() as Fl_Widget ptr
	declare function push(as Fl_Widget ptr) as long
	declare constructor (as long,as long,as long,as long,as const zstring ptr = 0)
	declare function which(event_x as long, event_y as long) as Fl_Widget ptr
	declare destructor()
	declare sub client_area(byref rx as long, byref ry as long, byref rw as long, byref rh as long, tabh as long=0)

end type

end extern

private function Fl_Tabs.push() as Fl_Widget ptr
	return push_
end function
