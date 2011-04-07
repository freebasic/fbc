''
''
'' gtkitemfactory -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkitemfactory_bi__
#define __gtkitemfactory_bi__

#include once "gtkwidget.bi"

#define GTK_TYPE_ITEM_FACTORY (gtk_item_factory_get_type ())
#define GTK_ITEM_FACTORY(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_ITEM_FACTORY, GtkItemFactory))
#define GTK_ITEM_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ITEM_FACTORY, GtkItemFactoryClass))
#define GTK_IS_ITEM_FACTORY(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_ITEM_FACTORY))
#define GTK_IS_ITEM_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ITEM_FACTORY))
#define GTK_ITEM_FACTORY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ITEM_FACTORY, GtkItemFactoryClass))

type GtkTranslateFunc as function cdecl(byval as zstring ptr, byval as gpointer) as gchar
type GtkPrintFunc as sub cdecl(byval as gpointer, byval as zstring ptr)
type GtkItemFactoryCallback as sub cdecl()
type GtkItemFactoryCallback1 as sub cdecl(byval as gpointer, byval as guint, byval as GtkWidget ptr)
type GtkItemFactory as _GtkItemFactory
type GtkItemFactoryClass as _GtkItemFactoryClass
type GtkItemFactoryEntry as _GtkItemFactoryEntry
type GtkItemFactoryItem as _GtkItemFactoryItem

type _GtkItemFactory
	object as GtkObject
	path as zstring ptr
	accel_group as GtkAccelGroup ptr
	widget as GtkWidget ptr
	items as GSList ptr
	translate_func as GtkTranslateFunc
	translate_data as gpointer
	translate_notify as GtkDestroyNotify
end type

type _GtkItemFactoryClass
	object_class as GtkObjectClass
	item_ht as GHashTable ptr
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

type _GtkItemFactoryEntry
	path as zstring ptr
	accelerator as zstring ptr
	callback as GtkItemFactoryCallback
	callback_action as guint
	item_type as zstring ptr
	extra_data as gconstpointer
end type

type _GtkItemFactoryItem
	path as zstring ptr
	widgets as GSList ptr
end type

declare function gtk_item_factory_get_type () as GType
declare function gtk_item_factory_new (byval container_type as GType, byval path as zstring ptr, byval accel_group as GtkAccelGroup ptr) as GtkItemFactory ptr
declare sub gtk_item_factory_construct (byval ifactory as GtkItemFactory ptr, byval container_type as GType, byval path as zstring ptr, byval accel_group as GtkAccelGroup ptr)
declare sub gtk_item_factory_add_foreign (byval accel_widget as GtkWidget ptr, byval full_path as zstring ptr, byval accel_group as GtkAccelGroup ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare function gtk_item_factory_from_widget (byval widget as GtkWidget ptr) as GtkItemFactory ptr
declare function gtk_item_factory_path_from_widget (byval widget as GtkWidget ptr) as zstring ptr
declare function gtk_item_factory_get_item (byval ifactory as GtkItemFactory ptr, byval path as zstring ptr) as GtkWidget ptr
declare function gtk_item_factory_get_widget (byval ifactory as GtkItemFactory ptr, byval path as zstring ptr) as GtkWidget ptr
declare function gtk_item_factory_get_widget_by_action (byval ifactory as GtkItemFactory ptr, byval action as guint) as GtkWidget ptr
declare function gtk_item_factory_get_item_by_action (byval ifactory as GtkItemFactory ptr, byval action as guint) as GtkWidget ptr
declare sub gtk_item_factory_create_item (byval ifactory as GtkItemFactory ptr, byval entry as GtkItemFactoryEntry ptr, byval callback_data as gpointer, byval callback_type as guint)
declare sub gtk_item_factory_create_items (byval ifactory as GtkItemFactory ptr, byval n_entries as guint, byval entries as GtkItemFactoryEntry ptr, byval callback_data as gpointer)
declare sub gtk_item_factory_delete_item (byval ifactory as GtkItemFactory ptr, byval path as zstring ptr)
declare sub gtk_item_factory_delete_entry (byval ifactory as GtkItemFactory ptr, byval entry as GtkItemFactoryEntry ptr)
declare sub gtk_item_factory_delete_entries (byval ifactory as GtkItemFactory ptr, byval n_entries as guint, byval entries as GtkItemFactoryEntry ptr)
declare sub gtk_item_factory_popup (byval ifactory as GtkItemFactory ptr, byval x as guint, byval y as guint, byval mouse_button as guint, byval time_ as guint32)
declare sub gtk_item_factory_popup_with_data (byval ifactory as GtkItemFactory ptr, byval popup_data as gpointer, byval destroy as GtkDestroyNotify, byval x as guint, byval y as guint, byval mouse_button as guint, byval time_ as guint32)
declare function gtk_item_factory_popup_data (byval ifactory as GtkItemFactory ptr) as gpointer
declare function gtk_item_factory_popup_data_from_widget (byval widget as GtkWidget ptr) as gpointer
declare sub gtk_item_factory_set_translate_func (byval ifactory as GtkItemFactory ptr, byval func as GtkTranslateFunc, byval data as gpointer, byval notify as GtkDestroyNotify)

type GtkMenuCallback as sub cdecl(byval as GtkWidget ptr, byval as gpointer)

type GtkMenuEntry
	path as zstring ptr
	accelerator as zstring ptr
	callback as GtkMenuCallback
	callback_data as gpointer
	widget as GtkWidget ptr
end type

type GtkItemFactoryCallback2 as sub cdecl(byval as GtkWidget ptr, byval as gpointer, byval as guint)

declare sub gtk_item_factory_create_items_ac (byval ifactory as GtkItemFactory ptr, byval n_entries as guint, byval entries as GtkItemFactoryEntry ptr, byval callback_data as gpointer, byval callback_type as guint)
declare function gtk_item_factory_from_path (byval path as zstring ptr) as GtkItemFactory ptr
declare sub gtk_item_factory_create_menu_entries (byval n_entries as guint, byval entries as GtkMenuEntry ptr)
declare sub gtk_item_factories_path_delete (byval ifactory_path as zstring ptr, byval path as zstring ptr)

#endif
