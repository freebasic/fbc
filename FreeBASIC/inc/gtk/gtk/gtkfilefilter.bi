''
''
'' gtkfilefilter -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfilefilter_bi__
#define __gtkfilefilter_bi__

#include once "gtk/glib-object.bi"

type GtkFileFilter as _GtkFileFilter
type GtkFileFilterInfo as _GtkFileFilterInfo

enum GtkFileFilterFlags
	GTK_FILE_FILTER_FILENAME = 1 shl 0
	GTK_FILE_FILTER_URI = 1 shl 1
	GTK_FILE_FILTER_DISPLAY_NAME = 1 shl 2
	GTK_FILE_FILTER_MIME_TYPE = 1 shl 3
end enum

type GtkFileFilterFunc as function cdecl(byval as GtkFileFilterInfo ptr, byval as gpointer) as gboolean

type _GtkFileFilterInfo
	contains as GtkFileFilterFlags
	filename as zstring ptr
	uri as zstring ptr
	display_name as zstring ptr
	mime_type as zstring ptr
end type

declare function gtk_file_filter_get_type cdecl alias "gtk_file_filter_get_type" () as GType
declare function gtk_file_filter_new cdecl alias "gtk_file_filter_new" () as GtkFileFilter ptr
declare sub gtk_file_filter_set_name cdecl alias "gtk_file_filter_set_name" (byval filter as GtkFileFilter ptr, byval name as string)
declare function gtk_file_filter_get_name cdecl alias "gtk_file_filter_get_name" (byval filter as GtkFileFilter ptr) as zstring ptr
declare sub gtk_file_filter_add_mime_type cdecl alias "gtk_file_filter_add_mime_type" (byval filter as GtkFileFilter ptr, byval mime_type as string)
declare sub gtk_file_filter_add_pattern cdecl alias "gtk_file_filter_add_pattern" (byval filter as GtkFileFilter ptr, byval pattern as string)
declare sub gtk_file_filter_add_pixbuf_formats cdecl alias "gtk_file_filter_add_pixbuf_formats" (byval filter as GtkFileFilter ptr)
declare sub gtk_file_filter_add_custom cdecl alias "gtk_file_filter_add_custom" (byval filter as GtkFileFilter ptr, byval needed as GtkFileFilterFlags, byval func as GtkFileFilterFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare function gtk_file_filter_get_needed cdecl alias "gtk_file_filter_get_needed" (byval filter as GtkFileFilter ptr) as GtkFileFilterFlags
declare function gtk_file_filter_filter cdecl alias "gtk_file_filter_filter" (byval filter as GtkFileFilter ptr, byval filter_info as GtkFileFilterInfo ptr) as gboolean

#endif
