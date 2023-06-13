#include once "Fl_Widget.bi"

extern "c++"

#ifndef fl_old_shortcut
declare function fl_old_shortcut(as const zstring ptr) as unsigned long
#endif

type Fl_Button extends Fl_Widget 
private:
	shortcut_ as long
	value_ as byte
	oldval as byte
	down_box_ as ubyte
protected:
	static key_release_tracker as any ptr

	declare constructor (byref b as const Fl_Button)
	declare operator let (byref b as const Fl_Button)

	declare virtual sub draw()
public:
	declare virtual function handle(h as long) as long

	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr)

	declare function value(v as long) as long
	declare const function value() as byte
	declare function set() as long
	declare function clear() as long
	declare sub setonly()
	declare const function shortcut() as long
	declare sub shortcut(s as long) 
	declare const function down_box() as Fl_Boxtype
	declare sub down_box(b as Fl_Boxtype)
	declare sub shortcut(s as const zstring ptr) 



end type
end extern

private const function Fl_Button.value() as byte
	return this.value_
end function

private function Fl_Button.set() as long
	return this.value(1)
end function

private function Fl_Button.clear() as long
	return this.value(0)
end function

private const function Fl_Button.shortcut() as long
	return this.shortcut_
end function

private sub Fl_Button.shortcut(s as long) 
	this.shortcut_=s
end sub

private const function Fl_Button.down_box() as Fl_Boxtype
	return cast (Fl_Boxtype, this.down_box_)
end function

private sub Fl_Button.down_box(b as Fl_Boxtype)
	this.down_box_=b
end sub

private sub Fl_Button.shortcut(s as const zstring ptr) 
	this.shortcut(fl_old_shortcut(s))
end sub
