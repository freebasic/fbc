''
''
'' gtkitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkitem_bi__
#define __gtkitem_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkbin.bi"

type GtkItem as _GtkItem
type GtkItemClass as _GtkItemClass

type _GtkItem
	bin as GtkBin
end type

type _GtkItemClass
	parent_class as GtkBinClass
	select as sub cdecl(byval as GtkItem ptr)
	deselect as sub cdecl(byval as GtkItem ptr)
	toggle as sub cdecl(byval as GtkItem ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_item_get_type cdecl alias "gtk_item_get_type" () as GType
declare sub gtk_item_select cdecl alias "gtk_item_select" (byval item as GtkItem ptr)
declare sub gtk_item_deselect cdecl alias "gtk_item_deselect" (byval item as GtkItem ptr)
declare sub gtk_item_toggle cdecl alias "gtk_item_toggle" (byval item as GtkItem ptr)

#endif
