''
''
'' gtksettings -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtksettings_bi__
#define __gtksettings_bi__

#include once "gtkrc.bi"

#define GTK_TYPE_SETTINGS (gtk_settings_get_type ())
#define GTK_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SETTINGS, GtkSettings))
#define GTK_SETTINGS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SETTINGS, GtkSettingsClass))
#define GTK_IS_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SETTINGS))
#define GTK_IS_SETTINGS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SETTINGS))
#define GTK_SETTINGS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SETTINGS, GtkSettingsClass))

type GtkSettingsClass as _GtkSettingsClass
type GtkSettingsValue as _GtkSettingsValue
type GtkSettingsPropertyValue as _GtkSettingsPropertyValue

type _GtkSettings
	parent_instance as GObject
	queued_settings as GData ptr
	property_values as GtkSettingsPropertyValue ptr
	rc_context as GtkRcContext ptr
	screen as GdkScreen ptr
end type

type _GtkSettingsClass
	parent_class as GObjectClass
end type

type _GtkSettingsValue
	origin as zstring ptr
	value as GValue
end type

declare function gtk_settings_get_type () as GType
declare function gtk_settings_get_default () as GtkSettings ptr
declare function gtk_settings_get_for_screen (byval screen as GdkScreen ptr) as GtkSettings ptr
declare sub gtk_settings_install_property (byval pspec as GParamSpec ptr)
declare sub gtk_settings_install_property_parser (byval pspec as GParamSpec ptr, byval parser as GtkRcPropertyParser)
declare function gtk_rc_property_parse_color (byval pspec as GParamSpec ptr, byval gstring as GString ptr, byval property_value as GValue ptr) as gboolean
declare function gtk_rc_property_parse_enum (byval pspec as GParamSpec ptr, byval gstring as GString ptr, byval property_value as GValue ptr) as gboolean
declare function gtk_rc_property_parse_flags (byval pspec as GParamSpec ptr, byval gstring as GString ptr, byval property_value as GValue ptr) as gboolean
declare function gtk_rc_property_parse_requisition (byval pspec as GParamSpec ptr, byval gstring as GString ptr, byval property_value as GValue ptr) as gboolean
declare function gtk_rc_property_parse_border (byval pspec as GParamSpec ptr, byval gstring as GString ptr, byval property_value as GValue ptr) as gboolean
declare sub gtk_settings_set_property_value (byval settings as GtkSettings ptr, byval name as zstring ptr, byval svalue as GtkSettingsValue ptr)
declare sub gtk_settings_set_string_property (byval settings as GtkSettings ptr, byval name as zstring ptr, byval v_string as zstring ptr, byval origin as zstring ptr)
declare sub gtk_settings_set_long_property (byval settings as GtkSettings ptr, byval name as zstring ptr, byval v_long as glong, byval origin as zstring ptr)
declare sub gtk_settings_set_double_property (byval settings as GtkSettings ptr, byval name as zstring ptr, byval v_double as gdouble, byval origin as zstring ptr)
declare sub _gtk_settings_set_property_value_from_rc (byval settings as GtkSettings ptr, byval name as zstring ptr, byval svalue as GtkSettingsValue ptr)
declare sub _gtk_settings_reset_rc_values (byval settings as GtkSettings ptr)
declare sub _gtk_settings_handle_event (byval event as GdkEventSetting ptr)
declare function _gtk_rc_property_parser_from_type (byval type as GType) as GtkRcPropertyParser
declare function _gtk_settings_parse_convert (byval parser as GtkRcPropertyParser, byval src_value as GValue ptr, byval pspec as GParamSpec ptr, byval dest_value as GValue ptr) as gboolean

#endif
