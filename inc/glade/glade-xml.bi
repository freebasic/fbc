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

extern "c" lib "glade-2.0"

#include once "glib.bi"
#include once "gtk/gtk.bi"

#define GLADE_TYPE_XML (glade_xml_get_type())
#define GLADE_XML(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GLADE_TYPE_XML, GladeXML))
#define GLADE_XML_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GLADE_TYPE_XML, GladeXMLClass))
#define GLADE_IS_XML(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GLADE_TYPE_XML))
#define GLADE_IS_XML_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((obj), GLADE_TYPE_XML))
#define GLADE_XML_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GLADE_TYPE_XML, GladeXMLClass))

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
	lookup_type as function cdecl(byval as GladeXML ptr, byval as zstring ptr) as GType
end type

declare function glade_xml_get_type () as GType
declare function glade_xml_new (byval fname as zstring ptr, byval root as zstring ptr, byval domain as zstring ptr) as GladeXML ptr
declare function glade_xml_new_from_buffer (byval buffer as zstring ptr, byval size as integer, byval root as zstring ptr, byval domain as zstring ptr) as GladeXML ptr
declare function glade_xml_construct (byval self as GladeXML ptr, byval fname as zstring ptr, byval root as zstring ptr, byval domain as zstring ptr) as gboolean
declare sub glade_xml_signal_connect (byval self as GladeXML ptr, byval handlername as zstring ptr, byval func as GCallback)
declare sub glade_xml_signal_connect_data (byval self as GladeXML ptr, byval handlername as zstring ptr, byval func as GCallback, byval user_data as gpointer)
declare sub glade_xml_signal_autoconnect (byval self as GladeXML ptr)

type GladeXMLConnectFunc as sub cdecl(byval as zstring ptr, byval as GObject ptr, byval as zstring ptr, byval as zstring ptr, byval as GObject ptr, byval as gboolean, byval as gpointer)

declare sub glade_xml_signal_connect_full (byval self as GladeXML ptr, byval handler_name as zstring ptr, byval func as GladeXMLConnectFunc, byval user_data as gpointer)
declare sub glade_xml_signal_autoconnect_full (byval self as GladeXML ptr, byval func as GladeXMLConnectFunc, byval user_data as gpointer)
declare function glade_xml_get_widget (byval self as GladeXML ptr, byval name as zstring ptr) as GtkWidget ptr
declare function glade_xml_get_widget_prefix (byval self as GladeXML ptr, byval name as zstring ptr) as GList ptr
declare function glade_xml_relative_file (byval self as GladeXML ptr, byval filename as zstring ptr) as zstring ptr
declare function glade_get_widget_name (byval widget as GtkWidget ptr) as zstring ptr
declare function glade_get_widget_tree (byval widget as GtkWidget ptr) as GladeXML ptr

type GladeXMLCustomWidgetHandler as function cdecl(byval as GladeXML ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as gint, byval as gint, byval as gpointer) as GtkWidget

declare sub glade_set_custom_handler (byval handler as GladeXMLCustomWidgetHandler, byval user_data as gpointer)

#define glade_xml_new_with_domain glade_xml_new
#define glade_xml_new_from_memory glade_xml_new_from_buffer

end extern

#endif
