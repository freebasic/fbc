''
''
'' atkstreamablecontent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkstreamablecontent_bi__
#define __atkstreamablecontent_bi__

#include once "atkobject.bi"

#define ATK_TYPE_STREAMABLE_CONTENT() atk_streamable_content_get_type ()
#define ATK_IS_STREAMABLE_CONTENT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_STREAMABLE_CONTENT)
#define ATK_STREAMABLE_CONTENT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_STREAMABLE_CONTENT, AtkStreamableContent)
#define ATK_STREAMABLE_CONTENT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_STREAMABLE_CONTENT, AtkStreamableContentIface)

type AtkStreamableContent as _AtkStreamableContent
type AtkStreamableContentIface as _AtkStreamableContentIface

type _AtkStreamableContentIface
	parent as GTypeInterface
	get_n_mime_types as function cdecl(byval as AtkStreamableContent ptr) as gint
	get_mime_type as function cdecl(byval as AtkStreamableContent ptr, byval as gint) as gchar
	get_stream as function cdecl(byval as AtkStreamableContent ptr, byval as zstring ptr) as GIOChannel
	pad1 as AtkFunction
	pad2 as AtkFunction
	pad3 as AtkFunction
	pad4 as AtkFunction
end type

declare function atk_streamable_content_get_type () as GType
declare function atk_streamable_content_get_n_mime_types (byval streamable as AtkStreamableContent ptr) as gint
declare function atk_streamable_content_get_mime_type (byval streamable as AtkStreamableContent ptr, byval i as gint) as zstring ptr
declare function atk_streamable_content_get_stream (byval streamable as AtkStreamableContent ptr, byval mime_type as zstring ptr) as GIOChannel ptr

#endif
