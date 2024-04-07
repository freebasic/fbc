#include once "Fl_Widget.bi"
#include once "Fl_Image.bi"


enum
	FL_MENU_INACTIVE = 1
	FL_MENU_TOGGLE= 2
	FL_MENU_VALUE = 4
	FL_MENU_RADIO = 8
	FL_MENU_INVISIBLE = &H10
	FL_SUBMENU_POINTER = &H20
	FL_SUBMENU = &H40
	FL_MENU_DIVIDER = &H80
	FL_MENU_HORIZONTAL = &H100
end enum

extern "c++"
#ifndef fl_old_shortcut
declare function fl_old_shortcut(s as const zstring ptr) as unsigned long
#endif

type Fl_Menu__ as Fl_Menu_

type Fl_Menu_Item
	text as const zstring ptr
	shortcut_ as long
	callback_ as Fl_Callback
	user_data_ as any ptr
	flags as long
	labeltype_ as unsigned byte
	labelfont_ as Fl_Font
	labelsize_ as Fl_Fontsize
	labelcolor_ as Fl_Color

	declare const function next_ alias "next" (i as long=1) as const Fl_Menu_Item ptr
	declare const function first () as const Fl_Menu_Item ptr
	declare const function label() as const zstring ptr
	declare sub label(a as const zstring ptr)
	declare sub label(a as Fl_Labeltype, b as const zstring ptr)
	declare const function labeltype() as Fl_Labeltype
	declare const function labelcolor() as Fl_Color
	declare sub labelcolor(a as Fl_Color)
	declare const function labelfont() as Fl_Font
	declare sub labelfont(a as Fl_Font)
	declare const function labelsize() as Fl_Fontsize
	declare sub labelsize(a as Fl_Fontsize)
	declare const function callback() as Fl_Callback
	declare sub callback(cb as Fl_Callback, p as any ptr )
	declare sub callback(cb as Fl_Callback )
	declare sub callback(cb as Fl_Callback0 )
	declare sub callback(cb as Fl_Callback1, p as integer=0 )
	declare function user_data() as any ptr
	declare sub user_data(v as any ptr)
	declare const function argument() as integer
	declare sub argument(v as integer)
	declare const function shortcut() as long
	declare sub shortcut(v as long)
	declare const function submenu() as long
	declare const function checkbox() as long
	declare const function radio() as long
	declare const function value() as long
	declare sub set()
	declare sub clear()

	declare sub setonly()

	declare const function visible() as long
	declare sub show()
	declare sub hide()
	declare const function active() as long
	declare sub activate()
	declare sub deactivate()
	declare const function activevisible() as long

	declare sub image(a as Fl_Image ptr)
	declare sub image(byref a as Fl_Image)

	declare const function measure (h as long ptr, m as const Fl_Menu__ ptr) as long
	declare sub draw(x as long, y as long, w as long, h as long, m as const Fl_Menu__ ptr, t as long=0) 
	declare const function popup(X as long, Y as long, title as const zstring ptr=0, picked as const Fl_Menu_Item ptr=0, m as const Fl_Menu__ ptr=0) as Fl_Menu_Item ptr
	declare const function pulldown(X as long, Y as long, W as long, H as long, picked as const Fl_Menu_Item ptr=0, m as const Fl_Menu__ ptr=0, title as const Fl_Menu_Item ptr=0, menubar as long=0) as Fl_Menu_Item ptr

	declare const function test_shortcut() as Fl_Menu_Item ptr
	declare const function find_shortcut(ip as long ptr=0, require_alt as const boolean= false) as Fl_Menu_Item ptr

	declare sub do_callback (o as Fl_Widget ptr)
	declare sub do_callback (o as Fl_Widget ptr, arg as any ptr)
	declare sub do_callback (o as Fl_Widget ptr, arg as integer)

	declare const function checked() as long
	declare sub check()
	declare sub uncheck()

	declare function insert(as long, as const zstring ptr, as long, as Fl_Callback, as any ptr =0, as long =0) as long
	declare function add(as const zstring ptr, shortcut as long, as Fl_Callback, as any ptr =0, as long =0) as long
	declare function add(a as const zstring ptr, b as const zstring ptr, c as Fl_Callback, d as any ptr =0, e as long =0) as long
end type 

end extern

private function Fl_Menu_Item.first () as const Fl_Menu_Item ptr
	return next_(0)
end function

private function Fl_Menu_Item.label () as const zstring ptr
	return text
end function

private sub Fl_Menu_Item.label (a as const zstring ptr)
	text=a
end sub

private sub Fl_Menu_Item.label (a as Fl_Labeltype, b as const zstring ptr)
	labeltype_ =a
	text=b
end sub

private function Fl_Menu_Item.labeltype () as Fl_Labeltype
	return cast (Fl_Labeltype,labeltype_)
end function

private function Fl_Menu_Item.labelcolor () as Fl_Color
	return labelcolor_
end function

private sub Fl_Menu_Item.labelcolor (a as Fl_Color)
	labelcolor_=a
end sub

private function Fl_Menu_Item.labelfont () as Fl_Font
	return labelfont_
end function

private sub Fl_Menu_Item.labelfont (a as Fl_Font)
	labelfont_=a
end sub

private function Fl_Menu_Item.labelsize () as Fl_Fontsize
	return labelsize_
end function

private sub Fl_Menu_Item.labelsize (a as Fl_Fontsize)
	labelsize_=a
end sub

private function Fl_Menu_Item.callback() as Fl_Callback
	return callback_
end function

private sub Fl_Menu_Item.callback(cb as Fl_Callback, p as any ptr )
	callback_=cb
	user_data_=p
end sub

private sub Fl_Menu_Item.callback(cb as Fl_Callback )
	callback_=cb
end sub

private sub Fl_Menu_Item.callback(cb as Fl_Callback0 )
	callback_=cast (Fl_Callback, cb)
end sub

private sub Fl_Menu_Item.callback(cb as Fl_Callback1, p as integer )
	callback_=cast (Fl_Callback, cb)
	user_data_=cast(any ptr, p)
end sub

private function Fl_Menu_Item.user_data() as any ptr
	return user_data_
end function

private sub Fl_Menu_Item.user_data(v as any ptr )
	user_data_=v
end sub

private function Fl_Menu_Item.argument() as integer
	return cast(integer, user_data_)
end function

private sub Fl_Menu_Item.argument(v as integer )
	user_data_=cast (any ptr, v)
end sub

private function Fl_Menu_Item.shortcut() as long
	return shortcut_
end function

private sub Fl_Menu_Item.shortcut(v as long )
	shortcut_=v
end sub

private function Fl_Menu_Item.submenu() as long
	return flags and (FL_SUBMENU or FL_SUBMENU_POINTER)
end function

private function Fl_Menu_Item.checkbox() as long
	return flags and FL_MENU_TOGGLE
end function

private function Fl_Menu_Item.radio() as long
	return flags and FL_MENU_RADIO
end function

private function Fl_Menu_Item.value() as long
	return flags and FL_MENU_VALUE
end function

private sub Fl_Menu_Item.set()
	flags=flags or FL_MENU_VALUE
end sub

private sub Fl_Menu_Item.clear()
	flags=flags and not FL_MENU_VALUE
end sub

private function Fl_Menu_Item.visible() as long
	return (flags and FL_MENU_INVISIBLE)=0
end function

private sub Fl_Menu_Item.show()
	flags=flags and not FL_MENU_INVISIBLE
end sub

private sub Fl_Menu_Item.hide()
	flags=flags or FL_MENU_INVISIBLE
end sub

private function Fl_Menu_Item.active() as long
	return (flags and FL_MENU_INACTIVE)=0
end function

private sub Fl_Menu_Item.activate()
	flags=flags and not FL_MENU_INACTIVE
end sub

private sub Fl_Menu_Item.deactivate()
	flags=flags or FL_MENU_INACTIVE
end sub

private function Fl_Menu_Item.activevisible() as long
	return (flags and (FL_MENU_INACTIVE or FL_MENU_INVISIBLE))=0
end function

private sub Fl_Menu_Item.image(a as Fl_Image ptr)
	a->label(@this)
end sub

private sub Fl_Menu_Item.image(byref a as Fl_Image)
	a.label(@this)
end sub

private sub Fl_Menu_Item.do_callback(o as Fl_Widget ptr)
	callback_(o, user_data_)
end sub

private sub Fl_Menu_Item.do_callback(o as Fl_Widget ptr, arg as any ptr)
	callback_(o, arg)
end sub

private sub Fl_Menu_Item.do_callback(o as Fl_Widget ptr, arg as integer)
	callback_(o, cast(any ptr, arg))
end sub

private function Fl_Menu_Item.checked() as long
	return flags and FL_MENU_VALUE
end function

private sub Fl_Menu_Item.check()
	flags=flags or FL_MENU_VALUE
end sub

private sub Fl_Menu_Item.uncheck()
	flags=flags and not FL_MENU_VALUE
end sub

private function Fl_Menu_Item.add(a as const zstring ptr, b as const zstring ptr, c as Fl_Callback, d as any ptr =0, e as long =0) as long
	return add(a,fl_old_shortcut(b),c,d,e)
end function


