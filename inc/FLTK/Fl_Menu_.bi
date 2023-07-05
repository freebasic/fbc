#include once "Fl.bi"
#include once "Fl_Widget.bi"
#include once "Fl_Menu_Item.bi"


extern "c++"


type Fl_Menu_ extends Fl_Widget
private:
	menu_ as Fl_Menu_Item ptr
	value_ as const Fl_Menu_Item ptr
	
	declare constructor (byref w as const Fl_Menu_)
	declare operator let (byref w as const Fl_Menu_)
protected:
	alloc as unsigned byte
	down_box_ as unsigned byte
	textfont_ as Fl_Font
	textsize_ as Fl_Fontsize
	textcolor_ as Fl_Color

	declare const function item_pathname_(name as zstring ptr, namelen as long, finditem as const Fl_Menu_Item ptr, menu as const Fl_Menu_Item ptr=0) as long
public:
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare virtual destructor()

	declare const function item_pathname (name as zstring ptr, namelen as long, finditem as const Fl_Menu_Item ptr=0) as long
	declare function picked(as const Fl_Menu_Item ptr) as const Fl_Menu_Item ptr
	declare function find_item(name as zstring ptr) as const Fl_Menu_Item ptr
	declare function find_item(as Fl_Callback) as const Fl_Menu_Item ptr
	declare const function find_index(name as const zstring ptr) as long
	declare const function find_index(item as const Fl_Menu_Item ptr) as long
	declare const function find_index(cb as Fl_Callback) as long

	declare function test_shortcut() as const Fl_Menu_Item ptr
	declare sub global()

	declare const function menu() as const Fl_Menu_Item ptr
	declare sub menu(m as const Fl_Menu_Item ptr)
	declare sub copy(m as const Fl_Menu_Item ptr, user_data as any ptr=0)
	declare function insert(index as long, as const zstring ptr, shortcut as long, as Fl_Callback, as any ptr = 0, as long = 0) as long
	declare function add(as const zstring ptr, shortcut as long, as Fl_Callback, as any ptr = 0, as long = 0) as long
	declare function add(a as const zstring ptr, b as const zstring ptr, c as Fl_Callback, d as any ptr = 0, e as long = 0) as long
	declare function insert(index as long, a as const zstring ptr, b as const zstring ptr, c as Fl_Callback, d as any ptr = 0, e as long = 0) as long
	declare function add(as const zstring ptr) as long
	declare const function size() as long
	declare sub size(w as long, h as long)
	declare sub clear()
	declare function clear_submenu(index as long) as long
	declare sub replace(as long,as const zstring ptr)
	declare sub remove(as long)
	declare sub shortcut(i as long, s as long) 
	declare sub mode(i as long, fl as long) 
	declare const function mode(i as long) as long
	declare const function mvalue() as const Fl_Menu_Item ptr
	declare const function value() as long
	declare function value(as const Fl_Menu_Item ptr) as long
	declare function value(i as long) as long
	declare const function text() as const zstring ptr
	declare const function text(i as long) as const zstring ptr
	declare const function textfont() as Fl_Font
	declare sub textfont(c as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(c as Fl_Fontsize)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(c as Fl_Color)

	declare const function down_box() as Fl_Boxtype
	declare sub down_box(b as Fl_Boxtype)

	declare const function down_color() as Fl_Color
	declare sub down_color(c as unsigned long)
	declare sub setonly(item as Fl_Menu_Item ptr)

end type

end extern

private function Fl_Menu_.test_shortcut() as const Fl_Menu_Item ptr
	return picked(menu()->test_shortcut())
end function

private function Fl_Menu_.menu() as const Fl_Menu_Item ptr
	return menu_
end function

private function Fl_Menu_.add(a as const zstring ptr, b as const zstring ptr, c as Fl_Callback, d as any ptr =0, e as long =0) as long
	return add(a,fl_old_shortcut(b),c,d,e)
end function

private function Fl_Menu_.insert(index as long, a as const zstring ptr, b as const zstring ptr, c as Fl_Callback, d as any ptr = 0, e as long = 0) as long
	return insert(index, a,fl_old_shortcut(b),c,d,e)
end function

private sub Fl_Menu_.size(w as long, h as long)
	base.size(w,h)
end sub

private sub Fl_Menu_.shortcut(i as long, s as long)
	menu_[i].shortcut(s)
end sub

private sub Fl_Menu_.mode(i as long, fl as long)
	menu_[i].flags=fl
end sub

private function Fl_Menu_.mode(i as long) as long
	return menu_[i].flags
end function

private function Fl_Menu_.mvalue() as const Fl_Menu_Item ptr
	return value_
end function

private function Fl_Menu_.value() as long
	return iif(value_ , cast(long, value_-menu_) , -1)
end function

private function Fl_Menu_.value(i as long) as long
	return value(menu_+i)
end function

private function Fl_Menu_.text() as const zstring ptr
	return iif(value_ , value_->text , 0)
end function

private function Fl_Menu_.text(i as long) as const zstring ptr
	return menu_[i].text
end function

private function Fl_Menu_.textfont() as Fl_Font
	return textfont_
end function

private sub Fl_Menu_.textfont(c as Fl_Font)
	textfont_=c
end sub

private function Fl_Menu_.textsize() as Fl_Fontsize
	return textsize_
end function

private sub Fl_Menu_.textsize(c as Fl_Fontsize)
	textsize_=c
end sub

private function Fl_Menu_.textcolor() as Fl_Color
	return textcolor_
end function

private sub Fl_Menu_.textcolor(c as Fl_Color)
	textcolor_=c
end sub

private function Fl_Menu_.down_box() as Fl_Boxtype
	return down_box_
end function

private sub Fl_Menu_.down_box(b as Fl_Boxtype)
	down_box_=b
end sub

private function Fl_Menu_.down_color() as Fl_Color
	return selection_color()
end function

private sub Fl_Menu_.down_color(c as unsigned long)
	selection_color(c)
end sub


