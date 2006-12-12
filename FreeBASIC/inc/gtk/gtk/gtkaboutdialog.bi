''
''
'' gtkaboutdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkaboutdialog_bi__
#define __gtkaboutdialog_bi__

#include once "gtkdialog.bi"

#define GTK_TYPE_ABOUT_DIALOG (gtk_about_dialog_get_type ())
#define GTK_ABOUT_DIALOG(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialog))
#define GTK_ABOUT_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialogClass))
#define GTK_IS_ABOUT_DIALOG(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_ABOUT_DIALOG))
#define GTK_IS_ABOUT_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ABOUT_DIALOG))
#define GTK_ABOUT_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialogClass))

type GtkAboutDialog as _GtkAboutDialog
type GtkAboutDialogClass as _GtkAboutDialogClass

type _GtkAboutDialog
	parent_instance as GtkDialog
	private_data as gpointer
end type

type _GtkAboutDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_about_dialog_get_type () as GType
declare function gtk_about_dialog_new () as GtkWidget ptr
declare sub gtk_show_about_dialog (byval parent as GtkWindow ptr, byval first_property_name as zstring ptr, ...)
declare function gtk_about_dialog_get_name (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_name (byval about as GtkAboutDialog ptr, byval name as zstring ptr)
declare function gtk_about_dialog_get_version (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_version (byval about as GtkAboutDialog ptr, byval version as zstring ptr)
declare function gtk_about_dialog_get_copyright (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_copyright (byval about as GtkAboutDialog ptr, byval copyright as zstring ptr)
declare function gtk_about_dialog_get_comments (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_comments (byval about as GtkAboutDialog ptr, byval comments as zstring ptr)
declare function gtk_about_dialog_get_license (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_license (byval about as GtkAboutDialog ptr, byval license as zstring ptr)
declare function gtk_about_dialog_get_website (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_website (byval about as GtkAboutDialog ptr, byval website as zstring ptr)
declare function gtk_about_dialog_get_website_label (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_website_label (byval about as GtkAboutDialog ptr, byval website_label as zstring ptr)
declare function gtk_about_dialog_get_authors (byval about as GtkAboutDialog ptr) as zstring ptr ptr
declare sub gtk_about_dialog_set_authors (byval about as GtkAboutDialog ptr, byval authors as zstring ptr ptr)
declare function gtk_about_dialog_get_documenters (byval about as GtkAboutDialog ptr) as zstring ptr ptr
declare sub gtk_about_dialog_set_documenters (byval about as GtkAboutDialog ptr, byval documenters as zstring ptr ptr)
declare function gtk_about_dialog_get_artists (byval about as GtkAboutDialog ptr) as zstring ptr ptr
declare sub gtk_about_dialog_set_artists (byval about as GtkAboutDialog ptr, byval artists as zstring ptr ptr)
declare function gtk_about_dialog_get_translator_credits (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_translator_credits (byval about as GtkAboutDialog ptr, byval translator_credits as zstring ptr)
declare function gtk_about_dialog_get_logo (byval about as GtkAboutDialog ptr) as GdkPixbuf ptr
declare sub gtk_about_dialog_set_logo (byval about as GtkAboutDialog ptr, byval logo as GdkPixbuf ptr)
declare function gtk_about_dialog_get_logo_icon_name (byval about as GtkAboutDialog ptr) as zstring ptr
declare sub gtk_about_dialog_set_logo_icon_name (byval about as GtkAboutDialog ptr, byval icon_name as zstring ptr)

type GtkAboutDialogActivateLinkFunc as sub cdecl(byval as GtkAboutDialog ptr, byval as zstring ptr, byval as gpointer)

declare function gtk_about_dialog_set_email_hook (byval func as GtkAboutDialogActivateLinkFunc, byval data as gpointer, byval destroy as GDestroyNotify) as GtkAboutDialogActivateLinkFunc
declare function gtk_about_dialog_set_url_hook (byval func as GtkAboutDialogActivateLinkFunc, byval data as gpointer, byval destroy as GDestroyNotify) as GtkAboutDialogActivateLinkFunc

#endif
