''
''
'' gtkclipboard -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkclipboard_bi__
#define __gtkclipboard_bi__

#include once "gtkselection.bi"

#define GTK_TYPE_CLIPBOARD (gtk_clipboard_get_type ())
#define GTK_CLIPBOARD(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CLIPBOARD, GtkClipboard))
#define GTK_IS_CLIPBOARD(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CLIPBOARD))

type GtkClipboardReceivedFunc as sub cdecl(byval as GtkClipboard ptr, byval as GtkSelectionData ptr, byval as gpointer)
type GtkClipboardTextReceivedFunc as sub cdecl(byval as GtkClipboard ptr, byval as zstring ptr, byval as gpointer)
type GtkClipboardImageReceivedFunc as sub cdecl(byval as GtkClipboard ptr, byval as GdkPixbuf ptr, byval as gpointer)
type GtkClipboardTargetsReceivedFunc as sub cdecl(byval as GtkClipboard ptr, byval as GdkAtom ptr, byval as gint, byval as gpointer)
type GtkClipboardGetFunc as sub cdecl(byval as GtkClipboard ptr, byval as GtkSelectionData ptr, byval as guint, byval as gpointer)
type GtkClipboardClearFunc as sub cdecl(byval as GtkClipboard ptr, byval as gpointer)

declare function gtk_clipboard_get_type () as GType
declare function gtk_clipboard_get_for_display (byval display as GdkDisplay ptr, byval selection as GdkAtom) as GtkClipboard ptr
declare function gtk_clipboard_get (byval selection as GdkAtom) as GtkClipboard ptr
declare function gtk_clipboard_get_display (byval clipboard as GtkClipboard ptr) as GdkDisplay ptr
declare function gtk_clipboard_set_with_data (byval clipboard as GtkClipboard ptr, byval targets as GtkTargetEntry ptr, byval n_targets as guint, byval get_func as GtkClipboardGetFunc, byval clear_func as GtkClipboardClearFunc, byval user_data as gpointer) as gboolean
declare function gtk_clipboard_set_with_owner (byval clipboard as GtkClipboard ptr, byval targets as GtkTargetEntry ptr, byval n_targets as guint, byval get_func as GtkClipboardGetFunc, byval clear_func as GtkClipboardClearFunc, byval owner as GObject ptr) as gboolean
declare function gtk_clipboard_get_owner (byval clipboard as GtkClipboard ptr) as GObject ptr
declare sub gtk_clipboard_clear (byval clipboard as GtkClipboard ptr)
declare sub gtk_clipboard_set_text (byval clipboard as GtkClipboard ptr, byval text as zstring ptr, byval len as gint)
declare sub gtk_clipboard_set_image (byval clipboard as GtkClipboard ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_clipboard_request_contents (byval clipboard as GtkClipboard ptr, byval target as GdkAtom, byval callback as GtkClipboardReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_text (byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardTextReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_image (byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardImageReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_targets (byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardTargetsReceivedFunc, byval user_data as gpointer)
declare function gtk_clipboard_wait_for_contents (byval clipboard as GtkClipboard ptr, byval target as GdkAtom) as GtkSelectionData ptr
declare function gtk_clipboard_wait_for_text (byval clipboard as GtkClipboard ptr) as zstring ptr
declare function gtk_clipboard_wait_for_image (byval clipboard as GtkClipboard ptr) as GdkPixbuf ptr
declare function gtk_clipboard_wait_for_targets (byval clipboard as GtkClipboard ptr, byval targets as GdkAtom ptr ptr, byval n_targets as gint ptr) as gboolean
declare function gtk_clipboard_wait_is_text_available (byval clipboard as GtkClipboard ptr) as gboolean
declare function gtk_clipboard_wait_is_image_available (byval clipboard as GtkClipboard ptr) as gboolean
declare function gtk_clipboard_wait_is_target_available (byval clipboard as GtkClipboard ptr, byval target as GdkAtom) as gboolean
declare sub gtk_clipboard_set_can_store (byval clipboard as GtkClipboard ptr, byval targets as GtkTargetEntry ptr, byval n_targets as gint)
declare sub gtk_clipboard_store (byval clipboard as GtkClipboard ptr)
declare sub _gtk_clipboard_handle_event (byval event as GdkEventOwnerChange ptr)
declare sub _gtk_clipboard_store_all ()

#endif
