''
''
'' gtkclist -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkclist_bi__
#define __gtkclist_bi__

#include once "gtk/gdk.bi"
#include once "gtksignal.bi"
#include once "gtkalignment.bi"
#include once "gtklabel.bi"
#include once "gtkbutton.bi"
#include once "gtkhscrollbar.bi"
#include once "gtkvscrollbar.bi"
#include once "gtkenums.bi"

#define GTK_TYPE_CLIST (gtk_clist_get_type ())
#define GTK_CLIST(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_CLIST, GtkCList))
#define GTK_CLIST_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_CLIST, GtkCListClass))
#define GTK_IS_CLIST(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_CLIST))
#define GTK_IS_CLIST_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CLIST))
#define GTK_CLIST_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_CLIST, GtkCListClass))

#define GTK_CLIST_FLAGS(clist) (GTK_CLIST (clist)->flags)
#define GTK_CLIST_SET_FLAG(clist,flag) GTK_CLIST_FLAGS (clist) or= (GTK_##flag)
#define GTK_CLIST_UNSET_FLAG(clist,flag) GTK_CLIST_FLAGS (clist) and= not(GTK_##flag)

#define GTK_CLIST_IN_DRAG(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_IN_DRAG)
#define GTK_CLIST_ROW_HEIGHT_SET(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_ROW_HEIGHT_SET)
#define GTK_CLIST_SHOW_TITLES(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_SHOW_TITLES)
#define GTK_CLIST_ADD_MODE(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_ADD_MODE)
#define GTK_CLIST_AUTO_SORT(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_AUTO_SORT)
#define GTK_CLIST_AUTO_RESIZE_BLOCKED(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_AUTO_RESIZE_BLOCKED)
#define GTK_CLIST_REORDERABLE(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_REORDERABLE)
#define GTK_CLIST_USE_DRAG_ICONS(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_USE_DRAG_ICONS)
#define GTK_CLIST_DRAW_DRAG_LINE(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_DRAW_DRAG_LINE)
#define GTK_CLIST_DRAW_DRAG_RECT(clist) (GTK_CLIST_FLAGS (clist) and GTK_CLIST_DRAW_DRAG_RECT)

#define GTK_CLIST_ROW(_glist_) cast(GtkCListRow ptr, (_glist_)->data))

#define GTK_CELL_TEXT(cell) cast(GtkCellText ptr, @(cell))
#define GTK_CELL_PIXMAP(cell) cast(GtkCellPixmap ptr, @(cell))
#define GTK_CELL_PIXTEXT(cell) cast(GtkCellPixText ptr, @(cell))
#define GTK_CELL_WIDGET(cell) cast(GtkCellWidget ptr, @(cell))

enum 
	GTK_CLIST_IN_DRAG_ = 1 shl 0
	GTK_CLIST_ROW_HEIGHT_SET_ = 1 shl 1
	GTK_CLIST_SHOW_TITLES_ = 1 shl 2
	GTK_CLIST_ADD_MODE_ = 1 shl 4
	GTK_CLIST_AUTO_SORT_ = 1 shl 5
	GTK_CLIST_AUTO_RESIZE_BLOCKED_ = 1 shl 6
	GTK_CLIST_REORDERABLE_ = 1 shl 7
	GTK_CLIST_USE_DRAG_ICONS_ = 1 shl 8
	GTK_CLIST_DRAW_DRAG_LINE_ = 1 shl 9
	GTK_CLIST_DRAW_DRAG_RECT_ = 1 shl 10
end enum

enum GtkCellType
	GTK_CELL_EMPTY_
	GTK_CELL_TEXT_
	GTK_CELL_PIXMAP_
	GTK_CELL_PIXTEXT_
	GTK_CELL_WIDGET_
end enum


enum GtkCListDragPos
	GTK_CLIST_DRAG_NONE
	GTK_CLIST_DRAG_BEFORE
	GTK_CLIST_DRAG_INTO
	GTK_CLIST_DRAG_AFTER
end enum


enum GtkButtonAction
	GTK_BUTTON_IGNORED = 0
	GTK_BUTTON_SELECTS = 1 shl 0
	GTK_BUTTON_DRAGS = 1 shl 1
	GTK_BUTTON_EXPANDS = 1 shl 2
end enum

type GtkCList as _GtkCList
type GtkCListClass as _GtkCListClass
type GtkCListColumn as _GtkCListColumn
type GtkCListRow as _GtkCListRow
type GtkCell as _GtkCell
type GtkCellText as _GtkCellText
type GtkCellPixmap as _GtkCellPixmap
type GtkCellPixText as _GtkCellPixText
type GtkCellWidget as _GtkCellWidget
type GtkCListCompareFunc as function cdecl(byval as GtkCList ptr, byval as gconstpointer, byval as gconstpointer) as gint
type GtkCListCellInfo as _GtkCListCellInfo
type GtkCListDestInfo as _GtkCListDestInfo

type _GtkCListCellInfo
	row as gint
	column as gint
end type

type _GtkCListDestInfo
	cell as GtkCListCellInfo
	insert_pos as GtkCListDragPos
end type

type _GtkCList
	container as GtkContainer
	flags as guint16
	row_mem_chunk as GMemChunk ptr
	cell_mem_chunk as GMemChunk ptr
	freeze_count as guint
	internal_allocation as GdkRectangle
	rows as gint
	row_height as gint
	row_list as GList ptr
	row_list_end as GList ptr
	columns as gint
	column_title_area as GdkRectangle
	title_window as GdkWindow ptr
	column as GtkCListColumn ptr
	clist_window as GdkWindow ptr
	clist_window_width as gint
	clist_window_height as gint
	hoffset as gint
	voffset as gint
	shadow_type as GtkShadowType
	selection_mode as GtkSelectionMode
	selection as GList ptr
	selection_end as GList ptr
	undo_selection as GList ptr
	undo_unselection as GList ptr
	undo_anchor as gint
	button_actions(0 to 5-1) as guint8
	drag_button as guint8
	click_cell as GtkCListCellInfo
	hadjustment as GtkAdjustment ptr
	vadjustment as GtkAdjustment ptr
	xor_gc as GdkGC ptr
	fg_gc as GdkGC ptr
	bg_gc as GdkGC ptr
	cursor_drag as GdkCursor ptr
	x_drag as gint
	focus_row as gint
	focus_header_column as gint
	anchor as gint
	anchor_state as GtkStateType
	drag_pos as gint
	htimer as gint
	vtimer as gint
	sort_type as GtkSortType
	compare as GtkCListCompareFunc
	sort_column as gint
	drag_highlight_row as gint
	drag_highlight_pos as GtkCListDragPos
end type

type _GtkCListClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub cdecl(byval as GtkCList ptr, byval as GtkAdjustment ptr, byval as GtkAdjustment ptr)
	refresh as sub cdecl(byval as GtkCList ptr)
	select_row as sub cdecl(byval as GtkCList ptr, byval as gint, byval as gint, byval as GdkEvent ptr)
	unselect_row as sub cdecl(byval as GtkCList ptr, byval as gint, byval as gint, byval as GdkEvent ptr)
	row_move as sub cdecl(byval as GtkCList ptr, byval as gint, byval as gint)
	click_column as sub cdecl(byval as GtkCList ptr, byval as gint)
	resize_column as sub cdecl(byval as GtkCList ptr, byval as gint, byval as gint)
	toggle_focus_row as sub cdecl(byval as GtkCList ptr)
	select_all as sub cdecl(byval as GtkCList ptr)
	unselect_all as sub cdecl(byval as GtkCList ptr)
	undo_selection as sub cdecl(byval as GtkCList ptr)
	start_selection as sub cdecl(byval as GtkCList ptr)
	end_selection as sub cdecl(byval as GtkCList ptr)
	extend_selection as sub cdecl(byval as GtkCList ptr, byval as GtkScrollType, byval as gfloat, byval as gboolean)
	scroll_horizontal as sub cdecl(byval as GtkCList ptr, byval as GtkScrollType, byval as gfloat)
	scroll_vertical as sub cdecl(byval as GtkCList ptr, byval as GtkScrollType, byval as gfloat)
	toggle_add_mode as sub cdecl(byval as GtkCList ptr)
	abort_column_resize as sub cdecl(byval as GtkCList ptr)
	resync_selection as sub cdecl(byval as GtkCList ptr, byval as GdkEvent ptr)
	selection_find as function cdecl(byval as GtkCList ptr, byval as gint, byval as GList ptr) as GList
	draw_row as sub cdecl(byval as GtkCList ptr, byval as GdkRectangle ptr, byval as gint, byval as GtkCListRow ptr)
	draw_drag_highlight as sub cdecl(byval as GtkCList ptr, byval as GtkCListRow ptr, byval as gint, byval as GtkCListDragPos)
	clear as sub cdecl(byval as GtkCList ptr)
	fake_unselect_all as sub cdecl(byval as GtkCList ptr, byval as gint)
	sort_list as sub cdecl(byval as GtkCList ptr)
	insert_row as function cdecl(byval as GtkCList ptr, byval as gint, byval as zstring ptr ptr) as gint
	remove_row as sub cdecl(byval as GtkCList ptr, byval as gint)
	set_cell_contents as sub cdecl(byval as GtkCList ptr, byval as GtkCListRow ptr, byval as gint, byval as GtkCellType, byval as zstring ptr, byval as guint8, byval as GdkPixmap ptr, byval as GdkBitmap ptr)
	cell_size_request as sub cdecl(byval as GtkCList ptr, byval as GtkCListRow ptr, byval as gint, byval as GtkRequisition ptr)
end type

type _GtkCListColumn
	title as zstring ptr
	area as GdkRectangle
	button as GtkWidget ptr
	window as GdkWindow ptr
	width as gint
	min_width as gint
	max_width as gint
	justification as GtkJustification
	visible:1 as guint
	width_set:1 as guint
	resizeable:1 as guint
	auto_resize:1 as guint
	button_passive:1 as guint
end type

type _GtkCListRow
	cell as GtkCell ptr
	state as GtkStateType
	foreground as GdkColor
	background as GdkColor
	style as GtkStyle ptr
	data as gpointer
	destroy as GtkDestroyNotify
	fg_set:1 as guint
	bg_set:1 as guint
	selectable:1 as guint
end type

type _GtkCellText
	type as GtkCellType
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	text as zstring ptr
end type

type _GtkCellPixmap
	type as GtkCellType
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
end type

type _GtkCellPixText
	type as GtkCellType
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	text as zstring ptr
	spacing as guint8
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
end type

type _GtkCellWidget
	type as GtkCellType
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	widget as GtkWidget ptr
end type

type _GtkCell_u_pt
	text as zstring ptr
	spacing as guint8
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
end type

type _GtkCell_u_pm
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
end type

union _GtkCell_u
	text as zstring ptr
	widget as GtkWidget ptr
	pt as _GtkCell_u_pt
	pm as _GtkCell_u_pm
end union

type _GtkCell
	type as GtkCellType
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	u as _GtkCell_u
end type

declare function gtk_clist_get_type () as GtkType
declare function gtk_clist_new (byval columns as gint) as GtkWidget ptr
declare function gtk_clist_new_with_titles (byval columns as gint, byval titles as zstring ptr ptr) as GtkWidget ptr
declare sub gtk_clist_set_hadjustment (byval clist as GtkCList ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_clist_set_vadjustment (byval clist as GtkCList ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_clist_get_hadjustment (byval clist as GtkCList ptr) as GtkAdjustment ptr
declare function gtk_clist_get_vadjustment (byval clist as GtkCList ptr) as GtkAdjustment ptr
declare sub gtk_clist_set_shadow_type (byval clist as GtkCList ptr, byval type as GtkShadowType)
declare sub gtk_clist_set_selection_mode (byval clist as GtkCList ptr, byval mode as GtkSelectionMode)
declare sub gtk_clist_set_reorderable (byval clist as GtkCList ptr, byval reorderable as gboolean)
declare sub gtk_clist_set_use_drag_icons (byval clist as GtkCList ptr, byval use_icons as gboolean)
declare sub gtk_clist_set_button_actions (byval clist as GtkCList ptr, byval button as guint, byval button_actions as guint8)
declare sub gtk_clist_freeze (byval clist as GtkCList ptr)
declare sub gtk_clist_thaw (byval clist as GtkCList ptr)
declare sub gtk_clist_column_titles_show (byval clist as GtkCList ptr)
declare sub gtk_clist_column_titles_hide (byval clist as GtkCList ptr)
declare sub gtk_clist_column_title_active (byval clist as GtkCList ptr, byval column as gint)
declare sub gtk_clist_column_title_passive (byval clist as GtkCList ptr, byval column as gint)
declare sub gtk_clist_column_titles_active (byval clist as GtkCList ptr)
declare sub gtk_clist_column_titles_passive (byval clist as GtkCList ptr)
declare sub gtk_clist_set_column_title (byval clist as GtkCList ptr, byval column as gint, byval title as zstring ptr)
declare function gtk_clist_get_column_title (byval clist as GtkCList ptr, byval column as gint) as zstring ptr
declare sub gtk_clist_set_column_widget (byval clist as GtkCList ptr, byval column as gint, byval widget as GtkWidget ptr)
declare function gtk_clist_get_column_widget (byval clist as GtkCList ptr, byval column as gint) as GtkWidget ptr
declare sub gtk_clist_set_column_justification (byval clist as GtkCList ptr, byval column as gint, byval justification as GtkJustification)
declare sub gtk_clist_set_column_visibility (byval clist as GtkCList ptr, byval column as gint, byval visible as gboolean)
declare sub gtk_clist_set_column_resizeable (byval clist as GtkCList ptr, byval column as gint, byval resizeable as gboolean)
declare sub gtk_clist_set_column_auto_resize (byval clist as GtkCList ptr, byval column as gint, byval auto_resize as gboolean)
declare function gtk_clist_columns_autosize (byval clist as GtkCList ptr) as gint
declare function gtk_clist_optimal_column_width (byval clist as GtkCList ptr, byval column as gint) as gint
declare sub gtk_clist_set_column_width (byval clist as GtkCList ptr, byval column as gint, byval width as gint)
declare sub gtk_clist_set_column_min_width (byval clist as GtkCList ptr, byval column as gint, byval min_width as gint)
declare sub gtk_clist_set_column_max_width (byval clist as GtkCList ptr, byval column as gint, byval max_width as gint)
declare sub gtk_clist_set_row_height (byval clist as GtkCList ptr, byval height as guint)
declare sub gtk_clist_moveto (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval row_align as gfloat, byval col_align as gfloat)
declare function gtk_clist_row_is_visible (byval clist as GtkCList ptr, byval row as gint) as GtkVisibility
declare function gtk_clist_get_cell_type (byval clist as GtkCList ptr, byval row as gint, byval column as gint) as GtkCellType
declare sub gtk_clist_set_text (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval text as zstring ptr)
declare function gtk_clist_get_text (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval text as zstring ptr ptr) as gint
declare sub gtk_clist_set_pixmap (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare function gtk_clist_get_pixmap (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr) as gint
declare sub gtk_clist_set_pixtext (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval text as zstring ptr, byval spacing as guint8, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare function gtk_clist_get_pixtext (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval text as zstring ptr ptr, byval spacing as guint8 ptr, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr) as gint
declare sub gtk_clist_set_foreground (byval clist as GtkCList ptr, byval row as gint, byval color as GdkColor ptr)
declare sub gtk_clist_set_background (byval clist as GtkCList ptr, byval row as gint, byval color as GdkColor ptr)
declare sub gtk_clist_set_cell_style (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval style as GtkStyle ptr)
declare function gtk_clist_get_cell_style (byval clist as GtkCList ptr, byval row as gint, byval column as gint) as GtkStyle ptr
declare sub gtk_clist_set_row_style (byval clist as GtkCList ptr, byval row as gint, byval style as GtkStyle ptr)
declare function gtk_clist_get_row_style (byval clist as GtkCList ptr, byval row as gint) as GtkStyle ptr
declare sub gtk_clist_set_shift (byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval vertical as gint, byval horizontal as gint)
declare sub gtk_clist_set_selectable (byval clist as GtkCList ptr, byval row as gint, byval selectable as gboolean)
declare function gtk_clist_get_selectable (byval clist as GtkCList ptr, byval row as gint) as gboolean
declare function gtk_clist_prepend (byval clist as GtkCList ptr, byval text as zstring ptr ptr) as gint
declare function gtk_clist_append (byval clist as GtkCList ptr, byval text as zstring ptr ptr) as gint
declare function gtk_clist_insert (byval clist as GtkCList ptr, byval row as gint, byval text as zstring ptr ptr) as gint
declare sub gtk_clist_remove (byval clist as GtkCList ptr, byval row as gint)
declare sub gtk_clist_set_row_data (byval clist as GtkCList ptr, byval row as gint, byval data as gpointer)
declare sub gtk_clist_set_row_data_full (byval clist as GtkCList ptr, byval row as gint, byval data as gpointer, byval destroy as GtkDestroyNotify)
declare function gtk_clist_get_row_data (byval clist as GtkCList ptr, byval row as gint) as gpointer
declare function gtk_clist_find_row_from_data (byval clist as GtkCList ptr, byval data as gpointer) as gint
declare sub gtk_clist_select_row (byval clist as GtkCList ptr, byval row as gint, byval column as gint)
declare sub gtk_clist_unselect_row (byval clist as GtkCList ptr, byval row as gint, byval column as gint)
declare sub gtk_clist_undo_selection (byval clist as GtkCList ptr)
declare sub gtk_clist_clear (byval clist as GtkCList ptr)
declare function gtk_clist_get_selection_info (byval clist as GtkCList ptr, byval x as gint, byval y as gint, byval row as gint ptr, byval column as gint ptr) as gint
declare sub gtk_clist_select_all (byval clist as GtkCList ptr)
declare sub gtk_clist_unselect_all (byval clist as GtkCList ptr)
declare sub gtk_clist_swap_rows (byval clist as GtkCList ptr, byval row1 as gint, byval row2 as gint)
declare sub gtk_clist_row_move (byval clist as GtkCList ptr, byval source_row as gint, byval dest_row as gint)
declare sub gtk_clist_set_compare_func (byval clist as GtkCList ptr, byval cmp_func as GtkCListCompareFunc)
declare sub gtk_clist_set_sort_column (byval clist as GtkCList ptr, byval column as gint)
declare sub gtk_clist_set_sort_type (byval clist as GtkCList ptr, byval sort_type as GtkSortType)
declare sub gtk_clist_sort (byval clist as GtkCList ptr)
declare sub gtk_clist_set_auto_sort (byval clist as GtkCList ptr, byval auto_sort as gboolean)
declare function _gtk_clist_create_cell_layout (byval clist as GtkCList ptr, byval clist_row as GtkCListRow ptr, byval column as gint) as PangoLayout ptr

#endif
