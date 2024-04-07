#include once "Fl_Menu_Bar.bi"


#ifdef __FB_APPLE__
extern "c++"
type Fl_Sys_Menu_Bar extends Fl_Menu_Bar
protected:
	declare constructor (byref b as const Fl_Sys_Menu_Bar)
	declare operator let (byref b as const Fl_Sys_Menu_Bar)
	declare sub update()
	declare sub draw()
public:
	declare constructor(x as long, y as long, w as long, h as long, l as const zstring ptr=0)
	declare destructor()

	declare const function menu() as const Fl_Menu_Item ptr
	declare sub menu(m as const Fl_Menu_Item ptr)

	declare function add(label as const zstring ptr, shortcut as long, as Fl_Callback ptr, user_data as any ptr=0, flags as long=0) as long
	declare function add(label as const zstring ptr, shortcut as const zstring ptr, cb as Fl_Callback ptr, user_data as any ptr=0, flags as long=0) as long
	declare function add(str_ as const zstring ptr) as long
	declare function insert(index as long, label as const zstring ptr, shortcut as long, b as Fl_Callback ptr, user_data as any ptr=0, flags as long=0) as long
	declare function insert(index as long, label as const zstring ptr, shortcut as const zstring ptr, cb as Fl_Callback ptr, user_data as any ptr=0, flags as long=0) as long
	declare sub remove(n as long)
	declare sub replace(index as long, name as const zstring ptr)
	declare sub clear()
	declare function clear_submenu(index as long) as long
	declare sub global() 
	declare sub mode (i as long, fl as long)
	declare const function mode(i as long) as long
	declare sub shortcut (i as long, s as long)
	declare sub setonly (item as Fl_Menu_Item ptr)
'/
end type
end extern

private function Fl_Sys_Menu_Bar.menu() as const Fl_Menu_Item ptr
	return base.base.menu()
end function

private function Fl_Sys_Menu_Bar.add(label as const zstring ptr, shortcut__ as const zstring ptr, cb as Fl_Callback ptr, user_data as any ptr=0, flags as long=0) as long
	return add(label, fl_old_shortcut(shortcut__), cb, user_data, flags)
end function

private function Fl_Sys_Menu_Bar.insert(index as long, label as const zstring ptr, shortcut__ as const zstring ptr, cb as Fl_Callback ptr, user_data as any ptr=0, flags as long=0) as long
	return insert(index, label, fl_old_shortcut(shortcut__), cb, user_data, flags)
end function

private sub Fl_Sys_Menu_Bar.global()
end sub

private sub Fl_Sys_Menu_Bar.mode (i as long, fl as long)
	base.base.mode(i, fl)
	update()
end sub

private function Fl_Sys_Menu_Bar.mode(i as long) as long
	return base.base.mode(i)
end function

private sub Fl_Sys_Menu_Bar.shortcut (i as long, s as long)
	base.base.shortcut(i, s)
	update()
end sub

private sub Fl_Sys_Menu_Bar.setonly (item as Fl_Menu_Item ptr)
	base.base.setonly(item)
	update()
end sub

#else
type Fl_Sys_Menu_Bar as Fl_Menu_Bar
#endif