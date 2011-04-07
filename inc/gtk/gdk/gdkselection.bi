''
''
'' gdkselection -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkselection_bi__
#define __gdkselection_bi__

#include once "gdktypes.bi"

type GdkSelection as GdkAtom
type GdkTarget as GdkAtom
type GdkSelectionType as GdkAtom

declare function gdk_selection_owner_set (byval owner as GdkWindow ptr, byval selection as GdkAtom, byval time_ as guint32, byval send_event as gboolean) as gboolean
declare function gdk_selection_owner_get (byval selection as GdkAtom) as GdkWindow ptr
declare function gdk_selection_owner_set_for_display (byval display as GdkDisplay ptr, byval owner as GdkWindow ptr, byval selection as GdkAtom, byval time_ as guint32, byval send_event as gboolean) as gboolean
declare function gdk_selection_owner_get_for_display (byval display as GdkDisplay ptr, byval selection as GdkAtom) as GdkWindow ptr
declare sub gdk_selection_convert (byval requestor as GdkWindow ptr, byval selection as GdkAtom, byval target as GdkAtom, byval time_ as guint32)
declare function gdk_selection_property_get (byval requestor as GdkWindow ptr, byval data as guchar ptr ptr, byval prop_type as GdkAtom ptr, byval prop_format as gint ptr) as gboolean
declare sub gdk_selection_send_notify (byval requestor as guint32, byval selection as GdkAtom, byval target as GdkAtom, byval property as GdkAtom, byval time_ as guint32)
declare sub gdk_selection_send_notify_for_display (byval display as GdkDisplay ptr, byval requestor as guint32, byval selection as GdkAtom, byval target as GdkAtom, byval property as GdkAtom, byval time_ as guint32)

#endif
