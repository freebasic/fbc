''
''
'' glade-xml -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glade_xml_bi__
#define __glade_xml_bi__

#include once "gtk/glib.bi"
#include once "gtk/gtk/gtkwidget.bi"
#include once "gtk/gtk/gtktooltips.bi"

type GladeXML as _GladeXML
type GladeXMLClass as _GladeXMLClass
type GladeXMLPrivate as _GladeXMLPrivate

type _GladeXML
	parent as GObject
	filename as zstring ptr
	priv as GladeXMLPrivate ptr
end type

type _GladeXMLClass
	parent_class as GObjectClass
	lookup_type as function cdecl(byval as GladeXML ptr, byval as string) as GType
end type

declare function glade_xml_get_type cdecl alias "glade_xml_get_type" () as GType
declare function glade_xml_new cdecl alias "glade_xml_new" (byval fname as string, byval root as string, byval domain as string) as GladeXML ptr
declare function glade_xml_new_from_buffer cdecl alias "glade_xml_new_from_buffer" (byval buffer as string, byval size as integer, byval root as string, byval domain as string) as GladeXML ptr
declare function glade_xml_construct cdecl alias "glade_xml_construct" (byval self as GladeXML ptr, byval fname as string, byval root as string, byval domain as string) as gboolean
declare sub glade_xml_signal_connect cdecl alias "glade_xml_signal_connect" (byval self as GladeXML ptr, byval handlername as string, byval func as GCallback)
declare sub glade_xml_signal_connect_data cdecl alias "glade_xml_signal_connect_data" (byval self as GladeXML ptr, byval handlername as string, byval func as GCallback, byval user_data as gpointer)
declare sub glade_xml_signal_autoconnect cdecl alias "glade_xml_signal_autoconnect" (byval self as GladeXML ptr)

type GladeXMLConnectFunc as sub cdecl(byval as gchar ptr, byval as GObject ptr, byval as gchar ptr, byval as gchar ptr, byval as GObject ptr, byval as gboolean, byval as gpointer)

declare sub glade_xml_signal_connect_full cdecl alias "glade_xml_signal_connect_full" (byval self as GladeXML ptr, byval handler_name as gchar ptr, byval func as GladeXMLConnectFunc, byval user_data as gpointer)
declare sub glade_xml_signal_autoconnect_full cdecl alias "glade_xml_signal_autoconnect_full" (byval self as GladeXML ptr, byval func as GladeXMLConnectFunc, byval user_data as gpointer)
declare function glade_xml_get_widget cdecl alias "glade_xml_get_widget" (byval self as GladeXML ptr, byval name as string) as GtkWidget ptr
declare function glade_xml_get_widget_prefix cdecl alias "glade_xml_get_widget_prefix" (byval self as GladeXML ptr, byval name as string) as GList ptr
declare function glade_xml_relative_file cdecl alias "glade_xml_relative_file" (byval self as GladeXML ptr, byval filename as gchar ptr) as gchar ptr
declare function glade_get_widget_name cdecl alias "glade_get_widget_name" (byval widget as GtkWidget ptr) as zstring ptr
declare function glade_get_widget_tree cdecl alias "glade_get_widget_tree" (byval widget as GtkWidget ptr) as GladeXML ptr

type GladeXMLCustomWidgetHandler as function cdecl(byval as GladeXML ptr, byval as gchar ptr, byval as gchar ptr, byval as gchar ptr, byval as gchar ptr, byval as gint, byval as gint, byval as gpointer) as GtkWidget

declare sub glade_set_custom_handler cdecl alias "glade_set_custom_handler" (byval handler as GladeXMLCustomWidgetHandler, byval user_data as gpointer)

#endif
