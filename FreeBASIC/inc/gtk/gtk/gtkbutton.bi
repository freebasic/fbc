''
''
'' gtkbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkbutton_bi__
#define __gtkbutton_bi__

#include once "gtk/gdk.bi"
#include once "gtkbin.bi"
#include once "gtkenums.bi"
#include once "gtkimage.bi"

#define GTK_TYPE_BUTTON (gtk_button_get_type ())
#define GTK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BUTTON, GtkButton))
#define GTK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BUTTON, GtkButtonClass))
#define GTK_IS_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BUTTON))
#define GTK_IS_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BUTTON))
#define GTK_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BUTTON, GtkButtonClass))

type GtkButton as _GtkButton
type GtkButtonClass as _GtkButtonClass

type _GtkButton
	bin as GtkBin
	event_window as GdkWindow ptr
	label_text as zstring ptr
	activate_timeout as guint
	constructed:1 as guint
	in_button:1 as guint
	button_down:1 as guint
	relief:2 as guint
	use_underline:1 as guint
	use_stock:1 as guint
	depressed:1 as guint
	depress_on_activate:1 as guint
	focus_on_click:1 as guint
end type

type _GtkButtonClass
	parent_class as GtkBinClass
	pressed as sub cdecl(byval as GtkButton ptr)
	released as sub cdecl(byval as GtkButton ptr)
	clicked as sub cdecl(byval as GtkButton ptr)
	enter as sub cdecl(byval as GtkButton ptr)
	leave as sub cdecl(byval as GtkButton ptr)
	activate as sub cdecl(byval as GtkButton ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_button_get_type () as GType
declare function gtk_button_new () as GtkWidget ptr
declare function gtk_button_new_with_label (byval label as zstring ptr) as GtkWidget ptr
declare function gtk_button_new_from_stock (byval stock_id as zstring ptr) as GtkWidget ptr
declare function gtk_button_new_with_mnemonic (byval label as zstring ptr) as GtkWidget ptr
declare sub gtk_button_pressed (byval button as GtkButton ptr)
declare sub gtk_button_released (byval button as GtkButton ptr)
declare sub gtk_button_clicked (byval button as GtkButton ptr)
declare sub gtk_button_enter (byval button as GtkButton ptr)
declare sub gtk_button_leave (byval button as GtkButton ptr)
declare sub gtk_button_set_relief (byval button as GtkButton ptr, byval newstyle as GtkReliefStyle)
declare function gtk_button_get_relief (byval button as GtkButton ptr) as GtkReliefStyle
declare sub gtk_button_set_label (byval button as GtkButton ptr, byval label as zstring ptr)
declare function gtk_button_get_label (byval button as GtkButton ptr) as zstring ptr
declare sub gtk_button_set_use_underline (byval button as GtkButton ptr, byval use_underline as gboolean)
declare function gtk_button_get_use_underline (byval button as GtkButton ptr) as gboolean
declare sub gtk_button_set_use_stock (byval button as GtkButton ptr, byval use_stock as gboolean)
declare function gtk_button_get_use_stock (byval button as GtkButton ptr) as gboolean
declare sub gtk_button_set_focus_on_click (byval button as GtkButton ptr, byval focus_on_click as gboolean)
declare function gtk_button_get_focus_on_click (byval button as GtkButton ptr) as gboolean
declare sub gtk_button_set_alignment (byval button as GtkButton ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_button_get_alignment (byval button as GtkButton ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_button_set_image (byval button as GtkButton ptr, byval image as GtkWidget ptr)
declare function gtk_button_get_image (byval button as GtkButton ptr) as GtkWidget ptr
declare sub _gtk_button_set_depressed (byval button as GtkButton ptr, byval depressed as gboolean)
declare sub _gtk_button_paint (byval button as GtkButton ptr, byval area as GdkRectangle ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval main_detail as zstring ptr, byval default_detail as zstring ptr)

#endif
