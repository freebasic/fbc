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
#include once "gtkbin.bi"

#define GTK_TYPE_ITEM (gtk_item_get_type ())
#define GTK_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ITEM, GtkItem))
#define GTK_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ITEM, GtkItemClass))
#define GTK_IS_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ITEM))
#define GTK_IS_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ITEM))
#define GTK_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ITEM, GtkItemClass))

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

declare function gtk_item_get_type () as GType
declare sub gtk_item_select (byval item as GtkItem ptr)
declare sub gtk_item_deselect (byval item as GtkItem ptr)
declare sub gtk_item_toggle (byval item as GtkItem ptr)

#endif
