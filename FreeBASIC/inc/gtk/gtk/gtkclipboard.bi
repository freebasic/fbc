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

#include once "gtk/gtk/gtkselection.bi"

type GtkClipboardReceivedFunc as sub cdecl(byval as GtkClipboard ptr, byval as GtkSelectionData ptr, byval as gpointer)
type GtkClipboardTextReceivedFunc as sub cdecl(byval as GtkClipboard ptr, byval as gchar ptr, byval as gpointer)
type GtkClipboardImageReceivedFunc as sub cdecl(byval as GtkClipboard ptr, byval as GdkPixbuf ptr, byval as gpointer)
type GtkClipboardTargetsReceivedFunc as sub cdecl(byval as GtkClipboard ptr, byval as GdkAtom ptr, byval as gint, byval as gpointer)
type GtkClipboardGetFunc as sub cdecl(byval as GtkClipboard ptr, byval as GtkSelectionData ptr, byval as guint, byval as gpointer)
type GtkClipboardClearFunc as sub cdecl(byval as GtkClipboard ptr, byval as gpointer)

declare function gtk_clipboard_get_type cdecl alias "gtk_clipboard_get_type" () as GType
declare function gtk_clipboard_get_for_display cdecl alias "gtk_clipboard_get_for_display" (byval display as GdkDisplay ptr, byval selection as GdkAtom) as GtkClipboard ptr
declare function gtk_clipboard_get cdecl alias "gtk_clipboard_get" (byval selection as GdkAtom) as GtkClipboard ptr
declare function gtk_clipboard_get_display cdecl alias "gtk_clipboard_get_display" (byval clipboard as GtkClipboard ptr) as GdkDisplay ptr
declare function gtk_clipboard_set_with_data cdecl alias "gtk_clipboard_set_with_data" (byval clipboard as GtkClipboard ptr, byval targets as GtkTargetEntry ptr, byval n_targets as guint, byval get_func as GtkClipboardGetFunc, byval clear_func as GtkClipboardClearFunc, byval user_data as gpointer) as gboolean
declare function gtk_clipboard_set_with_owner cdecl alias "gtk_clipboard_set_with_owner" (byval clipboard as GtkClipboard ptr, byval targets as GtkTargetEntry ptr, byval n_targets as guint, byval get_func as GtkClipboardGetFunc, byval clear_func as GtkClipboardClearFunc, byval owner as GObject ptr) as gboolean
declare function gtk_clipboard_get_owner cdecl alias "gtk_clipboard_get_owner" (byval clipboard as GtkClipboard ptr) as GObject ptr
declare sub gtk_clipboard_clear cdecl alias "gtk_clipboard_clear" (byval clipboard as GtkClipboard ptr)
declare sub gtk_clipboard_set_text cdecl alias "gtk_clipboard_set_text" (byval clipboard as GtkClipboard ptr, byval text as gchar ptr, byval len as gint)
declare sub gtk_clipboard_set_image cdecl alias "gtk_clipboard_set_image" (byval clipboard as GtkClipboard ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_clipboard_request_contents cdecl alias "gtk_clipboard_request_contents" (byval clipboard as GtkClipboard ptr, byval target as GdkAtom, byval callback as GtkClipboardReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_text cdecl alias "gtk_clipboard_request_text" (byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardTextReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_image cdecl alias "gtk_clipboard_request_image" (byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardImageReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_targets cdecl alias "gtk_clipboard_request_targets" (byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardTargetsReceivedFunc, byval user_data as gpointer)
declare function gtk_clipboard_wait_for_contents cdecl alias "gtk_clipboard_wait_for_contents" (byval clipboard as GtkClipboard ptr, byval target as GdkAtom) as GtkSelectionData ptr
declare function gtk_clipboard_wait_for_text cdecl alias "gtk_clipboard_wait_for_text" (byval clipboard as GtkClipboard ptr) as gchar ptr
declare function gtk_clipboard_wait_for_image cdecl alias "gtk_clipboard_wait_for_image" (byval clipboard as GtkClipboard ptr) as GdkPixbuf ptr
declare function gtk_clipboard_wait_for_targets cdecl alias "gtk_clipboard_wait_for_targets" (byval clipboard as GtkClipboard ptr, byval targets as GdkAtom ptr ptr, byval n_targets as gint ptr) as gboolean
declare function gtk_clipboard_wait_is_text_available cdecl alias "gtk_clipboard_wait_is_text_available" (byval clipboard as GtkClipboard ptr) as gboolean
declare function gtk_clipboard_wait_is_image_available cdecl alias "gtk_clipboard_wait_is_image_available" (byval clipboard as GtkClipboard ptr) as gboolean
declare function gtk_clipboard_wait_is_target_available cdecl alias "gtk_clipboard_wait_is_target_available" (byval clipboard as GtkClipboard ptr, byval target as GdkAtom) as gboolean
declare sub gtk_clipboard_set_can_store cdecl alias "gtk_clipboard_set_can_store" (byval clipboard as GtkClipboard ptr, byval targets as GtkTargetEntry ptr, byval n_targets as gint)
declare sub gtk_clipboard_store cdecl alias "gtk_clipboard_store" (byval clipboard as GtkClipboard ptr)
declare sub _gtk_clipboard_handle_event cdecl alias "_gtk_clipboard_handle_event" (byval event as GdkEventOwnerChange ptr)
declare sub _gtk_clipboard_store_all cdecl alias "_gtk_clipboard_store_all" ()

#endif
