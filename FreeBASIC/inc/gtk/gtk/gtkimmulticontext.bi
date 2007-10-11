''
''
'' gtkimmulticontext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkimmulticontext_bi__
#define __gtkimmulticontext_bi__

#include once "gtkimcontext.bi"
#include once "gtkmenushell.bi"

#define GTK_TYPE_IM_MULTICONTEXT (gtk_im_multicontext_get_type ())
#define GTK_IM_MULTICONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontext))
#define GTK_IM_MULTICONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontextClass))
#define GTK_IS_IM_MULTICONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IM_MULTICONTEXT))
#define GTK_IS_IM_MULTICONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IM_MULTICONTEXT))
#define GTK_IM_MULTICONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontextClass))


type GtkIMMulticontext as _GtkIMMulticontext
type GtkIMMulticontextClass as _GtkIMMulticontextClass
type GtkIMMulticontextPrivate as _GtkIMMulticontextPrivate

type _GtkIMMulticontext
	object as GtkIMContext
	slave as GtkIMContext ptr
	priv as GtkIMMulticontextPrivate ptr
	context_id as zstring ptr
end type

type _GtkIMMulticontextClass
	parent_class as GtkIMContextClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_im_multicontext_get_type () as GType
declare function gtk_im_multicontext_new () as GtkIMContext ptr
declare sub gtk_im_multicontext_append_menuitems (byval context as GtkIMMulticontext ptr, byval menushell as GtkMenuShell ptr)

#endif
