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

#include once "gtk/atk/atkobject.bi"

type AtkStreamableContent as _AtkStreamableContent
type AtkStreamableContentIface as _AtkStreamableContentIface

type _AtkStreamableContentIface
	parent as GTypeInterface
	get_n_mime_types as function cdecl(byval as AtkStreamableContent ptr) as gint
	get_mime_type as function cdecl(byval as AtkStreamableContent ptr, byval as gint) as gchar
	get_stream as function cdecl(byval as AtkStreamableContent ptr, byval as gchar ptr) as GIOChannel
	pad1 as AtkFunction
	pad2 as AtkFunction
	pad3 as AtkFunction
	pad4 as AtkFunction
end type

declare function atk_streamable_content_get_type cdecl alias "atk_streamable_content_get_type" () as GType
declare function atk_streamable_content_get_n_mime_types cdecl alias "atk_streamable_content_get_n_mime_types" (byval streamable as AtkStreamableContent ptr) as gint
declare function atk_streamable_content_get_mime_type cdecl alias "atk_streamable_content_get_mime_type" (byval streamable as AtkStreamableContent ptr, byval i as gint) as gchar ptr
declare function atk_streamable_content_get_stream cdecl alias "atk_streamable_content_get_stream" (byval streamable as AtkStreamableContent ptr, byval mime_type as gchar ptr) as GIOChannel ptr

#endif
