#include once "Fl.bi"

type Fl_Tree_Item_ as Fl_Tree_Item

extern "c++"

type Fl_Tree_Item_Array
private:
	_items as Fl_Tree_Item_ ptr ptr
	_total as long
	_size as long
	_chunksize as long
	enum 			
		MANAGE_ITEM = 1
	end enum
	_flags as ubyte
	declare sub enlarge(count as long)
public:
	declare constructor (new_chunksize as long= 10)
	declare destructor()
	declare constructor (o as const Fl_Tree_Item_Array ptr)

	declare operator [](i as long) as Fl_Tree_Item_ ptr
	declare const function total() as long
	declare sub swap_ (ax as long, bx as long)
	declare function move(to_ as long, from as long) as long
	declare function deparent(pos_ as long) as long
	declare function reparent(item as Fl_Tree_Item_ ptr, newparent as Fl_Tree_Item_ ptr, pos_ as long) as long
	declare sub clear()
	declare sub add(val_ as Fl_Tree_Item_ ptr)
	declare sub insert(pos_ as long, new_item as Fl_Tree_Item_ ptr)
	declare sub replace(pos_ as long, new_item as Fl_Tree_Item_ ptr)
	declare sub remove (index as long)
	declare function remove (item as Fl_Tree_Item_ ptr) as long

	declare sub manage_item_destroy(val_ as long)
	declare function manage_item_destroy() as long
end type

end extern

private operator Fl_Tree_Item_Array.[] (i as long) as Fl_Tree_Item_ ptr
	return(_items[i])
end operator

private function Fl_Tree_Item_Array.total() as long
	return _total
end function

private sub Fl_Tree_Item_Array.swap_ (ax as long, bx as long)
	dim asave as Fl_Tree_Item_ ptr = _items[ax]
	_items[ax] = _items[bx]
	_items[bx] = asave
end sub

private sub Fl_Tree_Item_Array.manage_item_destroy(val_ as long)
	if ( val_<>0 ) then _flags or= MANAGE_ITEM else _flags and= not MANAGE_ITEM
end sub

private function Fl_Tree_Item_Array.manage_item_destroy() as long
	return iif(_flags and MANAGE_ITEM , 1 , 0)
end function

