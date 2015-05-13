''
''
'' glade-build -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glade_build_bi__
#define __glade_build_bi__

#include once "glib.bi"
#include once "glib-object.bi"
#include once "gmodule.bi"
#include once "glade-xml.bi"
#include once "gtk/gtk.bi"
#include once "glade-parser.bi"

type GladeNewFunc as function cdecl(byval as GladeXML ptr, byval as GType, byval as GladeWidgetInfo ptr) as GtkWidget
type GladeBuildChildrenFunc as sub cdecl(byval as GladeXML ptr, byval as GtkWidget ptr, byval as GladeWidgetInfo ptr)
type GladeFindInternalChildFunc as function cdecl(byval as GladeXML ptr, byval as GtkWidget ptr, byval as zstring ptr) as GtkWidget
type GladeApplyCustomPropFunc as sub cdecl(byval as GladeXML ptr, byval as GtkWidget ptr, byval as zstring ptr, byval as zstring ptr)

declare sub glade_register_widget (byval type as GType, byval new_func as GladeNewFunc, byval build_children as GladeBuildChildrenFunc, byval find_internal_child as GladeFindInternalChildFunc)
declare sub glade_register_custom_prop (byval type as GType, byval prop_name as zstring ptr, byval apply_prop as GladeApplyCustomPropFunc)
declare sub glade_xml_set_toplevel (byval xml as GladeXML ptr, byval window as GtkWindow ptr)
declare function glade_xml_ensure_accel (byval xml as GladeXML ptr) as GtkAccelGroup ptr
declare sub glade_xml_handle_widget_prop (byval self as GladeXML ptr, byval widget as GtkWidget ptr, byval prop_name as zstring ptr, byval value_name as zstring ptr)
declare sub glade_xml_set_packing_property (byval self as GladeXML ptr, byval parent as GtkWidget ptr, byval child as GtkWidget ptr, byval name as zstring ptr, byval value as zstring ptr)
declare function glade_xml_build_widget (byval self as GladeXML ptr, byval info as GladeWidgetInfo ptr) as GtkWidget ptr
declare sub glade_xml_handle_internal_child (byval self as GladeXML ptr, byval parent as GtkWidget ptr, byval child_info as GladeChildInfo ptr)
declare sub glade_xml_set_common_params (byval self as GladeXML ptr, byval widget as GtkWidget ptr, byval info as GladeWidgetInfo ptr)
declare function glade_xml_set_value_from_string (byval xml as GladeXML ptr, byval pspec as GParamSpec ptr, byval string as zstring ptr, byval value as GValue ptr) as gboolean
declare function glade_standard_build_widget (byval xml as GladeXML ptr, byval widget_type as GType, byval info as GladeWidgetInfo ptr) as GtkWidget ptr
declare sub glade_standard_build_children (byval self as GladeXML ptr, byval parent as GtkWidget ptr, byval info as GladeWidgetInfo ptr)
declare function glade_enum_from_string (byval type as GType, byval string as zstring ptr) as gint
declare function glade_flags_from_string (byval type as GType, byval string as zstring ptr) as guint

#define GLADE_MODULE_API_VERSION 1

declare function glade_module_check_version (byval version as gint) as zstring ptr
declare sub glade_module_register_widgets ()

#endif
