''
''
'' gtkgamma -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkgamma_bi__
#define __gtkgamma_bi__

#include once "gtk/gdk.bi"
#include once "gtkvbox.bi"

#define GTK_TYPE_GAMMA_CURVE (gtk_gamma_curve_get_type ())
#define GTK_GAMMA_CURVE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_GAMMA_CURVE, GtkGammaCurve))
#define GTK_GAMMA_CURVE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_GAMMA_CURVE, GtkGammaCurveClass))
#define GTK_IS_GAMMA_CURVE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_GAMMA_CURVE))
#define GTK_IS_GAMMA_CURVE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_GAMMA_CURVE))
#define GTK_GAMMA_CURVE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_GAMMA_CURVE, GtkGammaCurveClass))

type GtkGammaCurve as _GtkGammaCurve
type GtkGammaCurveClass as _GtkGammaCurveClass

type _GtkGammaCurve
	vbox as GtkVBox
	table as GtkWidget ptr
	curve as GtkWidget ptr
	button(0 to 5-1) as GtkWidget ptr
	gamma as gfloat
	gamma_dialog as GtkWidget ptr
	gamma_text as GtkWidget ptr
end type

type _GtkGammaCurveClass
	parent_class as GtkVBoxClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_gamma_curve_get_type () as GType
declare function gtk_gamma_curve_new () as GtkWidget ptr

#endif
