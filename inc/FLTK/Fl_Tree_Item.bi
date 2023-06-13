#include once "Fl.bi"
#include once "Fl_Widget.bi"
#include once "Fl_Image.bi"
#include once "fl_draw.bi"

#include once "Fl_Tree_Item_Array.bi"
#include once "Fl_Tree_Prefs.bi"

type Fl_Tree_ as Fl_Tree

extern "c++"

type Fl_Tree_Item
private:
	_label as const zstring ptr
	_labelfont as Fl_Font
	_labelsize as Fl_Fontsize
	_labelfgcolor as Fl_Color
	_labelbgcolor as Fl_Color

	enum
		OPEN		= 1 shl 0
		VISIBLE_	= 1 shl 1
		ACTIVE		= 1 shl 2
		SELECTED	= 1 shl 3
	end enum

	_open as byte
	_visible as byte
	_active as byte
	_selected as byte

	_xywh(3) as long
	_collapse_xywh(3) as long
	_label_xywh(3) as long
	_widget as Fl_Widget ptr
	_usericon as Fl_Image ptr

	 _children as Fl_Tree_Item_Array
	_parent as Fl_Tree_Item ptr
	_userdata as any ptr

protected:
	declare sub _Init(byref prefs as const Fl_Tree_Prefs, tree as Fl_Tree_ ptr)
	declare sub show_widgets()
	declare sub hide_widgets()
	declare sub draw_vertical_connector(x as long, y1 as long, y2 as long, byref prefs as const Fl_Tree_Prefs)
	declare sub draw_horizontal_connector(x1 as long, x2 as long, y as long, byref prefs as const Fl_Tree_Prefs)
	declare sub recalc_tree()
	declare const function calc_item_height(byref prefs as const Fl_Tree_Prefs) as long

public:
	declare constructor (byref prefs as const Fl_Tree_Prefs)
	declare destructor
	declare constructor (o as const Fl_Tree_Item ptr)

	declare function x() as long
	declare function y() as long
	declare function w() as long
	declare function h() as long
	declare function label_x() as long
	declare function label_y() as long
	declare function label_w() as long
	declare function label_h() as long

	declare sub draw(X as long, byref Y as long, W as long, tree as Fl_Widget ptr, itemfocus as Fl_Tree_Item ptr, byref prefs as const Fl_Tree_Prefs , lastchild as long=1)

	declare const sub show_self(indent as const zstring ptr =@"") 

	declare sub label(val_ as const zstring ptr)
	declare const function label() as const zstring ptr

	declare sub user_data( data_ as any ptr )
	declare const function user_data() as any ptr
	declare sub labelfont(val_ as Fl_Font)
	declare const function labelfont() as Fl_Font
	declare sub labelsize(val_ as Fl_Fontsize)
	declare const function labelsize() as Fl_Fontsize
	declare sub labelfgcolor(val_ as Fl_Color)
	declare const function labelfgcolor() as Fl_Color
	declare sub labelcolor(val_ as Fl_Color)
	declare const function labelcolor() as Fl_Color
	declare sub labelbgcolor(val_ as Fl_Color)
	declare const function labelbgcolor() as Fl_Color
	declare sub widget(val_ as Fl_Widget ptr)
	declare const function widget() as Fl_Widget ptr
	declare const function children() as long
	declare function child(index as long) as Fl_Tree_Item ptr
	'declare const function child(t as long) as const Fl_Tree_Item ptr
	declare const function has_children() as long

	declare function find_child(name as const zstring ptr) as long
	declare function find_child(item as Fl_Tree_Item ptr) as long
	declare function remove_child(item as Fl_Tree_Item ptr) as long
	declare function remove_child(new_label as const zstring ptr) as long
	declare sub clear_children()
	declare sub swap_children(ax as long, bx as long)
	declare function swap_children(a as Fl_Tree_Item ptr, b as Fl_Tree_Item ptr) as long
	'declare const function find_child_item(name as const zstring ptr) as const Fl_Tree_Item ptr
	declare function find_child_item(name as const zstring ptr) as Fl_Tree_Item ptr
	'declare const function find_child_item(arr as zstring ptr ptr) as const Fl_Tree_Item ptr
	declare function find_child_item(arr as zstring ptr ptr) as Fl_Tree_Item ptr
	'declare const function find_item(arr as zstring ptr ptr) as const Fl_Tree_Item ptr
	declare function find_item(arr as zstring ptr ptr) as Fl_Tree_Item ptr

	declare function add(byref prefs as const Fl_Tree_Prefs, new_label as const zstring ptr, newitem as Fl_Tree_Item ptr) as Fl_Tree_Item ptr
	declare function add(byref prefs as const Fl_Tree_Prefs, new_label as const zstring ptr) as Fl_Tree_Item ptr
	declare function add(byref prefs as const Fl_Tree_Prefs, arr as zstring ptr ptr, newitem as Fl_Tree_Item ptr) as Fl_Tree_Item ptr
	declare function add(byref prefs as const Fl_Tree_Prefs, arr as zstring ptr ptr) as Fl_Tree_Item ptr

	declare function insert(byref prefs as const Fl_Tree_Prefs, new_label as const zstring ptr, pos_ as long=0) as Fl_Tree_Item ptr
	declare function insert_above(byref prefs as const Fl_Tree_Prefs, new_label as const zstring ptr) as Fl_Tree_Item ptr
	declare function deparent(index as long) as Fl_Tree_Item ptr
	declare function reparent(newchild as Fl_Tree_Item ptr, index as long) as long
	declare function move(to_ as long, from as long) as long
	declare function move(item as Fl_Tree_Item ptr, op as long=0, pos_ as long=0) as long
	declare function move_above(item as Fl_Tree_Item ptr) as long
	declare function move_below(item as Fl_Tree_Item ptr) as long
	declare function move_into(item as Fl_Tree_Item ptr, pos_ as long=0) as long
	declare const function depth() as long
	declare function prev() as Fl_Tree_Item ptr
	declare function next_ alias "next"() as Fl_Tree_Item ptr
	declare function next_sibling() as Fl_Tree_Item ptr
	declare function prev_sibling() as Fl_Tree_Item ptr
	declare sub update_prev_next(index as long)
	declare function next_displayed(byref prefs as Fl_Tree_Prefs) as Fl_Tree_Item ptr
	declare function prev_displayed(byref prefs as Fl_Tree_Prefs) as Fl_Tree_Item ptr
	declare function next_visible(byref prefs as Fl_Tree_Prefs) as Fl_Tree_Item ptr
	declare function prev_visible(byref prefs as Fl_Tree_Prefs) as Fl_Tree_Item ptr

	declare function parent() as Fl_Tree_Item ptr
	declare sub parent(val_ as Fl_Tree_Item ptr)

	declare sub open_ alias "open"()
	declare sub close_ alias "close"()
	declare const function is_open() as long
	declare const function is_close() as long
	declare sub open_toggle()
	declare sub select_(val_ as long=1)
	declare sub select_toggle()
	declare function select_all() as long
	declare sub deselect()
	declare function deselect_all() as long
	declare const function is_selected() as byte
	declare sub activate(val_ as long=1)
	declare sub deactivate()
	declare const function is_activated() as byte
	declare const function is_active() as byte
	declare const function visible() as long
	declare const function is_visible() as long
	declare const function visible_r() as long
	declare sub usericon(val_ as Fl_Image ptr)
	declare const function usericon() as Fl_Image ptr

	'declare const function  find_clicked(byref prefs as const Fl_Tree_Prefs) as const Fl_Tree_Item ptr
	declare function  find_clicked(byref prefs as const Fl_Tree_Prefs) as Fl_Tree_Item ptr
	declare const function event_on_collapse_icon(byref prefs as const Fl_Tree_Prefs) as long
	declare const function event_on_label(byref prefs as const Fl_Tree_Prefs) as long
	declare const function is_root() as long
protected:
	declare sub set_flag(flag as unsigned short, val_ as long)
	declare const function is_flag(flag as unsigned short) as long

end type

end extern

private function Fl_Tree_Item.x() as long
	return _xywh(0)
end function

private function Fl_Tree_Item.y() as long
	return _xywh(1)
end function

private function Fl_Tree_Item.w() as long
	return _xywh(2)
end function

private function Fl_Tree_Item.h() as long
	return _xywh(3)
end function

private function Fl_Tree_Item.label_x() as long
	return _label_xywh(0)
end function

private function Fl_Tree_Item.label_y() as long
	return _label_xywh(1)
end function

private function Fl_Tree_Item.label_w() as long
	return _label_xywh(2)
end function

private function Fl_Tree_Item.label_h() as long
	return _label_xywh(3)
end function

private sub Fl_Tree_Item.user_data(data_ as any ptr)
	_userdata=data_
end sub

private function Fl_Tree_Item.user_data() as any ptr
	return _userdata
end function

private sub Fl_Tree_Item.labelfont(val_ as Fl_Font)
	_labelfont=val_
	recalc_tree()
end sub

private function Fl_Tree_Item.labelfont() as Fl_Font
	return _labelfont
end function

private sub Fl_Tree_Item.labelsize(val_ as Fl_Fontsize)
	_labelsize=val_
	recalc_tree()
end sub

private function Fl_Tree_Item.labelsize() as Fl_Fontsize
	return _labelsize
end function

private sub Fl_Tree_Item.labelfgcolor(val_ as Fl_Color)
	_labelfgcolor=val_
end sub

private function Fl_Tree_Item.labelfgcolor() as Fl_Color
	return _labelfgcolor
end function

private sub Fl_Tree_Item.labelcolor(val_ as Fl_Color)
	_labelfgcolor=val_
end sub

private function Fl_Tree_Item.labelcolor() as Fl_Color
	return _labelfgcolor
end function

private sub Fl_Tree_Item.labelbgcolor(val_ as Fl_Color)
	_labelbgcolor=val_
end sub

private function Fl_Tree_Item.labelbgcolor() as Fl_Color
	return _labelbgcolor
end function

private sub Fl_Tree_Item.widget(val_ as Fl_Widget ptr)
	_widget=val_
	recalc_tree()
end sub

private function Fl_Tree_Item.widget() as Fl_Widget ptr
	return _widget
end function

private function Fl_Tree_Item.children() as long
	return _children.total()
end function

private function Fl_Tree_Item.child(index as long) as Fl_Tree_Item ptr
	return (_children[index])
end function

private function Fl_Tree_Item.has_children() as long
	return _children.total()
end function

private function Fl_Tree_Item.parent() as Fl_Tree_Item ptr
	return _parent
end function

private sub Fl_Tree_Item.parent(val_ as Fl_Tree_Item ptr)
	_parent=val_
end sub

private function Fl_Tree_Item.is_open() as long
	return (is_flag(OPEN))
end function

private function Fl_Tree_Item.is_close() as long
	return (iif(is_flag(OPEN),0,1))
end function

private sub Fl_Tree_Item.open_toggle() 
	if is_open() then close_() else open_()
end sub

private sub Fl_Tree_Item.select_(val_ as long) 
	set_flag(SELECTED, val_)
end sub

private sub Fl_Tree_Item.select_toggle() 
	if is_selected() then deselect() else select_()
end sub

private function Fl_Tree_Item.select_all() as long
	dim as integer count = 0
	if not is_selected() then
		select_()
		count+=1
	end if
	for t as long =0 to children()-1
		count += child(t)->select_all()
	next
	return(count)
end function

private sub Fl_Tree_Item.deselect()
	set_flag(SELECTED, 0)
end sub

private function Fl_Tree_Item.deselect_all() as long
	dim as integer count = 0
	if is_selected() then
		deselect()
		count+=1
	end if
	for t as long =0 to children()-1
		count += child(t)->deselect_all()
	next
	return(count)
end function

private function Fl_Tree_Item.is_selected() as byte
	return(is_flag(SELECTED))
end function

private sub Fl_Tree_Item.activate(val_ as long) 
	set_flag(ACTIVE,val_)
	if  _widget AndAlso val_ <> cast(long,_widget->active()) then
		if  val_ then
			_widget->activate()
		else
			_widget->deactivate()
      		endif
		_widget->redraw()
	end if
end sub

private sub Fl_Tree_Item.deactivate()
	activate(0)
end sub

private function Fl_Tree_Item.is_activated() as byte
	return(is_flag(ACTIVE))
end function

private function Fl_Tree_Item.is_active() as byte
	return(is_flag(ACTIVE))
end function

private function Fl_Tree_Item.visible() as long
	return(is_flag(VISIBLE_))
end function

private function Fl_Tree_Item.is_visible() as long
	return(is_flag(VISIBLE_))
end function

private sub Fl_Tree_Item.usericon(val_ as Fl_Image ptr)
	_usericon = val_
	recalc_tree()
end sub

private function Fl_Tree_Item.usericon() as Fl_Image ptr
	return _usericon 
end function

private function Fl_Tree_Item.is_root() as long
	return iif(_parent=0, 1,0)
end function

private sub Fl_Tree_Item.set_flag(flag as unsigned short, val_ as long)
	select case flag
	case OPEN
		 _open = val_
	case VISIBLE_
		_visible  = val_
	case ACTIVE
		_active   = val_
	case SELECTED
		_selected = val_
	end select
	
end sub

private function Fl_Tree_Item.is_flag(flag as unsigned short) as long
	select case flag
	case OPEN
		return iif(_open,1,0)
	case VISIBLE_
		return iif(_visible,1,0)
	case ACTIVE
		return iif(_active,1,0)
	case SELECTED
		return iif(_selected,1,0)
	case else
		return 0
	end select
end function

