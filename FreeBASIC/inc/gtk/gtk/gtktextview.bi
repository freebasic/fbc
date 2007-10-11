''
''
'' gtktextview -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktextview_bi__
#define __gtktextview_bi__

#include once "gtkcontainer.bi"
#include once "gtkimcontext.bi"
#include once "gtktextbuffer.bi"
#include once "gtkmenu.bi"

#define GTK_TYPE_TEXT_VIEW (gtk_text_view_get_type ())
#define GTK_TEXT_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_VIEW, GtkTextView))
#define GTK_TEXT_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_VIEW, GtkTextViewClass))
#define GTK_IS_TEXT_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_VIEW))
#define GTK_IS_TEXT_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_VIEW))
#define GTK_TEXT_VIEW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_VIEW, GtkTextViewClass))

enum GtkTextWindowType
	GTK_TEXT_WINDOW_PRIVATE
	GTK_TEXT_WINDOW_WIDGET
	GTK_TEXT_WINDOW_TEXT
	GTK_TEXT_WINDOW_LEFT
	GTK_TEXT_WINDOW_RIGHT
	GTK_TEXT_WINDOW_TOP
	GTK_TEXT_WINDOW_BOTTOM
end enum

type GtkTextView as _GtkTextView
type GtkTextViewClass as _GtkTextViewClass
type GtkTextWindow as _GtkTextWindow
type GtkTextPendingScroll as _GtkTextPendingScroll
type _GtkTextLayout as any

type _GtkTextView
	parent_instance as GtkContainer
	layout as _GtkTextLayout ptr
	buffer as GtkTextBuffer ptr
	selection_drag_handler as guint
	scroll_timeout as guint
	pixels_above_lines as gint
	pixels_below_lines as gint
	pixels_inside_wrap as gint
	wrap_mode as GtkWrapMode
	justify as GtkJustification
	left_margin as gint
	right_margin as gint
	indent as gint
	tabs as PangoTabArray ptr
	editable:1 as guint
	overwrite_mode:1 as guint
	cursor_visible:1 as guint
	need_im_reset:1 as guint
	accepts_tab:1 as guint
	reserved:1 as guint
	onscreen_validated:1 as guint
	mouse_cursor_obscured:1 as guint
	text_window as GtkTextWindow ptr
	left_window as GtkTextWindow ptr
	right_window as GtkTextWindow ptr
	top_window as GtkTextWindow ptr
	bottom_window as GtkTextWindow ptr
	hadjustment as GtkAdjustment ptr
	vadjustment as GtkAdjustment ptr
	xoffset as gint
	yoffset as gint
	width as gint
	height as gint
	virtual_cursor_x as gint
	virtual_cursor_y as gint
	first_para_mark as GtkTextMark ptr
	first_para_pixels as gint
	dnd_mark as GtkTextMark ptr
	blink_timeout as guint
	first_validate_idle as guint
	incremental_validate_idle as guint
	im_context as GtkIMContext ptr
	popup_menu as GtkWidget ptr
	drag_start_x as gint
	drag_start_y as gint
	children as GSList ptr
	pending_scroll as GtkTextPendingScroll ptr
	pending_place_cursor_button as gint
end type

type _GtkTextViewClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub cdecl(byval as GtkTextView ptr, byval as GtkAdjustment ptr, byval as GtkAdjustment ptr)
	populate_popup as sub cdecl(byval as GtkTextView ptr, byval as GtkMenu ptr)
	move_cursor as sub cdecl(byval as GtkTextView ptr, byval as GtkMovementStep, byval as gint, byval as gboolean)
	page_horizontally as sub cdecl(byval as GtkTextView ptr, byval as gint, byval as gboolean)
	set_anchor as sub cdecl(byval as GtkTextView ptr)
	insert_at_cursor as sub cdecl(byval as GtkTextView ptr, byval as zstring ptr)
	delete_from_cursor as sub cdecl(byval as GtkTextView ptr, byval as GtkDeleteType, byval as gint)
	backspace as sub cdecl(byval as GtkTextView ptr)
	cut_clipboard as sub cdecl(byval as GtkTextView ptr)
	copy_clipboard as sub cdecl(byval as GtkTextView ptr)
	paste_clipboard as sub cdecl(byval as GtkTextView ptr)
	toggle_overwrite as sub cdecl(byval as GtkTextView ptr)
	move_focus as sub cdecl(byval as GtkTextView ptr, byval as GtkDirectionType)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
	_gtk_reserved5 as sub cdecl()
	_gtk_reserved6 as sub cdecl()
	_gtk_reserved7 as sub cdecl()
end type

declare function gtk_text_view_get_type () as GType
declare function gtk_text_view_new () as GtkWidget ptr
declare function gtk_text_view_new_with_buffer (byval buffer as GtkTextBuffer ptr) as GtkWidget ptr
declare sub gtk_text_view_set_buffer (byval text_view as GtkTextView ptr, byval buffer as GtkTextBuffer ptr)
declare function gtk_text_view_get_buffer (byval text_view as GtkTextView ptr) as GtkTextBuffer ptr
declare function gtk_text_view_scroll_to_iter (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval within_margin as gdouble, byval use_align as gboolean, byval xalign as gdouble, byval yalign as gdouble) as gboolean
declare sub gtk_text_view_scroll_to_mark (byval text_view as GtkTextView ptr, byval mark as GtkTextMark ptr, byval within_margin as gdouble, byval use_align as gboolean, byval xalign as gdouble, byval yalign as gdouble)
declare sub gtk_text_view_scroll_mark_onscreen (byval text_view as GtkTextView ptr, byval mark as GtkTextMark ptr)
declare function gtk_text_view_move_mark_onscreen (byval text_view as GtkTextView ptr, byval mark as GtkTextMark ptr) as gboolean
declare function gtk_text_view_place_cursor_onscreen (byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_get_visible_rect (byval text_view as GtkTextView ptr, byval visible_rect as GdkRectangle ptr)
declare sub gtk_text_view_set_cursor_visible (byval text_view as GtkTextView ptr, byval setting as gboolean)
declare function gtk_text_view_get_cursor_visible (byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_get_iter_location (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval location as GdkRectangle ptr)
declare sub gtk_text_view_get_iter_at_location (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval x as gint, byval y as gint)
declare sub gtk_text_view_get_iter_at_position (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval trailing as gint ptr, byval x as gint, byval y as gint)
declare sub gtk_text_view_get_line_yrange (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval y as gint ptr, byval height as gint ptr)
declare sub gtk_text_view_get_line_at_y (byval text_view as GtkTextView ptr, byval target_iter as GtkTextIter ptr, byval y as gint, byval line_top as gint ptr)
declare sub gtk_text_view_buffer_to_window_coords (byval text_view as GtkTextView ptr, byval win as GtkTextWindowType, byval buffer_x as gint, byval buffer_y as gint, byval window_x as gint ptr, byval window_y as gint ptr)
declare sub gtk_text_view_window_to_buffer_coords (byval text_view as GtkTextView ptr, byval win as GtkTextWindowType, byval window_x as gint, byval window_y as gint, byval buffer_x as gint ptr, byval buffer_y as gint ptr)
declare function gtk_text_view_get_window (byval text_view as GtkTextView ptr, byval win as GtkTextWindowType) as GdkWindow ptr
declare function gtk_text_view_get_window_type (byval text_view as GtkTextView ptr, byval window as GdkWindow ptr) as GtkTextWindowType
declare sub gtk_text_view_set_border_window_size (byval text_view as GtkTextView ptr, byval type as GtkTextWindowType, byval size as gint)
declare function gtk_text_view_get_border_window_size (byval text_view as GtkTextView ptr, byval type as GtkTextWindowType) as gint
declare function gtk_text_view_forward_display_line (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_backward_display_line (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_forward_display_line_end (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_backward_display_line_start (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_starts_display_line (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_move_visually (byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare sub gtk_text_view_add_child_at_anchor (byval text_view as GtkTextView ptr, byval child as GtkWidget ptr, byval anchor as GtkTextChildAnchor ptr)
declare sub gtk_text_view_add_child_in_window (byval text_view as GtkTextView ptr, byval child as GtkWidget ptr, byval which_window as GtkTextWindowType, byval xpos as gint, byval ypos as gint)
declare sub gtk_text_view_move_child (byval text_view as GtkTextView ptr, byval child as GtkWidget ptr, byval xpos as gint, byval ypos as gint)
declare sub gtk_text_view_set_wrap_mode (byval text_view as GtkTextView ptr, byval wrap_mode as GtkWrapMode)
declare function gtk_text_view_get_wrap_mode (byval text_view as GtkTextView ptr) as GtkWrapMode
declare sub gtk_text_view_set_editable (byval text_view as GtkTextView ptr, byval setting as gboolean)
declare function gtk_text_view_get_editable (byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_set_overwrite (byval text_view as GtkTextView ptr, byval overwrite as gboolean)
declare function gtk_text_view_get_overwrite (byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_set_accepts_tab (byval text_view as GtkTextView ptr, byval accepts_tab as gboolean)
declare function gtk_text_view_get_accepts_tab (byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_set_pixels_above_lines (byval text_view as GtkTextView ptr, byval pixels_above_lines as gint)
declare function gtk_text_view_get_pixels_above_lines (byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_pixels_below_lines (byval text_view as GtkTextView ptr, byval pixels_below_lines as gint)
declare function gtk_text_view_get_pixels_below_lines (byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_pixels_inside_wrap (byval text_view as GtkTextView ptr, byval pixels_inside_wrap as gint)
declare function gtk_text_view_get_pixels_inside_wrap (byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_justification (byval text_view as GtkTextView ptr, byval justification as GtkJustification)
declare function gtk_text_view_get_justification (byval text_view as GtkTextView ptr) as GtkJustification
declare sub gtk_text_view_set_left_margin (byval text_view as GtkTextView ptr, byval left_margin as gint)
declare function gtk_text_view_get_left_margin (byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_right_margin (byval text_view as GtkTextView ptr, byval right_margin as gint)
declare function gtk_text_view_get_right_margin (byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_indent (byval text_view as GtkTextView ptr, byval indent as gint)
declare function gtk_text_view_get_indent (byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_tabs (byval text_view as GtkTextView ptr, byval tabs as PangoTabArray ptr)
declare function gtk_text_view_get_tabs (byval text_view as GtkTextView ptr) as PangoTabArray ptr
declare function gtk_text_view_get_default_attributes (byval text_view as GtkTextView ptr) as GtkTextAttributes ptr

#endif
