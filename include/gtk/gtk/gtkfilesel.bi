''
''
'' gtkfilesel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfilesel_bi__
#define __gtkfilesel_bi__

#include once "gtk/gdk.bi"
#include once "gtkdialog.bi"

#define GTK_TYPE_FILE_SELECTION (gtk_file_selection_get_type ())
#define GTK_FILE_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_SELECTION, GtkFileSelection))
#define GTK_FILE_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FILE_SELECTION, GtkFileSelectionClass))
#define GTK_IS_FILE_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_SELECTION))
#define GTK_IS_FILE_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FILE_SELECTION))
#define GTK_FILE_SELECTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FILE_SELECTION, GtkFileSelectionClass))

type GtkFileSelection as _GtkFileSelection
type GtkFileSelectionClass as _GtkFileSelectionClass

type _GtkFileSelection
	parent_instance as GtkDialog
	dir_list as GtkWidget ptr
	file_list as GtkWidget ptr
	selection_entry as GtkWidget ptr
	selection_text as GtkWidget ptr
	main_vbox as GtkWidget ptr
	ok_button as GtkWidget ptr
	cancel_button as GtkWidget ptr
	help_button as GtkWidget ptr
	history_pulldown as GtkWidget ptr
	history_menu as GtkWidget ptr
	history_list as GList ptr
	fileop_dialog as GtkWidget ptr
	fileop_entry as GtkWidget ptr
	fileop_file as zstring ptr
	cmpl_state as gpointer
	fileop_c_dir as GtkWidget ptr
	fileop_del_file as GtkWidget ptr
	fileop_ren_file as GtkWidget ptr
	button_area as GtkWidget ptr
	action_area as GtkWidget ptr
	selected_names as GPtrArray ptr
	last_selected as zstring ptr
end type

type _GtkFileSelectionClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

#ifdef __FB_Win32__
/' Reserve old names for DLL ABI backward compatibility '/
#define gtk_file_selection_get_filename gtk_file_selection_get_filename_utf8
#define gtk_file_selection_set_filename gtk_file_selection_set_filename_utf8
#define gtk_file_selection_get_selections gtk_file_selection_get_selections_utf8
#endif

declare function gtk_file_selection_get_type () as GType
declare function gtk_file_selection_new (byval title as zstring ptr) as GtkWidget ptr
declare sub gtk_file_selection_set_filename (byval filesel as GtkFileSelection ptr, byval filename as zstring ptr)
declare function gtk_file_selection_get_filename (byval filesel as GtkFileSelection ptr) as zstring ptr
declare sub gtk_file_selection_complete (byval filesel as GtkFileSelection ptr, byval pattern as zstring ptr)
declare sub gtk_file_selection_show_fileop_buttons (byval filesel as GtkFileSelection ptr)
declare sub gtk_file_selection_hide_fileop_buttons (byval filesel as GtkFileSelection ptr)
declare function gtk_file_selection_get_selections (byval filesel as GtkFileSelection ptr) as zstring ptr ptr
declare sub gtk_file_selection_set_select_multiple (byval filesel as GtkFileSelection ptr, byval select_multiple as gboolean)
declare function gtk_file_selection_get_select_multiple (byval filesel as GtkFileSelection ptr) as gboolean

#endif
