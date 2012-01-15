''
''
'' gtknotebook -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtknotebook_bi__
#define __gtknotebook_bi__

#include once "gtk/gdk.bi"
#include once "gtkcontainer.bi"

#define GTK_TYPE_NOTEBOOK (gtk_notebook_get_type ())
#define GTK_NOTEBOOK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_NOTEBOOK, GtkNotebook))
#define GTK_NOTEBOOK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_NOTEBOOK, GtkNotebookClass))
#define GTK_IS_NOTEBOOK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_NOTEBOOK))
#define GTK_IS_NOTEBOOK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_NOTEBOOK))
#define GTK_NOTEBOOK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_NOTEBOOK, GtkNotebookClass))

enum GtkNotebookTab
	GTK_NOTEBOOK_TAB_FIRST
	GTK_NOTEBOOK_TAB_LAST
end enum

type GtkNotebook as _GtkNotebook
type GtkNotebookClass as _GtkNotebookClass
type GtkNotebookPage as _GtkNotebookPage

type _GtkNotebook
	container as GtkContainer
	cur_page as GtkNotebookPage ptr
	children as GList ptr
	first_tab as GList ptr
	focus_tab as GList ptr
	menu as GtkWidget ptr
	event_window as GdkWindow ptr
	timer as guint32
	tab_hborder as guint16
	tab_vborder as guint16
	show_tabs:1 as guint
	homogeneous:1 as guint
	show_border:1 as guint
	tab_pos:2 as guint
	scrollable:1 as guint
	in_child:3 as guint
	click_child:3 as guint
	button:2 as guint
	need_timer:1 as guint
	child_has_focus:1 as guint
	have_visible_child:1 as guint
	focus_out:1 as guint
	has_before_previous:1 as guint
	has_before_next:1 as guint
	has_after_previous:1 as guint
	has_after_next:1 as guint
end type

type _GtkNotebookClass
	parent_class as GtkContainerClass
	switch_page as sub cdecl(byval as GtkNotebook ptr, byval as GtkNotebookPage ptr, byval as guint)
	select_page as function cdecl(byval as GtkNotebook ptr, byval as gboolean) as gboolean
	focus_tab as function cdecl(byval as GtkNotebook ptr, byval as GtkNotebookTab) as gboolean
	change_current_page as sub cdecl(byval as GtkNotebook ptr, byval as gint)
	move_focus_out as sub cdecl(byval as GtkNotebook ptr, byval as GtkDirectionType)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_notebook_get_type () as GType
declare function gtk_notebook_new () as GtkWidget ptr
declare function gtk_notebook_append_page (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr) as gint
declare function gtk_notebook_append_page_menu (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr) as gint
declare function gtk_notebook_prepend_page (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr) as gint
declare function gtk_notebook_prepend_page_menu (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr) as gint
declare function gtk_notebook_insert_page (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval position as gint) as gint
declare function gtk_notebook_insert_page_menu (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr, byval position as gint) as gint
declare sub gtk_notebook_remove_page (byval notebook as GtkNotebook ptr, byval page_num as gint)
declare function gtk_notebook_get_current_page (byval notebook as GtkNotebook ptr) as gint
declare function gtk_notebook_get_nth_page (byval notebook as GtkNotebook ptr, byval page_num as gint) as GtkWidget ptr
declare function gtk_notebook_get_n_pages (byval notebook as GtkNotebook ptr) as gint
declare function gtk_notebook_page_num (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as gint
declare sub gtk_notebook_set_current_page (byval notebook as GtkNotebook ptr, byval page_num as gint)
declare sub gtk_notebook_next_page (byval notebook as GtkNotebook ptr)
declare sub gtk_notebook_prev_page (byval notebook as GtkNotebook ptr)
declare sub gtk_notebook_set_show_border (byval notebook as GtkNotebook ptr, byval show_border as gboolean)
declare function gtk_notebook_get_show_border (byval notebook as GtkNotebook ptr) as gboolean
declare sub gtk_notebook_set_show_tabs (byval notebook as GtkNotebook ptr, byval show_tabs as gboolean)
declare function gtk_notebook_get_show_tabs (byval notebook as GtkNotebook ptr) as gboolean
declare sub gtk_notebook_set_tab_pos (byval notebook as GtkNotebook ptr, byval pos as GtkPositionType)
declare function gtk_notebook_get_tab_pos (byval notebook as GtkNotebook ptr) as GtkPositionType
declare sub gtk_notebook_set_homogeneous_tabs (byval notebook as GtkNotebook ptr, byval homogeneous as gboolean)
declare sub gtk_notebook_set_tab_border (byval notebook as GtkNotebook ptr, byval border_width as guint)
declare sub gtk_notebook_set_tab_hborder (byval notebook as GtkNotebook ptr, byval tab_hborder as guint)
declare sub gtk_notebook_set_tab_vborder (byval notebook as GtkNotebook ptr, byval tab_vborder as guint)
declare sub gtk_notebook_set_scrollable (byval notebook as GtkNotebook ptr, byval scrollable as gboolean)
declare function gtk_notebook_get_scrollable (byval notebook as GtkNotebook ptr) as gboolean
declare sub gtk_notebook_popup_enable (byval notebook as GtkNotebook ptr)
declare sub gtk_notebook_popup_disable (byval notebook as GtkNotebook ptr)
declare function gtk_notebook_get_tab_label (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as GtkWidget ptr
declare sub gtk_notebook_set_tab_label (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr)
declare sub gtk_notebook_set_tab_label_text (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_text as zstring ptr)
declare function gtk_notebook_get_tab_label_text (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as zstring ptr
declare function gtk_notebook_get_menu_label (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as GtkWidget ptr
declare sub gtk_notebook_set_menu_label (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval menu_label as GtkWidget ptr)
declare sub gtk_notebook_set_menu_label_text (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval menu_text as zstring ptr)
declare function gtk_notebook_get_menu_label_text (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as zstring ptr
declare sub gtk_notebook_query_tab_label_packing (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval expand as gboolean ptr, byval fill as gboolean ptr, byval pack_type as GtkPackType ptr)
declare sub gtk_notebook_set_tab_label_packing (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval pack_type as GtkPackType)
declare sub gtk_notebook_reorder_child (byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval position as gint)

#define	gtk_notebook_current_page gtk_notebook_get_current_page
#define gtk_notebook_set_page gtk_notebook_set_current_page

#endif
