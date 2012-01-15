''
''
'' gtkselection -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkselection_bi__
#define __gtkselection_bi__

#include once "gtk/gdk.bi"
#include once "gtkenums.bi"
#include once "gtkwidget.bi"

#define GTK_TYPE_SELECTION_DATA (gtk_selection_data_get_type ())

type GtkTargetList as _GtkTargetList
type GtkTargetEntry as _GtkTargetEntry

type _GtkSelectionData
	selection as GdkAtom
	target as GdkAtom
	type as GdkAtom
	format as gint
	data as guchar ptr
	length as gint
	display as GdkDisplay ptr
end type

type _GtkTargetEntry
	target as zstring ptr
	flags as guint
	info as guint
end type

type GtkTargetPair as _GtkTargetPair

type _GtkTargetList
	list as GList ptr
	ref_count as guint
end type

type _GtkTargetPair
	target as GdkAtom
	flags as guint
	info as guint
end type

declare function gtk_target_list_new (byval targets as GtkTargetEntry ptr, byval ntargets as guint) as GtkTargetList ptr
declare sub gtk_target_list_ref (byval list as GtkTargetList ptr)
declare sub gtk_target_list_unref (byval list as GtkTargetList ptr)
declare sub gtk_target_list_add (byval list as GtkTargetList ptr, byval target as GdkAtom, byval flags as guint, byval info as guint)
declare sub gtk_target_list_add_text_targets (byval list as GtkTargetList ptr, byval info as guint)
declare sub gtk_target_list_add_image_targets (byval list as GtkTargetList ptr, byval info as guint, byval writable as gboolean)
declare sub gtk_target_list_add_uri_targets (byval list as GtkTargetList ptr, byval info as guint)
declare sub gtk_target_list_add_table (byval list as GtkTargetList ptr, byval targets as GtkTargetEntry ptr, byval ntargets as guint)
declare sub gtk_target_list_remove (byval list as GtkTargetList ptr, byval target as GdkAtom)
declare function gtk_target_list_find (byval list as GtkTargetList ptr, byval target as GdkAtom, byval info as guint ptr) as gboolean
declare function gtk_selection_owner_set (byval widget as GtkWidget ptr, byval selection as GdkAtom, byval time_ as guint32) as gboolean
declare function gtk_selection_owner_set_for_display (byval display as GdkDisplay ptr, byval widget as GtkWidget ptr, byval selection as GdkAtom, byval time_ as guint32) as gboolean
declare sub gtk_selection_add_target (byval widget as GtkWidget ptr, byval selection as GdkAtom, byval target as GdkAtom, byval info as guint)
declare sub gtk_selection_add_targets (byval widget as GtkWidget ptr, byval selection as GdkAtom, byval targets as GtkTargetEntry ptr, byval ntargets as guint)
declare sub gtk_selection_clear_targets (byval widget as GtkWidget ptr, byval selection as GdkAtom)
declare function gtk_selection_convert (byval widget as GtkWidget ptr, byval selection as GdkAtom, byval target as GdkAtom, byval time_ as guint32) as gboolean
declare sub gtk_selection_data_set (byval selection_data as GtkSelectionData ptr, byval type as GdkAtom, byval format as gint, byval data as guchar ptr, byval length as gint)
declare function gtk_selection_data_set_text (byval selection_data as GtkSelectionData ptr, byval str as zstring ptr, byval len as gint) as gboolean
declare function gtk_selection_data_get_text (byval selection_data as GtkSelectionData ptr) as guchar ptr
declare function gtk_selection_data_set_pixbuf (byval selection_data as GtkSelectionData ptr, byval pixbuf as GdkPixbuf ptr) as gboolean
declare function gtk_selection_data_get_pixbuf (byval selection_data as GtkSelectionData ptr) as GdkPixbuf ptr
declare function gtk_selection_data_set_uris (byval selection_data as GtkSelectionData ptr, byval uris as zstring ptr ptr) as gboolean
declare function gtk_selection_data_get_uris (byval selection_data as GtkSelectionData ptr) as zstring ptr ptr
declare function gtk_selection_data_get_targets (byval selection_data as GtkSelectionData ptr, byval targets as GdkAtom ptr ptr, byval n_atoms as gint ptr) as gboolean
declare function gtk_selection_data_targets_include_text (byval selection_data as GtkSelectionData ptr) as gboolean
declare function gtk_selection_data_targets_include_image (byval selection_data as GtkSelectionData ptr, byval writable as gboolean) as gboolean
declare sub gtk_selection_remove_all (byval widget as GtkWidget ptr)
declare function gtk_selection_clear (byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
declare function _gtk_selection_request (byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
declare function _gtk_selection_incr_event (byval window as GdkWindow ptr, byval event as GdkEventProperty ptr) as gboolean
declare function _gtk_selection_notify (byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
declare function _gtk_selection_property_notify (byval widget as GtkWidget ptr, byval event as GdkEventProperty ptr) as gboolean
declare function gtk_selection_data_get_type () as GType
declare function gtk_selection_data_copy (byval data as GtkSelectionData ptr) as GtkSelectionData ptr
declare sub gtk_selection_data_free (byval data as GtkSelectionData ptr)

#endif
