#include once "Fl.bi"

enum Fl_Tree_Sort 
  FL_TREE_SORT_NONE=0
  FL_TREE_SORT_ASCENDING=1
  FL_TREE_SORT_DESCENDING=2
end enum

enum Fl_Tree_Connector
  FL_TREE_CONNECTOR_NONE=0
  FL_TREE_CONNECTOR_DOTTED=1
  FL_TREE_CONNECTOR_SOLID=2
end enum


enum Fl_Tree_Select
  FL_TREE_SELECT_NONE=0
  FL_TREE_SELECT_SINGLE=1
  FL_TREE_SELECT_MULTI=2
  FL_TREE_SELECT_SINGLE_DRAGGABLE=3
end enum

enum Fl_Tree_Item_Reselect_Mode
  FL_TREE_SELECTABLE_ONCE=0
  FL_TREE_SELECTABLE_ALWAYS
end enum

enum Fl_Tree_Item_Draw_Mode
  FL_TREE_ITEM_DRAW_DEFAULT=0
  FL_TREE_ITEM_DRAW_LABEL_AND_WIDGET=1
  FL_TREE_ITEM_HEIGHT_FROM_WIDGET=2	
end enum

type Fl_Tree_Item_ as Fl_Tree_Item

extern "c++"
type Fl_Tree_Prefs
private:
	_labelfont as Fl_Font
	_labelsize as Fl_Fontsize
	_margintop as long
	_marginleft as long
	'_marginbottom as long
	_openchild_marginbottom as long
	_usericonmarginleft as long
	_labelmarginleft as long
	'_widgetmarginleft as long
	_connectorwidth as long
	_linespacing as long

	_labelfgcolor as Fl_Color 
	_labelbgcolor as Fl_Color 
	_connectorcolor as Fl_Color 
	_connectorstyle as long'Fl_Tree_Connector 
	_openimage as Fl_Image ptr
	_closeimage as Fl_Image ptr
	_userimage as Fl_Image ptr

	'_opendeimage as Fl_Image ptr
	'_closedeimage as Fl_Image ptr
	'_userdeimage as Fl_Image ptr
	_showcollapse as byte
	_showroot as byte
	_sortorder as  long'Fl_Tree_Sort
	_selectbox as Fl_Boxtype
	_selectmode as long'Fl_Tree_Select
	'_itemreselectmode as  long'Fl_Tree_Item_Reselect_Mode
	'_itemdrawmode as long'Fl_Tree_Item_Draw_Mode
	'_itemdrawcallback as Fl_Tree_Item_Draw_Callback ptr
	'_itemdrawuserdata as any ptr
public:
	declare constructor()
	'declare destructor()

	declare function item_labelfont() as Fl_Font
	declare sub item_labelfont(val_ as Fl_Font)
	declare function item_labelsize() as Fl_Fontsize
	declare sub item_labelsize(val_ as Fl_Fontsize)
	declare function item_labelfgcolor() as Fl_Color
	declare sub item_labelfgcolor(val_ as Fl_Color)
	declare function item_labelbgcolor() as Fl_Color
	declare sub item_labelbgcolor(val_ as Fl_Color)

	declare function labelfont() as Fl_Font
	declare sub labelfont(val_ as Fl_Font)
	declare function labelsize() as Fl_Fontsize
	declare sub labelsize(val_ as Fl_Fontsize)
	declare function labelfgcolor() as Fl_Color
	declare sub labelfgcolor(val_ as Fl_Color)
	declare function labelbgcolor() as Fl_Color
	declare sub labelbgcolor(val_ as Fl_Color)

	declare function marginleft() as long
	declare sub marginleft(val_ as long)
	declare function margintop() as long
	declare sub margintop(val_ as long)
	'declare function marginbottom() as long
	'declare sub marginbottom(val_ as long)
	declare function openchild_marginbottom() as long
	declare sub openchild_marginbottom(val_ as long)
	declare function usericonmarginleft() as long
	declare sub usericonmarginleft(val_ as long)
	declare function labelmarginleft() as long
	declare sub labelmarginleft(val_ as long)
	'declare function widgetmarginleft() as long
	'declare sub widgetmarginleft(val_ as long)
	declare function linespacing() as long
	declare sub linespacing(val_ as long)

	declare function connectorcolor() as Fl_Color
	declare sub connectorcolor(val_ as Fl_Color)
	declare function connectorstyle() as Fl_Tree_Connector
	declare sub connectorstyle(val_ as Fl_Tree_Connector)
	declare sub connectorstyle(val_ as long)
	declare function connectorwidth() as long
	declare sub connectorwidth(val_ as long)

	declare function openicon() as Fl_Image ptr
	declare sub openicon(val_ as Fl_Image ptr)
	declare function closeicon() as Fl_Image ptr
	declare sub closeicon(val_ as Fl_Image ptr)
	declare function usericon() as Fl_Image ptr
	declare sub usericon(val_ as Fl_Image ptr)

	declare function showcollapse() as byte
	declare sub showcollapse(val_ as long)

	declare function sortorder() as Fl_Tree_Sort
	declare sub sortorder(val_ as Fl_Tree_Sort)
	declare function selectbox() as Fl_Boxtype
	declare sub selectbox(val_ as Fl_Boxtype)
	declare function showroot() as long
	declare sub showroot(val_ as long)
	declare function selectmode() as Fl_Tree_Select
	declare sub selectmode(val_ as Fl_Tree_Select)
end type

end extern

private function Fl_Tree_Prefs.item_labelfont() as Fl_Font
	return(_labelfont)
end function

private sub Fl_Tree_Prefs.item_labelfont(val_ as Fl_Font)
	_labelfont=val_
end sub

private function Fl_Tree_Prefs.item_labelsize() as Fl_Fontsize
	return(_labelsize)
end function

private sub Fl_Tree_Prefs.item_labelsize(val_ as Fl_Fontsize)
	_labelsize=val_
end sub

private function Fl_Tree_Prefs.item_labelfgcolor() as Fl_Color
	return(_labelfgcolor)
end function

private sub Fl_Tree_Prefs.item_labelfgcolor(val_ as Fl_Color)
	_labelfgcolor=val_
end sub

private function Fl_Tree_Prefs.item_labelbgcolor() as Fl_Color
	return(_labelbgcolor)
end function

private sub Fl_Tree_Prefs.item_labelbgcolor(val_ as Fl_Color)
	_labelbgcolor=val_
end sub

private function Fl_Tree_Prefs.labelfont() as Fl_Font
	return(_labelfont)
end function

private sub Fl_Tree_Prefs.labelfont(val_ as Fl_Font)
	_labelfont=val_
end sub

private function Fl_Tree_Prefs.labelsize() as Fl_Fontsize
	return(_labelsize)
end function

private sub Fl_Tree_Prefs.labelsize(val_ as Fl_Fontsize)
	_labelsize=val_
end sub

private function Fl_Tree_Prefs.labelfgcolor() as Fl_Color
	return(_labelfgcolor)
end function

private sub Fl_Tree_Prefs.labelfgcolor(val_ as Fl_Color)
	_labelfgcolor=val_
end sub

private function Fl_Tree_Prefs.labelbgcolor() as Fl_Color
	return(_labelbgcolor)
end function

private sub Fl_Tree_Prefs.labelbgcolor(val_ as Fl_Color)
	_labelbgcolor=val_
end sub

private function Fl_Tree_Prefs.marginleft() as long
	return(_marginleft)
end function

private sub Fl_Tree_Prefs.marginleft(val_ as long)
	_marginleft=val_
end sub

private function Fl_Tree_Prefs.margintop() as long
	return(_margintop)
end function

private sub Fl_Tree_Prefs.margintop(val_ as long)
	_margintop=val_
end sub

private function Fl_Tree_Prefs.openchild_marginbottom() as long
	return(_openchild_marginbottom)
end function

private sub Fl_Tree_Prefs.openchild_marginbottom(val_ as long)
	_openchild_marginbottom=val_
end sub

private function Fl_Tree_Prefs.usericonmarginleft() as long
	return(_usericonmarginleft)
end function

private sub Fl_Tree_Prefs.usericonmarginleft(val_ as long)
	_usericonmarginleft=val_
end sub

private function Fl_Tree_Prefs.labelmarginleft() as long
	return(_labelmarginleft)
end function

private sub Fl_Tree_Prefs.labelmarginleft(val_ as long)
	_labelmarginleft=val_
end sub

private function Fl_Tree_Prefs.linespacing() as long
	return(_linespacing)
end function

private sub Fl_Tree_Prefs.linespacing(val_ as long)
	_linespacing=val_
end sub

private function Fl_Tree_Prefs.connectorcolor() as Fl_Color
	return(_connectorcolor)
end function

private sub Fl_Tree_Prefs.connectorcolor(val_ as Fl_Color)
	_connectorcolor=val_
end sub

private function Fl_Tree_Prefs.connectorstyle() as Fl_Tree_Connector
	return(_connectorstyle)
end function

private sub Fl_Tree_Prefs.connectorstyle(val_ as Fl_Tree_Connector)
	_connectorstyle=val_
end sub

private sub Fl_Tree_Prefs.connectorstyle(val_ as long)
	_connectorstyle=cast(Fl_Tree_Connector, val_)
end sub

private function Fl_Tree_Prefs.connectorwidth() as long
	return(_connectorwidth)
end function

private sub Fl_Tree_Prefs.connectorwidth(val_ as long)
	_connectorwidth=val_
end sub

private function Fl_Tree_Prefs.openicon() as Fl_Image ptr
	return(_openimage)
end function

private function Fl_Tree_Prefs.closeicon() as Fl_Image ptr
	return(_closeimage)
end function

private function Fl_Tree_Prefs.usericon() as Fl_Image ptr
	return(_userimage)
end function

private sub Fl_Tree_Prefs.usericon(val_ as Fl_Image ptr)
	_userimage=val_
end sub

private function Fl_Tree_Prefs.showcollapse() as byte
	return(_showcollapse)
end function

private sub Fl_Tree_Prefs.showcollapse(val_ as long)
	_showcollapse=val_
end sub

private function Fl_Tree_Prefs.sortorder() as Fl_Tree_Sort
	return(_sortorder)
end function

private sub Fl_Tree_Prefs.sortorder(val_ as Fl_Tree_Sort)
	_sortorder=val_
end sub

private function Fl_Tree_Prefs.selectbox() as Fl_Boxtype
	return(_selectbox)
end function

private sub Fl_Tree_Prefs.selectbox(val_ as Fl_Boxtype)
	_selectbox=val_
end sub

private function Fl_Tree_Prefs.showroot() as long
	return(_showroot)
end function

private sub Fl_Tree_Prefs.showroot(val_ as long)
	_showroot=val_
end sub

private function Fl_Tree_Prefs.selectmode() as Fl_Tree_Select
	return(_selectmode)
end function

private sub Fl_Tree_Prefs.selectmode(val_ as Fl_Tree_Select)
	_selectmode=val_
end sub

