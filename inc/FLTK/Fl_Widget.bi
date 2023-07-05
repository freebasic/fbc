type Fl_Image_ as Fl_Image
type Fl_Font_ as Fl_Font
type Fl_Window_ as Fl_Window
type Fl_Gl_Window_ as Fl_Gl_Window
type Fl_Widget_ as Fl_Widget
type Fl_Group_ as Fl_Group



extern "c++"

type Fl_Widget_ as Fl_Widget
type Fl_Callback as sub(as Fl_Widget_ ptr, as any ptr)
type Fl_Callback0 as sub(as Fl_Widget_ ptr)
type Fl_Callback1 as sub(as Fl_Widget_ ptr, as integer)

type Fl_Label 
	value as const zstring ptr

	image as Fl_Image_ ptr
	deimage as Fl_Image_ ptr
	font as Fl_Font
	size as Fl_Fontsize
	color as Fl_Color
	align_ as Fl_Align
	type_ as ubyte

	declare const sub draw(x as long, y as long, w as long, h as long, Fl_Align as ulong)
	declare const sub measure(byref w as long, byref h as long)
end type

type Fl_Widget extends object
protected:
	parent_ as Fl_Group_ ptr
	callback_ as Fl_Callback
	user_data_ as any ptr
  	as long x_,y_,w_,h_
	label_ as Fl_Label
	flags_ as ulong
	color_ as Fl_Color
	color2_ as Fl_Color
	type__ as ubyte
	damage_ as ubyte
	box_ as ubyte
	when_ as ubyte

	tooltip_ as zstring ptr

	declare constructor (byref w as const Fl_Widget)
	declare operator let (byref w as const Fl_Widget)
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr)

	declare sub x(v as long)
	declare sub y(v as long)
	declare sub w(v as long)
	declare sub h(v as long)
	declare const function flags() as unsigned long
	declare sub set_flag(c as unsigned long)
	declare sub clear_flag(c as unsigned long)

	enum
		INACTIVE_       = 1 shl 0
		INVISIBLE_      = 1 shl 1
		OUTPUT__        = 1 shl 2
		NOBORDER_       = 1 shl 3
		FORCE_POSITION_ = 1 shl 4
		NON_MODAL_      = 1 shl 5
		SHORTCUT_LABEL_ = 1 shl 6
		CHANGED_        = 1 shl 7
		OVERRIDE_       = 1 shl 8
		VISIBLE_FOCUS_  = 1 shl 9
		COPIED_LABEL_   = 1 shl 10
		CLIP_CHILDREN_  = 1 shl 11
		MENU_WINDOW_    = 1 shl 12
		TOOLTIP_WINDOW_ = 1 shl 13
		MODAL_          = 1 shl 14
		NO_OVERLAY_     = 1 shl 15
		GROUP_RELATIVE_ = 1 shl 16
		COPIED_TOOLTIP_ = 1 shl 17
		FULLSCREEN_     = 1 shl 18
		MAC_USE_ACCENTS_MENU_= 1 shl 19

		USERFLAG3_      = 1 shl 29
		USERFLAG2_      = 1 shl 30
		USERFLAG1_      = 1 shl 31
	end enum

	declare const sub draw_box()
	declare const sub draw_box(t as Fl_Boxtype, c as ulong)
	declare const sub draw_box(t as Fl_Boxtype, x as long, y as long, w as long, h as long, c as ulong)
	declare const sub draw_backdrop() 
	declare const sub draw_focus()
	declare const sub draw_focus(t as Fl_Boxtype, x as long, y as long, w as long, h as long)
	declare const sub draw_label() 
	declare const sub draw_label(x as long, y as long, w as long, h as long) 


public:

	declare virtual destructor
	declare abstract sub draw()
	declare virtual function handle(event as long) as long

	declare const function is_label_copied() as long
	declare const function parent() as Fl_Group_ ptr
	declare sub parent(p as Fl_Group_ ptr)

	declare const function type_() as ubyte
	declare sub type_(t as ubyte)

	declare const function x() as long
	declare const function y() as long
	declare const function w() as long
	declare const function h() as long

	declare virtual sub resize(x as long, y as long, w as long, h as long)
	declare sub position(x as long, y as long)
	declare sub size(w as long, h as long)

	declare const function align() as Fl_Align
	declare sub align(alignment as Fl_Align)

	declare const function box() as Fl_Boxtype
	declare sub box(new_box as Fl_Boxtype)

	declare const function Color() as Fl_Color
	declare sub Color(new_color as Fl_Color)

	declare const function selection_Color() as Fl_Color
	declare sub selection_Color(new_color as Fl_Color)

	declare sub Color(bg as Fl_Color, sel as Fl_Color)

	declare const function label() as const zstring ptr
	declare sub label(text as const zstring ptr)
	declare sub copy_label(new_label as const zstring ptr)
	declare sub label(a as Fl_Labeltype, b as const zstring ptr)
	declare const function labeltype() as Fl_Labeltype
	declare sub labeltype(t as Fl_Labeltype)
	declare const function labelcolor() as Fl_Color
	declare sub labelcolor(c as Fl_Color)
	declare const function labelfont() as Fl_Font
	declare sub labelfont(f as Fl_Font)
	declare const function labelsize() as Fl_Fontsize
	declare sub labelsize(f as Fl_Fontsize)
	declare function image() as Fl_Image_ ptr
	declare sub image(img as Fl_Image_ ptr)
	declare function deimage() as Fl_Image_ ptr
	declare sub deimage(img as Fl_Image_ ptr)

	declare const function tooltip() as const zstring ptr

	declare sub tooltip(text as const zstring ptr)
	declare sub copy_tooltip(text as const zstring ptr)

	declare const function callback() as Fl_Callback
	declare sub callback(cb as Fl_Callback, p as any ptr )
	declare sub callback(cb as Fl_Callback )
	declare sub callback(cb as Fl_Callback0 )
	declare sub callback(cb as Fl_Callback1, p as integer=0 )
	declare const function user_data() as any ptr
	declare sub user_data(v as any ptr)
	declare const function argument() as integer
	declare sub argument(v as integer)

	declare const function when() as const Fl_When
	declare sub when(i as ubyte)

	declare const function visible() as ulong
	declare const function visible_r() as long

	declare virtual sub show()
	declare virtual sub hide()

	declare sub set_visible()
	declare sub clear_visible()

	declare const function active() as ulong
	declare const function active_r() as long

	declare sub activate()
	declare sub deactivate()

	declare const function output() as ulong
	declare sub set_output()
	declare sub clear_output()
	declare const function takesevents() as ulong
	declare const function changed() as ulong
	declare sub set_changed()
	declare sub clear_changed()
	declare sub set_active()
	declare sub clear_active()

	declare function take_focus() as long
	declare sub set_visible_focus()
	declare sub clear_visible_focus()
	declare sub visible_focus(v as long)
	declare function visible_focus() as ulong


	declare static sub default_callback(cb as Fl_Widget ptr, d as any ptr)

	declare sub do_callback()
	declare sub do_callback(o as Fl_Widget ptr, arg as integer)
	declare sub do_callback(o as Fl_Widget ptr, arg as any ptr=0)

	declare const function contains(w as const Fl_Widget ptr) as long
	declare const function inside(wgt as const Fl_Widget ptr) as long

	declare sub redraw()
	declare sub redraw_label()

	declare const function damage() as ubyte
	declare sub clear_damage(c as ubyte)

	declare sub damage(c as ubyte)
	declare sub damage(c as ubyte, x as long, y as long, w as long, h as long)

	declare const sub draw_label(x as long, y as long, w as long, h as long, Fl_Align as ulong)

	declare const sub measure_label(byref ww as long, byref hh as long) 

	declare const function window as Fl_Window_ ptr
	declare const function top_window() as Fl_Window_ ptr
	declare const function top_window_offset(byref xoff as long, byref yoff as long) as Fl_Window_ ptr

	declare virtual function as_group() as Fl_Group_ ptr
	declare virtual function as_window() as Fl_Window_ ptr
	declare virtual function as_gl_window() as Fl_Gl_Window_ ptr

	declare function use_accents_menu() as long
end type

end extern

private sub Fl_Widget.x(v as long)
	x_=v
end sub

private sub Fl_Widget.y(v as long)
	y_=v
end sub

private sub Fl_Widget.w(v as long)
	w_=v
end sub

private sub Fl_Widget.h(v as long)
	h_=v
end sub

private const function Fl_Widget.flags() as unsigned long
	return flags_
end function

private sub Fl_Widget.set_flag(c as unsigned long)
	flags_ or= c
end sub

private sub Fl_Widget.clear_flag(c as unsigned long)
	flags_ and= not c
end sub

private sub Fl_Widget.draw_focus()
	draw_focus(box(),x(),y(),w(),h())
end sub

private const function Fl_Widget.is_label_copied() as long
	if this.flags_ and (1 shl 10) then return 1 else return 0
end function

private const function Fl_Widget.parent() as Fl_Group_ ptr
	return this.parent_
end function

private sub Fl_Widget.parent(p as Fl_Group_ ptr)
	this.parent_=p
end sub

private const function Fl_Widget.type_() as ubyte
	return this.type__
end function

private sub Fl_Widget.type_(t as ubyte)
	this.type__=t
end sub

private const function Fl_Widget.x() as long
	return this.x_
end function

private const function Fl_Widget.y() as long
	return this.y_
end function

private const function Fl_Widget.w() as long
	return this.w_
end function

private const function Fl_Widget.h() as long
	return this.h_
end function

private sub Fl_Widget.position(x1 as long, y1 as long)
	this.resize(x1,y1, this.w_, this.h_)
end sub

private sub Fl_Widget.size(w1 as long, h1 as long)
	this.resize(this.x_, this.y_, w1, h1)
end sub

private function Fl_Widget.align() as Fl_Align
	return this.label_.align_
end function

private sub Fl_Widget.align(alignment as Fl_Align)
	this.label_.align_=alignment
end sub

private const function Fl_Widget.box() as Fl_Boxtype
	return this.box_
end function

private sub Fl_Widget.box(new_box as Fl_Boxtype)
	this.box_=new_box
end sub

private const function Fl_Widget.Color() as Fl_Color
	return this.color_
end function

private sub Fl_Widget.Color(new_color as Fl_Color)
	this.color_=new_color
end sub

private const function Fl_Widget.selection_Color() as Fl_Color
	return this.color2_
end function

private sub Fl_Widget.selection_Color(new_color as Fl_Color)
	this.color2_=new_color
end sub

private sub Fl_Widget.Color(a as Fl_Color, b as Fl_Color)
	this.color_=a
	this.color2_=b
end sub

private const function Fl_Widget.label() as const zstring ptr
	return this.label_.value
end function

private sub Fl_Widget.label(a as Fl_Labeltype, b as const zstring ptr)
	this.label_.type_=a
	this.label_.value=b
end sub

private const function Fl_Widget.labeltype() as Fl_Labeltype
	return this.label_.type_
end function

private sub Fl_Widget.labeltype(a as Fl_Labeltype)
	this.label_.type_=a
end sub

private const function Fl_Widget.labelcolor() as Fl_Color
	return this.label_.color
end function

private sub Fl_Widget.labelcolor(c as Fl_Color)
	this.label_.color=c
end sub

private const function Fl_Widget.labelfont() as long
	return this.label_.font
end function

private sub Fl_Widget.labelfont(f as long)
	this.label_.font=f
end sub

private const function Fl_Widget.labelsize() as long
	return this.label_.size
end function

private sub Fl_Widget.labelsize(s as long)
	this.label_.size=s
end sub

private function Fl_Widget.image() as Fl_Image_ ptr
	return this.label_.image
end function

private sub Fl_Widget.image(img as Fl_image_ ptr)
	this.label_.image=img
end sub

private function Fl_Widget.deimage() as Fl_Image_ ptr
	return this.label_.deimage
end function

private sub Fl_Widget.deimage(img as Fl_image_ ptr)
	this.label_.deimage=img
end sub

private const function Fl_Widget.tooltip() as const zstring ptr
	return this.tooltip_
end function

private const function Fl_Widget.callback() as Fl_Callback
	return this.callback_
end function

private sub Fl_Widget.callback(cb as Fl_Callback, p as any ptr )
	this.callback_=cb
	this.user_data_=p
end sub

private sub Fl_Widget.callback(cb as Fl_Callback )
	this.callback_=cb
end sub

private sub Fl_Widget.callback(cb as Fl_Callback0 )
	this.callback_=cast (Fl_Callback, cb)
end sub

private sub Fl_Widget.callback(cb as Fl_Callback1, p as integer )
	this.callback_=cast (Fl_Callback, cb)
	this.user_data_=cast(any ptr, p)
end sub

private const function Fl_Widget.user_data() as any ptr
	return this.user_data_
end function

private sub Fl_Widget.user_data(v as any ptr )
	this.user_data_=v
end sub

private const function Fl_Widget.argument() as integer
	return cast(integer, this.user_data_)
end function

private sub Fl_Widget.argument(v as integer )
	this.user_data_=cast (any ptr, v)
end sub

private const function Fl_Widget.when() as const Fl_When
	return this.when_
end function

private sub Fl_Widget.when(i as ubyte)
	this.when_=i
end sub

private const function Fl_Widget.visible() as ulong
	return (this.flags_ and 2)=0
end function

private sub Fl_Widget.set_visible()
	this.flags_ and= not 2
end sub

private sub Fl_Widget.clear_visible()
	this.flags_ or= 2
end sub

private const function Fl_Widget.active() as ulong
	return (this.flags_ and 1)=0
end function

private const function Fl_Widget.output() as ulong
	return this.flags_ and 4
end function

private sub Fl_Widget.set_output()
	this.flags_ or= 4
end sub

private sub Fl_Widget.clear_output()
	this.flags_ and= not 4
end sub

private const function Fl_Widget.takesevents() as ulong
	return (this.flags_ and (1 or 2 or 4))=0
end function

private const function Fl_Widget.changed() as ulong
	return this.flags_ and 128
end function

private sub Fl_Widget.set_changed()
	this.flags_ or= 128
end sub

private sub Fl_Widget.clear_changed()
	this.flags_ and= not 128
end sub

private sub Fl_Widget.set_active()
	this.flags_ and= not 1
end sub

private sub Fl_Widget.clear_active()
	this.flags_ or=  1
end sub

private sub Fl_Widget.set_visible_focus()
	this.flags_ or= 512
end sub

private sub Fl_Widget.clear_visible_focus()
	this.flags_ and= not 512
end sub

private sub Fl_Widget.visible_focus(v as long)
	if v then set_visible_focus() else clear_visible_focus()
end sub

private function Fl_Widget.visible_focus() as ulong
	return this.flags_ and 512
end function

private sub Fl_Widget.do_callback()
	this.do_callback(@this, user_data_)
end sub

private sub Fl_Widget.do_callback(o as Fl_Widget ptr, arg as integer)
	this.do_callback(o, cast(any ptr, arg))
	
end sub

private const function Fl_Widget.inside(wgt as const Fl_Widget ptr) as long
	return iif (wgt, wgt->contains(@this),0)
end function

private const function Fl_Widget.damage() as ubyte
	return this.damage_
end function

private sub Fl_Widget.clear_damage(c as ubyte)
	this.damage_=c
end sub

private const sub Fl_Widget.measure_label(byref ww as long, byref hh as long) 
	this.label_.measure(ww, hh)
end sub

private function Fl_Widget.as_group() as Fl_Group_ ptr
	return 0
end function

private function Fl_Widget.as_window() as Fl_Window_ ptr
	return 0
end function

private function Fl_Widget.as_gl_window() as Fl_Gl_Window_ ptr
	return 0
end function

private function Fl_Widget.use_accents_menu() as long
	return this.flags_ and (1 shl 19)
end function
