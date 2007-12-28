''
''
'' gtkfilechooser -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfilechooser_bi__
#define __gtkfilechooser_bi__

#include once "gtkfilefilter.bi"
#include once "gtkwidget.bi"

#define GTK_TYPE_FILE_CHOOSER gtk_file_chooser_get_type()
#define GTK_FILE_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_FILE_CHOOSER, GtkFileChooser)
#define GTK_IS_FILE_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_FILE_CHOOSER)


type GtkFileChooser as _GtkFileChooser

enum GtkFileChooserAction
	GTK_FILE_CHOOSER_ACTION_OPEN
	GTK_FILE_CHOOSER_ACTION_SAVE
	GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER
	GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER
end enum


declare function gtk_file_chooser_get_type () as GType

enum GtkFileChooserError
	GTK_FILE_CHOOSER_ERROR_NONEXISTENT
	GTK_FILE_CHOOSER_ERROR_BAD_FILENAME
end enum


declare function gtk_file_chooser_error_quark () as GQuark
declare sub gtk_file_chooser_set_action (byval chooser as GtkFileChooser ptr, byval action as GtkFileChooserAction)
declare function gtk_file_chooser_get_action (byval chooser as GtkFileChooser ptr) as GtkFileChooserAction
declare sub gtk_file_chooser_set_local_only (byval chooser as GtkFileChooser ptr, byval local_only as gboolean)
declare function gtk_file_chooser_get_local_only (byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_select_multiple (byval chooser as GtkFileChooser ptr, byval select_multiple as gboolean)
declare function gtk_file_chooser_get_select_multiple (byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_show_hidden (byval chooser as GtkFileChooser ptr, byval show_hidden as gboolean)
declare function gtk_file_chooser_get_show_hidden (byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_current_name (byval chooser as GtkFileChooser ptr, byval name as zstring ptr)

#ifdef __FB_Win32__
/' Reserve old names for DLL ABI backward compatibility '/
#define gtk_file_chooser_get_filename gtk_file_chooser_get_filename_utf8
#define gtk_file_chooser_set_filename gtk_file_chooser_set_filename_utf8
#define gtk_file_chooser_select_filename gtk_file_chooser_select_filename_utf8
#define gtk_file_chooser_unselect_filename gtk_file_chooser_unselect_filename_utf8
#define gtk_file_chooser_get_filenames gtk_file_chooser_get_filenames_utf8
#define gtk_file_chooser_set_current_folder gtk_file_chooser_set_current_folder_utf8
#define gtk_file_chooser_get_current_folder gtk_file_chooser_get_current_folder_utf8
#define gtk_file_chooser_get_preview_filename gtk_file_chooser_get_preview_filename_utf8
#define gtk_file_chooser_add_shortcut_folder gtk_file_chooser_add_shortcut_folder_utf8
#define gtk_file_chooser_remove_shortcut_folder gtk_file_chooser_remove_shortcut_folder_utf8
#define gtk_file_chooser_list_shortcut_folders gtk_file_chooser_list_shortcut_folders_utf8
#endif

declare function gtk_file_chooser_get_filename (byval chooser as GtkFileChooser ptr) as zstring ptr
declare function gtk_file_chooser_set_filename (byval chooser as GtkFileChooser ptr, byval filename as zstring ptr) as gboolean
declare function gtk_file_chooser_select_filename (byval chooser as GtkFileChooser ptr, byval filename as zstring ptr) as gboolean
declare sub gtk_file_chooser_unselect_filename (byval chooser as GtkFileChooser ptr, byval filename as zstring ptr)
declare sub gtk_file_chooser_select_all (byval chooser as GtkFileChooser ptr)
declare sub gtk_file_chooser_unselect_all (byval chooser as GtkFileChooser ptr)
declare function gtk_file_chooser_get_filenames (byval chooser as GtkFileChooser ptr) as GSList ptr
declare function gtk_file_chooser_set_current_folder (byval chooser as GtkFileChooser ptr, byval filename as zstring ptr) as gboolean
declare function gtk_file_chooser_get_current_folder (byval chooser as GtkFileChooser ptr) as zstring ptr
declare function gtk_file_chooser_get_uri (byval chooser as GtkFileChooser ptr) as zstring ptr
declare function gtk_file_chooser_set_uri (byval chooser as GtkFileChooser ptr, byval uri as zstring ptr) as gboolean
declare function gtk_file_chooser_select_uri (byval chooser as GtkFileChooser ptr, byval uri as zstring ptr) as gboolean
declare sub gtk_file_chooser_unselect_uri (byval chooser as GtkFileChooser ptr, byval uri as zstring ptr)
declare function gtk_file_chooser_get_uris (byval chooser as GtkFileChooser ptr) as GSList ptr
declare function gtk_file_chooser_set_current_folder_uri (byval chooser as GtkFileChooser ptr, byval uri as zstring ptr) as gboolean
declare function gtk_file_chooser_get_current_folder_uri (byval chooser as GtkFileChooser ptr) as zstring ptr
declare sub gtk_file_chooser_set_preview_widget (byval chooser as GtkFileChooser ptr, byval preview_widget as GtkWidget ptr)
declare function gtk_file_chooser_get_preview_widget (byval chooser as GtkFileChooser ptr) as GtkWidget ptr
declare sub gtk_file_chooser_set_preview_widget_active (byval chooser as GtkFileChooser ptr, byval active as gboolean)
declare function gtk_file_chooser_get_preview_widget_active (byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_use_preview_label (byval chooser as GtkFileChooser ptr, byval use_label as gboolean)
declare function gtk_file_chooser_get_use_preview_label (byval chooser as GtkFileChooser ptr) as gboolean
declare function gtk_file_chooser_get_preview_filename (byval chooser as GtkFileChooser ptr) as zstring ptr
declare function gtk_file_chooser_get_preview_uri (byval chooser as GtkFileChooser ptr) as zstring ptr
declare sub gtk_file_chooser_set_extra_widget (byval chooser as GtkFileChooser ptr, byval extra_widget as GtkWidget ptr)
declare function gtk_file_chooser_get_extra_widget (byval chooser as GtkFileChooser ptr) as GtkWidget ptr
declare sub gtk_file_chooser_add_filter (byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare sub gtk_file_chooser_remove_filter (byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare function gtk_file_chooser_list_filters (byval chooser as GtkFileChooser ptr) as GSList ptr
declare sub gtk_file_chooser_set_filter (byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare function gtk_file_chooser_get_filter (byval chooser as GtkFileChooser ptr) as GtkFileFilter ptr
declare function gtk_file_chooser_add_shortcut_folder (byval chooser as GtkFileChooser ptr, byval folder as zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_remove_shortcut_folder (byval chooser as GtkFileChooser ptr, byval folder as zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_list_shortcut_folders (byval chooser as GtkFileChooser ptr) as GSList ptr
declare function gtk_file_chooser_add_shortcut_folder_uri (byval chooser as GtkFileChooser ptr, byval uri as zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_remove_shortcut_folder_uri (byval chooser as GtkFileChooser ptr, byval uri as zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_list_shortcut_folder_uris (byval chooser as GtkFileChooser ptr) as GSList ptr

#endif
