#include once "Fl.bi"
#include once "Fl_Widget.bi"


extern "c++"

type Fl_Group_ as Fl_Group 

type Fl_Group extends Fl_Widget
private:
	array_ as Fl_Widget ptr ptr
	savedfocus_ as Fl_Widget ptr
	resizable_ as Fl_Widget ptr
	children_ as long
	sizes_ as long ptr	' remembered initial sizes of children

	declare function navigation(i as long) as long

	static current_ as Fl_Group_ ptr
protected:
	declare virtual sub draw()
	declare const sub draw_child(byref widget as Fl_Widget)
	declare sub draw_children()
	declare const sub draw_outside_label(byref widget as const Fl_Widget)
	declare const sub update_child(byref widget as Fl_Widget) 
	declare function sizes() as long ptr
	

public:
	declare constructor (byref w as const Fl_Group)
	declare operator let (byref w as const Fl_Group)
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare virtual destructor()

	declare virtual function handle(i as long) as long
	declare sub begin()
	declare sub end_ alias "end"()

	declare static function current() as Fl_Group_ ptr
	declare static sub current(g as Fl_Group_ ptr)

	declare const function children() as long
	declare const function child(n as long) as Fl_Widget ptr

	declare const function find(as const Fl_Widget ptr) as long
	declare const function find(byref f as const Fl_Widget) as long
	declare const function array() as Fl_Widget ptr const ptr

	declare virtual sub resize(x as long, y as long, x1 as long, y1 as long)

	declare sub add(byref w as Fl_Widget)
	declare sub add(w as Fl_Widget ptr)
	declare sub insert(byref w as Fl_Widget, i as long)
	declare sub insert(byref w as Fl_Widget, before as Fl_Widget ptr)
	declare sub remove(index as long)
	declare sub remove(byref w as Fl_Widget)
	declare sub remove(w as Fl_Widget ptr)
	declare sub clear()

	declare sub resizable(byref o as Fl_Widget)
	declare sub resizable(o as Fl_Widget ptr)
	declare function resizable() as Fl_Widget ptr
	declare sub add_resizable(byref o as Fl_Widget)

	declare sub init_sizes()
	declare sub clip_children(c as long)
	declare function clip_children() as long

	declare sub forms_end()

	declare virtual function as_group() as Fl_Group_ ptr

end type

type Fl_End extends object
	declare constructor ()
end type


end extern

private const function Fl_Group.children() as long
	return this.children_
end function

private const function Fl_Group.child(n as long) as Fl_Widget ptr
	return this.array()[n]
end function

private const function Fl_Group.find(byref o as const Fl_Widget) as long
	return find(@o)
end function

private sub Fl_Group.add(w as Fl_Widget ptr)
	this.add(*w)
end sub

private sub Fl_Group.insert(byref w as Fl_Widget, before as Fl_Widget ptr)
	this.insert(w, this.find(before))
end sub

private sub Fl_Group.remove(w as Fl_Widget ptr)
	this.remove(*w)
end sub

private sub Fl_Group.resizable(byref o as Fl_Widget)
	this.resizable_=@o
end sub

private sub Fl_Group.resizable(o as Fl_Widget ptr)
	this.resizable_=o
end sub

private function Fl_Group.resizable() as Fl_Widget ptr
	return this.resizable_
end function

private sub Fl_Group.add_resizable(byref o as Fl_Widget)
	this.resizable_=@o
	this.add(o)
end sub

private sub Fl_Group.clip_children(c as long)
	if c then this.flags_ or=2048 else this.flags_ and= not 2048
end sub

private function Fl_Group.clip_children() as long
	return (this.flags_ and 2048) <>0
end function

private function Fl_Group.as_group() as Fl_Group_ ptr
	return @this
end function

private constructor Fl_End
	Fl_Group.current()->end_()
end constructor
