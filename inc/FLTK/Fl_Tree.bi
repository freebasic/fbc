#include once "Fl.bi"
#include once "Fl_Group.bi"
#include once "Fl_Scrollbar.bi"
#include once "fl_draw.bi"

#include once "Fl_Tree_Item.bi"
#include once "Fl_Tree_Prefs.bi"

enum Fl_Tree_Reason 
	FL_TREE_REASON_NONE=0
	FL_TREE_REASON_SELECTED
	FL_TREE_REASON_DESELECTED
	FL_TREE_REASON_OPENED
	FL_TREE_REASON_CLOSED
	FL_TREE_REASON_DRAGGED	
end enum

type Fl_Preferences_ as Fl_Preferences

extern "c++"

type Fl_Tree extends Fl_Group
private:
	_root as Fl_Tree_Item ptr
	_item_focus as Fl_Tree_Item ptr
	_callback_item as Fl_Tree_Item ptr
	_callback_reason as Fl_Tree_Reason
	_prefs as Fl_Tree_Prefs
	_scrollbar_size as long

	declare sub fix_scrollbar_order()

protected:
	_vscroll as Fl_Scrollbar ptr

	declare sub item_clicked(val_ as Fl_Tree_Item ptr)
	declare sub do_callback_for_item(item as Fl_Tree_Item ptr, reason as Fl_Tree_Reason)

	declare function next_visible_item(start as Fl_Tree_Item ptr, dir_ as long) as Fl_Tree_Item ptr
	declare sub extend_selection(from as Fl_Tree_Item ptr, to_ as Fl_Tree_Item ptr)
	declare function draw_tree() as long


	declare constructor (byref o as const Fl_Tree)
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
	declare destructor
	declare function handle(e as long) as long
	declare sub draw()
	declare sub show_self()
	declare sub resize( as long, as long, as long, as long)

	declare sub root_label(new_label as const zstring ptr)
	declare function root() as Fl_Tree_Item ptr
	declare sub root(newitem as Fl_Tree_Item ptr)
 	declare const function prefs() byref as const Fl_Tree_Prefs 

	declare function add(path as const zstring ptr) as Fl_Tree_Item ptr
	declare function add(path as const zstring ptr, newitem as  Fl_Tree_Item ptr) as Fl_Tree_Item

	declare function add(parent_item as Fl_Tree_Item ptr, name as const zstring ptr) as Fl_Tree_Item ptr
	declare function insert_above(above as Fl_Tree_Item ptr, name as const zstring ptr) as Fl_Tree_Item ptr
	declare function insert(item as Fl_Tree_Item ptr, name as const zstring ptr, pos_ as long) as Fl_Tree_Item ptr
	declare function remove(item as Fl_Tree_Item ptr) as long
	declare sub clear()
	declare sub clear_children(item as Fl_Tree_Item ptr)

	declare function find_item(path as const zstring ptr) as Fl_Tree_Item ptr
	'declare const function find_item(path as const zstring ptr) as const Fl_Tree_Item ptr
	declare const function item_pathname(pathname as zstring ptr, pathnamelen as long, item as const Fl_Tree_Item ptr) as long
	'declare const function find_clicked() as const Fl_Tree_Item ptr
	declare function find_clicked() as Fl_Tree_Item ptr

	declare function item_clicked() as Fl_Tree_Item ptr
	declare function first() as Fl_Tree_Item ptr
	declare function first_visible() as Fl_Tree_Item ptr
	declare function first_visible_item() as Fl_Tree_Item ptr
	declare function next_ alias "next"(item as Fl_Tree_Item ptr=0) as Fl_Tree_Item ptr
	declare function prev(item as Fl_Tree_Item ptr=0) as Fl_Tree_Item ptr
	declare function last() as Fl_Tree_Item ptr
	declare function last_visible() as Fl_Tree_Item ptr
	declare function last_visible_item() as Fl_Tree_Item ptr

	declare function first_selected_item() as Fl_Tree_Item ptr
	declare function last_selected_item() as Fl_Tree_Item ptr
	declare function next_item(item as Fl_Tree_Item ptr, dir as long=&Hff54, visible as boolean=false) as Fl_Tree_Item ptr
	declare function next_selected_item(item as Fl_Tree_Item ptr=0) as Fl_Tree_Item ptr
	declare function next_selected_item(item as Fl_Tree_Item ptr, dir as long) as Fl_Tree_Item ptr

	declare function open_ alias "open" (item as Fl_Tree_Item ptr, docallback as long=1) as long
	declare function open_ alias "open" (path as const zstring ptr, docallback as long=1) as long
	declare sub open_toggle(item as Fl_Tree_Item ptr, docallback as long=1)
	declare function close_ alias "close"(item as Fl_Tree_Item ptr, docallback as long=1) as long
	declare function close_ alias "close"(path as const zstring ptr, docallback as long=1) as long
	declare const function is_open(item as Fl_Tree_Item ptr) as long
	declare const function is_open(path as const zstring ptr) as long
	declare const function is_close(item as Fl_Tree_Item ptr) as long
	declare const function is_close(path as const zstring ptr) as long

	declare function select_ alias "select"(item as Fl_Tree_Item ptr, docallback as long=1) as long
	declare function select_ alias "select"(path as const zstring ptr, docallback as long=1) as long
	declare sub select_toggle(item as Fl_Tree_Item ptr, docallback as long=1)
	declare function deselect(item as Fl_Tree_Item ptr, docallback as long=1) as long
	declare function deselect(path as const zstring ptr, docallback as long=1) as long
	declare function deselect_all(item as Fl_Tree_Item ptr=0, docallback as long=1) as long
	declare function select_only(selitem as Fl_Tree_Item ptr, docallback as long=1) as long
	declare function select_all(item as Fl_Tree_Item ptr=0, docallback as long=1) as long
	declare function extend_selection_dir(from as Fl_Tree_Item ptr, to_ as Fl_Tree_Item ptr, dir as long, val_ as long, visible as boolean) as long
private:
	declare function extend_selection__(from as Fl_Tree_Item ptr, to_ as Fl_Tree_Item ptr, val_ as long, visible as boolean) as long
public:
	declare sub set_item_focus(item as Fl_Tree_Item ptr)
	declare const function get_item_focus() as Fl_Tree_Item ptr
	declare const function is_selected(item as Fl_Tree_Item ptr) as long
	declare function is_selected(path as const zstring ptr) as long

	declare const function item_labelfont() as Fl_Font
	declare sub item_labelfont(val_ as Fl_Font)
	declare const function item_labelsize() as Fl_Fontsize
	declare sub item_labelsize(val_ as Fl_Fontsize)
	declare const function item_labelfgcolor() as  Fl_Color
	declare sub item_labelfgcolor(val_ as Fl_Color)
	declare const function item_labelbgcolor() as Fl_Color
	declare sub item_labelbgcolor(val_ as Fl_Color)
	declare const function connectorcolor() as Fl_Color
	declare sub connectorcolor(val_ as Fl_Color)
	declare const function marginleft() as long
	declare sub marginleft(val_ as long)
	declare const function margintop() as long
	declare sub margintop(val_ as long)
	declare const function linespacing() as long
	declare sub linespacing(val as long)
	declare const function openchild_marginbottom() as long
	declare sub openchild_marginbottom(val_ as long)
	declare const function usericonmarginleft() as long
	declare sub usericonmarginleft(val_ as long)
	declare const function labelmarginleft() as long
	declare sub labelmarginleft(val_ as long)
	declare const function connectorwidth() as long
	declare sub connectorwidth(val_ as long)
	declare const function usericon() as Fl_Image ptr
	declare sub usericon(val_ as Fl_Image ptr)
	declare const function openicon() as Fl_Image ptr
	declare sub openicon(val_ as Fl_Image ptr)
	declare const function closeicon() as Fl_Image ptr
	declare sub closeicon(val_ as Fl_Image ptr)
	declare const function showcollapse() as long
	declare sub showcollapse(val_ as long)
	declare const function showroot() as long
	declare sub showroot(val_ as long)
	declare const function connectorstyle() as Fl_Tree_Connector
	declare sub connectorstyle(val_ as Fl_Tree_Connector)
	declare const function sortorder() as Fl_Tree_Sort
	declare sub sortorder(val_ as Fl_Tree_Sort)
	declare const function selectbox() as Fl_Boxtype
	declare sub selectbox(val_ as Fl_Boxtype)
	declare const function selectmode() as Fl_Tree_Select
	declare sub selectmode(val_ as Fl_Tree_Select)

	declare sub recalc_tree()
	declare function displayed(item as Fl_Tree_Item ptr) as long
	declare sub show_item(item as Fl_Tree_Item ptr, yoff as long)
	declare sub show_item(item as Fl_Tree_Item ptr)
	declare sub show_item_top(item as Fl_Tree_Item ptr)
	declare sub show_item_middle(item as Fl_Tree_Item ptr)
	declare sub show_item_bottom(item as Fl_Tree_Item ptr)
	declare sub display(item as Fl_Tree_Item ptr)
	declare const function vposition() as long
	declare sub vposition(pos_ as long)
	declare const function hposition() as long
	declare sub hposition(pos_ as long)

	declare function is_scrollbar(w as Fl_Widget ptr) as long
	declare const function scrollbar_size() as long
	declare sub scrollbar_size(size as long)
	declare const function is_vscroll_visible() as long
	declare const function is_hscroll_visible() as long

	declare sub callback_item(item as Fl_Tree_Item ptr)
	declare function callback_item() as Fl_Tree_Item ptr
	declare sub callback_reason(reason as Fl_Tree_Reason)
	declare const function callback_reason() as Fl_Tree_Reason

	declare sub load(byref p as Fl_Preferences_)
end type

end extern

private function Fl_Tree.prefs() byref as const Fl_Tree_Prefs 
	return prefs
end function

