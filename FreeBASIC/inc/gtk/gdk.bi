''
''
'' gdk -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdk_bi__
#define __gdk_bi__

#ifdef __FB_WIN32__
#inclib "gdk-win32-2.0"
#elseif defined(__FB_LINUX__)
#inclib "gdk-x11-2.0"
#else
#error Platform not supported!
#endif

#include once "gtk/gdk/gdkcolor.bi"
#include once "gtk/gdk/gdkcursor.bi"
#include once "gtk/gdk/gdkdisplay.bi"
#include once "gtk/gdk/gdkdnd.bi"
#include once "gtk/gdk/gdkdrawable.bi"
#include once "gtk/gdk/gdkenumtypes.bi"
#include once "gtk/gdk/gdkevents.bi"
#include once "gtk/gdk/gdkfont.bi"
#include once "gtk/gdk/gdkgc.bi"
#include once "gtk/gdk/gdkimage.bi"
#include once "gtk/gdk/gdkinput.bi"
#include once "gtk/gdk/gdkkeys.bi"
#include once "gtk/gdk/gdkdisplaymanager.bi"
#include once "gtk/gdk/gdkpango.bi"
#include once "gtk/gdk/gdkpixbuf.bi"
#include once "gtk/gdk/gdkpixmap.bi"
#include once "gtk/gdk/gdkproperty.bi"
#include once "gtk/gdk/gdkregion.bi"
#include once "gtk/gdk/gdkrgb.bi"
#include once "gtk/gdk/gdkscreen.bi"
#include once "gtk/gdk/gdkselection.bi"
#include once "gtk/gdk/gdkspawn.bi"
#include once "gtk/gdk/gdktypes.bi"
#include once "gtk/gdk/gdkvisual.bi"
#include once "gtk/gdk/gdkwindow.bi"

declare sub gdk_parse_args cdecl alias "gdk_parse_args" (byval argc as gint ptr, byval argv as zstring ptr ptr ptr)
declare sub gdk_init cdecl alias "gdk_init" (byval argc as gint ptr, byval argv as zstring ptr ptr ptr)
declare function gdk_init_check cdecl alias "gdk_init_check" (byval argc as gint ptr, byval argv as zstring ptr ptr ptr) as gboolean
declare sub gdk_add_option_entries_libgtk_only cdecl alias "gdk_add_option_entries_libgtk_only" (byval group as GOptionGroup ptr)
declare sub gdk_pre_parse_libgtk_only cdecl alias "gdk_pre_parse_libgtk_only" ()
declare sub gdk_exit cdecl alias "gdk_exit" (byval error_code as gint)
declare function gdk_set_locale cdecl alias "gdk_set_locale" () as zstring ptr
declare function gdk_get_program_class cdecl alias "gdk_get_program_class" () as zstring ptr
declare sub gdk_set_program_class cdecl alias "gdk_set_program_class" (byval program_class as zstring ptr)
declare sub gdk_error_trap_push cdecl alias "gdk_error_trap_push" ()
declare function gdk_error_trap_pop cdecl alias "gdk_error_trap_pop" () as gint
declare sub gdk_set_use_xshm cdecl alias "gdk_set_use_xshm" (byval use_xshm as gboolean)
declare function gdk_get_use_xshm cdecl alias "gdk_get_use_xshm" () as gboolean
declare function gdk_get_display cdecl alias "gdk_get_display" () as zstring ptr
declare function gdk_get_display_arg_name cdecl alias "gdk_get_display_arg_name" () as zstring ptr
declare function gdk_input_add_full cdecl alias "gdk_input_add_full" (byval source as gint, byval condition as GdkInputCondition, byval function as GdkInputFunction, byval data as gpointer, byval destroy as GdkDestroyNotify) as gint
declare function gdk_input_add cdecl alias "gdk_input_add" (byval source as gint, byval condition as GdkInputCondition, byval function as GdkInputFunction, byval data as gpointer) as gint
declare sub gdk_input_remove cdecl alias "gdk_input_remove" (byval tag as gint)
declare function gdk_pointer_grab cdecl alias "gdk_pointer_grab" (byval window as GdkWindow ptr, byval owner_events as gboolean, byval event_mask as GdkEventMask, byval confine_to as GdkWindow ptr, byval cursor as GdkCursor ptr, byval time_ as guint32) as GdkGrabStatus
declare function gdk_keyboard_grab cdecl alias "gdk_keyboard_grab" (byval window as GdkWindow ptr, byval owner_events as gboolean, byval time_ as guint32) as GdkGrabStatus
declare function gdk_pointer_grab_info_libgtk_only cdecl alias "gdk_pointer_grab_info_libgtk_only" (byval display as GdkDisplay ptr, byval grab_window as GdkWindow ptr ptr, byval owner_events as gboolean ptr) as gboolean
declare function gdk_keyboard_grab_info_libgtk_only cdecl alias "gdk_keyboard_grab_info_libgtk_only" (byval display as GdkDisplay ptr, byval grab_window as GdkWindow ptr ptr, byval owner_events as gboolean ptr) as gboolean
declare sub gdk_pointer_ungrab cdecl alias "gdk_pointer_ungrab" (byval time_ as guint32)
declare sub gdk_keyboard_ungrab cdecl alias "gdk_keyboard_ungrab" (byval time_ as guint32)
declare function gdk_pointer_is_grabbed cdecl alias "gdk_pointer_is_grabbed" () as gboolean
declare function gdk_screen_width cdecl alias "gdk_screen_width" () as gint
declare function gdk_screen_height cdecl alias "gdk_screen_height" () as gint
declare function gdk_screen_width_mm cdecl alias "gdk_screen_width_mm" () as gint
declare function gdk_screen_height_mm cdecl alias "gdk_screen_height_mm" () as gint
declare sub gdk_beep cdecl alias "gdk_beep" ()
declare sub gdk_flush cdecl alias "gdk_flush" ()
declare sub gdk_set_double_click_time cdecl alias "gdk_set_double_click_time" (byval msec as guint)
declare function gdk_rectangle_intersect cdecl alias "gdk_rectangle_intersect" (byval src1 as GdkRectangle ptr, byval src2 as GdkRectangle ptr, byval dest as GdkRectangle ptr) as gboolean
declare sub gdk_rectangle_union cdecl alias "gdk_rectangle_union" (byval src1 as GdkRectangle ptr, byval src2 as GdkRectangle ptr, byval dest as GdkRectangle ptr)
declare function gdk_rectangle_get_type cdecl alias "gdk_rectangle_get_type" () as GType
declare function gdk_wcstombs cdecl alias "gdk_wcstombs" (byval src as GdkWChar ptr) as zstring ptr
declare function gdk_mbstowcs cdecl alias "gdk_mbstowcs" (byval dest as GdkWChar ptr, byval src as zstring ptr, byval dest_max as gint) as gint
declare function gdk_event_send_client_message cdecl alias "gdk_event_send_client_message" (byval event as GdkEvent ptr, byval winid as GdkNativeWindow) as gboolean
declare sub gdk_event_send_clientmessage_toall cdecl alias "gdk_event_send_clientmessage_toall" (byval event as GdkEvent ptr)
declare function gdk_event_send_client_message_for_display cdecl alias "gdk_event_send_client_message_for_display" (byval display as GdkDisplay ptr, byval event as GdkEvent ptr, byval winid as GdkNativeWindow) as gboolean
declare sub gdk_notify_startup_complete cdecl alias "gdk_notify_startup_complete" ()
declare sub gdk_threads_enter cdecl alias "gdk_threads_enter" ()
declare sub gdk_threads_leave cdecl alias "gdk_threads_leave" ()
declare sub gdk_threads_init cdecl alias "gdk_threads_init" ()
declare sub gdk_threads_set_lock_functions cdecl alias "gdk_threads_set_lock_functions" (byval enter_fn as GCallback, byval leave_fn as GCallback)

#endif
