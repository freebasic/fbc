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
#include once "gtk/gtk/gtkdialog.bi"

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
	fileop_file as gchar ptr
	cmpl_state as gpointer
	fileop_c_dir as GtkWidget ptr
	fileop_del_file as GtkWidget ptr
	fileop_ren_file as GtkWidget ptr
	button_area as GtkWidget ptr
	action_area as GtkWidget ptr
	selected_names as GPtrArray ptr
	last_selected as gchar ptr
end type

type _GtkFileSelectionClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_file_selection_get_type cdecl alias "gtk_file_selection_get_type" () as GType
declare function gtk_file_selection_new cdecl alias "gtk_file_selection_new" (byval title as gchar ptr) as GtkWidget ptr
declare sub gtk_file_selection_set_filename cdecl alias "gtk_file_selection_set_filename" (byval filesel as GtkFileSelection ptr, byval filename as gchar ptr)
declare function gtk_file_selection_get_filename cdecl alias "gtk_file_selection_get_filename" (byval filesel as GtkFileSelection ptr) as gchar ptr
declare sub gtk_file_selection_complete cdecl alias "gtk_file_selection_complete" (byval filesel as GtkFileSelection ptr, byval pattern as gchar ptr)
declare sub gtk_file_selection_show_fileop_buttons cdecl alias "gtk_file_selection_show_fileop_buttons" (byval filesel as GtkFileSelection ptr)
declare sub gtk_file_selection_hide_fileop_buttons cdecl alias "gtk_file_selection_hide_fileop_buttons" (byval filesel as GtkFileSelection ptr)
declare function gtk_file_selection_get_selections cdecl alias "gtk_file_selection_get_selections" (byval filesel as GtkFileSelection ptr) as gchar ptr ptr
declare sub gtk_file_selection_set_select_multiple cdecl alias "gtk_file_selection_set_select_multiple" (byval filesel as GtkFileSelection ptr, byval select_multiple as gboolean)
declare function gtk_file_selection_get_select_multiple cdecl alias "gtk_file_selection_get_select_multiple" (byval filesel as GtkFileSelection ptr) as gboolean

#endif
