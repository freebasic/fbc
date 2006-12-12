''
''
'' atkhypertext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkhypertext_bi__
#define __atkhypertext_bi__

#include once "atkobject.bi"
#include once "atkhyperlink.bi"

#define ATK_TYPE_HYPERTEXT() atk_hypertext_get_type()
#define ATK_IS_HYPERTEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_HYPERTEXT)
#define ATK_HYPERTEXT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_HYPERTEXT, AtkHypertext)
#define ATK_HYPERTEXT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_HYPERTEXT, AtkHypertextIface)

type AtkHypertext as _AtkHypertext
type AtkHypertextIface as _AtkHypertextIface

type _AtkHypertextIface
	parent as GTypeInterface
	get_link as function cdecl(byval as AtkHypertext ptr, byval as gint) as AtkHyperlink
	get_n_links as function cdecl(byval as AtkHypertext ptr) as gint
	get_link_index as function cdecl(byval as AtkHypertext ptr, byval as gint) as gint
	link_selected as sub cdecl(byval as AtkHypertext ptr, byval as gint)
	pad1 as AtkFunction
	pad2 as AtkFunction
	pad3 as AtkFunction
end type

declare function atk_hypertext_get_type () as GType
declare function atk_hypertext_get_link (byval hypertext as AtkHypertext ptr, byval link_index as gint) as AtkHyperlink ptr
declare function atk_hypertext_get_n_links (byval hypertext as AtkHypertext ptr) as gint
declare function atk_hypertext_get_link_index (byval hypertext as AtkHypertext ptr, byval char_index as gint) as gint

#endif
